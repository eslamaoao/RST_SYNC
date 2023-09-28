`timescale 1ns/1ps
module RST_SYNC_TB ;


/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////

parameter CLK_PERIOD = 100 ; 
parameter NUM_STAGES_TB = 3 ; 

/////////////////////////////////////////////////////////
//////////////////// DUT Signals ////////////////////////
/////////////////////////////////////////////////////////

reg CLK_TB,RST_TB;
wire SYNC_RST_TB;


initial
  begin
  initialize() ;
  reset ();
  #(3*CLK_PERIOD); /// cause the num of stages is 3
   if (SYNC_RST_TB == 1'b1)
	$display ("test case succeeded");
	  else
	$display ("test case failed");
  #5000;
  $stop;
  
  
  
  end


/////////////// Signals Initialization //////////////////

task initialize ;
  begin
	CLK_TB    	  = 1'b0  ;
	RST_TB    	  = 1'b1  ;    
  end
endtask

///////////////////////// RESET /////////////////////////

task reset ;
 begin
  #(CLK_PERIOD)
  RST_TB  = 'b0;           // rst is activated
  #(CLK_PERIOD)
  #50
  RST_TB  = 'b1;
  #(CLK_PERIOD) ;
 end
endtask


///////////////////// Clock Generator //////////////////

always #(CLK_PERIOD/2.0) CLK_TB = ~CLK_TB ;




// Design Instaniation
RST_SYNC #(.NUM_STAGES(NUM_STAGES_TB)) DUT  
(
.CLK			(CLK_TB),           
.RST			(RST_TB),             
.SYNC_RST	  	(SYNC_RST_TB)
);


endmodule 	