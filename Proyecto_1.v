
//FLipFlopD3bits

module FLipFlopD3bits(input wire [2:0] D,input wire clk,input wire reset,output [2:0] Q);
reg Q;
	always @(posedge clk or posedge reset)  
		begin
			if(reset)
				begin
					Q <= 3'b000; 
				end
			else 
				begin
					Q <= D;
				end
		end
endmodule 

module FSM_Secundario (input wire clk, reset, input wire [2:0]FS_Y, input wire [2:0]CS_Y, input wire A, G, R, N, output wire [2:0]Y);

	FLipFlopD3bits U1(FS_Y, clk, reset, CS_Y);
	
	assign FS_Y[2] = (~CS_Y[1]&~CS_Y[0]&~A&~G&~R&N);
	assign FS_Y[1] = (~CS_Y[2]&~CS_Y[0]&~A&G&~R&~N)|(~CS_Y[2]&CS_Y[1]&CS_Y[0]&~A&~G&R&~N)|(~CS_Y[2]&~CS_Y[1]&~CS_Y[0]&~A&~G&R&~N);
	assign FS_Y[0] = (~CS_Y[2]&~CS_Y[1]&A&~G&~R&~N)|(~CS_Y[2]&CS_Y[1]&CS_Y[0]&~A&~G&R&~N)|(~CS_Y[2]&~CS_Y[1]&~CS_Y[0]&~A&~G&R&~N);
	
	assign Y[2] = (~CS_Y[2]&~CS_Y[1]&~CS_Y[0]&~A&~G&~R&N);
	assign Y[1] = (~CS_Y[2]&~CS_Y[1]&~CS_Y[0]&~A&~G&R&~N)|(~CS_Y[2]&~CS_Y[1]&~CS_Y[0]&~A&G&~R&~N);
	assign Y[0] = (~CS_Y[2]&~CS_Y[1]&~CS_Y[0]&~A&~G&R&~N)|(~CS_Y[2]&~CS_Y[1]&~CS_Y[0]&A&~G&~R&~N);
	
endmodule

module FSM_Principal (input wire clk, reset, input wire [2:0]FS, input wire [2:0]CS, input wire [2:0]Y, input wire [1:0]B, input wire Back, Start, Mayor, output wire [4:0] Despacho, output wire [2:0] Display);

	FLipFlopD3bits U2(FS, clk, reset, CS);
	
	assign FS[2] = (CS[2]&~CS[1]&B[1]&B[0])|(CS[2]&~CS[0]&B[1]&B[0])|(~CS[2]&CS[1]&~CS[0]&~Back&Mayor)|(~CS[2]&~CS[1]&CS[0]&~Y[2]&Y[1]&Y[0])|(~CS[2]&~CS[1]&CS[0]&Y[2]&~Y[1]&~Y[0])|(CS[2]&~CS[1]&Back&Start)|(CS[2]&CS[1]&~CS[0]&~Start)|(CS[2]&~CS[1]&~Start&B[1])|(CS[2]&~CS[1]&~Start&B[0])|(CS[2]&CS[1]&~CS[0]&~B[1]&~B[0])|(CS[2]&~CS[1]&~Back&~B[1]&~B[0]);
	assign FS[1] = (CS[2]&CS[1]&~CS[0]&~Start)|(~CS[2]&~CS[1]&CS[0]&~Y[2]&~Y[1]&Y[0])|(~CS[2]&~CS[1]&CS[0]&~Y[2]&Y[1]&~Y[0])|(~CS[2]&CS[1]&~CS[0]&~Back)|(~CS[2]&CS[1]&Back&Start)|(~CS[2]&CS[1]&CS[0]&~Start&B[1])|(CS[1]&~CS[0]&~Start&Mayor&B[1])|(~CS[2]&CS[1]&CS[0]&~Start&B[0])|(CS[1]&~CS[0]&~Start&Mayor&B[0])|(~CS[2]&CS[1]&Start&B[1]&B[0])|(CS[1]&~CS[0]&Start&B[1]&B[0])|(~CS[2]&CS[1]&~Back&~B[1]&~B[0])|(CS[1]&~CS[0]&Start&~B[1]&~B[0]);
	assign FS[0] = (~CS[2]&CS[1]&CS[0]&Back)|(CS[2]&~CS[1]&CS[0]&Back)|(~CS[2]&CS[1]&CS[0]&~Start)|(CS[2]&~CS[1]&CS[0]&~Start)|(~CS[2]&~CS[1]&~CS[0]&~Back&Start)|(~CS[2]&CS[1]&Back&~Start&~Mayor)|(~CS[2]&CS[1]&CS[0]&B[1]&B[0])|(CS[2]&~CS[1]&CS[0]&B[1]&B[0])|(~CS[2]&CS[1]&CS[0]&~B[1]&~B[0])|(CS[2]&~CS[1]&CS[0]&~B[1]&~B[0])|(~CS[2]&CS[1]&Back&~Start&~B[1]&~B[0])|(CS[2]&~CS[1]&Back&~Start&~B[1]&~B[0])|(~CS[2]&~CS[1]&CS[0]&Y[2])|(~CS[2]&~CS[1]&CS[0]&~Y[0]);
	
	assign Display[2] = (CS[2]&~CS[1])|(CS[2]&~CS[0])|(CS[1]&~CS[0]&Back&Start&~Mayor);
	assign Display[1] = (~CS[2]&CS[1])|(CS[1]&~CS[0]);
	assign Display[0] = (~CS[2]&CS[0])|(~CS[1]&CS[0]);
	
	assign Despacho[4] = (CS[2]&CS[1]&~CS[0]&Start&~B[1]&B[0])|(CS[2]&~CS[1]&~Back&Start&~B[1]&B[0])|(CS[2]&CS[1]&~CS[0]&Start&B[1]&~B[0])|(CS[2]&~CS[1]&~Back&Start&B[1]&~B[0]);
	assign Despacho[3] = (CS[2]&CS[1]&~CS[0]&Start&~B[1]&B[0])|(CS[2]&CS[1]&~CS[0]&Start&B[1]&~B[0])|(~CS[2]&CS[1]&CS[0]&~Back&Start&~B[1]&B[0])|(~CS[2]&CS[1]&CS[0]&~Back&Start&B[1]&~B[0]);
	assign Despacho[2] = (~CS[2]&CS[1]&CS[0]&~Back&Start&~B[1]&B[0])|(CS[2]&~CS[1]&CS[0]&~Back&Start&~B[1]&B[0])|(~CS[2]&CS[1]&CS[0]&~Back&Start&B[1]&~B[0])|(CS[2]&~CS[1]&CS[0]&~Back&Start&B[1]&~B[0]);
	assign Despacho[1] = (CS[2]&CS[1]&~CS[0]&Start&B[1]&~B[0])|(CS[2]&~CS[1]&~Back&Start&B[1]&~B[0])|(~CS[2]&CS[1]&CS[0]&~Back&Start&B[1]&~B[0]);
	assign Despacho[0] = (CS[2]&CS[1]&~CS[0]&Start&~B[1]&B[0])|(CS[2]&~CS[1]&~Back&Start&~B[1]&B[0])|(~CS[2]&CS[1]&CS[0]&~Back&Start&~B[1]&B[0]);
	
endmodule