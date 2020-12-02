create or replace function parts_income() returns void as
$$
    begin
    update shipments
    set count_left    = count_left + delivery_size,
        delivery_date = delivery_date + delivery_interval
    where delivery_date = current_date;
    end
$$
    language plpgsql;

create or replace function match_display_size() returns trigger as
$$
begin
    if ((select display_size from bases where id = NEW.id) <> (select size_inches from displays where displays.id = NEW.display_id)) then
        raise exception 'Base display size differs from display size';
    end if;
    return null;
end
$$
    language plpgsql;

create or replace function match_gpu_allowed() returns trigger as
$$
begin
    if (new.gpu_id is not null and not (select gpu_allowed from bases where id = new.base_id)) then
        raise exception 'Base in your build does not support gpu but build has one';
    end if;
end
$$ language plpgsql;

create or replace function create_order() returns trigger as
$$
declare
    rec      record;
    base     record;
    part_num int;
    required_count int;
begin
    select * from builds where id = new.build_id limit 1 into rec;
    select * from bases where id = rec.base_id limit 1 into base;
    required_count = new.quantity;
    --base
    part_num = base.part_number;
    if ((select count_left from shipments where part_number = part_num) < required_count) then
        raise exception 'There is not enough bases you have chosen is not in stock';
    end if;
    --cpu
    part_num = (select part_number from cpus where id = base.cpu_id);
    if ((select count_left from shipments where part_number = part_num) < required_count) then
        raise exception 'There is not enough CPU you have chosen is not in stock';
    end if;
    --display
    part_num = (select part_number from displays where id = base.display_id);
    if ((select count_left from shipments where part_number = part_num) < required_count) then
        raise exception 'There is not enough displays you have chosen is not in stock';
    end if;
    --gpu
    part_num = (select part_number from gpus where id = rec.gpu_id);
    if ((select count_left from shipments where part_number = part_num) < required_count) then
        raise exception 'There is not enough GPU you have chosen is not in stock';
    end if;
    --ram
    if (rec.ram1_id = rec.ram2_id) then
        part_num = (select part_number from ram where id = rec.ram1_id);
        if ((select count_left from shipments where part_number = part_num) < 2*required_count) then
            raise exception 'There is not enough RAM you have chosen is not in stock';
        end if;
    else
        part_num = (select part_number from ram where id = rec.ram1_id);
        if ((select count_left from shipments where part_number = part_num) < required_count) then
            raise exception 'There is not enough RAM you have chosen is not in stock';
        end if;
        part_num = (select part_number from ram where id = rec.ram2_id);
        if ((select count_left from shipments where part_number = part_num) < required_count) then
            raise exception 'There is not enough RAM you have chosen is not in stock';
        end if;
    end if;
    --drive
    if (rec.drive1_id = rec.drive2_id) then
        part_num = (select part_number from drives where id = rec.drive1_id);
        if ((select count_left from shipments where part_number = part_num) < 2*required_count) then
            raise exception 'There is not enough drive you have chosen is not in stock';
        end if;
    else
        part_num = (select part_number from drives where id = rec.drive1_id);
        if ((select count_left from shipments where part_number = part_num) < required_count) then
            raise exception 'There is not enough drives you have chosen is not in stock';
        end if;
        part_num = (select part_number from drives where id = rec.drive2_id);
        if ((select count_left from shipments where part_number = part_num) < required_count) then
            raise exception 'There is not enough drives you have chosen is not in stock';
        end if;
    end if;

    --base
    update shipments set count_left = count_left - 1 where part_number = base.part_number;
    --display
    part_num = (select part_number from displays where id = base.display_id);
    update shipments set count_left = count_left - 1 where part_number = part_num;
    --cpu
    part_num = (select part_number from displays where id = base.cpu_id);
    update shipments set count_left = count_left - 1 where part_number = part_num;
    --gpu
    part_num = (select part_number from gpus where id = rec.gpu_id);
    update shipments set count_left = count_left - 1 where part_number = part_num;
    --ram1
    part_num = (select part_number from ram where id = rec.ram1_id);
    update shipments set count_left = count_left - 1 where part_number = part_num;
    --ram2
    part_num = (select part_number from ram where id = rec.ram2_id);
    update shipments set count_left = count_left - 1 where part_number = part_num;
    --drive1
    part_num = (select part_number from drives where id = rec.drive1_id);
    update shipments set count_left = count_left - 1 where part_number = part_num;
    --drive2
    part_num = (select part_number from drives where id = rec.drive2_id);
    update shipments set count_left = count_left - 1 where part_number = part_num;
    return null;
end;
$$ language plpgsql;