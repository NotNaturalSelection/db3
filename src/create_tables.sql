create table if not exists shipments
(
    part_number       int primary key,
    count_left        int      not null,
    delivery_date     date     not null,
    delivery_interval interval not null,
    delivery_size     int      not null
);

create table if not exists displays
(
    id           int primary key,
    size_inches  float4      not null,
    resolution   varchar(10) not null,
    display_type varchar(10) not null,
    part_number  int         not null unique references shipments (part_number) on delete cascade,
    price        int         not null
);

create table if not exists customers
(
    id         int primary key,
    first_name varchar(50) not null,
    last_name  varchar(50) not null
);

create table if not exists gpus
(
    id               int primary key,
    core_speed_mhz   int         not null,
    memory_speed_mhz int,
    memory_size_gb   int,
    form             varchar(10) not null,
    part_number      int         not null unique references shipments (part_number) on delete cascade,
    price            int         not null
);

create table if not exists ram
(
    id          int primary key,
    type        varchar(10) not null,
    size_gb     int         not null,
    form        varchar(10) not null,
    speed_mhz   int         not null,
    part_number int         not null unique references shipments (part_number) on delete cascade,
    price       int         not null
);

create table if not exists drives
(
    id              int primary key,
    form            varchar(20) not null,
    is_ssd          bool        not null,
    size_gb         int         not null,
    read_speed_gbs  int         not null,
    write_speed_gbs int         not null,
    part_number     int         not null unique references shipments (part_number) on delete cascade,
    price           int         not null
);

create table if not exists cpus
(
    id                int primary key,
    model             varchar(50) not null,
    integrated_gpu_id int references gpus,
    core_speed_mhz    int         not null,
    core_number       int         not null,
    part_number       int         not null unique references shipments (part_number) on delete cascade,
    price             int         not null
);

create table if not exists bases
(
    id          int primary key,
    gpu_allowed bool not null,
    display_id  int  not null references displays,
    cpu_id      int  not null references cpus,
    drive_slots int  not null,
    ram_slots   int  not null,
    part_number int  not null unique references shipments (part_number) on delete cascade,
    price       int  not null
);

create table if not exists builds
(
    id        int primary key,
    base_id   int not null references bases,
    gpu_id    int references gpus,
    ram1_id   int not null references ram,
    ram2_id   int references ram,
    drive1_id int not null references drives,
    drive2_id int references drives
);

create table if not exists buckets
(
    customer_id int primary key references customers,
    build_id    int not null references builds,
    quantity    int not null
);

create table if not exists orders
(
    id          int primary key,
    status      varchar(30) not null,
    customer_id int         not null references customers,
    zip_code    varchar(20) not null,
    build_id    int         not null references builds,
    quantity    int         not null
);