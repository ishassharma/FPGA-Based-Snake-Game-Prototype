// Computer_System_Video_In_Subsystem_Edge_Detection_Subsystem.v

// Generated using ACDS version 15.1 185

`timescale 1 ps / 1 ps
module Computer_System_Video_In_Subsystem_Edge_Detection_Subsystem (
		input  wire [1:0]  edge_detection_control_slave_address,    // edge_detection_control_slave.address
		input  wire        edge_detection_control_slave_write_n,    //                             .write_n
		input  wire [31:0] edge_detection_control_slave_writedata,  //                             .writedata
		input  wire        edge_detection_control_slave_chipselect, //                             .chipselect
		output wire [31:0] edge_detection_control_slave_readdata,   //                             .readdata
		input  wire        sys_clk_clk,                             //                      sys_clk.clk
		input  wire        sys_reset_reset_n,                       //                    sys_reset.reset_n
		input  wire [23:0] video_stream_sink_data,                  //            video_stream_sink.data
		input  wire        video_stream_sink_startofpacket,         //                             .startofpacket
		input  wire        video_stream_sink_endofpacket,           //                             .endofpacket
		input  wire        video_stream_sink_valid,                 //                             .valid
		output wire        video_stream_sink_ready,                 //                             .ready
		input  wire        video_stream_source_ready,               //          video_stream_source.ready
		output wire [23:0] video_stream_source_data,                //                             .data
		output wire        video_stream_source_startofpacket,       //                             .startofpacket
		output wire        video_stream_source_endofpacket,         //                             .endofpacket
		output wire        video_stream_source_valid                //                             .valid
	);

	wire         chroma_filter_avalon_chroma_source_valid;                          // Chroma_Filter:stream_out_valid -> Edge_Detection:in_valid
	wire   [7:0] chroma_filter_avalon_chroma_source_data;                           // Chroma_Filter:stream_out_data -> Edge_Detection:in_data
	wire         chroma_filter_avalon_chroma_source_ready;                          // Edge_Detection:in_ready -> Chroma_Filter:stream_out_ready
	wire         chroma_filter_avalon_chroma_source_startofpacket;                  // Chroma_Filter:stream_out_startofpacket -> Edge_Detection:in_startofpacket
	wire         chroma_filter_avalon_chroma_source_endofpacket;                    // Chroma_Filter:stream_out_endofpacket -> Edge_Detection:in_endofpacket
	wire         chroma_upsampler_avalon_chroma_source_valid;                       // Chroma_Upsampler:stream_out_valid -> Video_Stream_Merger:stream_in_valid_1
	wire  [23:0] chroma_upsampler_avalon_chroma_source_data;                        // Chroma_Upsampler:stream_out_data -> Video_Stream_Merger:stream_in_data_1
	wire         chroma_upsampler_avalon_chroma_source_ready;                       // Video_Stream_Merger:stream_in_ready_1 -> Chroma_Upsampler:stream_out_ready
	wire         chroma_upsampler_avalon_chroma_source_startofpacket;               // Chroma_Upsampler:stream_out_startofpacket -> Video_Stream_Merger:stream_in_startofpacket_1
	wire         chroma_upsampler_avalon_chroma_source_endofpacket;                 // Chroma_Upsampler:stream_out_endofpacket -> Video_Stream_Merger:stream_in_endofpacket_1
	wire         edge_detection_avalon_edge_detection_source_valid;                 // Edge_Detection:out_valid -> Chroma_Upsampler:stream_in_valid
	wire   [7:0] edge_detection_avalon_edge_detection_source_data;                  // Edge_Detection:out_data -> Chroma_Upsampler:stream_in_data
	wire         edge_detection_avalon_edge_detection_source_ready;                 // Chroma_Upsampler:stream_in_ready -> Edge_Detection:out_ready
	wire         edge_detection_avalon_edge_detection_source_startofpacket;         // Edge_Detection:out_startofpacket -> Chroma_Upsampler:stream_in_startofpacket
	wire         edge_detection_avalon_edge_detection_source_endofpacket;           // Edge_Detection:out_endofpacket -> Chroma_Upsampler:stream_in_endofpacket
	wire         video_stream_splitter_avalon_stream_router_source_0_valid;         // Video_Stream_Splitter:stream_out_valid_0 -> Video_Stream_Merger:stream_in_valid_0
	wire  [23:0] video_stream_splitter_avalon_stream_router_source_0_data;          // Video_Stream_Splitter:stream_out_data_0 -> Video_Stream_Merger:stream_in_data_0
	wire         video_stream_splitter_avalon_stream_router_source_0_ready;         // Video_Stream_Merger:stream_in_ready_0 -> Video_Stream_Splitter:stream_out_ready_0
	wire         video_stream_splitter_avalon_stream_router_source_0_startofpacket; // Video_Stream_Splitter:stream_out_startofpacket_0 -> Video_Stream_Merger:stream_in_startofpacket_0
	wire         video_stream_splitter_avalon_stream_router_source_0_endofpacket;   // Video_Stream_Splitter:stream_out_endofpacket_0 -> Video_Stream_Merger:stream_in_endofpacket_0
	wire         video_stream_splitter_avalon_stream_router_source_1_valid;         // Video_Stream_Splitter:stream_out_valid_1 -> Chroma_Filter:stream_in_valid
	wire  [23:0] video_stream_splitter_avalon_stream_router_source_1_data;          // Video_Stream_Splitter:stream_out_data_1 -> Chroma_Filter:stream_in_data
	wire         video_stream_splitter_avalon_stream_router_source_1_ready;         // Chroma_Filter:stream_in_ready -> Video_Stream_Splitter:stream_out_ready_1
	wire         video_stream_splitter_avalon_stream_router_source_1_startofpacket; // Video_Stream_Splitter:stream_out_startofpacket_1 -> Chroma_Filter:stream_in_startofpacket
	wire         video_stream_splitter_avalon_stream_router_source_1_endofpacket;   // Video_Stream_Splitter:stream_out_endofpacket_1 -> Chroma_Filter:stream_in_endofpacket
	wire         video_stream_splitter_avalon_sync_source_valid;                    // Video_Stream_Splitter:sync_valid -> Video_Stream_Merger:sync_valid
	wire         video_stream_splitter_avalon_sync_source_data;                     // Video_Stream_Splitter:sync_data -> Video_Stream_Merger:sync_data
	wire         video_stream_splitter_avalon_sync_source_ready;                    // Video_Stream_Merger:sync_ready -> Video_Stream_Splitter:sync_ready
	wire         edge_detection_router_controller_external_connection_export;       // Edge_Detection_Router_Controller:out_port -> Video_Stream_Splitter:stream_select
	wire         rst_controller_reset_out_reset;                                    // rst_controller:reset_out -> [Chroma_Filter:reset, Chroma_Upsampler:reset, Edge_Detection:reset, Edge_Detection_Router_Controller:reset_n, Video_Stream_Merger:reset, Video_Stream_Splitter:reset]

	Computer_System_Video_In_Subsystem_Edge_Detection_Subsystem_Chroma_Filter chroma_filter (
		.clk                      (sys_clk_clk),                                                       //                  clk.clk
		.reset                    (rst_controller_reset_out_reset),                                    //                reset.reset
		.stream_in_startofpacket  (video_stream_splitter_avalon_stream_router_source_1_startofpacket), //   avalon_chroma_sink.startofpacket
		.stream_in_endofpacket    (video_stream_splitter_avalon_stream_router_source_1_endofpacket),   //                     .endofpacket
		.stream_in_valid          (video_stream_splitter_avalon_stream_router_source_1_valid),         //                     .valid
		.stream_in_ready          (video_stream_splitter_avalon_stream_router_source_1_ready),         //                     .ready
		.stream_in_data           (video_stream_splitter_avalon_stream_router_source_1_data),          //                     .data
		.stream_out_ready         (chroma_filter_avalon_chroma_source_ready),                          // avalon_chroma_source.ready
		.stream_out_startofpacket (chroma_filter_avalon_chroma_source_startofpacket),                  //                     .startofpacket
		.stream_out_endofpacket   (chroma_filter_avalon_chroma_source_endofpacket),                    //                     .endofpacket
		.stream_out_valid         (chroma_filter_avalon_chroma_source_valid),                          //                     .valid
		.stream_out_data          (chroma_filter_avalon_chroma_source_data)                            //                     .data
	);

	Computer_System_Video_In_Subsystem_Edge_Detection_Subsystem_Chroma_Upsampler chroma_upsampler (
		.clk                      (sys_clk_clk),                                               //                  clk.clk
		.reset                    (rst_controller_reset_out_reset),                            //                reset.reset
		.stream_in_startofpacket  (edge_detection_avalon_edge_detection_source_startofpacket), //   avalon_chroma_sink.startofpacket
		.stream_in_endofpacket    (edge_detection_avalon_edge_detection_source_endofpacket),   //                     .endofpacket
		.stream_in_valid          (edge_detection_avalon_edge_detection_source_valid),         //                     .valid
		.stream_in_ready          (edge_detection_avalon_edge_detection_source_ready),         //                     .ready
		.stream_in_data           (edge_detection_avalon_edge_detection_source_data),          //                     .data
		.stream_out_ready         (chroma_upsampler_avalon_chroma_source_ready),               // avalon_chroma_source.ready
		.stream_out_startofpacket (chroma_upsampler_avalon_chroma_source_startofpacket),       //                     .startofpacket
		.stream_out_endofpacket   (chroma_upsampler_avalon_chroma_source_endofpacket),         //                     .endofpacket
		.stream_out_valid         (chroma_upsampler_avalon_chroma_source_valid),               //                     .valid
		.stream_out_data          (chroma_upsampler_avalon_chroma_source_data)                 //                     .data
	);

	Computer_System_Video_In_Subsystem_Edge_Detection_Subsystem_Edge_Detection edge_detection (
		.clk               (sys_clk_clk),                                               //                          clk.clk
		.reset             (rst_controller_reset_out_reset),                            //                        reset.reset
		.in_data           (chroma_filter_avalon_chroma_source_data),                   //   avalon_edge_detection_sink.data
		.in_startofpacket  (chroma_filter_avalon_chroma_source_startofpacket),          //                             .startofpacket
		.in_endofpacket    (chroma_filter_avalon_chroma_source_endofpacket),            //                             .endofpacket
		.in_valid          (chroma_filter_avalon_chroma_source_valid),                  //                             .valid
		.in_ready          (chroma_filter_avalon_chroma_source_ready),                  //                             .ready
		.out_ready         (edge_detection_avalon_edge_detection_source_ready),         // avalon_edge_detection_source.ready
		.out_data          (edge_detection_avalon_edge_detection_source_data),          //                             .data
		.out_startofpacket (edge_detection_avalon_edge_detection_source_startofpacket), //                             .startofpacket
		.out_endofpacket   (edge_detection_avalon_edge_detection_source_endofpacket),   //                             .endofpacket
		.out_valid         (edge_detection_avalon_edge_detection_source_valid)          //                             .valid
	);

	Computer_System_Video_In_Subsystem_Edge_Detection_Subsystem_Edge_Detection_Router_Controller edge_detection_router_controller (
		.clk        (sys_clk_clk),                                                 //                 clk.clk
		.reset_n    (~rst_controller_reset_out_reset),                             //               reset.reset_n
		.address    (edge_detection_control_slave_address),                        //                  s1.address
		.write_n    (edge_detection_control_slave_write_n),                        //                    .write_n
		.writedata  (edge_detection_control_slave_writedata),                      //                    .writedata
		.chipselect (edge_detection_control_slave_chipselect),                     //                    .chipselect
		.readdata   (edge_detection_control_slave_readdata),                       //                    .readdata
		.out_port   (edge_detection_router_controller_external_connection_export)  // external_connection.export
	);

	Computer_System_Video_In_Subsystem_Edge_Detection_Subsystem_Video_Stream_Merger video_stream_merger (
		.clk                       (sys_clk_clk),                                                       //                         clk.clk
		.reset                     (rst_controller_reset_out_reset),                                    //                       reset.reset
		.stream_in_data_0          (video_stream_splitter_avalon_stream_router_source_0_data),          // avalon_stream_router_sink_0.data
		.stream_in_startofpacket_0 (video_stream_splitter_avalon_stream_router_source_0_startofpacket), //                            .startofpacket
		.stream_in_endofpacket_0   (video_stream_splitter_avalon_stream_router_source_0_endofpacket),   //                            .endofpacket
		.stream_in_valid_0         (video_stream_splitter_avalon_stream_router_source_0_valid),         //                            .valid
		.stream_in_ready_0         (video_stream_splitter_avalon_stream_router_source_0_ready),         //                            .ready
		.stream_in_data_1          (chroma_upsampler_avalon_chroma_source_data),                        // avalon_stream_router_sink_1.data
		.stream_in_startofpacket_1 (chroma_upsampler_avalon_chroma_source_startofpacket),               //                            .startofpacket
		.stream_in_endofpacket_1   (chroma_upsampler_avalon_chroma_source_endofpacket),                 //                            .endofpacket
		.stream_in_valid_1         (chroma_upsampler_avalon_chroma_source_valid),                       //                            .valid
		.stream_in_ready_1         (chroma_upsampler_avalon_chroma_source_ready),                       //                            .ready
		.sync_data                 (video_stream_splitter_avalon_sync_source_data),                     //            avalon_sync_sink.data
		.sync_valid                (video_stream_splitter_avalon_sync_source_valid),                    //                            .valid
		.sync_ready                (video_stream_splitter_avalon_sync_source_ready),                    //                            .ready
		.stream_out_ready          (video_stream_source_ready),                                         // avalon_stream_router_source.ready
		.stream_out_data           (video_stream_source_data),                                          //                            .data
		.stream_out_startofpacket  (video_stream_source_startofpacket),                                 //                            .startofpacket
		.stream_out_endofpacket    (video_stream_source_endofpacket),                                   //                            .endofpacket
		.stream_out_valid          (video_stream_source_valid)                                          //                            .valid
	);

	Computer_System_Video_In_Subsystem_Edge_Detection_Subsystem_Video_Stream_Splitter video_stream_splitter (
		.clk                        (sys_clk_clk),                                                       //                           clk.clk
		.reset                      (rst_controller_reset_out_reset),                                    //                         reset.reset
		.stream_in_data             (video_stream_sink_data),                                            //     avalon_stream_router_sink.data
		.stream_in_startofpacket    (video_stream_sink_startofpacket),                                   //                              .startofpacket
		.stream_in_endofpacket      (video_stream_sink_endofpacket),                                     //                              .endofpacket
		.stream_in_valid            (video_stream_sink_valid),                                           //                              .valid
		.stream_in_ready            (video_stream_sink_ready),                                           //                              .ready
		.sync_ready                 (video_stream_splitter_avalon_sync_source_ready),                    //            avalon_sync_source.ready
		.sync_data                  (video_stream_splitter_avalon_sync_source_data),                     //                              .data
		.sync_valid                 (video_stream_splitter_avalon_sync_source_valid),                    //                              .valid
		.stream_out_ready_0         (video_stream_splitter_avalon_stream_router_source_0_ready),         // avalon_stream_router_source_0.ready
		.stream_out_data_0          (video_stream_splitter_avalon_stream_router_source_0_data),          //                              .data
		.stream_out_startofpacket_0 (video_stream_splitter_avalon_stream_router_source_0_startofpacket), //                              .startofpacket
		.stream_out_endofpacket_0   (video_stream_splitter_avalon_stream_router_source_0_endofpacket),   //                              .endofpacket
		.stream_out_valid_0         (video_stream_splitter_avalon_stream_router_source_0_valid),         //                              .valid
		.stream_out_ready_1         (video_stream_splitter_avalon_stream_router_source_1_ready),         // avalon_stream_router_source_1.ready
		.stream_out_data_1          (video_stream_splitter_avalon_stream_router_source_1_data),          //                              .data
		.stream_out_startofpacket_1 (video_stream_splitter_avalon_stream_router_source_1_startofpacket), //                              .startofpacket
		.stream_out_endofpacket_1   (video_stream_splitter_avalon_stream_router_source_1_endofpacket),   //                              .endofpacket
		.stream_out_valid_1         (video_stream_splitter_avalon_stream_router_source_1_valid),         //                              .valid
		.stream_select              (edge_detection_router_controller_external_connection_export)        //            external_interface.export
	);

	altera_reset_controller #(
		.NUM_RESET_INPUTS          (1),
		.OUTPUT_RESET_SYNC_EDGES   ("deassert"),
		.SYNC_DEPTH                (2),
		.RESET_REQUEST_PRESENT     (0),
		.RESET_REQ_WAIT_TIME       (1),
		.MIN_RST_ASSERTION_TIME    (3),
		.RESET_REQ_EARLY_DSRT_TIME (1),
		.USE_RESET_REQUEST_IN0     (0),
		.USE_RESET_REQUEST_IN1     (0),
		.USE_RESET_REQUEST_IN2     (0),
		.USE_RESET_REQUEST_IN3     (0),
		.USE_RESET_REQUEST_IN4     (0),
		.USE_RESET_REQUEST_IN5     (0),
		.USE_RESET_REQUEST_IN6     (0),
		.USE_RESET_REQUEST_IN7     (0),
		.USE_RESET_REQUEST_IN8     (0),
		.USE_RESET_REQUEST_IN9     (0),
		.USE_RESET_REQUEST_IN10    (0),
		.USE_RESET_REQUEST_IN11    (0),
		.USE_RESET_REQUEST_IN12    (0),
		.USE_RESET_REQUEST_IN13    (0),
		.USE_RESET_REQUEST_IN14    (0),
		.USE_RESET_REQUEST_IN15    (0),
		.ADAPT_RESET_REQUEST       (0)
	) rst_controller (
		.reset_in0      (~sys_reset_reset_n),             // reset_in0.reset
		.clk            (sys_clk_clk),                    //       clk.clk
		.reset_out      (rst_controller_reset_out_reset), // reset_out.reset
		.reset_req      (),                               // (terminated)
		.reset_req_in0  (1'b0),                           // (terminated)
		.reset_in1      (1'b0),                           // (terminated)
		.reset_req_in1  (1'b0),                           // (terminated)
		.reset_in2      (1'b0),                           // (terminated)
		.reset_req_in2  (1'b0),                           // (terminated)
		.reset_in3      (1'b0),                           // (terminated)
		.reset_req_in3  (1'b0),                           // (terminated)
		.reset_in4      (1'b0),                           // (terminated)
		.reset_req_in4  (1'b0),                           // (terminated)
		.reset_in5      (1'b0),                           // (terminated)
		.reset_req_in5  (1'b0),                           // (terminated)
		.reset_in6      (1'b0),                           // (terminated)
		.reset_req_in6  (1'b0),                           // (terminated)
		.reset_in7      (1'b0),                           // (terminated)
		.reset_req_in7  (1'b0),                           // (terminated)
		.reset_in8      (1'b0),                           // (terminated)
		.reset_req_in8  (1'b0),                           // (terminated)
		.reset_in9      (1'b0),                           // (terminated)
		.reset_req_in9  (1'b0),                           // (terminated)
		.reset_in10     (1'b0),                           // (terminated)
		.reset_req_in10 (1'b0),                           // (terminated)
		.reset_in11     (1'b0),                           // (terminated)
		.reset_req_in11 (1'b0),                           // (terminated)
		.reset_in12     (1'b0),                           // (terminated)
		.reset_req_in12 (1'b0),                           // (terminated)
		.reset_in13     (1'b0),                           // (terminated)
		.reset_req_in13 (1'b0),                           // (terminated)
		.reset_in14     (1'b0),                           // (terminated)
		.reset_req_in14 (1'b0),                           // (terminated)
		.reset_in15     (1'b0),                           // (terminated)
		.reset_req_in15 (1'b0)                            // (terminated)
	);

endmodule
