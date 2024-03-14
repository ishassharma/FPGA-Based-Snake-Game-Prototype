# _hw.tcl file for VGA_Subsystem
package require -exact qsys 14.0

# module properties
set_module_property NAME {VGA_Subsystem_export}
set_module_property DISPLAY_NAME {VGA_Subsystem_export_display}

# default module properties
set_module_property VERSION {1.0}
set_module_property GROUP {default group}
set_module_property DESCRIPTION {default description}
set_module_property AUTHOR {author}

set_module_property COMPOSITION_CALLBACK compose
set_module_property opaque_address_map false

proc compose { } {
    # Instances and instance parameters
    # (disabled instances are intentionally culled)
    add_instance Sys_Clk clock_source 18.1
    set_instance_parameter_value Sys_Clk {clockFrequency} {50000000.0}
    set_instance_parameter_value Sys_Clk {clockFrequencyKnown} {0}
    set_instance_parameter_value Sys_Clk {resetSynchronousEdges} {NONE}

    add_instance VGA_Alpha_Blender altera_up_avalon_video_alpha_blender 18.0
    set_instance_parameter_value VGA_Alpha_Blender {mode} {Normal}

    add_instance VGA_Char_Buffer altera_up_avalon_video_character_buffer_with_dma 18.0
    set_instance_parameter_value VGA_Char_Buffer {color_bits} {1-bit}
    set_instance_parameter_value VGA_Char_Buffer {enable_transparency} {1}
    set_instance_parameter_value VGA_Char_Buffer {resolution} {80 x 60}
    set_instance_parameter_value VGA_Char_Buffer {vga_device} {On-board VGA DAC}

    add_instance VGA_Controller altera_up_avalon_video_vga_controller 18.1
    set_instance_parameter_value VGA_Controller {board} {DE1-SoC}
    set_instance_parameter_value VGA_Controller {device} {VGA Connector}
    set_instance_parameter_value VGA_Controller {resolution} {VGA 640x480}
    set_instance_parameter_value VGA_Controller {underflow_flag} {0}

    add_instance VGA_Dual_Clock_FIFO altera_up_avalon_video_dual_clock_buffer 18.0
    set_instance_parameter_value VGA_Dual_Clock_FIFO {color_bits} {10}
    set_instance_parameter_value VGA_Dual_Clock_FIFO {color_planes} {3}

    add_instance VGA_PLL altera_up_avalon_video_pll 18.0
    set_instance_parameter_value VGA_PLL {camera} {5MP Digital Camera (THDB_D5M)}
    set_instance_parameter_value VGA_PLL {gui_refclk} {50.0}
    set_instance_parameter_value VGA_PLL {gui_resolution} {VGA 640x480}
    set_instance_parameter_value VGA_PLL {lcd} {2.4" LCD on LT24}
    set_instance_parameter_value VGA_PLL {lcd_clk_en} {0}
    set_instance_parameter_value VGA_PLL {vga_clk_en} {1}
    set_instance_parameter_value VGA_PLL {video_in_clk_en} {0}

    add_instance VGA_Pixel_DMA altera_up_avalon_video_pixel_buffer_dma 18.0
    set_instance_parameter_value VGA_Pixel_DMA {addr_mode} {X-Y}
    set_instance_parameter_value VGA_Pixel_DMA {back_start_address} {134217728}
    set_instance_parameter_value VGA_Pixel_DMA {color_space} {8-bit RGB}
    set_instance_parameter_value VGA_Pixel_DMA {image_height} {480}
    set_instance_parameter_value VGA_Pixel_DMA {image_width} {640}
    set_instance_parameter_value VGA_Pixel_DMA {start_address} {134217728}

    add_instance VGA_Pixel_FIFO altera_up_avalon_video_dual_clock_buffer 18.0
    set_instance_parameter_value VGA_Pixel_FIFO {color_bits} {8}
    set_instance_parameter_value VGA_Pixel_FIFO {color_planes} {1}

    add_instance VGA_Pixel_RGB_Resampler altera_up_avalon_video_rgb_resampler 18.0
    set_instance_parameter_value VGA_Pixel_RGB_Resampler {alpha} {1023}
    set_instance_parameter_value VGA_Pixel_RGB_Resampler {input_type} {8-bit RGB}
    set_instance_parameter_value VGA_Pixel_RGB_Resampler {output_type} {30-bit RGB}

    # connections and connection parameters
    add_connection Sys_Clk.clk VGA_Alpha_Blender.clk clock

    add_connection Sys_Clk.clk VGA_Char_Buffer.clk clock

    add_connection Sys_Clk.clk VGA_Dual_Clock_FIFO.clock_stream_in clock

    add_connection Sys_Clk.clk VGA_Pixel_DMA.clk clock

    add_connection Sys_Clk.clk VGA_Pixel_FIFO.clock_stream_in clock

    add_connection Sys_Clk.clk VGA_Pixel_FIFO.clock_stream_out clock

    add_connection Sys_Clk.clk VGA_Pixel_RGB_Resampler.clk clock

    add_connection Sys_Clk.clk_reset VGA_Alpha_Blender.reset reset

    add_connection Sys_Clk.clk_reset VGA_Char_Buffer.reset reset

    add_connection Sys_Clk.clk_reset VGA_Dual_Clock_FIFO.reset_stream_in reset

    add_connection Sys_Clk.clk_reset VGA_Pixel_DMA.reset reset

    add_connection Sys_Clk.clk_reset VGA_Pixel_FIFO.reset_stream_in reset

    add_connection Sys_Clk.clk_reset VGA_Pixel_FIFO.reset_stream_out reset

    add_connection Sys_Clk.clk_reset VGA_Pixel_RGB_Resampler.reset reset

    add_connection VGA_Alpha_Blender.avalon_blended_source VGA_Dual_Clock_FIFO.avalon_dc_buffer_sink avalon_streaming

    add_connection VGA_Char_Buffer.avalon_char_source VGA_Alpha_Blender.avalon_foreground_sink avalon_streaming

    add_connection VGA_Dual_Clock_FIFO.avalon_dc_buffer_source VGA_Controller.avalon_vga_sink avalon_streaming

    add_connection VGA_PLL.reset_source VGA_Controller.reset reset

    add_connection VGA_PLL.reset_source VGA_Dual_Clock_FIFO.reset_stream_out reset

    add_connection VGA_PLL.vga_clk VGA_Controller.clk clock

    add_connection VGA_PLL.vga_clk VGA_Dual_Clock_FIFO.clock_stream_out clock

    add_connection VGA_Pixel_DMA.avalon_pixel_source VGA_Pixel_FIFO.avalon_dc_buffer_sink avalon_streaming

    add_connection VGA_Pixel_FIFO.avalon_dc_buffer_source VGA_Pixel_RGB_Resampler.avalon_rgb_sink avalon_streaming

    add_connection VGA_Pixel_RGB_Resampler.avalon_rgb_source VGA_Alpha_Blender.avalon_background_sink avalon_streaming

    # exported interfaces
    add_interface char_buffer_control_slave avalon slave
    set_interface_property char_buffer_control_slave EXPORT_OF VGA_Char_Buffer.avalon_char_control_slave
    add_interface char_buffer_slave avalon slave
    set_interface_property char_buffer_slave EXPORT_OF VGA_Char_Buffer.avalon_char_buffer_slave
    add_interface pixel_dma_control_slave avalon slave
    set_interface_property pixel_dma_control_slave EXPORT_OF VGA_Pixel_DMA.avalon_control_slave
    add_interface pixel_dma_master avalon master
    set_interface_property pixel_dma_master EXPORT_OF VGA_Pixel_DMA.avalon_pixel_dma_master
    add_interface sys_clk clock sink
    set_interface_property sys_clk EXPORT_OF Sys_Clk.clk_in
    add_interface sys_reset reset sink
    set_interface_property sys_reset EXPORT_OF Sys_Clk.clk_in_reset
    add_interface vga conduit end
    set_interface_property vga EXPORT_OF VGA_Controller.external_interface
    add_interface vga_pll_ref_clk clock sink
    set_interface_property vga_pll_ref_clk EXPORT_OF VGA_PLL.ref_clk
    add_interface vga_pll_ref_reset reset sink
    set_interface_property vga_pll_ref_reset EXPORT_OF VGA_PLL.ref_reset

    # interconnect requirements
    set_interconnect_requirement {$system} {qsys_mm.clockCrossingAdapter} {HANDSHAKE}
    set_interconnect_requirement {$system} {qsys_mm.enableEccProtection} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.insertDefaultSlave} {FALSE}
    set_interconnect_requirement {$system} {qsys_mm.maxAdditionalLatency} {1}
}
