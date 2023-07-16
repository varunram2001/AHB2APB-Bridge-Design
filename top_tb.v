module top_tb();
reg hclk,hresetn;
wire hready_out,hwrite,hready_in;
wire [31:0]hr_data,haddr,hwdata,paddr,pwdata,paddrout,pwdataout,pr_data;
wire [1:0]hres,htrans;
wire penable,pwrite,pwriteout,penableout;
wire [2:0]psel,pselout;
ahb_master ahb(hclk,hresetn,hready_out,hr_data,haddr,hwdata,hwrite,hready_in,htrans);
bridgetop 
bridge(hclk,hresetn,hwrite,hready_in,htrans,hwdata,haddr,pr_data,penable,pwrite,hready_out,psel,hres
,paddr,pwdata,hr_data);
//apb_interface 
//apb(pwrite,psel,penable,paddr,pwdata,pwriteout,pselout,penableout,paddrout,pwdataout,pr_data);
initial
begin
hclk=1'b0;
forever #10 hclk=~hclk;
end
task reset();
begin
@(negedge hclk)
hresetn=1'b0;
@(negedge hclk)
hresetn=1'b1;
end
endtask
initial
begin
reset;
ahb.single_write();
end
endmodule
