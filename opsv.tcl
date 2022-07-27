set service_type "master"
set master_service_paths [get_service_paths $service_type]

set master_index 0
set master_path [lindex $master_service_paths $master_index]
set claim_path_0 [claim_service $service_type $master_path system_console_example];

set master_index 1
set master_path [lindex $master_service_paths $master_index]
set claim_path_1 [claim_service $service_type $master_path system_console_example];

set base 0x0
set length 0x1000
set sram0_base  0x00000000
set sram0_length    0x100
set regfile_base 0x00000000
set regfile_length 0x20

puts "###################################################################"
puts "Beginning memory test..."
puts "Resetting memory system..."
reset 0
reset 1