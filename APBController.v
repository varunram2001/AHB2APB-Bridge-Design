module APBController (
  input reg hclk,
  input reg hresetn,
  input reg hwrite_reg,
  input reg hwrite_reg1,
  input reg hwrite,
  input reg valid,
  input reg [31:0] haddr,
  input reg [31:0] hwdata,
  input reg [31:0] hwdata1,
  input reg [31:0] hwdata2,
  input reg [31:0] haddr1,
  input reg [31:0] haddr2,
  input reg [31:0] pr_data,
  output reg penable,
  output reg pwrite,
  output reg hr_readyout,
  output reg [2:0] psel,
  output reg [31:0] paddr,
  output reg [31:0] pwdata
);

  // Define states using parameters
  parameter ST_IDLE = 3'b000;
  parameter ST_WWAIT = 3'b001;
  parameter ST_READ = 3'b010;
  parameter ST_RENABLE = 3'b011;
  parameter ST_WRITE = 3'b100;
  parameter ST_WRITEP = 3'b101;
  parameter ST_WENABLE = 3'b110;
  parameter ST_WENABLEP = 3'b111;

  // Define present state and next state variables
  reg [2:0] present;
  reg [2:0] next;

  // Present state logic
  always @(posedge hclk or negedge hresetn) begin
    if (~hresetn)
      present <= ST_IDLE;
    else
      present <= next;
  end

  // Next state logic
  always @(*) begin
    case (present)
      ST_IDLE:
        begin
          if (valid == 1 && hwrite == 1)
            next = ST_WWAIT;
          else if (valid == 1 && hwrite == 0)
            next = ST_READ;
          else 
            next = ST_IDLE;
        end
      ST_READ:
        begin
          next = ST_RENABLE;
        end
      ST_RENABLE:
        begin
          if (valid == 1 && hwrite == 1)
            next = ST_WWAIT;
          else if (valid == 1 && hwrite == 0)
            next = ST_READ;
          else
            next = ST_IDLE;
        end
      ST_WRITE:
        begin
          if (valid == 1)
            next = ST_WENABLEP;
          else
            next = ST_WENABLE;
        end
      ST_WRITEP:
        begin
          next = ST_WENABLEP;
        end
      ST_WWAIT:
        begin
          if (valid == 1)
            next = ST_WRITEP;
          else 
            next = ST_WRITE;
        end
      ST_WENABLE:
        begin
          if (valid == 1 && hwrite == 0)
            next = ST_READ;
          else if (valid == 1 && hwrite == 1)
            next = ST_WWAIT;
          else 
            next = ST_IDLE;
        end
      ST_WENABLEP:
        begin
          if (valid == 1 && hwrite_reg == 0)
            next = ST_WRITEP;
          else if (valid == 0 && hwrite_reg == 1)
            next = ST_WRITEP;
          else if (hwrite_reg == 0)
            next = ST_WRITE;
        end
    endcase
  end

  // Temporary output logic
  reg [2:0] psel_temp;
  reg [31:0] paddr_temp;
  reg [31:0] pwdata_temp;
  reg penable_temp;
  reg hr_readyout_temp;
  reg hr_readyput_temp;

  always @(*) begin
    case (present)
      ST_IDLE:
        begin
          if (valid == 1 && hwrite == 0) begin
            paddr_temp = haddr;
            pwrite = hwrite;
            psel_temp = hwrite_reg1;
            penable_temp = 0;
            hr_readyout_temp = 0;
          end
          else if (valid == 1 && hwrite == 1) begin
            psel_temp = 3'b000;
            penable_temp = 0;
            hr_readyout_temp = 1;
          end
          else begin
            psel_temp = 3'b000;
            penable_temp = 0;
            hr_readyout_temp = 1;
          end
        end
      ST_READ:
        begin
          penable_temp = 1;
          hr_readyout_temp = 1;
        end
      ST_RENABLE:
        begin
          if (valid == 1 && hwrite == 0) begin
            paddr_temp = haddr;
            pwrite = hwrite;
            psel_temp = hwrite_reg1;
            penable_temp = 0;
            hr_readyout_temp = 0;
          end
          else begin
            psel_temp = 3'b000;
            penable_temp = 0;
            hr_readyout_temp = 1;
          end
        end
      ST_WRITE:
        begin
          penable_temp = 1;
          hr_readyout_temp = 1;
        end
      ST_WRITEP:
        begin
          penable_temp = 1;
          hr_readyout_temp = 1;
        end
      ST_WWAIT:
        begin
          if (valid == 1) begin
            paddr_temp = haddr1;
            pwdata_temp = hwdata;
            pwrite = hwrite;
            psel_temp = hwrite_reg1;
            penable_temp = 0;
            hr_readyput_temp = 0;
          end
          else begin
            paddr_temp = haddr2;
            pwdata_temp = hwdata2;
            pwrite = hwrite;
            psel_temp = hwrite_reg1;
            penable_temp = 0;
            hr_readyput_temp = 0;
          end
        end
      ST_WENABLE:
        begin
          if (valid == 1 && hwrite == 0) begin
            paddr_temp = haddr;
            pwrite = hwrite;
            psel_temp = hwrite_reg1;
            penable_temp = 0;
            hr_readyout_temp = 0;
          end
          else if (valid == 1 && hwrite == 1) begin
            psel_temp = 3'b000;
            penable_temp = 0;
            hr_readyout_temp = 1;
          end
          else begin
            psel_temp = 3'b000;
            penable_temp = 0;
            hr_readyout_temp = 1;
          end
        end
      ST_WENABLEP:
        begin
          if (valid == 1 && hwrite_reg == 0) begin
            paddr_temp = haddr;
            pwrite = hwrite;
            psel_temp = hwrite_reg1;
            penable_temp = 0;
            hr_readyout_temp = 0;
          end
          else if (valid == 0 && hwrite_reg == 1) begin
            paddr_temp = haddr1;
            pwdata_temp = hwdata1;
            pwrite = hwrite;
            psel_temp = hwrite_reg1;
            penable_temp = 0;
            hr_readyout_temp = 0;
          end
          else if (hwrite_reg == 0) begin
            paddr_temp = haddr2;
            pwdata_temp = hwdata2;
            pwrite = hwrite;
            psel_temp = hwrite_reg1;
            penable_temp = 0;
            hr_readyout_temp = 0;
          end
        end
    endcase
  end

  // Actual output logic
  always @(posedge hclk) begin
    if (!hresetn) begin
      paddr <= 0;
      pwrite <= 0;
      pwdata <= 0;
      psel <= 0;
      penable <= 0;
      hr_readyout <= 1;
    end
    else begin
      paddr <= paddr_temp;
      pwdata <= pwdata_temp;
      pwrite <= pwrite;
      psel <= psel_temp;
      penable <= penable_temp;
      hr_readyout <= hr_readyout_temp;
    end
  end

endmodule
