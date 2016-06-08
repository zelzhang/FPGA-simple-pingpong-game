module pixel_gen(
   input [9:0] h_cnt,v_cnt,
   input [9:0] ballx,bally,player0,player1, 
   input [9:0] ahrix,ahriy,syndrax,syndray,
   input  ahrimode,syndramode,
   input valid,
   input clk_25MHz,
   input  [2:0] gamemod,
   output reg [3:0] vgaRed,
   output reg [3:0] vgaGreen,
   output reg [3:0] vgaBlue
   );
   //game mod
       parameter [2:0] INT_MODE   =3'b000;
       parameter [2:0] P0_WIN     =3'b001;
       parameter [2:0] P1_WIN     =3'b010; 
       parameter [2:0] STOP       =3'b011;
       parameter [2:0] GAME_COUNT =3'b100; 
       parameter [2:0] GAME_P0    =3'b101;
       parameter [2:0] GAME_P1    =3'b110;
       parameter [2:0] GAME_ON    =3'b111;
   //PLAYER
   parameter [9:0] pylon_l=50;
   
   
   
   wire[9:0] ballx_L,ballx_R,bally_U,bally_D;
   wire[9:0] player0_U,player0_D,player1_U,player1_D;
   wire[13:0] pixel_addr0,pixel_addr1;
   wire[16:0] pixel_addr3;
   wire[11:0] pixel0,pixel1,pixel2,pixel3,pixel4;
   wire[11:0] data0,data1,data2,data3,data4;
   
   
   
   assign pixel_addr0[6:0]=(showahri)?   h_cnt-ahrix:0;
   assign pixel_addr0[13:7]=(showahri)?  v_cnt-ahriy:0; 
   
   assign pixel_addr1[6:0]=(showsyndra)?  h_cnt-syndrax:0;
   assign pixel_addr1[13:7]=(showsyndra)? v_cnt-syndray:0;
   
   assign pixel_addr3= ((h_cnt>>1)+320*(v_cnt>>1))%76800;
    
   assign ballx_L=ballx-10;
   assign ballx_R=ballx+10;
   assign bally_U=bally-10;
   assign bally_D=bally+10;
   
   assign player0_U=player0-pylon_l;
   assign player0_D=player0+pylon_l;
   assign player1_U=player1-pylon_l;
   assign player1_D=player1+pylon_l;
   
   assign showball=( (h_cnt>=ballx_L) && (h_cnt<ballx_R) ) && ((v_cnt>=bally_U) && (v_cnt<bally_D));
   assign showplayer0=((h_cnt>=0) && (h_cnt<30)) && ((v_cnt>=player0_U) && (v_cnt<player0_D));
   assign showplayer1=((h_cnt>=610) && (h_cnt<640)) && ((v_cnt>=player1_U) && (v_cnt<player1_D));
   assign showahri= ((h_cnt>=ahrix) && (h_cnt<ahrix+128)) && ((v_cnt>=ahriy) && (v_cnt<ahriy+128));
   assign showsyndra= ((h_cnt>=syndrax) && (h_cnt<syndrax+128)) && ((v_cnt>=syndray) && (v_cnt<syndray+128));
   
   
   always @* begin
            if(valid)begin
                if(gamemod == INT_MODE) begin
                   {vgaRed, vgaGreen, vgaBlue} = pixel4;
                 end else  if(showball/*( (h_cnt>=ballx_L) && (h_cnt<ballx_R) ) && ((v_cnt>=bally_U) && (v_cnt<bally_D))*/)begin
                                    {vgaRed, vgaGreen, vgaBlue} = 12'hf00;
                        end else if(showplayer0/*((h_cnt>=0) && (h_cnt<30)) && ((v_cnt>=player0_U) && (v_cnt<player0_D))*/)begin
                                    if((v_cnt>=player0_U+20) && (v_cnt<player0_D-20))begin
                                    {vgaRed, vgaGreen, vgaBlue} = (gamemod==INT_MODE) ? 12'h000:12'h0f0;
                                    end else begin
                                    {vgaRed, vgaGreen, vgaBlue} = (gamemod==INT_MODE) ? 12'h000:12'h00f;
                                    end
                        end else if(showplayer1/*((h_cnt>=610) && (h_cnt<640)) && ((v_cnt>=player1_U) && (v_cnt<player1_D))*/)begin
                                    if((v_cnt>=player1_U+20) && (v_cnt<player1_D-20))begin
                                    {vgaRed, vgaGreen, vgaBlue} = (gamemod==INT_MODE) ? 12'h000:12'h0f0;
                                    end else begin
                                    {vgaRed, vgaGreen, vgaBlue} = (gamemod==INT_MODE) ? 12'h000:12'h00f;
                                    end
                        end else if (showahri)begin
                                    {vgaRed, vgaGreen, vgaBlue} =(ahrimode)? pixel1:pixel0;
                        end else if (showsyndra)begin
                                    {vgaRed, vgaGreen, vgaBlue} =(syndramode)? pixel3:pixel2;
                      
                        end else begin
                                    {vgaRed, vgaGreen, vgaBlue} = 12'h000;
                        end
            end else begin
                        {vgaRed, vgaGreen, vgaBlue} = 12'h000;
            end
   end

	//picture
	
                  blk_mem_gen_0 blk_mem_gen_0_inst(
                      .clka(clk_25MHz),
                      .wea(0),
                      .addra(pixel_addr0),
                      .dina(data0[11:0]),
                      .douta(pixel0)
                 ); 
                 
                 blk_mem_gen_1 blk_mem_gen_1_inst(
                           .clka(clk_25MHz),
                           .wea(0),
                           .addra(pixel_addr0),
                           .dina(data1[11:0]),
                           .douta(pixel1)
                      ); 
                  
                  blk_mem_gen_2 blk_mem_gen_2_inst(
                                .clka(clk_25MHz),
                                .wea(0),
                                .addra(pixel_addr1),
                                .dina(data2[11:0]),
                                .douta(pixel2)
                      ); 
                      
                  blk_mem_gen_3 blk_mem_gen_3_inst(
                                .clka(clk_25MHz),
                                .wea(0),
                                .addra(pixel_addr1),
                                .dina(data3[11:0]),
                                .douta(pixel3)
                       ); 
                       
                       blk_mem_gen_4 blk_mem_gen_4_inst(
                                                       .clka(clk_25MHz),
                                                       .wea(0),
                                                       .addra(pixel_addr3),
                                                       .dina(data4[11:0]),
                                                       .douta(pixel4)
                                              ); 
                       
                  

endmodule
