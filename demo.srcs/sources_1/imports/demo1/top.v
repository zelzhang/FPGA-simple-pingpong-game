 module top(
   input clk,
   input rst,
   input[3:0] btn,
   output reg[3:0] vgaRed,
   output reg[3:0] vgaGreen,
   output reg[3:0] vgaBlue,
   output hsync,
   output vsync,
   //7 segment
   output reg[6:0] Seg,
   output reg[3:0] AN,
   output bomb,
   //music
   input MusicFlag,
   output pmod_1,
   output pmod_2,
   output pmod_4,
   //keyboard
    inout wire PS2_DATA,
    inout wire PS2_CLK,
    //LED
    output[5:0] LED
    );
    //muic
    parameter BEAT_FREQ = 32'd12;	//one beat=0.125sec origin 8 //168  //5.376
    parameter DUTY_BEST = 10'd512;            //duty cycle=50%
    wire [31:0] freq;
    wire [9:0] ibeatNum;
    wire beatFreq;
    wire en;//control music START?
    wire bomb;
    assign pmod_2 = 1'd1;            //no gain(6dB)
    assign pmod_4 = 1'd1;            //turn-on
    assign en=MusicFlag;
    assign bomb=((x_flipL || x_flipR) || (y_flipU || y_flipD)) & (gamemod == GAME_ON);
    
    //keyboard
    parameter [8:0] LEFT_SHIFT_CODES  = 9'b0_0001_0010;
    parameter [8:0] RIGHT_SHIFT_CODES = 9'b0_0101_1001;
    parameter [8:0] KEY_CODES [0:6] = {
            9'b0_0101_1010,//enter 5a
            
            9'b0_0001_1101,//w 1d
            9'b0_0010_0010,//X 22
            9'b0_0010_1001,//space 29
            
            9'b0_0111_0101, // right_8 => 75
            9'b0_0111_0010, // right_2 => 72
            9'b0_0111_0000 // right_0 => 70
    };
    
    reg [4:0] nums1;
    reg [4:0] nums2;
    reg [19:0] counter1;
    reg [19:0] counter2;
    reg [4:0] key_num;
    reg [9:0] last_key;
    
    wire shift_down;
    wire [511:0] key_down;
    wire [8:0] last_change;
    wire been_ready;
    wire [2:0] R_ctr,L_ctr;
    
    assign shift_down = (key_down[LEFT_SHIFT_CODES] == 1'b1 || key_down[RIGHT_SHIFT_CODES] == 1'b1) ? 1'b1 : 1'b0;

    //game mod
    parameter [2:0] INT_MODE   =3'b000;
    parameter [2:0] P0_WIN     =3'b001;
    parameter [2:0] P1_WIN     =3'b010; 
    parameter [2:0] STOP       =3'b011;
    parameter [2:0] GAME_00    =3'b100; 
    parameter [2:0] GAME_P0    =3'b101;
    parameter [2:0] GAME_P1    =3'b110;
    parameter [2:0] GAME_ON    =3'b111;
    //direction
    parameter  P0   =1'b0;
    parameter  P1   =1'b1;
    parameter  UP   =1'b0;
    parameter  DOWN =1'b1;
    parameter  LEFT =1'b0;
    parameter  RIGHT=1'b1;
    //PLAYER
    parameter [9:0] pylon_l=60;
    parameter [9:0] pylon_s=12;
    parameter [9:0] pylon_upb=60;
    parameter [9:0] pylon_dwb=420;
    //EDGE
    parameter [9:0] BOUND_XS=40;
    parameter [9:0] BOUND_XE=600;
    parameter [9:0] BOUND_YS=20;
    parameter [9:0] BOUND_YE=460;
    //wire
   wire [3:0] vgaRed_GAME,vgaRed_MENU;
   wire [3:0] vgaGreen_GAME,vgaGreen_MENU;
   wire [3:0] vgaBlue_GAME,vgaBlue_MENU;  
   //memory
    wire clk_25MHZ,clk20;
    wire[1:0] clk17;
    wire valid;
    wire[9:0] h_cnt,v_cnt;
    wire[19:0] pixel_addr;
    //game
    reg[2:0] gamemod;
    reg[9:0] bally,ballx,player1,player0,speedy,speedx;
    reg      diry,dirx; 
    wire[9:0] y_add,y_sub,x_add,x_sub;
    wire y_dwBD,x_dwBD,y_upBD,x_upBD;
    wire  y_flipU,y_flipD,x_flipL,x_flipR;
    wire[9:0] player0_U,player0_D,player1_U,player1_D,relative0,relative1;
    wire[1:0] relative_sign;
    wire[1:0] deg;
    //score
    reg[7:0] score;
    reg[3:0] num;
    //picture
    reg[9:0] ahrix,ahriy,syndrax,syndray;
    reg ahrimode,syndramode;
    //control of player0******************************************************
    always @(posedge clk20 or posedge rst)begin
            if(rst)begin
                player0<=240;   
            end else begin
                case(gamemod)
        GAME_00,GAME_ON,GAME_P0,GAME_P1:begin
                        case(L_ctr[1:0])       //here is the button control of player0****************************************************
                        2'b01:player0<=(player0<=60)?     player0:player0-pylon_s;
                        2'b10:player0<=(player0>=420)?    player0:player0+pylon_s;
                        default:player0<=player0;
                        endcase
                        end
                STOP   :player0<=player0;
                default:player0<=240;
                endcase
            end
    end
    
    always @(posedge clk20 or posedge rst)begin
                if(rst)begin
                    player1<=240;   
                end else begin
                    case(gamemod)
            GAME_00,GAME_ON,GAME_P0,GAME_P1:begin
                            case(R_ctr[1:0])     //here is the button control of player1****************************************************
                            2'b01:player1<=(player1<=60)?     player1:player1-pylon_s;//up
                            2'b10:player1<=(player1>=420)?    player1:player1+pylon_s;//down
                            default:player1<=player1;
                            endcase
                            end
                    STOP   :player1<=player1;
                    default:player1<=240;
                    endcase
                end
      end
      
      assign player0_U=player0-pylon_l;
      assign player0_D=player0+pylon_l;
      assign player1_U=player1-pylon_l;
      assign player1_D=player1+pylon_l;
    //impact****************************************
    assign relative_sign[0]=bally>player0;
    assign relative_sign[1]=bally>player1;
    assign relative0=(relative_sign[0])? (bally-player0):(player0-bally);
    assign relative1=(relative_sign[1])? (bally-player1):(player1-bally);

    assign deg[1]=(ballx<320)? (  (relative0>=30) &  (relative0<60) ):(  (relative1>=30) &  (relative1<60) );
    assign deg[0]=(ballx<320)? (  (relative0>=0)  &  (relative0<30) ):(  (relative1>=0) &  (relative1<30) );
    
    always@(posedge clk)begin
            $display("%d",deg);
    end
    
    
    
    //ball 1Y**************************************************
    assign y_add=bally+speedy;
    assign y_sub=bally-speedy;
    
    assign y_dwBD=y_add>BOUND_YE;
    assign y_upBD=bally<(speedy+BOUND_YS);
   
    assign y_flipU=(bally==BOUND_YS);
    assign y_flipD=(bally==BOUND_YE);
    
    always @(posedge clk20 or posedge rst) begin
        if(rst)begin
            speedy<=0;
        end else if(gamemod==GAME_ON)begin
             case({x_flipL,x_flipR})
             2'b01:begin
                        case({relative_sign[0],diry,deg[1:0]})
                        4'b0001:speedy<=speedy;
                        4'b0010:speedy<=(speedy>1)? speedy:speedy+1;
                        4'b0101:speedy<=speedy;
                        4'b0110:speedy<=(speedy>0)? speedy-1:speedy+1;
              
                        4'b1001:speedy<=speedy;
                        4'b1010:speedy<=(speedy>0)? speedy:speedy+1;
                        4'b1101:speedy<=speedy;
                        4'b1110:speedy<=(speedy>1)?  speedy-1:speedy+1;                     
                        default:speedy<=speedy;
                        endcase
                    end
             2'b10:begin
                         case({relative_sign[1],diry,deg[1:0]})
                                     4'b0001:speedy<=speedy;
                                     4'b0010:speedy<=speedy+1;
                                     4'b0101:speedy<=speedy;
                                     4'b0110:speedy<=(speedy>0)? speedy-1:speedy+1;
                           
                                     4'b1001:speedy<=speedy;
                                     4'b1010:speedy<=(speedy>0)? speedy-1:speedy+1;
                                     4'b1101:speedy<=speedy;
                                     4'b1110:speedy<=speedy+1;                      
                                     default:speedy<=speedy;
                           endcase
                   end
             default:speedy<=speedy;
             endcase
        end else begin
            speedy<=0;
        end
        
    end
    
    always @(posedge clk20  or posedge rst) begin
            if(rst)begin
                  diry<=P0;
            end else begin
               case(gamemod) 
               GAME_ON:begin
                      case(diry)
                      UP:diry<=(y_flipU)?   DOWN:UP;
                      DOWN:diry<=(y_flipD)?   UP:DOWN;
                      endcase
                      end 
               STOP:diry<=diry;
               default:diry<=P0;
               endcase
            end
     end
    
    
    always @(posedge clk20  or posedge rst) begin
        if(rst)begin
            bally<=240;
        end else begin
            case(gamemod)     
            GAME_ON:begin
                        case(diry)
                        UP  :bally<=(y_upBD)?   BOUND_YS:y_sub;
                        DOWN:bally<=(y_dwBD)?   BOUND_YE:y_add;
                        endcase
                     end
             STOP   :bally<=bally;
             GAME_00:bally<=player0;
             GAME_P0:bally<=player0;
             GAME_P1:bally<=player1;
             default:bally<=240;
             endcase
       end
    end
    
    
    //ball_x****************************************************
    assign x_add=ballx+speedx;
    assign x_sub=ballx-speedx;
        
    assign x_dwBD=x_add>BOUND_XE;
    assign x_upBD=ballx<(speedx+BOUND_XS);
        
        
    always @(posedge clk20 or posedge rst) begin
        if(rst)begin
            speedx<=0;
        end else begin
            case(gamemod)
            GAME_ON:speedx<=2;
            default:speedx<=0;
            endcase
        end
    end
    
    assign x_flipL=(ballx==BOUND_XS);
    assign x_flipR=(ballx==BOUND_XE);
        
        always @(posedge clk20  or posedge rst) begin
                if(rst)begin
                      dirx<=P0;
                end else begin
                   case(gamemod)
                   GAME_ON:begin
                           case(dirx)
                           LEFT:dirx<=(x_flipL) ? RIGHT:LEFT;
                           RIGHT:dirx<=(x_flipR)? LEFT:RIGHT;
                           endcase
                           end 
                   STOP:dirx<=dirx;
                   default:dirx<=P0;
                   endcase
                end
         end
        
        
        always @(posedge clk20  or posedge rst) begin
            if(rst)begin
                ballx<=320;
           end else begin
               case(gamemod)
               GAME_ON:begin
                            case(dirx)
                            UP  :ballx<=(x_upBD)?   BOUND_XS:x_sub;
                            DOWN:ballx<=(x_dwBD)?   BOUND_XE:x_add;
                            endcase
                        end
                STOP   :ballx<=bally;
                GAME_00:ballx<=BOUND_XS;
                GAME_P0:ballx<=BOUND_XS;
                GAME_P1:ballx<=BOUND_XE;
                default:ballx<=320;
                endcase
           end
        end
    
    
    
     //FSM MACHINE
     
     always @(posedge clk20 or posedge rst) begin
          if(rst)begin
             gamemod<=INT_MODE;
             ahrix<=190;
             ahriy<=176;
             ahrimode<=0;
             syndrax<=320;
             syndray<=176;
             syndramode<=0;
             score<=0;
          end else begin
            case(gamemod)
            INT_MODE:begin
                        if((L_ctr[2]==0) & (R_ctr[2]==0) )begin //用發射紐兩方的做開始*****************************
                         gamemod<=INT_MODE;
                        end else begin
                         gamemod<=GAME_00;
                        end
                                    ahrix<=190;
                                     ahriy<=176;
                                     ahrimode<=0;
                                     syndrax<=320;
                                     syndray<=176;
                                     syndramode<=0;
                        score<=0;
                     end
            P0_WIN:begin
                        if(L_ctr[2]==0)begin
                            gamemod<=P0_WIN;
                        end else begin
                            gamemod<=INT_MODE;
                         end
                           ahrix<=190;
                           ahriy<=176;
                           ahrimode<=0;
                           syndrax<=320;
                           syndray<=176;
                           syndramode<=1;
                         score<=score;
                     end
            P1_WIN:begin
                         if(R_ctr[2]==0)begin
                            gamemod<=P1_WIN;
                          end else begin
                             gamemod<=INT_MODE;
                          end
                                    ahrix<=190;
                                       ahriy<=176;
                                       ahrimode<=1;
                                       syndrax<=320;
                                       syndray<=176;
                                       syndramode<=0;
                          score<=score;
                   end
            STOP:begin
                         ahrix<=190;
                         ahriy<=176;
                         ahrimode<=0;
                         syndrax<=320;
                         syndray<=176;
                         syndramode<=0;
                          gamemod<=GAME_ON;
                          score<=score;
                   end
            GAME_00:begin
                          if(L_ctr[2]==0)begin
                                gamemod<=GAME_00;
                           end else begin
                                gamemod<=GAME_ON;
                         end
                          ahrix<=190;
                          ahriy<=176;
                          ahrimode<=0;
                          syndrax<=320;
                          syndray<=176;
                          syndramode<=0;
                          score<=score;
                        end 
            GAME_P0:begin
                        if(score[3:0]==10)begin
                          gamemod<=P0_WIN;
                        end else begin
                          if(L_ctr[2]==0)begin
                          gamemod<=GAME_P0;
                          end else begin
                          gamemod<=GAME_ON;
                          end
                        end
                                     ahrix<=190;
                                     ahriy<=176;
                                     ahrimode<=0;
                                     syndrax<=320;
                                     syndray<=176;
                                     syndramode<=1;
                        score<=score;
                  end
            GAME_P1:begin
                        if(score[7:4]==10)begin
                           gamemod<=P1_WIN;
                        end else begin
                           if(R_ctr[2]==0)begin
                            gamemod<=GAME_P1;
                            end else begin
                            gamemod<=GAME_ON;
                            end
                        end
                                     ahrix<=190;
                                     ahriy<=176;
                                     ahrimode<=1;
                                     syndrax<=320;
                                     syndray<=176;
                                     syndramode<=0;
                        score<=score;
                    end
            GAME_ON:begin
                        case({x_upBD,x_dwBD,deg})
                        4'b1000:begin
                                    gamemod<=GAME_P1;
                                    score<=score+16;
                                end
                        4'b0100:begin
                                    gamemod<=GAME_P0;
                                    score<=score+1;
                                end
                        default:begin
                                    gamemod<=GAME_ON;
                                    score<=score;
                                end
                        endcase
                        ahrix<=190;
                        ahriy<=176;
                        ahrimode<=0;
                        syndrax<=320;
                         syndray<=176;
                         syndramode<=0;
                    end
            endcase
          end
     end
     //7 segment=======================================
     always @* begin
     
     case(clk17[1:0])
     2'b00:AN=4'b1110;
     2'b01:AN=4'b1101;
     2'b10:AN=4'b1011;
     2'b11:AN=4'b0111;
     endcase
     
     case(clk17[1:0])
     2'b00:num=score[7:4];
     2'b01:num=4'b0000;
     2'b10:num=score[3:0];
     2'b11:num=4'b0000;
     endcase
     
     end
     
     always @* begin
                 case(num)
                 4'b0000:Seg[6:0]=7'b1000000;
                 4'b0001:Seg[6:0]=7'b1111001;
                 4'b0010:Seg[6:0]=7'b0100100;
                 4'b0011:Seg[6:0]=7'b0110000;
                 4'b0100:Seg[6:0]=7'b0011001;
                 4'b0101:Seg[6:0]=7'b0010010;
                 4'b0110:Seg[6:0]=7'b0000010;
                 4'b0111:Seg[6:0]=7'b1011000;
                 4'b1000:Seg[6:0]=7'b0000000;
                 4'b1001:Seg[6:0]=7'b0011000;
                 4'b1010:Seg[6:0]=7'b0001000;
                 4'b1011:Seg[6:0]=7'b0000011;
                 4'b1100:Seg[6:0]=7'b1000110;
                 4'b1101:Seg[6:0]=7'b0100001;
                 4'b1110:Seg[6:0]=7'b0000110;
                 4'b1111:Seg[6:0]=7'b0001110;
                 endcase            
         end            
            
     //monotor=====================================
     always @* begin
        /*case(gamemod)
        GAME_ON,GAME_P0,GAME_P1:{vgaRed,vgaGreen,vgaBlue}={vgaRed_GAME,vgaGreen_GAME,vgaBlue_GAME};
        default:GAME_ON,GAME_P0,GAME_P1:{vgaRed,vgaGreen,vgaBlue}=;
        endcase*/
        {vgaRed,vgaGreen,vgaBlue}={vgaRed_GAME,vgaGreen_GAME,vgaBlue_GAME};
     end
     //*******************************************************************
     clock_divisor clk_wiz_0_inst(
      .clk(clk),
      .clk1(clk_25MHz),
      .clk20(clk20),
      .clk17(clk17)
    );

   pixel_gen pixel_gen_inst(
       .h_cnt(h_cnt),
       .v_cnt(v_cnt),
       .valid(valid),
       .ballx(ballx),
       .bally(bally),
       .player0(player0),
       .player1(player1),
       .clk_25MHz(clk_25MHz),
       .ahrix(ahrix),
       .ahriy(ahriy),
       .syndrax(syndrax),
       .syndray(syndray),
       .ahrimode(ahrimode),
       .syndramode(syndramode),
       .gamemod(gamemod),
       .vgaRed(vgaRed_GAME),
       .vgaGreen(vgaGreen_GAME),
       .vgaBlue(vgaBlue_GAME)
    );

    vga_controller   vga_inst(
      .pclk(clk_25MHz),
      .reset(rst),
      .hsync(hsync),
      .vsync(vsync),
      .valid(valid),
      .h_cnt(h_cnt),
      .v_cnt(v_cnt)
    );
    //music================================================================================
    //Generate beat speed
    PWM_gen btSpeedGen ( .clk(clk), 
                                                                 .reset(reset),
                                                                 .freq(BEAT_FREQ),
                                                                 .duty(DUTY_BEST), 
                                                                 .PWM(beatFreq)
    );
                
    //manipulate beat
    PlayerCtrl playerCtrl_00 ( .clk(beatFreq),
                                                                               .reset(reset),
                                                                               .ibeat(ibeatNum)
    );            
                
    //Generate variant freq. of tones
    Music music00 ( .ibeatNum(ibeatNum),
                                                    .en(en),
                                                    .bomb(bomb),
                                                    .tone(freq)
    );
    
    // Generate particular freq. signal
    PWM_gen toneGen ( 
                     .clk(clk), 
                                                     .reset(reset), 
                                                      .freq(freq),
                                                      .duty(DUTY_BEST), 
                                                      .PWM(pmod_1)
    );
    //keyboard
    KeyboardDecoder key_de (
		.key_down(key_down),
		.last_change(last_change),
		.key_valid(been_ready),
		.PS2_DATA(PS2_DATA),
		.PS2_CLK(PS2_CLK),
		.rst(rst),
		.clk(clk)
		);
		
                                     always @ (posedge clk, posedge rst) begin
                                                if (rst) begin
                                                            nums1 <= 5'b1;
                                                            nums2 <= 5'b1;
                                                            counter1 <= 20'b0;
                                                            counter2 <= 20'b0;
                                                end else begin
                                                
                                                            if(counter1 == 0) begin
                                                                        if (been_ready && key_down[last_change] == 1'b1) begin
                                                                                     if (key_num == 5'b00000 || key_num == 5'b00100 || key_num == 5'b00101 || key_num == 5'b00110)begin
                                                                                                nums1 <= key_num;
                                                                                                counter1 <= 20'b11111111111111111111;
                                                                                     end else begin
                                                                                                nums1 <= 5'b11111; 
                                                                                                counter1 <= 0;
                                                                                     end
                                                                        end else begin
                                                                                    counter1 <= 0;
                                                                                    nums1 <= 5'b11111; 
                                                                        end
                                                            end else begin
                                                                        counter1 = counter1-1;
                                                            end
                                                            
                                                           if(counter2 == 0) begin
                                                                        if (been_ready && key_down[last_change] == 1'b1) begin
                                                                                     if (key_num == 5'b00000 || key_num == 5'b00001 || key_num == 5'b00010 || key_num == 5'b00011)begin
                                                                                                nums2 <= key_num;
                                                                                                counter2 <= 20'b11111111111111111111;
                                                                                     end else begin
                                                                                                nums2 <= 5'b11111; 
                                                                                                counter2 <= 0;
                                                                                     end
                                                                        end else begin
                                                                                    counter2 <= 0;
                                                                                    nums2 <= 5'b11111; 
                                                                        end
                                                            end else begin
                                                                        counter2 = counter2-1;
                                                            end
                                                end
                                    end

                                      
                                    always @ (*) begin
                                                case (last_change)
                                                            KEY_CODES[00] : key_num = 5'b00000;
                                                            
                                                            KEY_CODES[01] : key_num = 5'b00001;
                                                            KEY_CODES[02] : key_num = 5'b00010;
                                                            KEY_CODES[03] : key_num = 5'b00011;
                                                            
                                                            KEY_CODES[04] : key_num = 5'b00100;
                                                            KEY_CODES[05] : key_num = 5'b00101;
                                                            KEY_CODES[06] : key_num = 5'b00110;
                                                            default                          : key_num = 5'b11111;
                                                endcase
                                    end
                                    
                                    assign R_ctr[0]=(nums1==5'b00100);
                                    assign R_ctr[1]=(nums1==5'b00101);
                                    assign R_ctr[2]=(nums1==5'b00110)||(nums1==5'b00000);
                                    
                                    assign L_ctr[0]=(nums2==5'b00001);
                                    assign L_ctr[1]=(nums2==5'b00010);
                                    assign L_ctr[2]=(nums2==5'b00011)||(nums2==5'b00000);
                                    
                                    assign LED[5:0]={L_ctr[2:0],R_ctr[2:0]};
                                    
endmodule




//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

