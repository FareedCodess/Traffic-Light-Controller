module tlc_time(input clk,
	input reset,
	input  enable, 
	output reg s4, s3, s2, s1, 
	output reg[3:0] t4,t3,t2,t1);

// Assigning the initial values.
t1 = 5; t2 = 5; t3 = 10; t4 = 15;
reg[1:0] state;
reg[1:0] next_state;

// Four States
parameter STATE1 = 2'b00, STATE2 = 2'b01,STATE3 = 2'b10,STATE4 = 2'b11;

always @(posedge clk, posedge reset)// Asynchronous reset
	if (reset) begin 
	state <= STATE1;
	t1 <= 5; 
	t2 <= 5; 
	t3 <= 10; 
	t4 <= 15; end

	// Each time signal will be counted down and assigned initial values accordingly upon reaching 0.
	else if(enable) begin
	state <= next_state;
	if (t1 == 0 && t2 == 0) begin t1 <= 15 ; t2 <= 5; end
	else if ( t2 == 0 && t3 == 0) begin t2 <= 15 ; t3 <= 5 ; end
	else if ( t3 == 0 && t4 == 0) begin t3 <= 15 ; t4 <= 5 ; end
	else if ( t4 == 0 && t1 == 0) begin t4 <= 15 ; t1 <= 5 ; end
	else begin
		t1 <= t1 - 1; 
		t2 <= t2 - 1; 
		t3 <= t3 - 1;  
		t4 <= t4 - 1; 
		end 
	end

	// Inner always block to detect changes in the state and times, and accordingly change the state.
	// Moore finite state machine

	always@(state, t1, t2, t3, t4)begin
	s1 = 0; s2 = 0; s3 = 0; s4 = 0;
	case (state)
	STATE1:
	begin s1 = 1 ; if (t1 == 0 && t2 == 0) next_state = STATE2;
			   else next_state = STATE1;  end
	STATE2:
	begin s2 = 1 ; if (t2 == 0 && t3 == 0) next_state = STATE3;
			   else next_state = STATE2;  end
	STATE3:
	begin s3 = 1 ; if (t3 == 0 && t4 == 0) next_state = STATE4;
			   else next_state = STATE3;  end
	STATE4:
	begin s4 = 1 ; if (t4 == 0 && t1 == 0) next_state = STATE1;
			   else next_state = STATE4;  end	
	endcase
	end
end
endmodule