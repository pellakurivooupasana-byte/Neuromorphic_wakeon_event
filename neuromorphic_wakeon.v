module neuro_top(
input clk,
    input rst,
    input [7:0] pcm_data,
    input processor_ack,
    output wake_signal
);

wire [7:0] filtered_audio;
wire spike;
wire neuron_fire;
wire pattern_match;

bandpass_filter u1(
    .clk(clk),
    .rst(rst),
    .audio_in(pcm_data),
    .audio_out(filtered_audio)
);

spike_encoder u2(
    .clk(clk),
    .rst(rst),
    .audio(filtered_audio),
    .spike(spike)
);

lif_neuron u3(
    .clk(clk),
     .rst(rst),
    .spike_in(spike),
    .fire(neuron_fire)
);

pattern_matcher u4(
    .clk(clk),
    .rst(rst),
    .fire(neuron_fire),
    .match(pattern_match)
);

wake_latch u5(
    .clk(clk),
    .rst(rst),
    .pattern_match(pattern_match),
    .processor_ack(processor_ack),
    .wake(wake_signal)
);

endmodule
module bandpass_filter(
    input clk,
    input rst,
    input [7:0] audio_in,
    output reg [7:0] audio_out
);
always @(posedge clk or posedge rst)
begin
    if(rst)
        audio_out <= 8'd0;
    else
    begin
        if(audio_in > 8'd30 && audio_in < 8'd180)
            audio_out <= audio_in;
        else
            audio_out <= 8'd0;
    end
end

endmodule
module spike_encoder(
    input clk,
    input rst,
    input [7:0] audio,
    output reg spike
);

parameter THRESHOLD = 8'd80;

always @(posedge clk or posedge rst)
begin
    if(rst)
        spike <= 1'b0;
    else
     begin
        if(audio >= THRESHOLD)
            spike <= 1'b1;
        else
            spike <= 1'b0;
    end
end

endmodule
module lif_neuron(
    input clk,
    input rst,
    input spike_in,
    output reg fire
);

parameter THRESHOLD = 4;

reg [2:0] count;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        count <= 3'd0;
        fire <= 1'b0;
    end
    else
    begin
 fire <= 1'b0;

        if(spike_in)
        begin
            if(count == THRESHOLD-1)
            begin
                fire <= 1'b1;
                count <= 3'd0;
            end
            else
            begin
                count <= count + 1'b1;
            end
        end
    end
end

endmodule
module pattern_matcher(
    input clk,
    input rst,
    input fire,
    output reg match
);

reg [1:0] fire_count;
always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        fire_count <= 2'd0;
        match <= 1'b0;
    end
    else
    begin
        match <= 1'b0;

        if(fire)
        begin
            if(fire_count == 2'd1)
            begin
                match <= 1'b1;
                fire_count <= 2'd0;
            end
            else
            begin
                fire_count <= fire_count + 1'b1;
            end
        end
    end
end

endmodule
module wake_latch(
     input clk,
    input rst,
    input pattern_match,
    input processor_ack,
    output reg wake
);

always @(posedge clk or posedge rst)
begin
    if(rst)
        wake <= 1'b0;
    else
    begin
        if(pattern_match)
            wake <= 1'b1;
        else if(processor_ack)
            wake <= 1'b0;
    end
end

endmodule