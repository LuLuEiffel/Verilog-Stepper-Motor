module motorController(clk, rst, speedValue, stepSizeKey, quarterTurnKey, operationModekey, speedControllerOut);

	input wire clk, rst, stepSizeKey, quarterTurnKey, operationModekey;
	input wire [3:0] speedValue;
	
	
	output wire speedControllerOut;
	
	wire countMaxOut;
	wire quarterTrunOut;
	wire [23:0]maxCountBusWire;

	MaxCount maxCount(.clk(clk), .rst(rst), .speedValue(speedValue), .stepSizeKey(stepSizeKey),
					  .maxCountOut(maxCountBusWire));
					  
	CountToMax CountToMax(.clk(clk), .rst(rst), .endCountValue(maxCountBusWire), .countMaxOutOut(countMaxOut));
	
	quarterTurn quarterTurn(.clk(clk), .rst(rst), .quarterTurnKey((quarterTurnKey)), .in(countMaxOut),
							.stepSizeKey(stepSizeKey), . quarterTurnOut(quarterTrunOut));

	assign speedControllerOut = (operationModekey)? countMaxOut: quarterTrunOut; // MUX2:1

endmodule
