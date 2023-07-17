module bridgetop (
  input hclk, hresetn, hwrite, hreadyin,
  input [1:0] htrans,
  input [31:0] hwdata, haddr, prdata,
  output penable, pwrite, hreadyout,
  output [31:0] paddr, pwdata, hrdata,
  output [2:0] pselx,
  output [1:0] hres
);

  wire [31:0] haddr1, haddr2, hwdata1, hwdata2;
  wire [2:0] temp_selx;
  wire valid, hwrite_reg, hwrite_reg1;

  ahb_slave_interface k1(
    .hclk(hclk),
    .hresetn(hresetn),
    .hwrite(hwrite),
    .hreadyin(hreadyin),
    .haddr(haddr),
    .hwdata(hwdata),
    .prdata(prdata),
    .htrans(htrans),
    .hrdata(hrdata),
    .hres(hres),
    .hwrite_reg(hwrite_reg),
    .hwrite_reg1(hwrite_reg1),
    .valid(valid),
    .hwdata1(hwdata1),
    .hwdata2(hwdata2),
    .haddr1(haddr1),
    .haddr2(haddr2),
    .temp_selx(temp_selx)
  );

  APBController k2(
    .valid(valid),
    .hwrite(hwrite),
    .hwrite_reg(hwrite_reg),
    .hresetn(hresetn),
    .hclk(hclk),
    .haddr(haddr),
    .hwdata(hwdata),
    .haddr1(haddr1),
    .haddr2(haddr2),
    .temp_selx(temp_selx),
    .pwdata(pwdata),
    .paddr(paddr),
    .pselx(pselx),
    .penable(penable),
    .pwrite(pwrite),
    .hreadyout(hreadyout)
  );

endmodule
