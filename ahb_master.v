module ahb_master(hclk,hresetn,hready_out,hr_data,haddr,hwdata,hwrite,hready_in,htrans);
input hclk,hresetn,hready_out;
input [31:0]hr_data;
output reg[31:0]haddr,hwdata;
output reg hwrite,hready_in,htrans;
reg [2:0]hburst;
reg [2:0]hsize;
task single_write();
begin
@(posedge hclk);
#1
begin
hwrite=1;
htrans=2'd2;
hsize=0;
hburst=0;
hready_in=1;
haddr=32'h8000_0001;
end
@(posedge hclk);
#1
begin
htrans=2'd0;
end
end
endtask
endmodule
