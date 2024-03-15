module cordic_rotate 
(
    input clk,
    input rst_n,
    input [N-1:0] angle,
    input angle_valid,
    input [15:0] x_in,
    input [15:0] y_in,

    output [15:0] x_out,
    output [15:0] y_out
);
parameter N = 16;
reg signed [15:0] ANGLE [0:13];// = {16'd6434, 16'd3798, 16'd2007, 16'd1019, 16'd511, 16'd256, 16'd128, 16'd64, 16'd32, 16'd16, 16'd8, 16'd4, 16'd2, 16'd1};
reg signed [31:0] cosz_t;
reg signed [31:0] sinz_t;
reg signed[N-1:0] z_t;

assign x_out = cosz_t[31:16];
assign y_out = sinz_t[31:16];

initial begin
    ANGLE[0] = 16'd6434;
    ANGLE[1] = 16'd3798;
    ANGLE[2] = 16'd2007;
    ANGLE[3] = 16'd1019;
    ANGLE[4] = 16'd511;
    ANGLE[5] = 16'd256;
    ANGLE[6] = 16'd128;
    ANGLE[7] = 16'd64;
    ANGLE[8] = 16'd32;
    ANGLE[9] = 16'd16;
    ANGLE[10] = 16'd8;
    ANGLE[11] = 16'd4;
    ANGLE[12] = 16'd2;
    ANGLE[13] = 16'd1;
end

reg angle_valid_t;
always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        angle_valid_t <= 1'b0;
    end else begin
        angle_valid_t <= angle_valid;
    end
end

