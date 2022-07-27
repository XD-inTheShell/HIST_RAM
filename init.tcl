


set device_index 0 ; #Device index for target
set device [lindex [get_service_paths device] $device_index]
set project_path /home/xiyingd/HIST_RAM_MEMTEST
set project_name SRAM_SC.sof
set sof_path [file join $project_path output_files $project_name]
device_download_sof $device $sof_path