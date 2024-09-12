/*
 * 
 * FINAL PROJECT - top level module
 *
 */
 
`timescale 1ps/1ps

/*****************************************************************************
 *                               Main Module                                 *
 *****************************************************************************/
module labyrinth(
		SW,
		KEY,
		LEDR,
		CLOCK_50,						//	On Board 50 MHz
		// The ports below are for the VGA output.  Do not change.
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK_N,						//	VGA BLANK
		VGA_SYNC_N,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,   							//	VGA Blue[9:0]);
		// PS2 stuff //
		PS2_CLK,
		PS2_DAT
);

	// temporary inputs
	input [3:0]SW;
	input [3:0]KEY;
	input [3:0]LEDR;
	
	// Bidirectionals
	inout PS2_CLK;
	inout PS2_DAT;

	//.................... VGA THINGS -- DO NOT TOUCH !!! ....................//
	input				CLOCK_50;				//	50 MHz
//	input				KEY;					
	// Declare your inputs and outputs here
	// Do not change the following outputs
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[7:0] Changed from 10 to 8-bit DAC
	output	[7:0]	VGA_G;	 				//	VGA Green[7:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[7:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	// Create the colour, x, y and writeEn wires that are inputs to the controller.

//	wire [5:0] colour;
//	wire [13:0] x;
//	wire [11:0] y;
	wire [2:0] colour;
	wire [7:0] x;
	wire [6:0] y;
	
//	wire [2:0] colour_again;
//	wire [7:0] x_again;
//	wire [6:0] y_again;
	
	wire writeEn;
	wire hitWall;
	wire won;
	
	vga_adapter VGA(
		.resetn(resetn),
		.clock(CLOCK_50),
		.colour(colour),
		.x(x),
		.y(y),
		.plot(writeEn),
		/* Signals for the DAC to drive the monitor. */
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B),
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_BLANK(VGA_BLANK_N),
		.VGA_SYNC(VGA_SYNC_N),
		.VGA_CLK(VGA_CLK));
	defparam VGA.RESOLUTION = "160x120";
	defparam VGA.MONOCHROME = "FALSE";
	defparam VGA.BITS_PER_COLOUR_CHANNEL = 2;
	defparam VGA.BACKGROUND_IMAGE = "maze.mif";
	
	//........................................................................//
	// connect output directions of "FSM_1" to input directions of "animate"
	wire go_u, go_d, go_l, go_r; // directions
	
	//wire go_next = 1'b1; // start drawing
	
	
	// connect output of moveBox to input of connectBox
	wire x_out, y_out, colour_out, write_out;
	
	// new "oDone"
	wire endDone;

	// Internal Wires
	wire [7:0] ps2_key_data;
	wire ps2_key_pressed;

	//........................................................................//
	// Internal Registers
	reg [7:0] last_data_received;

	always @(posedge CLOCK_50)
	begin
		if (KEY[0] == 1'b0)
			last_data_received <= 8'h00;
		else if (ps2_key_pressed == 1'b1)
			last_data_received <= ps2_key_data;
	end

	// SHOW OUTPUT 
	/*Right Arrow Key: Make code is E074 and Break code is E0F0741.
	Up Arrow Key: Make code is E075 and Break code is E0F0751.
	Down Arrow Key: Make code is E072 and Break code is E0F0721.
	Left Arrow Key: Make code is E06B and Break code is E0F06B1.
	Enter Key: Make code is 5A and Break code is F05A
	*/
	assign LEDR[0] = (last_data_received == 8'h74); // RIGHT
	assign LEDR[1] = (last_data_received == 8'h75); // UP
	assign LEDR[2] = (last_data_received == 8'h72); // DOWN
	assign LEDR[3] = (last_data_received == 8'h6B); // LEFT
	
	assign go_u = (ps2_key_data == 8'h75); // UP
	assign go_d = (ps2_key_data == 8'h72); // DOWN
	assign go_l = (ps2_key_data == 8'h6B); // LEFT
	assign go_r = (ps2_key_data == 8'h74); // RIGHT
//		
	//........................................................................//
	
	//---------------------------------------------------------------------//
	//                      top level module for inputs                    //
	//---------------------------------------------------------------------//
	
//	PS2KeyBoardWithLights u0(
//		// Inputs
//		.CLOCK_50(CLOCK_50),
//		.KEY(KEY),
//
//		// Bidirectionals
//		.PS2_CLK(PS2_CLK),
//		.PS2_DAT(PS2_DAT),
//	
//		// Outputs
//		.LEDR(LEDR)
//	);
//	
//	//---------------------------------------------------------------------//
//	//                   top level module for background                   //
//	//---------------------------------------------------------------------//
	
//	fill u1(
//		CLOCK_50,						//	On Board 50 MHz
//		// Your inputs and outputs here
//		KEY,									// On Board Keys
//		SW,
//		// The ports below are for the VGA output.  Do not change.
//		VGA_CLK,   					//	VGA Clock
//		VGA_HS,							//	VGA H_SYNC
//		VGA_VS,							//	VGA V_SYNC
//		VGA_BLANK_N,				//	VGA BLANK
//		VGA_SYNC_N,				//	VGA SYNC
//		VGA_R,   							//	VGA Red[9:0]
//		VGA_G,	 							//	VGA Green[9:0]
//		VGA_B   							//	VGA Blue[9:0]
//	);

//	//---------------------------------------------------------------------//
//	//                    top level module for animation                   //
//	//---------------------------------------------------------------------//
//	
//	animate u2(
//		.CLOCK_50(CLOCK_50),						//	On Board 50 MHz
//		// Your inputs and outputs here
//		.KEY(KEY),									// On Board Keys
//		// The ports below are for the VGA output.  Do not change.
//		.VGA_CLK(VGA_CLK),   					//	VGA Clock
//		.VGA_HS(VGA_HS),							//	VGA H_SYNC
//		.VGA_VS(VGA_VS),							//	VGA V_SYNC
//		.VGA_BLANK_N(VGA_BLANK_N),				//	VGA BLANK
//		.VGA_SYNC_N(VGA_SYNC_N),				//	VGA SYNC
//		.VGA_R(VGA_R),   							//	VGA Red[9:0]
//		.VGA_G(VGA_G),	 							//	VGA Green[9:0]
//		.VGA_B(VGA_B)   							//	VGA Blue[9:0]
//	);
	//........................................................................//

//	PS2KeyBoardWithLights u0(
//		// Inputs
//		.CLOCK_50(CLOCK_50),
//		.KEY(KEY),
//
//		// Bidirectionals
//		.PS2_CLK(PS2_CLK),
//		.PS2_DAT(PS2_DAT),
//	
//		// Outputs
//		.LEDR(LEDR)
//	);
	
	// static display
//	staticMaze v1(
//		.Clock(CLOCK_50),
//		.reset(resetn),
//		
//		.count_horizontal(x),
//		.count_vertical(y),
//			
//		.colour(colour),
//		.wall(hitwall),
//		.win(won)
//	);
		
	PS2_Controller PS2(
		// Inputs
		.CLOCK_50	(CLOCK_50),
		.reset		(resetn),

		// Bidirectionals
		.PS2_CLK			(PS2_CLK),
		.PS2_DAT			(PS2_DAT),

		// Outputs
		.received_data		(ps2_key_data),
		.received_data_en	(ps2_key_pressed)
	);
	
	conectBox u2(
		.iResetn(resetn),
		.iClock(CLOCK_50),
		
		.nextStep(SW[3]),
		
		.up(go_u),
		.down(go_d),
		.left(go_l),
		.right(go_r),
		
		.oX(x),
		.oY(y),
		.oColour(colour),
		.oPlot(writeEn)
	);
	
//	
//	// character movement
//	FSM_1 f1(
//		.clock(CLOCK_50),
//		.reset(resetn),
//		
//		// input directions (REPLACE WITH KEYBOARD INPUTS LATER !!!!!!!!!!!!)
//		.up(SW[0]),
//		.down(SW[1]),
//		.left(SW[2]),
//		.right(SW[3]),
//		
//		.load(hitwall), // input from (static_maze)
//		.enable(go_next), // output to (animate)
//		
//		// output directions to (animate)
//		.u(go_u),
//		.d(go_d),
//		.l(go_l),
//		.r(go_r)
//	);
	
//	// start drawing for animation
//	conectBox v2(
//		.iResetn(resetn),
//		.iClock(CLOCK_50),
//		
//		.nextStep(go_next),
//		
//		// inputs from FSM_1
//		.up(go_up),
//		.down(go_down),
//		.left(go_left),
//		.right(go_right),
//		
//		.oX(x_out),
//		.oY(y_out),
//		.oColour(colour_out),
//		.oPlot(write_out)
//	);
	
	
	
	//---------------------------------------------------------------------//
	//                   combined module for "keyboard"                    //
	//---------------------------------------------------------------------//
	/*
	 * from file: PS2KeyBoardWithLights.v (includes PS2_Controler.v)
	 */
//	PS2_Controller PS2(
//		// Inputs
//		.CLOCK_50	(CLOCK_50),
//		.reset		(resetn),
//
//		// Bidirectionals
//		.PS2_CLK			(PS2_CLK),
//		.PS2_DAT			(PS2_DAT),
//
//		// Outputs
//		.received_data		(ps2_key_data),
//		.received_data_en	(ps2_key_pressed)
//	);
	
	//---------------------------------------------------------------------//
	//                    module for "static maze visual"                  //
	//---------------------------------------------------------------------//
	/*
	 * from file: fill.v (includes staticMaze.v & vga_adapter.v)
	 */
	
//	staticMaze v1(
//		.Clock(CLOCK_50),
//		.reset(resetn),
//		
//		.count_horizontal(x),
//		.count_vertical(y),
//		
//		.colour(colour),
//		.wall(hitwall),
//		.win(won)
//	);
	
	//---------------------------------------------------------------------//
	//                     combined module for "FSM 2"                     //
	//---------------------------------------------------------------------//
	/*
	 * from file: FSM_2.v
	 */
//	FSM_2 f2(
//		.Clock(CLOCK_50),
//		.Reset(resetn),
//		
//		.ps2_key_data_en(ps2_key_data_en),
//		.DataIn(last_data_received),
//		.DataResult(),
//		.updates(),
//		.won(won)
//	);
	
	//---------------------------------------------------------------------//
	//                     combined module for "FSM 1"                     //
	//---------------------------------------------------------------------//
	/*
	 * from file: FSM_1.v
	 */
//	FSM_1 f1(
//		.clock(CLOCK_50),
//		.reset(resetn),
//		
//		// input directions (REPLACE WITH KEYBOARD INPUTS LATER !!!!!!!!!!!!)
//		.up(SW[0]),
//		.down(SW[1]),
//		.left(SW[2]),
//		.right(SW[3]),
//		
//		.load(hitwall), // input from (static_maze)
//		.enable(go_next), // output to (animate)
//		
//		// output directions to (animate)
//		.u(go_u),
//		.d(go_d),
//		.l(go_l),
//		.r(go_r)
//	);

	//---------------------------------------------------------------------//
	//                       modules for "animation"                       //
	//---------------------------------------------------------------------//
	/*
	 * from file: animate.v (includes conectBox.v & vga_adapter.v)
	 */

//	conectBox v2(
//		.iResetn(resetn),
//		.iClock(CLOCK_50),
//		
//		.nextStep(go_next),
//		
//		// inputs from FSM_1
//		.up(go_up),
//		.down(go_down),
//		.left(go_left),
//		.right(go_right),
//		
//		.oX(x),
//		.oY(y),
//		.oColour(colour),
//		.oPlot(writeEn)
//	);

endmodule
 