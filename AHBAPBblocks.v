module ahb_slave_interface (
  input reg hclk,
  input reg hresetn,
  input reg hwrite,
  input reg hready_in,
  input reg [1:0] htrans,
  input reg [31:0] hwdata,
  input reg [31:0] haddr,
  input reg [31:0] pr_data,
  output reg hwrite_reg,
  output reg hwrite_reg1,
  output reg valid,
  output reg [1:0] hresp,
  output reg [31:0] hwdata1,
  output reg [31:0] hwdata2,
  output reg [31:0] haddr1,
  output reg [31:0] haddr2,
  output reg [31:0] hr_data,
  output reg [2:0] temp_sel
);

always @(posedge hclk) begin
  if (!hresetn) begin
    haddr1 <= 0;
    haddr2 <= 0;
  end else begin
    haddr1 <= haddr;
    haddr2 <= haddr1;
  end
end

always @(posedge hclk) begin
  if (!hresetn) begin
    hwdata1 <= 0;
    hwdata2 <= 0;
  end else begin
    hwdata1 <= hwdata;
    hwdata2 <= hwdata1;
  end
end

always @(posedge hclk) begin
  if (!hresetn) begin
    hwrite_reg1 <= 0;
    hwrite_reg <= 0;
  end else begin
    hwrite_reg1 <= hwrite_reg;
    hwrite_reg <= hwrite;
  end
end

always @* begin
  if (hready_in == 1'b1 && haddr >= 32'h8000_0000 && haddr < 32'h8c00_0000 && (htrans == 2'd10 || htrans == 2'd11))
    valid = 1;
  else
    valid = 0;
end

always @* begin
  if (haddr >= 32'h8000_0000 && haddr < 32'h8400_0000)
    temp_sel = 3'b001;
  else if (haddr >= 32'h8400_0000 && haddr < 32'h8800_0000)
    temp_sel = 3'b010;
  else if (haddr >= 32'h8800_0000 && haddr < 32'h8c00_0000) 
    temp_sel = 3'b111; 
  else
    temp_sel = 3'b000; 
end

endmodule