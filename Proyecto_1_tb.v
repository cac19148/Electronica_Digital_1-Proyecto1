module Proyecto_1_tb();

reg clk, reset, set, A, G, R, N, Back, Start, Mayor; 
reg [1:0]B;
wire [2:0]Y; wire[2:0]CS_Y; wire[2:0]FS_Y; wire [2:0]CS; wire[2:0]FS; wire[2:0]Display; wire[4:0]Despacho; 

FSM_Secundario FSM_1( clk, reset, FS_Y, CS_Y, A, G, R, N, Y);
FSM_Principal FSM_0(clk, reset, FS, CS, Y, B, Back, Start, Mayor, Despacho, Display);

initial begin
	clk=1;
	forever #5 clk = ~clk;  
end 



initial begin

	#1 $display("");
	$display("PROYECTO 1");
    $display("  CS  A  G  R  N  Back  Start  Mayor   B   Y  |  FS   Display  Despacho");
    $display("--------------------------------------------|------------------------");
    $monitor(" S%d  %d  %d  %d  %d   %d      %d      %d     %d   %d  |  S%d     %b      %b ", CS, A, G, R, N, Back, Start, Mayor, B, Y, FS, Display, Despacho);
	   
	#2  reset = 1; A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; 
	#5 reset=1;
	
	//Prueba de que Dispensador de Bebidas de Buffet solo inicia (Pasa de S0 a S1) cuando "Start" = 1
    #10  A = 1; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; reset=0;
    #10  A = 0; G = 1; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; 
    #10  A = 0; G = 0; R = 1; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; 
    #10  A = 0; G = 0; R = 0; N = 1; Back = 0; Start = 0; Mayor = 0; B = 2'b00; 
    #10  A = 0; G = 0; R = 0; N = 0; Back = 1; Start = 0; Mayor = 0; B = 2'b00; 
    #10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 1; B = 2'b00; 
    #10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b01; 
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b10; 
    #10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b11; 
    #10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; reset = 1;
	$display("");
	//Prueba de que se puede entrar a cada Sub-Menú (S2 para alcoholocas, S3 para gaseosas, S4 para rehidratantes y S5 para naturales) y regresar al Menú Principal (S1) 
    #10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00; reset = 0;
	#10  A = 1; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; 
    #10  A = 0; G = 0; R = 0; N = 0; Back = 1; Start = 0; Mayor = 0; B = 2'b00; 
    #10  A = 0; G = 1; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; 
	#10  A = 0; G = 0; R = 0; N = 0; Back = 1; Start = 0; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 1; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 1; Start = 0; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 1; Back = 0; Start = 0; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 1; Start = 0; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; reset = 1;
	$display("");
	//Prueba de que el Dispensador de Bebidas de Buffet solo dispensa al hacer una única selección (B=01 o B=10) y hacer que "Start" = 1
	//Prueba con Sub-Menú Gaseosas
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00; reset = 0;
	#10  A = 0; G = 1; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b01;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b10;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b11;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b01; 
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; reset = 1;
	//Prueba con Sub-Menú Rehidratantes
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00; reset = 0;
	#10  A = 0; G = 0; R = 1; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b01;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b10;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b11;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b10; 
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; reset = 1;
	//Prueba con Sub-Menú Naturales
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00; reset = 0;
	#10  A = 0; G = 0; R = 0; N = 1; Back = 0; Start = 0; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b01;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b10;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b11;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b10; 
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; reset = 1;
	$display("");
	//Prueba de que el sistema no permite despachar una Bebida Alcohólica si no se presenta un DPI (Mayor=1) 
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00; reset = 0;
	#10  A = 1; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b01;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b10;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b11;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b10;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 1; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b01;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b10;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b00;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b11;
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 1; Mayor = 0; B = 2'b01; 
	#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00; 
	
	//#10  A = 0; G = 0; R = 0; N = 0; Back = 0; Start = 0; Mayor = 0; B = 2'b00;	
	
	#10 $display("");
 end
	
initial
#630 $finish; 
 

initial begin
    $dumpfile("Proyecto_1_tb.vcd");
    $dumpvars(0, Proyecto_1_tb);
end

endmodule 