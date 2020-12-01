insert into shipments
values (152523, 100, '10 days' , 500);
insert into shipments
values (285295, 100, '10 days' , 500);
insert into shipments
values (957286, 100, '10 days' , 500);
insert into shipments
values (963741, 100, '10 days' , 500);
insert into shipments
values (567249, 100, '10 days' , 500);
insert into shipments
values (127829, 100, '10 days' , 500);

insert into displays
values (1, 15.6, '1920x1080', 'IPS', 152523, 1000);

insert into customers
values (1, 'John', 'Doe');

insert into gpus
values (1, 1800, 9000, 8, 'PCIe x16', 285295, 20000);

insert into ram
values (1, 'DDR4', 8, 'SO-DIMM', 2400, 957286, 3000);

insert into drives
values (1, 'SATA 3.0', true, 512, 120, 50, 963741, 3000);

insert into cpus
values (1, 'AMD Ryzen 5 3600', null, 3200, 8, 567249, 7000);

insert into bases
values (1, true, 1, 1, 2, 2, 127829, 4000);

insert into builds
values (1, 1, 1, 1, 1, 1, 1);

insert into buckets
values (1, 1, 2);

insert into orders
values (1, 'Received', 1, '197384', 1, 2);