
`define NM1  32'd262 //C_freq
`define NM15 32'd277 //C#_freq
`define NM2  32'd294 //D_freq
`define NM25 32'd311 //D#_freq
`define NM3 32'd330  //E_freq

`define NM4 32'd349  //F_freq
`define NM45 32'd370 //F#_freq
`define NM5 32'd392  //G_freq
`define NM55  32'd415 //G#_freq
`define NM6 32'd440  //A_freq
`define NM65  32'd466 //A#_freq
`define NM7 32'd494 //B_freq

`define NH1  32'd524 //C_freq
`define NH15 32'd554 //C#_freq
`define NH2  32'd588 //D_freq
`define NH25 32'd587 //D#_freq
`define NH3 32'd660 //E_freq
`define NH35 32'd622 //E#_freq
`define NH4 32'd698 //F_freq

`define NH5 32'd784 //G_freq
`define NH55  32'd830 //G#_freq
`define NH6 32'd880 //A_freq
`define NH65  32'd932 //A#_freq
`define NH7 32'd988 //B_freq

`define NHH1  32'd1047 //C_freq

`define NM0 32'd20000 //slience (over freq.)

module Music (
	input [9:0] ibeatNum,	
	input en,
	input bomb,
	output reg [31:0] tone
);

always @(*) begin
	
	if(bomb)begin
	   tone = `NHH1;
	end else if(en)begin
	
		case (ibeatNum)		// 1/4 beat
			//1  //5 5 1* 1* 5
			10'd0 : tone = `NM5;	
			10'd1 : tone = `NM0;
			10'd2 : tone = `NM5;
			10'd3 : tone = `NM0;
			10'd4 : tone = `NM5;	
			10'd5 : tone = `NM0;
			10'd6 : tone = `NM0;
			10'd7 : tone = `NM0;
			10'd8 : tone = `NH1;	
			10'd9 : tone = `NM0;
			10'd10 : tone = `NH1;
			10'd11 : tone = `NH1;
			10'd12 : tone = `NH1;	
			10'd13 : tone = `NH1;
			10'd14 : tone = `NM5;
			10'd15 : tone = `NM0;
			//2 //5 1* 2*
			10'd16 : tone = `NM5;
			10'd17 : tone = `NM0;
			10'd18 : tone = `NM5;
			10'd19 : tone = `NM0;
			10'd20 : tone = `NH1;
			10'd21 : tone = `NH1;
			10'd22 : tone = `NH1;
			10'd23 : tone = `NH1;
			10'd24 : tone = `NH1;
			10'd25 : tone = `NH1;
			10'd26 : tone = `NM0;
			10'd27 : tone = `NM0;
			10'd28 : tone = `NH2;
			10'd29 : tone = `NH2;
			10'd30 : tone = `NH2;
			10'd31 : tone = `NH2;
			//3 //1* 2* 4* 3*
			10'd32 : tone = `NH1;
			10'd33 : tone = `NH1;
			10'd34 : tone = `NH2;
			10'd35 : tone = `NH2;
			10'd36 : tone = `NH4;
			10'd37 : tone = `NH4;
			10'd38 : tone = `NH4;
			10'd39 : tone = `NH4;
			10'd40 : tone = `NH4;
			10'd41 : tone = `NH4;
			10'd42 : tone = `NH3;
			10'd43 : tone = `NH3;
			10'd44 : tone = `NH3;
			10'd45 : tone = `NH3;
			10'd46 : tone = `NM0;
			10'd47 : tone = `NM0;
			//4 //1*
			10'd48 : tone = `NH1;
			10'd49 : tone = `NH1;
			10'd50 : tone = `NH1;
			10'd51 : tone = `NH1;
			10'd52 : tone = `NH1;
			10'd53 : tone = `NH1;
			10'd54 : tone = `NH1;
			10'd55 : tone = `NH1;
			10'd56 : tone = `NH1;
			10'd57 : tone = `NH1;
			10'd58 : tone = `NH1;
			10'd59 : tone = `NH1;
			10'd60 : tone = `NH1;
			10'd61 : tone = `NH1;
			10'd62 : tone = `NH1;
			10'd63 : tone = `NH1;
			//5 //5 5 5 1* 1* 5
			10'd64 : tone = `NM5;
			10'd65 : tone = `NM0;
			10'd66 : tone = `NM5;
			10'd67 : tone = `NM0;
			10'd68 : tone = `NM5;
			10'd69 : tone = `NM0;
			10'd70 : tone = `NH1;
			10'd71 : tone = `NM0;
			10'd72 : tone = `NH1;
			10'd73 : tone = `NH1;
			10'd74 : tone = `NH1;
			10'd75 : tone = `NH1;
			10'd76 : tone = `NH1;
			10'd77 : tone = `NH1;
			10'd78 : tone = `NM5;
			10'd79 : tone = `NM5;
			//6 //5 1* 2* 2* 4
			10'd80 : tone = `NM5;
			10'd81 : tone = `NM5;
			10'd82 : tone = `NH1;
			10'd83 : tone = `NH1;
			10'd84 : tone = `NH2;
			10'd85 : tone = `NH2;
			10'd86 : tone = `NH2;
			10'd87 : tone = `NM0;
			10'd88 : tone = `NH2;
			10'd89 : tone = `NH2;
			10'd90 : tone = `NH2;
			10'd91 : tone = `NH2;
			10'd92 : tone = `NH4;
			10'd93 : tone = `NH4;
			10'd94 : tone = `NM0;
			10'd95 : tone = `NM0;
			//7 //3* 2* 1* 2* 1*
			10'd96 : tone = `NH3;
			10'd97 : tone = `NH3;
			10'd98 : tone = `NH2;
			10'd99 : tone = `NH2;
			10'd100 : tone = `NH2;
			10'd101 : tone = `NH2;
			10'd102 : tone = `NH1;
			10'd103 : tone = `NH1;
			10'd104 : tone = `NH2;
			10'd105 : tone = `NH2;
			10'd106 : tone = `NH2;
			10'd107 : tone = `NM0;
			10'd108 : tone = `NH1;
			10'd109 : tone = `NH1;
			10'd110 : tone = `NH1;
			10'd111 : tone = `NM0;
			//8 //2* 1*
			10'd112 : tone = `NM0;
			10'd113 : tone = `NM0;
			10'd114 : tone = `NM0;
			10'd115 : tone = `NM0;
			10'd116 : tone = `NH2;
			10'd117 : tone = `NH2;
			10'd118 : tone = `NH2;
			10'd119 : tone = `NH2;
			10'd120 : tone = `NM0;
			10'd121 : tone = `NH2;
			10'd122 : tone = `NH2;
			10'd123 : tone = `NH2;
			10'd124 : tone = `NM0;
			10'd125 : tone = `NH1;
			10'd126 : tone = `NH1;
			10'd127 : tone = `NH1;
			//9 //1*
			10'd128 : tone = `NH1;
			10'd129 : tone = `NM0;
			10'd130 : tone = `NM0;
			10'd131 : tone = `NM0;
			10'd132 : tone = `NM0;
			10'd133 : tone = `NM0;
			10'd134 : tone = `NM0;
			10'd135 : tone = `NM0;
			10'd136 : tone = `NM0;
			10'd137 : tone = `NM0;
			10'd138 : tone = `NM0;
			10'd139 : tone = `NM0;
			10'd140 : tone = `NM0;	
			10'd141 : tone = `NM0;
			10'd142 : tone = `NM0;
			10'd143 : tone = `NM0;
			//10 //5 4 4 3 2 1
			10'd144 : tone = `NM5;
			10'd145 : tone = `NM5;
			10'd146 : tone = `NM5;
			10'd147 : tone = `NM5;
			10'd148 : tone = `NM4;
			10'd149 : tone = `NM0;
			10'd150 : tone = `NM4;
			10'd151 : tone = `NM0;
			10'd152 : tone = `NM3;
			10'd153 : tone = `NM3;
			10'd154 : tone = `NM3;
			10'd155 : tone = `NM3;
			10'd156 : tone = `NM2;
			10'd157 : tone = `NM2;
			10'd158 : tone = `NM1;
			10'd159 : tone = `NM1;
			//11 //1 1* 7 7
			10'd160 : tone = `NM1;
			10'd161 : tone = `NM1;
			10'd162 : tone = `NM0;
			10'd163 : tone = `NM0;
			10'd164 : tone = `NM0;
			10'd165 : tone = `NM0;
			10'd166 : tone = `NH1;
			10'd167 : tone = `NH1;
			10'd168 : tone = `NH1;
			10'd169 : tone = `NH1;
			10'd170 : tone = `NM7;
			10'd171 : tone = `NM0;
			10'd172 : tone = `NM7;
			10'd173 : tone = `NM0;
			10'd174 : tone = `NM0;
			10'd175 : tone = `NM0;
			//12 //6 5 6 5
			10'd176 : tone = `NM6;
			10'd177 : tone = `NM6;
			10'd178 : tone = `NM6;
			10'd179 : tone = `NM6;
			10'd180 : tone = `NM6;
			10'd181 : tone = `NM6;
			10'd182 : tone = `NM6;
			10'd183 : tone = `NM6;
			10'd184 : tone = `NM5;
			10'd185 : tone = `NM5;
			10'd186 : tone = `NM6;
			10'd187 : tone = `NM6;
			10'd188 : tone = `NM6;
			10'd189 : tone = `NM6;
			10'd190 : tone = `NM5;
			10'd191 : tone = `NM5;
			//13 //5 5 4 4
			10'd192 : tone = `NM5;
			10'd193 : tone = `NM5;
			10'd194 : tone = `NM0;
			10'd195 : tone = `NM0;
			10'd196 : tone = `NM0;
			10'd197 : tone = `NM0;
			10'd198 : tone = `NM0;
			10'd199 : tone = `NM0;
			10'd200 : tone = `NM5;
			10'd201 : tone = `NM5;
			10'd202 : tone = `NM5;
			10'd203 : tone = `NM5;
			10'd204 : tone = `NM4;
			10'd205 : tone = `NM0;
			10'd206 : tone = `NM4;
			10'd207 : tone = `NM0;
			//14 //3 2 1
			10'd208 : tone = `NM3;
			10'd209 : tone = `NM3;
			10'd210 : tone = `NM3;
			10'd211 : tone = `NM3;
			10'd212 : tone = `NM2;
			10'd213 : tone = `NM2;
			10'd214 : tone = `NM1;
			10'd215 : tone = `NM1;
			10'd216 : tone = `NM0;
			10'd217 : tone = `NM0;
			10'd218 : tone = `NM0;
			10'd219 : tone = `NM0;
			10'd220 : tone = `NM0;
			10'd221 : tone = `NM0;
			10'd222 : tone = `NM0;
			10'd223 : tone = `NM0;
			//15 //1 2 3b
			10'd224 : tone = `NM1;
			10'd225 : tone = `NM1;
			10'd226 : tone = `NM2;
			10'd227 : tone = `NM2;
			10'd228 : tone = `NM2;
			10'd229 : tone = `NM2;
			10'd230 : tone = `NM25;
			10'd231 : tone = `NM25;
			10'd232 : tone = `NM25;
			10'd233 : tone = `NM25;
			10'd234 : tone = `NM0;
			10'd235 : tone = `NM0;
			10'd236 : tone = `NM0;
			10'd237 : tone = `NM0;
			10'd238 : tone = `NM0;
			10'd239 : tone = `NM0;
			
			//16 //5 4 3b 4 //wrong?
			10'd240 : tone = `NM5;
			10'd241 : tone = `NM5;
			10'd242 : tone = `NM4;
			10'd243 : tone = `NM4;
			10'd244 : tone = `NM4;
			10'd245 : tone = `NM25;
			10'd246 : tone = `NM25;
			10'd247 : tone = `NM4;
			10'd248 : tone = `NM4;
			10'd249 : tone = `NM4;
			10'd250 : tone = `NM0;
			10'd251 : tone = `NM0;
			10'd252 : tone = `NM0;
			10'd253 : tone = `NM0;
			10'd254 : tone = `NM0;
			10'd255 : tone = `NM0;
			
			//17  5 4 4 3 2 1
			10'd256 : tone = `NM5;
			10'd257 : tone = `NM5;
			10'd258 : tone = `NM5;
			10'd259 : tone = `NM5;
			10'd260 : tone = `NM4;
			10'd261 : tone = `NM0;
			10'd262 : tone = `NM4;
			10'd263 : tone = `NM0;
			10'd264 : tone = `NM3;
			10'd265 : tone = `NM3;
			10'd266 : tone = `NM3;
			10'd267 : tone = `NM3;
			10'd268 : tone = `NM2;
			10'd269 : tone = `NM2;
			10'd270 : tone = `NM1;
			10'd271 : tone = `NM1;
			
			//18 1 1 1* 1* 2*
			10'd272 : tone = `NM0;
			10'd273 : tone = `NM0;
			10'd274 : tone = `NM1;
			10'd275 : tone = `NM0;
			10'd276 : tone = `NM1;
			10'd277 : tone = `NM0;
			10'd278 : tone = `NH1;
			10'd279 : tone = `NH1;
			10'd280 : tone = `NH1;
			10'd281 : tone = `NM0;
			10'd282 : tone = `NH1;
			10'd283 : tone = `NH1;
			10'd284 : tone = `NH1;
			10'd285 : tone = `NH1;
			10'd286 : tone = `NH2;
			10'd287 : tone = `NH2;
			
			//19 2* 7 1*
			10'd288 : tone = `NH2;
			10'd289 : tone = `NH2;
			10'd290 : tone = `NM7;
			10'd291 : tone = `NM0;
			10'd292 : tone = `NM7;
			10'd293 : tone = `NM0;
			10'd294 : tone = `NM0;
			10'd295 : tone = `NM0;
			10'd296 : tone = `NH1;
			10'd297 : tone = `NH1;
			10'd298 : tone = `NH1;
			10'd299 : tone = `NM0;
			10'd300 : tone = `NH1;
			10'd301 : tone = `NH1;
			10'd302 : tone = `NH1;
			10'd303 : tone = `NH1;
			
			//20 6 7 1* 1*  //wrong?
			10'd304 : tone = `NM6;
			10'd305 : tone = `NM6;
			10'd306 : tone = `NM6;
			10'd307 : tone = `NM6;
			10'd308 : tone = `NM7;
			10'd309 : tone = `NM7;
			10'd310 : tone = `NM7;
			10'd311 : tone = `NM7;
			10'd312 : tone = `NH1;
			10'd313 : tone = `NH1;
			10'd314 : tone = `NH1;
			10'd315 : tone = `NH1;
			10'd316 : tone = `NH1;
			10'd317 : tone = `NH1;
			10'd318 : tone = `NM0;
			10'd319 : tone = `NM0;
			
			//21 7 6 5 6
			10'd320 : tone = `NM7;
			10'd321 : tone = `NM7;
			10'd322 : tone = `NM7;
			10'd323 : tone = `NM6;
			10'd324 : tone = `NM5;
			10'd325 : tone = `NM5;
			10'd326 : tone = `NM5;
			10'd327 : tone = `NM5;
			10'd328 : tone = `NM5;
			10'd329 : tone = `NM5;
			10'd330 : tone = `NM6;
			10'd331 : tone = `NM6;
			10'd332 : tone = `NM6;
			10'd333 : tone = `NM6;
			10'd334 : tone = `NM0;
			10'd335 : tone = `NM0;
			
			//22 2 3 4 5
			10'd336 : tone = `NM2;
			10'd337 : tone = `NM2;
			10'd338 : tone = `NM0;
			10'd339 : tone = `NM0;
			10'd340 : tone = `NM3;
			10'd341 : tone = `NM3;
			10'd342 : tone = `NM4;
			10'd343 : tone = `NM4;
			10'd344 : tone = `NM4;
			10'd345 : tone = `NM4;
			10'd346 : tone = `NM0;
			10'd347 : tone = `NM0;
			10'd348 : tone = `NM5;
			10'd349 : tone = `NM5;
			10'd350 : tone = `NM5;
			10'd351 : tone = `NM5;
			
			//23 5 3 2 1
			10'd352 : tone = `NM5;
			10'd353 : tone = `NM5;
			10'd354 : tone = `NM5;
			10'd355 : tone = `NM5;
			10'd356 : tone = `NM3;
			10'd357 : tone = `NM3;
			10'd358 : tone = `NM2;
			10'd359 : tone = `NM2;
			10'd360 : tone = `NM0;
			10'd361 : tone = `NM0;
			10'd362 : tone = `NM1;
			10'd363 : tone = `NM1;
			10'd364 : tone = `NM0;
			10'd365 : tone = `NM1;
			10'd366 : tone = `NM1;
			10'd367 : tone = `NM1;
			
			//24 5 6 7b
			10'd368 : tone = `NM0;
			10'd369 : tone = `NM0;
			10'd370 : tone = `NM0;
			10'd371 : tone = `NM0;
			10'd372 : tone = `NM5;
			10'd373 : tone = `NM5;
			10'd374 : tone = `NM5;
			10'd375 : tone = `NM5;
			10'd376 : tone = `NM6;
			10'd377 : tone = `NM6;
			10'd378 : tone = `NM6;
			10'd379 : tone = `NM6;
			10'd380 : tone = `NM65;
			10'd381 : tone = `NM65;
			10'd382 : tone = `NM65;
			10'd383 : tone = `NM65;
			
			//25 7b 2* 2* 1*
			10'd384 : tone = `NM65;
			10'd385 : tone = `NM65;
			10'd386 : tone = `NH2;
			10'd387 : tone = `NH2;
			10'd388 : tone = `NH2;
			10'd389 : tone = `NH2;
			10'd390 : tone = `NH2;
			10'd391 : tone = `NH2;
			10'd392 : tone = `NH2;
			10'd393 : tone = `NH1;
			10'd394 : tone = `NM0;
			10'd395 : tone = `NH1;
			10'd396 : tone = `NM0;
			10'd397 : tone = `NH1;
			10'd398 : tone = `NH1;
			10'd399 : tone = `NH1;
			
			//26 6 5 4 5 3 2 3 
			10'd400 : tone = `NM6;
			10'd401 : tone = `NM6;
			10'd402 : tone = `NM5;
			10'd403 : tone = `NM5;
			10'd404 : tone = `NM4;
			10'd405 : tone = `NM4;
			10'd406 : tone = `NM5;
			10'd407 : tone = `NM5;
			10'd408 : tone = `NM0;
			10'd409 : tone = `NM0;
			10'd410 : tone = `NM3;
			10'd411 : tone = `NM3;
			10'd412 : tone = `NM2;
			10'd413 : tone = `NM2;
			10'd414 : tone = `NM3;
			10'd415 : tone = `NM3;
			
			//27 1 5 6  
			10'd416 : tone = `NM1;
			10'd417 : tone = `NM1;
			10'd418 : tone = `NM0;
			10'd419 : tone = `NM0;
			10'd420 : tone = `NM0;
			10'd421 : tone = `NM0;
			10'd422 : tone = `NM0;
			10'd423 : tone = `NM0;
			10'd424 : tone = `NM5;
			10'd425 : tone = `NM5;
			10'd426 : tone = `NM5;
			10'd427 : tone = `NM5;
			10'd428 : tone = `NM6;
			10'd429 : tone = `NM6;
			10'd430 : tone = `NM6;
			10'd431 : tone = `NM6;
			
			//28 7b 2* 2* 1*# //wrong
			10'd432 : tone = `NM65;
			10'd433 : tone = `NM65;
			10'd434 : tone = `NM65;
			10'd435 : tone = `NM65;
			10'd436 : tone = `NM65;
			10'd437 : tone = `NM65;
			10'd438 : tone = `NH2;
			10'd439 : tone = `NH2;
			10'd440 : tone = `NM0;
			10'd441 : tone = `NH2;
			10'd442 : tone = `NH2;
			10'd443 : tone = `NH15;
			10'd444 : tone = `NH15;
			10'd445 : tone = `NM0;
			10'd446 : tone = `NH15;
			10'd447 : tone = `NH15;
			
			//29 1*# 2* 3* 4*
			10'd448 : tone = `NH15;
			10'd449 : tone = `NH15;
			10'd450 : tone = `NM0;
			10'd451 : tone = `NM0;
			10'd452 : tone = `NH2;
			10'd453 : tone = `NH2;
			10'd454 : tone = `NH2;
			10'd455 : tone = `NH2;
			10'd456 : tone = `NH3;
			10'd457 : tone = `NH3;
			10'd458 : tone = `NH3;
			10'd459 : tone = `NH3;
			10'd460 : tone = `NH4;
			10'd461 : tone = `NH4;
			10'd462 : tone = `NH4;
			10'd463 : tone = `NH4;
			
			//30 4* 4* 4* 3* 3* 2* 1* 
			10'd464 : tone = `NM0;
			10'd465 : tone = `NH4;
			10'd466 : tone = `NM0;
			10'd467 : tone = `NH4;
			10'd468 : tone = `NM0;
			10'd469 : tone = `NH4;
			10'd470 : tone = `NM0;
			10'd471 : tone = `NH3;
			10'd472 : tone = `NM0;
			10'd473 : tone = `NH3;
			10'd474 : tone = `NM0;
			10'd475 : tone = `NH2;
			10'd476 : tone = `NH2;
			10'd477 : tone = `NH2;
			10'd478 : tone = `NH1;
			10'd479 : tone = `NH1;
			
			//31 2* 5 5
			10'd480 : tone = `NH2;
			10'd481 : tone = `NH2;
			10'd482 : tone = `NH2;
			10'd483 : tone = `NH2;
			10'd484 : tone = `NH2;
			10'd485 : tone = `NH2;
			10'd486 : tone = `NH2;
			10'd487 : tone = `NH2;
			10'd488 : tone = `NM0;
			10'd489 : tone = `NM0;
			10'd490 : tone = `NM0;
			10'd491 : tone = `NM0;
			10'd492 : tone = `NM5;
			10'd493 : tone = `NM0;
			10'd494 : tone = `NM5;
			10'd495 : tone = `NM0;
			
			//32 5 1* 1* 5 1* 
			10'd496 : tone = `NM5;
			10'd497 : tone = `NM5;
			10'd498 : tone = `NM0;
			10'd499 : tone = `NM0;
			10'd500 : tone = `NH1;
			10'd501 : tone = `NH1;
			10'd502 : tone = `NM0;
			10'd503 : tone = `NH1;
			10'd504 : tone = `NH1;
			10'd505 : tone = `NH1;
			10'd506 : tone = `NM5;
			10'd507 : tone = `NM5;
			10'd508 : tone = `NM5;
			10'd509 : tone = `NM5;
			10'd510 : tone = `NH1;
			10'd511 : tone = `NH1;
			
			//33 1* 2* 1* 2* 
			10'd512 : tone = `NH1;
			10'd513 : tone = `NH1;
			10'd514 : tone = `NH2;
			10'd515 : tone = `NH2;
			10'd516 : tone = `NH2;
			10'd517 : tone = `NH2;
			10'd518 : tone = `NH2;
			10'd519 : tone = `NH2;
			10'd520 : tone = `NH2;
			10'd521 : tone = `NH2;
			10'd522 : tone = `NM0;
			10'd523 : tone = `NM0;
			10'd524 : tone = `NH1;
			10'd525 : tone = `NH1;
			10'd526 : tone = `NH2;
			10'd527 : tone = `NH2;
			
			//34 4* 3* 2* 1*
			10'd528 : tone = `NH4;
			10'd529 : tone = `NH4;
			10'd530 : tone = `NH3;
			10'd531 : tone = `NH3;
			10'd532 : tone = `NH2;
			10'd533 : tone = `NH2;
			10'd534 : tone = `NH1;
			10'd535 : tone = `NH1;
			10'd536 : tone = `NM0;
			10'd537 : tone = `NM0;
			10'd538 : tone = `NM0;
			10'd539 : tone = `NM0;
			10'd540 : tone = `NM0;
			10'd541 : tone = `NM0;
			10'd542 : tone = `NM0;
			10'd543 : tone = `NM0;
			
			//35 5 5 5 1* 1* 5 
			10'd544 : tone = `NM5;
			10'd545 : tone = `NM0;
			10'd546 : tone = `NM5;
			10'd547 : tone = `NM0;
			10'd548 : tone = `NM5;
			10'd549 : tone = `NM0;
			10'd550 : tone = `NH1;
			10'd551 : tone = `NH1;
			10'd552 : tone = `NM0;
			10'd553 : tone = `NH1;
			10'd554 : tone = `NH1;
			10'd555 : tone = `NH1;
			10'd556 : tone = `NM5;
			10'd557 : tone = `NM5;
			10'd558 : tone = `NM5;
			10'd559 : tone = `NM5;
			
			//36  1* 2* 2* 
			10'd560 : tone = `NH1;
			10'd561 : tone = `NH1;
			10'd562 : tone = `NM0;
			10'd563 : tone = `NM0;
			10'd564 : tone = `NH2;
			10'd565 : tone = `NH2;
			10'd566 : tone = `NH2;
			10'd567 : tone = `NH2;
			10'd568 : tone = `NH2;
			10'd569 : tone = `NH2;
			10'd570 : tone = `NH2;
			10'd571 : tone = `NM0;
			10'd572 : tone = `NH2;
			10'd573 : tone = `NH2;
			10'd574 : tone = `NM0;
			10'd575 : tone = `NM0;
			//37 4* 3* 2* 1* 2* 1*
			10'd576 : tone = `NH4;
			10'd577 : tone = `NH4;
			10'd578 : tone = `NH3;
			10'd579 : tone = `NH3;
			10'd580 : tone = `NH2;
			10'd581 : tone = `NH2;
			10'd582 : tone = `NH1;
			10'd583 : tone = `NH1;
			10'd584 : tone = `NH2;
			10'd585 : tone = `NH2;
			10'd586 : tone = `NM0;
			10'd587 : tone = `NM0;
			10'd588 : tone = `NH1;
			10'd589 : tone = `NH1;
			10'd590 : tone = `NH1;
			10'd591 : tone = `NH1;
			//38  1* 1* 1* 1* 
			10'd592 : tone = `NM0;
			10'd593 : tone = `NM0;
			10'd594 : tone = `NM0;
			10'd595 : tone = `NM0;
			10'd596 : tone = `NM0;
			10'd597 : tone = `NM0;
			10'd598 : tone = `NM0;
			10'd599 : tone = `NM0;
			10'd600 : tone = `NH1;
			10'd601 : tone = `NM0;
			10'd602 : tone = `NH1;
			10'd603 : tone = `NM0;
			10'd604 : tone = `NH1;
			10'd605 : tone = `NM0;
			10'd606 : tone = `NH1;
			10'd607 : tone = `NM0;
			//39  5 3* 2* 7 7 
			10'd608 : tone = `NM0;
			10'd609 : tone = `NM0;
			10'd610 : tone = `NM5;
			10'd611 : tone = `NM5;
			10'd612 : tone = `NH3;
			10'd613 : tone = `NH3;
			10'd614 : tone = `NH2;
			10'd615 : tone = `NH2;
			10'd616 : tone = `NM0;
			10'd617 : tone = `NM0;
			10'd618 : tone = `NM0;
			10'd619 : tone = `NM0;
			10'd620 : tone = `NM7;
			10'd621 : tone = `NM0;
			10'd622 : tone = `NM7;
			10'd623 : tone = `NM0;
			//40 7 7 7 7 6 
			10'd624 : tone = `NM7;
			10'd625 : tone = `NM0;
			10'd626 : tone = `NM7;
			10'd627 : tone = `NM0;
			10'd628 : tone = `NM7;
			10'd629 : tone = `NM0;
			10'd630 : tone = `NM7;
			10'd631 : tone = `NM0;
			10'd632 : tone = `NM7;
			10'd633 : tone = `NM0;
			10'd634 : tone = `NM0;
			10'd635 : tone = `NM0;
			10'd636 : tone = `NM6;
			10'd637 : tone = `NM6;
			10'd638 : tone = `NM0;
			10'd639 : tone = `NM0;
			//41 5 6
			10'd640 : tone = `NM5;
			10'd641 : tone = `NM5;
			10'd642 : tone = `NM5;
			10'd643 : tone = `NM5;
			10'd644 : tone = `NM6;
			10'd645 : tone = `NM6;
			10'd646 : tone = `NM6;
			10'd647 : tone = `NM6;
			10'd648 : tone = `NM0;
			10'd649 : tone = `NM0;
			10'd650 : tone = `NM0;
			10'd651 : tone = `NM0;
			10'd652 : tone = `NM0;
			10'd653 : tone = `NM0;
			10'd654 : tone = `NM0;
			10'd655 : tone = `NM0;
			//42 4 1* 5 
			10'd656 : tone = `NM4;
			10'd657 : tone = `NM4;
			10'd658 : tone = `NM4;
			10'd659 : tone = `NM4;
			10'd660 : tone = `NH1;
			10'd661 : tone = `NH1;
			10'd662 : tone = `NH1;
			10'd663 : tone = `NH1;
			10'd664 : tone = `NH1;
			10'd665 : tone = `NH1;
			10'd666 : tone = `NH1;
			10'd667 : tone = `NH1;
			10'd668 : tone = `NM5;
			10'd669 : tone = `NM5;
			10'd670 : tone = `NM5;
			10'd671 : tone = `NM5;
			//43 2* 1* 2* 
			10'd672 : tone = `NH2;
			10'd673 : tone = `NH2;
			10'd674 : tone = `NH2;
			10'd675 : tone = `NH2;
			10'd676 : tone = `NH2;
			10'd677 : tone = `NH2;
			10'd678 : tone = `NH2;
			10'd679 : tone = `NH2;
			10'd680 : tone = `NM0;
			10'd681 : tone = `NM0;
			10'd682 : tone = `NM0;
			10'd683 : tone = `NM0;
			10'd684 : tone = `NH1;
			10'd685 : tone = `NH1;
			10'd686 : tone = `NH2;
			10'd687 : tone = `NH2;
			//44 3*b 2* 1* 2* 
			10'd688 : tone = `NH25;
			10'd689 : tone = `NH25;
			10'd690 : tone = `NH25;
			10'd691 : tone = `NH25;
			10'd692 : tone = `NH25;
			10'd693 : tone = `NH25;
			10'd694 : tone = `NH25;
			10'd695 : tone = `NH25;
			10'd696 : tone = `NM0;
			10'd697 : tone = `NM0;
			10'd698 : tone = `NH2;
			10'd699 : tone = `NH2;
			10'd700 : tone = `NH1;
			10'd701 : tone = `NH1;
			10'd702 : tone = `NH2;
			10'd703 : tone = `NH2;
			//45 1*
			10'd704 : tone = `NH1;
			10'd705 : tone = `NH1;
			10'd706 : tone = `NM0;
			10'd707 : tone = `NM0;
			10'd708 : tone = `NM0;
			10'd709 : tone = `NM0;
			10'd710 : tone = `NM0;
			10'd711 : tone = `NM0;
			10'd712 : tone = `NM0;
			10'd713 : tone = `NM0;
			10'd714 : tone = `NM0;
			10'd715 : tone = `NM0;
			10'd716 : tone = `NM0;
			10'd717 : tone = `NM0;
			10'd718 : tone = `NM0;
			10'd719 : tone = `NM0;
			//46
			10'd720 : tone = `NM0;
			10'd721 : tone = `NM0;
			10'd722 : tone = `NM0;
			10'd723 : tone = `NM0;
			10'd724 : tone = `NM0;
			10'd725 : tone = `NM0;
			10'd726 : tone = `NM0;
			10'd727 : tone = `NM0;
			10'd728 : tone = `NM0;
			10'd729 : tone = `NM0;
			10'd730 : tone = `NM0;
			10'd731 : tone = `NM0;
			10'd732 : tone = `NM0;
			10'd733 : tone = `NM0;
			10'd734 : tone = `NM0;
			10'd735 : tone = `NM0;
			//47
			10'd736 : tone = `NM0;
			10'd737 : tone = `NM0;
			10'd738 : tone = `NM0;
			10'd739 : tone = `NM0;
			10'd740 : tone = `NM0;
			10'd741 : tone = `NM0;
			10'd742 : tone = `NM0;
			10'd743 : tone = `NM0;
			10'd744 : tone = `NM0;
			10'd745 : tone = `NM0;
			10'd746 : tone = `NM0;
			10'd747 : tone = `NM0;
			10'd748 : tone = `NM0;
			10'd749 : tone = `NM0;
			10'd750 : tone = `NM0;
			10'd751 : tone = `NM0;
			
			default : tone = `NM0;
		endcase
	end else begin
		tone = `NM0;
	end
	
	
	
	
end

endmodule