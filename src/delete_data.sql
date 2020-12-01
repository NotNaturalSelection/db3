delete
from orders
where id = 1
  and status = 'Received'
  and customer_id = 1
  and zip_code = '197384'
  and build_id = 1
  and quantity = 2;

delete
from buckets
where customer_id = 1
  and build_id = 1
  and quantity = 2;

delete
from builds
where id = 1
  and base_id = 1
  and gpu_id = 1
  and ram1_id = 1
  and ram2_id = 1
  and drive1_id = 1
  and drive2_id = 1;

delete
from bases
where id = 1
  and gpu_allowed = true
  and display_id = 1
  and cpu_id = 1
  and drive_slots = 2
  and ram_slots = 2
  and part_number = 127829
  and price = 4000;

delete
from cpus
where id = 1
  and model = 'AMD Ryzen 5 3600'
  and integrated_gpu_id is null
  and core_speed_mhz = 3200
  and core_number = 8
  and part_number = 567249
  and price = 7000;

delete
from displays
where id = 1
  and size_inches = 15.6
  and resolution = '1920x1080'
  and display_type = 'IPS'
  and part_number = 152523
  and price = 1000;

delete
from customers
where id = 1
  and first_name = 'John'
  and last_name = 'Doe';

delete
from gpus
where id = 1
  and core_speed_mhz = 1800
  and memory_speed_mhz = 9000
  and memory_size_gb = 8
  and form = 'PCIe x16'
  and part_number = 285295
  and price = 20000;

delete
from ram
where id = 1
  and type = 'DDR4'
  and size_gb = 8
  and form = 'SO-DIMM'
  and speed_mhz = 2400
  and part_number = 957286
  and price = 3000;

delete
from drives
where id = 1
  and form = 'SATA 3.0'
  and is_ssd = true
  and size_gb = 512
  and read_speed_gbs = 120
  and write_speed_gbs = 50
  and part_number = 963741
  and price = 3000;

delete from shipments;