reg [7:0] current_state;
reg [7:0] next_state;
always @(posedge clk or negedge rst_n) begin       
    if(rst_n == 1'b0) begin          
        current_state <= 8'd0;    
    end       
    else begin           
        current_state <= next_state;     
    end   
end
always @(*) begin
    case (current_state)
        8'd0: begin
            if (angle_valid == 1'b0 && angle_valid_t == 1'b1) begin
                next_state = 8'd1;
            end else begin
                next_state = 8'd0;
            end
        end
        8'd1:  next_state = 8'd2;
        8'd2:  next_state = 8'd3;
        8'd3:  next_state = 8'd4;
        8'd4:  next_state = 8'd5;
        8'd5:  next_state = 8'd6;
        8'd6:  next_state = 8'd7;
        8'd7:  next_state = 8'd8;
        8'd8:  next_state = 8'd9;
        8'd9:  next_state = 8'd10;
        8'd10: next_state = 8'd11;
        8'd11: next_state = 8'd12;
        8'd12: next_state = 8'd13;
        8'd13: next_state = 8'd14;
        8'd14: next_state = 8'd15;
        8'd15: next_state = 8'd16;
        8'd16: next_state = 8'd0;
        default: next_state = 8'd0;
    endcase
end

always @(posedge clk or negedge rst_n) begin
    if (rst_n == 1'b0) begin
        cosz_t <= 32'd0;
        sinz_t <= 32'd0;
        z_t <= 'd0;
    end else begin
        case (current_state)
            8'd0: begin
                cosz_t <= {x_in,{16{x_in[N-1]}}};
                sinz_t <= {y_in,{16{y_in[N-1]}}};
            end
            8'd1: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[0];
                    cosz_t <= cosz_t - (sinz_t >>> 1);
                    sinz_t <= sinz_t + (cosz_t >>> 1);
                end else begin
                    z_t <= z_t - ANGLE[0];
                    cosz_t <= cosz_t + (sinz_t >>> 1);
                    sinz_t <= sinz_t - (cosz_t >>> 1);
                end
            end
            8'd2: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[1];
                    cosz_t <= cosz_t - (sinz_t >>> 2);
                    sinz_t <= sinz_t + (cosz_t >>> 2);
                end else begin
                    z_t <= z_t - ANGLE[1];
                    cosz_t <= cosz_t + (sinz_t >>> 2);
                    sinz_t <= sinz_t - (cosz_t >>> 2);
                end
            end
            8'd3: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[2];
                    cosz_t <= cosz_t - (sinz_t >>> 3);
                    sinz_t <= sinz_t + (cosz_t >>> 3);
                end else begin
                    z_t <= z_t - ANGLE[2];
                    cosz_t <= cosz_t + (sinz_t >>> 3);
                    sinz_t <= sinz_t - (cosz_t >>> 3);
                end
            end
            8'd4: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[3];
                    cosz_t <= cosz_t - (sinz_t >>> 4);
                    sinz_t <= sinz_t + (cosz_t >>> 4);
                end else begin
                    z_t <= z_t - ANGLE[3];
                    cosz_t <= cosz_t + (sinz_t >>> 4);
                    sinz_t <= sinz_t - (cosz_t >>> 4);
                end
            end
            8'd5: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[4];
                    cosz_t <= cosz_t - (sinz_t >>> 5);
                    sinz_t <= sinz_t + (cosz_t >>> 5);
                end else begin
                    z_t <= z_t - ANGLE[4];
                    cosz_t <= cosz_t + (sinz_t >>> 5);
                    sinz_t <= sinz_t - (cosz_t >>> 5);
                end
            end
            8'd6: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[5];
                    cosz_t <= cosz_t - (sinz_t >>> 6);
                    sinz_t <= sinz_t + (cosz_t >>> 6);
                end else begin
                    z_t <= z_t - ANGLE[5];
                    cosz_t <= cosz_t + (sinz_t >>> 6);
                    sinz_t <= sinz_t - (cosz_t >>> 6);
                end
            end
            8'd7: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[6];
                    cosz_t <= cosz_t - (sinz_t >>> 7);
                    sinz_t <= sinz_t + (cosz_t >>> 7);
                end else begin
                    z_t <= z_t - ANGLE[6];
                    cosz_t <= cosz_t + (sinz_t >>> 7);
                    sinz_t <= sinz_t - (cosz_t >>> 7);
                end
            end
            8'd8: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[7];
                    cosz_t <= cosz_t - (sinz_t >>> 8);
                    sinz_t <= sinz_t + (cosz_t >>> 8);
                end else begin
                    z_t <= z_t - ANGLE[7];
                    cosz_t <= cosz_t + (sinz_t >>> 8);
                    sinz_t <= sinz_t - (cosz_t >>> 8);
                end
            end
            8'd9: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[8];
                    cosz_t <= cosz_t - (sinz_t >>> 9);
                    sinz_t <= sinz_t + (cosz_t >>> 9);
                end else begin
                    z_t <= z_t - ANGLE[8];
                    cosz_t <= cosz_t + (sinz_t >>> 9);
                    sinz_t <= sinz_t - (cosz_t >>> 9);
                end
            end
            8'd10: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[9];
                    cosz_t <= cosz_t - (sinz_t >>> 10);
                    sinz_t <= sinz_t + (cosz_t >>> 10);
                end else begin
                    z_t <= z_t - ANGLE[9];
                    cosz_t <= cosz_t + (sinz_t >>> 10);
                    sinz_t <= sinz_t - (cosz_t >>> 10);
                end
            end
            8'd11: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[10];
                    cosz_t <= cosz_t - (sinz_t >>> 11);
                    sinz_t <= sinz_t + (cosz_t >>> 11);
                end else begin
                    z_t <= z_t - ANGLE[10];
                    cosz_t <= cosz_t + (sinz_t >>> 11);
                    sinz_t <= sinz_t - (cosz_t >>> 11);
                end
            end
            8'd12: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[11];
                    cosz_t <= cosz_t - (sinz_t >>> 12);
                    sinz_t <= sinz_t + (cosz_t >>> 12);
                end else begin
                    z_t <= z_t - ANGLE[11];
                    cosz_t <= cosz_t + (sinz_t >>> 12);
                    sinz_t <= sinz_t - (cosz_t >>> 12);
                end
            end
            8'd13: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[12];
                    cosz_t <= cosz_t - (sinz_t >>> 13);
                    sinz_t <= sinz_t + (cosz_t >>> 13);
                end else begin
                    z_t <= z_t - ANGLE[12];
                    cosz_t <= cosz_t + (sinz_t >>> 13);
                    sinz_t <= sinz_t - (cosz_t >>> 13);
                end
            end
            8'd14: begin
                if (z_t <= angle) begin
                    z_t <= z_t + ANGLE[13];
                    cosz_t <= cosz_t - (sinz_t >>> 14);
                    sinz_t <= sinz_t + (cosz_t >>> 14);
                end else begin
                    z_t <= z_t - ANGLE[13];
                    cosz_t <= cosz_t + (sinz_t >>> 14);
                    sinz_t <= sinz_t - (cosz_t >>> 14);
                end
            end
            8'd15: begin
                z_t <= z_t;
                cosz_t <= cosz_t;
                sinz_t <= sinz_t;
            end
            8'd16: begin

            end        
            default: begin

            end
        endcase
    end
end

endmodule
