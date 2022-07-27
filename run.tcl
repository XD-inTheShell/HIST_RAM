#TCL script to set memory with predefined value
proc fill_memory {claim_path base length} {
    for {set i 0} {$i < $length} {incr i} {
        master_write_32 $claim_path [expr {$base + $i * 4}] [expr $length - $i]
    }
}
proc verify_memory {claim_path base length} {
    set error 0
    for {set i 0} {$i < $length} {incr i} {
        set expected_val [expr $length - $i]
        set read_val [master_read_32 $claim_path [expr $base + {$i * 4}] 0x1]
        if {$read_val != $expected_val} {
            puts "@$i Value mismatch occured, expected: $expected_val, received: $read_val"
            incr error
        }
    }

    if {$error == 0} {
        puts "Test passed! :\)"
    } else {
        puts "Test failed... :\("
    }
}

proc reset {index} {
    set jtag_debug_path [lindex [get_service_paths jtag_debug] $index]
    set claim_jtag_debug_path [claim_service jtag_debug $jtag_debug_path system_console_example]
    jtag_debug_reset_system $claim_jtag_debug_path; 
    close_service jtag_debug $claim_jtag_debug_path
}

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

puts "Writing to all the SRAM elements..."
fill_memory $claim_path_1 $sram0_base $sram0_length
puts "Write Complete! Beginning read back..."
verify_memory $claim_path_1 $sram0_base $sram0_length


# master_read_32 $claim_path $base

# Close the service
# close_service master $claim_path;