module mem_addr_gen(
   input rst,
   input [2:0] gamemod,
   input [9:0] h_cnt,
   input [9:0] v_cnt,
   output [19:0] pixel_addr
   );
    parameter [2:0] INT_MODE   =3'b000;
    parameter [2:0] P0_WIN     =3'b001;
    parameter [2:0] P1_WIN     =3'b010; 
    parameter [2:0] STOP       =3'b011;
    parameter [2:0] GAME_COUNT =3'b100; 
    parameter [2:0] GAME_P0    =3'b101;
    parameter [2:0] GAME_P1    =3'b110;
    parameter [2:0] GAME_ON    =3'b111;
   
   reg [3:0] pic;
  
   assign pixel_addr = (h_cnt+320*v_cnt)+76800*pic;  //640*480 --> 320*240 

   always @* begin
      case(gamemod)
      INT_MODE:pic=0;
      P0_WIN:pic=1;
      P1_WIN:pic=2;
      default:pic=0;
      endcase
   end
    
endmodule
