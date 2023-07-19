module apb_interface(input pwrite, penable, input [2:0]psel, input [31:0]paddr, pwdata,
output pwrite_out, penable_out, output [2:0]psel_out, output[31:0]paddr_out, pwdata_out,
output reg [31:0] pr_data);

assign pwrite_out=pwrite;
assign paddr_out=paddr;
assign psel_out=psel;
assign pwdata_out=pwdata;
assign penable_out=penable;

always@(*)
begin
if (!pwrite && penable)
pr_data={$random)%256;
else
pr_data=0;
end

endmodule
