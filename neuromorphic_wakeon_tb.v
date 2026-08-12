

module neuro_tb;

reg clk;
reg rst;
reg [7:0] pcm_data;
reg processor_ack;

wire wake_signal;

// DUT
neuro_top DUT (
    .clk(clk),
    .rst(rst),
    .pcm_data(pcm_data),
    .processor_ack(processor_ack),
    .wake_signal(wake_signal)
);

// Clock Generation
always #5 clk = ~clk;

initial
begin
    clk = 0;
    rst = 1;
    pcm_data = 8'd0;
    processor_ack = 0;

    #20;
    rst = 0;

    // -------------------------
    // Noise (No Spike)
    // -------------------------
    pcm_data = 8'd10;  #10;
    pcm_data = 8'd20;  #10;
    pcm_data = 8'd25;  #10;
    pcm_data = 8'd30;  #10;

    // -------------------------
    // Voice Samples (>80)
    // 8 spikes -> 2 fires -> match
    // -------------------------
    pcm_data = 8'd100; #10;
    pcm_data = 8'd110; #10;
    pcm_data = 8'd120; #10;
    pcm_data = 8'd130; #10;

    pcm_data = 8'd140; #10;
    pcm_data = 8'd150; #10;
    pcm_data = 8'd160; #10;
    pcm_data = 8'd170; #10;

    // Keep High for few clocks
    pcm_data = 8'd170; #50;

    // Silence
    pcm_data = 8'd0; #30;

    // Clear Wake Signal
    processor_ack = 1;
    #20;
    processor_ack = 0;

    #50;

    $stop;

end

endmodule
