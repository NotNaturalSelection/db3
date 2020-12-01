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
    if (new.gpu_id is not null and not(select gpu_allowed from bases where id = new.base_id)) then
        raise exception 'Base in your build does not support gpu but build has one';
    end if;
end
$$ language plpgsql;



