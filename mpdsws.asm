.nds

.open "arm9_header.bin", 0x2000000

.org 0x2000BA4
.area 0x2001000-0x2000BA4
fix_touch_pos:
mov r1, 336 //X Scale Factor for Touch Position
ldrh r0, [r4] //Read Touch Screen X Coordinate
mul r0, r0, r1 //Scale Touch Screen X Coordinate
mov r0, r0, asr 8 //Downshift Touch Screen X Coordinate
sub r0, r0, 40 //Left-Align Touch Screen Coordinates
strh r0, [r4] //Update Touch Screen X Coordinate
ldrh r0, [r4, 4h] //Read Another Field
b 0x1FFC7F4 //Return to Caller
bg_force_wrap:
mov r12, 0x1 //Load 1
str r12, [r13] //Write Mosaic Flag
b 0x201F1C4 //Run Replaced Call
bg_force_width_512:
ldr r12, [r13, 8h] //Read Background Size
orr r12, r12, 0x1 //OR Wide Background Flag
str r12, [r13, 8h] //Write Background Size
b 0x201F1C4 //Run Replaced Call
bg_force_width_512_left:
ldr r12, [r13, 8h] //Read Background Size
orr r12, r12, 0x1 //OR Wide Background Flag
str r12, [r13, 8h] //Write Background Size
bg_force_left:
push r4-r7, r14 //Save Some Registers
sub r13, r13, 0x14 //Allocate Stack Space
mov r4, r0 //Copy Argument 1
mov r5, r1 //Copy Argument 2
mov r6, r2 //Copy Argument 3
mov r7, r3 //Copy Argument 4
//Copy Stack Arguments
add r0, r13, 0x28 //Stack Arguments Source
add r1, r13, 0 //Stack Arguments Destination
mov r2, 0x14 //Stack Argument Length
bl 0x206553C //Call MICopy16
mov r0, r4 //Restore Argument 1
mov r1, r5 //Restore Argument 2
mov r2, r6 //Restore Argument 3
mov r3, r7 //Restore Argument 4
bl 0x201F1C4 //Call BGInit
mov r0, r4 //Restore Argument 1
mov r1, r5 //Restore Argument 2
mov r2, 40 //Load 40
mov r3, 0 //Load 0
bl 0x201F7A0 //Call BGSetScroll
add r13, r13, 0x14 //Free Stack Space
pop r4-r7, r15 //Restore Registers
fix_menu_sprites:
ldrb r1, [r10, 6h] //Load X Position of File Select Sprite
cmp r1, 0x20 //Check if Right of Back Button
suble r1, r1, 0x28 //Left Align If Left
cmp r1, 0xE0 //Check if Right of OK Button 
addge r1, r1, 0x28 //Right Align If So
bx lr //Return to Caller
fix_pause_menu_ui:
ldrb r1, [r2, 3h] //Load X Position of Pause Menu Sprite
cmp r1, 0x20 //Check if Right of Back Button
suble r1, r1, 0x28 //Center 
cmp r1, 0xE0 //Check if Right of OK Button 
addge r1, r1, 0x28 //Right Align If So
b 0x20441A8 //Return to Caller
fix_pause_menu_cursor:
ldrb r3, [r1, 3h] //Load X Position of Pause Menu Sprite
cmp r3, 0x20 //Check if Right of Back Button
suble r3, r3, 0x28 //Center 
cmp r3, 0xE0 //Check if Right of OK Button 
addge r3, r3, 0x28 //Right Align If So
b 0x2044124 //Return to Caller
fix_pause_menu_touch:
ldrb r12, [r4, 3h] //Load X Position of Pause Menu Sprite
cmp r12, 0x20 //Check if Right of Back Button
suble r12, r12, 0x28 //Center 
cmp r12, 0xE0 //Check if Right of OK Button 
addge r12, r12, 0x28 //Right Align If So
b 0x2044260 //Return to Caller
fix_goomba_wrangler_score_spacing:
mov r2, 91 //Load Spacing Between Scores
mul r0, r0, r2 //Calculate Offset of Score
bx lr //Return to Caller
fix_goomba_wrangler_score_icons:
mov r2, 91 //Load Spacing Between Scores
mul r1, r1, r2 //Calculate Offset of Score
b 0x215F9CC //Return to Game
fix_goomba_target_pos:
mov r5, 91 //Load Spacing Between Goomba Targets
mul r5, r5, r4 //Calculate Offset of Goomba Target
add r0, r0, r5 //Calculate Position of Goomba Target
b 0x216328C //Return to Game
fix_goomba_final_target_pos:
mov r11, 91 //Load Spacing Between Goomba Targets
mul r0, r0, r11 //Calculate Offset of Goomba Target
add r0, r1, r0 //Calculate Position of Goomba Target
bx lr //Return to Caller
fix_goomba_top_screen_layer_pos:
mov r12, 40 //Load Top Screen Layer X Position
str r12, [r13, 10h] //Set Top Screen Layer X Position
b 0x2161A48 //Return to Game
fix_culling_planes:
mov r3, 336
mul r6, r6, r3
mov r6, r6, asr 8h
smull r2, r1, r0, r6
b 0x20145DC
fix_shortcut_penult_copy_ofs:
ldr r3, =(42*168*2)
add r0, r0, r3
b 0x2163038
fix_shortcut_last_copy_ofs:
ldr r3, =(42*200*2)
add r0, r0, r3
b 0x2163054
fix_mpp_sprites:
ldrb r5, [r10, 4h] //Load X Position of Mario Party Points Sprite
cmp r5, 0x20 //Check if Right of Back Button
suble r5, r5, 0x28 //Left Align If Left
cmp r5, 0xE0 //Check if Right of OK Button 
addge r5, r5, 0x28 //Right Align If So
bx lr //Return to Caller
fix_mpp_sprites_touch:
ldrb r0, [r5, 4h] //Load X Position of Mario Party Points Sprite
cmp r0, 0x20 //Check if Right of Back Button
suble r0, r0, 0x28 //Left Align If Left
cmp r0, 0xE0 //Check if Right of OK Button 
addge r0, r0, 0x28 //Right Align If So
bx lr //Return to Caller
fix_step_menu_sprites_touch:
ldrb r1, [r5, 4h] //Load X Position of Step it Up Menu Sprite
cmp r1, 0x20 //Check if Right of Back Button
suble r1, r1, 0x28 //Left Align If Left
cmp r1, 0xE0 //Check if Right of OK Button 
addge r1, r1, 0x28 //Right Align If So
b 0x217DC98 //Return to Caller
fix_step_menu_cursor:
ldrb r0, [r4, 4h] //Load X Position of Step it Up Menu Sprite
cmp r0, 0x20 //Check if Right of Back Button
suble r0, r0, 0x28 //Left Align If Left
cmp r0, 0xE0 //Check if Right of OK Button 
addge r0, r0, 0x28 //Right Align If So
bx lr //Return to Caller
fix_rubber_ducky_skew:
mov r0, 336 //Scale Factor for Rubber Ducky Rodeo Skew Point
mul r12, r12, r0 //Scale Rubber Ducky Rodeo Skew Point
mov r12, r12, asr 8h //Downshift Rubber Ducky Rodeo Skew Point
sub r12, r12, 40 //Center Rubber Ducky Rodeo Skew Point
str r12, [r2, 0BF0h] //Update Rubber Ducky Rodeo Skew Point
b 0x2160100 //Return to Caller
spr_set_pos_scaled:
mov r3, 336 //Scale Factor for Scaled Sprite Positions
mul r1, r1, r3 //Scale Input Sprite Position
mov r1, r1, asr 8h //Downshift Input Sprite Position
sub r1, r1, 40 //Center Input Sprite Position
b 0x201BB1C //Call SprSetPos
double_vision_force_bg_wrap:
ldrsb r4, [r2, 8h] //Get BG Address
cmp r4, 18h //Check for Main Screen Wood Background
cmpne r4, 0h //Check for Sub Screen Wood Background
moveq r4, 1 //Set Wrap Flag
movne r4, 0 //Do Not Set Wrap Flag
b 0x21641C8 //Return to Caller
fix_airbrushers_culling:
mov r0, 336 //Object Cull Width Scale Factor
mul r7, r7, r0 //Get Scaled Object Cull Width
mov r7, r7, asr 8h //Downshift Object Cull Width
sub r0, r4, r7 //Run Replaced Instruction
b 0x215DFA0 //Return to Caller
fix_airbrushers_bg_coin_culling:
ldrsh r11, [r7]
mov r0, 336 //Coin Cull Width Scale Factor
mul r11, r11, r0 //Get Scaled Coin Cull Width
mov r11, r11, asr 8h //Downshift Coin Cull Width
b 0x215D18C //Return to Caller
fix_cherry_go_round_scroll:
ldrsh r2, [r13, 3Ch] //Get X Position of Cherry Go Round BG
cmp r2, 0 //Check if Cherry Go Round Background is Left-Aligned
addeq r2, r2, 40 //Move Cherry Go Round Background Left
b 0x2162B90 //Return to Caller
fix_short_fuse_bg:
ldrsh r2, [r13, 3Ch] //Get BG Position for Short Fuse BG
ldrb r3, [r7, 7h] //Get BG Layer Index for Short Fuse BG
cmp r3, 2h //Check BG Layer Index for Short Fuse BG
addeq r2, r2, 40 //Shift BG Left for Short Fuse BG
b 0x2162E2C //Return to Caller
fix_extra_logo_scroll:
mov r1, r0 //Run Replaced Instruction
ldr r0, =0x20C8720 //Load Sub BG0 Scroll
mov r2, 0h //Load Scroll for Desert Duel Logo
strh r2, [r0] //Set Sub BG0 Scroll
bx lr //Return to Caller
fix_goomba_disappear:
cmp r1, 192 //Check for Minimum Y Position of Goomba in Goomba Wrangler
movlt r0, 0 //Mark Goomba as Destroyed if Below Minimum Y Position
bxlt lr //Return to Caller if Below 
cmp r1, 384 //Check for Maximum Y Position of Goomba in Goomba Wrangler
movlt r0, 4 //Mark Goomba as Visible if Below Maximum Y Position
movge r0, 0 //Mark Goomba as Destroyed if Above Maximum Y Position
bx lr //Return to Caller
fix_kamek_canvas:
mov r7, 3120 //X Scale for Touch Coordinates
add r10, r10, 40 //Left-Align Start Touch Coordinates
add r0, r0, 40 //Left-Align End Touch Coordinates
mul r10, r10, r7 //Scale Start Touch Coordinates
mul r7, r0, r7 //Scale End Touch Coordinates
mov r10, r10, asr 0Ch //Downshift Start Touch Coordinates
mov r7, r7, asr 0Ch //Downshift End Touch Coordinates
b 0x217BCF8 //Return to Caller
fix_gallery_sprites:
cmp r2, 16 //Check for Left Side Arrows
sublt r2, r2, 0x28 //Align Left Side Arrows to Left Side
cmp r2, 240 //Check for Right Side Arrows
addge r2, r2, 0x28 //Align Right Side Arrows to Right Side
str r2, [r13] //Set Target Position for Gallery Sprites
b 0x217D510 //Execute Replaced Subroutine Call
fix_party_results_button:
ldrb r5, [r10, 4h] //Load X Position of Party Results Button
cmp r5, 224 //Check for Right Party Results Button
addge r5, r5, 40 //Align to Right
b 0x217C1AC //Return to Caller
fix_party_results_button_touch:
ldrb r1, [r6, 4h] //Load X Position of Party Results Button
cmp r1, 224 //Check for Right Party Results Button
addge r1, r1, 40 //Align to Right
b 0x217C3F4 //Return to Caller
fix_party_results_button_cursor:
ldrb r0, [r4, 4h] //Load X Position of Party Results Button
cmp r0, 224 //Check for Right Party Results Button
addge r0, r0, 40 //Align to Right
b 0x217C6AC //Return to Caller
fix_turn_counter_slideout:
ldr r0, =270 //Load 270
add r0, r3, r0 //Set Position of Turn Counter Sprite
b 0x2186BB0 //Return to Caller
fix_boss_bash_menu_sprites:
ldrb r3, [r10, 4h] //Load X Position of Mario Party Points Sprite
cmp r3, 0x20 //Check if Right of Back Button
suble r3, r3, 0x28 //Left Align If Left
cmp r3, 0xE0 //Check if Right of OK Button 
addge r3, r3, 0x28 //Right Align If So
b 0x217C6F0 //Return to Caller
fix_scoreattack_menu_sprites_touch:
ldrb r1, [r6, 4h] //Load X Position of Score Scuffle Menu Sprite
cmp r1, 0x20 //Check if Right of Back Button
suble r1, r1, 0x28 //Left Align If Left
cmp r1, 0xE0 //Check if Right of OK Button 
addge r1, r1, 0x28 //Right Align If So
b 0x217C758 //Return to Caller
fix_scoreattack_menu_sprites:
ldrb r4, [r9, 4h] //Load X Position of Score Scuffle Menu Sprite
cmp r4, 0x20 //Check if Right of Back Button
suble r4, r4, 0x28 //Left Align If Left
cmp r4, 0xE0 //Check if Right of OK Button 
addge r4, r4, 0x28 //Right Align If So
b 0x217BBD4 //Return to Caller
fix_battlecup_sprites_touch:
ldrb r1, [r6, 4h] //Load X Position of Step it Up Menu Sprite
cmp r1, 0x20 //Check if Right of Back Button
suble r1, r1, 0x28 //Left Align If Left
cmp r1, 0xE0 //Check if Right of OK Button 
addge r1, r1, 0x28 //Right Align If So
b 0x2181E70 //Return to Caller
fix_battlecup_sprites:
ldrb r3, [r10, 4h] //Load X Position of Mario Party Points Sprite
cmp r3, 0x20 //Check if Right of Back Button
suble r3, r3, 0x28 //Left Align If Left
cmp r3, 0xE0 //Check if Right of OK Button 
addge r3, r3, 0x28 //Right Align If So
b 0x217E148 //Return to Caller
.pool
.endarea

.close

.open "arm9_decompressed.bin", 0x2004000

.org 0x20046B8
.area 0x48
ldr r2, =0x20C86B0 //Load BG Scroll Pointer
addne r2, r2, 0x70 //Offset Scroll Pointer for Sub Screen
mov r1, r0, lsl 1h //Load Screen Scroll Offset
ldr r0, =0x1FF //Load Screen Scroll Mask
and r0, r7, r0 //Mask Screen Scroll
add r0, r0, 40 //Offset Screen Scroll Left by 40 Pixels
strh r0, [r2, r1] //Center Screen Scroll
add r0, r2, 8 //Load Y Scroll Pointer
and r2, r9, 0xFF //Set Y Scroll Value
ldrh r1, [r5] //Load Some Flags
b 0x2004700 //Skip Over Useless Code
.pool
.endarea

.org 0x2004774
add r0, r7, 336 //Fix Maximum X Offset for Writing Tilemaps

.org 0x200557C
mov r2, -9 //Fix X Position of Back Button in Shops

.org 0x2005590
mov r2, 264 //Fix X Position of OK Button in Shops

.org 0x20055A8
mov r2, -9 //Fix X Position of Back Button in Board Startup

.org 0x20055C0
mov r2, 264 //Fix X Position of OK Button in Board Startup

.org 0x2006600
sub r1, r4, 8 //Fix X Position of Digit 1 of Timer

.org 0x20073D8
push lr
sub r13, r13, 0x18
ldr r12, [r13, 0x20]
str r12, [r13, 0x8]
ldr r12, [r13, 0x1C]
str r12, [r13, 0x4]
mov r12, 0
str r12, [r13]
bl 0x2007484
add r13, r13, 0x18
pop r15

.org 0x2009CD4
cmp r3, -641 //Fix Minimum Projected X Position for Viewport 3D to 2D

.org 0x2009CE4
cmp r3, 4736 //Fix Maximum Projected X Position for Viewport 3D to 2D

.org 0x200A02C
cmp r4, -641 //Fix Minimum Projected X Position for Viewport 2D to 3D

.org 0x200A038
cmp r4, 4736 //Fix Maximum Projected X Position for Viewport 2D to 3D

.org 0x20145D8
b fix_culling_planes //Fix Culling Planes for View

.org 0x201AB78
bl bg_force_wrap //Force Wrap of Download Play Loading Pattern

.org 0x201ABA4
bl bg_force_wrap //Force Wrap of Download Play Loading Background

.org 0x201AF74
mov r2, 312 //Fix Start X Position of Mario on Download Play Loading

.org 0x201AFF0
mov r0, 296 //Fix X Position of Loading Text on Download Play Loading

.org 0x201B2C4
mov r0, -56 //Fix Mimimum X Position of Mario on Download Play Loading

.org 0x201B2D8
movlt r0, 312 //Fix Return X Position of Mario on Download Play Loading

.org 0x201D60C
ldrsh r0, [r0, 1Ch] //Force Down Coordinate to be Signed

.org 0x201D618
ldrsh r0, [r0, 24h] //Force Pressed Coordinate to be Signed

.org 0x201D624
ldrsh r0, [r0, 2Ch] //Force Released Coordinate to be Signed

.org 0x201D658
ldrsh r0, [r0, r1] //Force Multiplayer Down Coordinate to be Signed

.org 0x201D668
ldrsh r0, [r0, r1] //Force Multiplayer Pressed Coordinate to be Signed

.org 0x201D678
ldrsh r0, [r0, r1] //Force Multiplayer Released Coordinate to be Signed

.org 0x20270E0
mov r12, -40 //Fix X Position of Wireless Strength Icon

.org 0x202AC38
bl bg_force_width_512_left //Force Width of Top Screen Rules Border

.org 0x202AC50
mov r2, 5h //Move Address of Top Screen Rules Background

.org 0x202AC64
bl bg_force_wrap //Force Top Screen Rules Background to Wrap

.org 0x202ACBC
bl bg_force_width_512_left //Force Width of Bottom Screen Rules Border

.org 0x202ACD4
mov r0, 5h //Move Address of Bottom Screen Rules Background

.org 0x202ACE8
bl bg_force_wrap //Force Bottom Screen Rules Background to Wrap

.org 0x202BA04
mov r4, 260 //Fix X Position of Puzzle Mode Player Icon

.org 0x202BC7C
mov r0, 0 //Fix X Position of Minigame Type

.org 0x202C830
mov r2, -8 //Fix X Position of Boss End Button on Rules Screen

.org 0x202C850
mov r2, -8 //Fix X Position of Start Button on Rules Screen

.org 0x202C878
mov r2, 264 //Fix X Position of Start Button on Rules Screen

.org 0x202D144
bl bg_force_width_512_left //Force Top Screen Results Bar to 512 Width

.org 0x202D170
bl bg_force_wrap //Force Wrap of Top Screen Results Background

.org 0x202D1C8
bl bg_force_width_512_left //Force Bottom Screen Results Bar to 512 Width

.org 0x202D1DC
mov r0, 13 //Change Bottom Screen Results Background Address

.org 0x202D1F4
bl bg_force_wrap //Force Wrap of Bottom Screen Results Background

.org 0x2037554
mov r0, 0Bh //Change Top Screen Background Address

.org 0x203756C
bl bg_force_width_512_left //Force Top Screen Background Width to 512

.org 0x2037598
bl bg_force_width_512_left //Force Top Screen Bosses Width to 512

.org 0x20375F0
bl bg_force_wrap //Force Wrap Screen Filter

.org 0x2037644
mov r2, 1Ch //Change Address of Bottom Screen Filter

.org 0x2037658
bl bg_force_width_512_left //Force Bottom Screen Filter to be Wider

.org 0x203AADC
mov r2, 264 //Fix X Position of Yes Button

.org 0x203AAF0
mov r2, -8 //Fix X Position of No Button

.org 0x203AB08
mov r2, 264 //Fix X Position of OK Button

.org 0x203AB34
mov r2, 264 //Fix X Position of Place Button

.org 0x203AB48
mov r2, -8 //Fix X Position of Back Button

.org 0x203AB60
mov r2, 248 //Fix X Position of Exit Button in Rules Board

.org 0x2044120
b fix_pause_menu_cursor //Jump to Code to Fix Pause Menu Cursor

.org 0x20441A4
b fix_pause_menu_ui //Jump to Code to Fix Pause Menu UI

.org 0x204425C
b fix_pause_menu_touch //Fix Touch Screen for Pause Menu

.org 0x2044CEC
mov r2, 0x28 //Fix X Position of Pause Screen Filter

.org 0x2044CF4
mov r3, 0 //Fix Y Position of Pause Screen Filter

.org 0x2044D44
mov r2, 0x1000 //Force Clear Screen Filter

.org 0x20451F8
mov r1, 200 //Set X Position of Game Mode Banner

.org 0x20453A4
mov r4, -104 //Fix Start X Position of Pause Menu Options

.org 0x2045B64
mov r4, -104 //Fix Start X Position of Pause Menu Minigame Sets

.org 0x2046220
mov r0, -104 //Fix Start X Position of Pause Menu COM Difficulties

.org 0x2047488
bl bg_force_wrap //Force Desert Duel Bottom Screen Filter to Wrap

.org 0x204749C
mov r2, 0x80 //Fix Screen Filter in Desert Duel

.org 0x2047564
bl bg_force_wrap //Force Desert Duel Top Screen Filter to Wrap

.org 0x2047608
b 0x20476C4 //Skip Loading Top Screen Bar

.org 0x20479B8
mov r2, 0x1000 //Increase Clear Size of Pause Menu Board Names

.org 0x2047A14
b 0x2047B04 //Skip Loading Top Screen Name Bar

.org 0x2047B50
rsb r2, r0, 0x340 //Move Destination Tile for Board Pause Screen Clear

.org 0x2047B9C
mov r1, 0Ah //Hide Top Screen Name Bar

.org 0x204F098
mov r1, 246 //X Spacing for Practice Sprites
mov r2, 168 //Y Spacing for Practice Sprites
mul r1, r1, r4 //Calculate X Offset for Practice Sprites
mul r2, r2, r4 //Calculate Y Offset for Practice Sprites
add r1, r1, 2 //Calculate X Position for Practice Sprites
add r2, r2, 12 //Calculate Y Position for Practice Sprites

.org 0x2052FE4
bl bg_force_width_512_left //Extend Foreground Width for Pause Screen

.org 0x2052FF8
mov r1, 15 //Force Background Address for Pause Screen

.org 0x2053014
bl bg_force_wrap //Extend Background Width for Pause Screen

.org 0x2053020
mov r2, 40 //Fix X Position of Pause Screen Foreground

.org 0x2057F58
cmp r0, 424 //Fix Maximum X Position of Sliding Results Player UIs

.org 0x205EEB0
orr r0, r0, 0x7200 //Force Touch Screen to Stretch and Enable Extra Flags for Both Screens

.org 0x206919C
mov r0, 1 //Disable Overlay Authenication

.org 0x2069450
mov r0, 1 //Disable Overlay Table Authenication

.org 0x209FD54
.dh 260 //Fix X Position of Boss Icon on Boss Rules Screen

.org 0x209FD58
.dh 264 //Fix X Position of Player Icon on Boss Rules Screen

.org 0x209FD5C
.dh 296 //Fix X Position of Blue Team Bar on 1 vs 3 Rules Screen

.org 0x209FD60
.dh 296 //Fix X Position of Red Team Bar on 1 vs 3 Rules Screen

.org 0x209FD6C
.dh 296 //Fix X Position of Blue Team Bar on 2 vs 2 Rules Screen

.org 0x209FD70
.dh 296 //Fix X Position of Red Team Bar on 2 vs 2 Rules Screen

.org 0x209FD74
.dh 260 //Fix X Position of P1 on Duel Rules Screen

.org 0x209FD78
.dh 260 //Fix X Position of P2 on Duel Rules Screen

.org 0x209FD8C
.dh 248 //Fix X Position of P1 on 4 Player Rules Screen

.org 0x209FD90
.dh 270 //Fix X Position of P2 on 4 Player Rules Screen

.org 0x209FD94
.dh 248 //Fix X Position of P3 on 4 Player Rules Screen

.org 0x209FD98
.dh 270 //Fix X Position of P4 on 4 Player Rules Screen

.org 0x209FD9C
.dh 248 //Fix X Position of P1 on 1 vs 3 Rules Screen

.org 0x209FDA0
.dh 226 //Fix X Position of P2 on 1 vs 3 Rules Screen

.org 0x209FDA4
.dh 270 //Fix X Position of P3 on 1 vs 3 Rules Screen

.org 0x209FDA8
.dh 248 //Fix X Position of P4 on 1 vs 3 Rules Screen

.org 0x209FDAC
.dh 226 //Fix X Position of P1 on 2 vs 2 Rules Screen

.org 0x209FDB0
.dh 270 //Fix X Position of P2 on 2 vs 2 Rules Screen

.org 0x209FDB4
.dh 226 //Fix X Position of P3 on 2 vs 2 Rules Screen

.org 0x209FDB8
.dh 270 //Fix X Position of P4 on 2 vs 2 Rules Screen

.org 0x209FDBC
.dh 138 //Fix X Position of P1 on Battle Rules Screen

.org 0x209FDC0
.dh 182 //Fix X Position of P2 on Battle Rules Screen

.org 0x209FDC4
.dh 226 //Fix X Position of P3 on Battle Rules Screen

.org 0x209FDC8
.dh 270 //Fix X Position of P4 on Battle Rules Screen

.org 0x209FDCC
.dh 260 //Fix X Position of P1 on Duel Rules Screen

.org 0x209FDD0
.dh 260 //Fix X Position of P2 on Duel Rules Screen

.org 0x209FDDC
.dh 260 //Fix X Position of P1 on Puzzle Rules Screen

.org 0x209FDE0
.dh 260 //Fix X Position of P2 on Puzzle Rules Screen

.org 0x209FE00
.dh -8 //Fix X Position of Controller Minigame State

.org 0x209FE08
.dh -8 //Fix X Position of Stylus Minigame State

.org 0x209FE10
.dh -8 //Fix X Position of Mic Minigame State

.org 0x20A2048
.dh 7 //Number of Sprites for Hex Set Bar
.dh 0x40F0, 0xC020, 0, -192, -16 //Fix Sprite 1 of Hex Set Bar
.dh 0x40F0, 0xC020, 0, -128, -16 //Fix Sprite 2 of Hex Set Bar
.dh 0x40F0, 0xC020, 0, -64, -16 //Fix Sprite 3 of Hex Set Bar
.dh 0x40F0, 0xC020, 0, 0, -16 //Fix Sprite 4 of Hex Set Bar
.dh 0x40F0, 0xC020, 0, 64, -16 //Fix Sprite 5 of Hex Set Bar
.dh 0x40F0, 0xC020, 0, 128, -16 //Fix Sprite 6 of Hex Set Bar
.dh 0x40F0, 0xC020, 0, 192, -16 //Fix Sprite 7 of Hex Set Bar

.org 0x20A2828
.dh 392 //Fix End Sprite X Position of Sliding Player Background

.org 0x20A2840
.dh 392 //Fix End Sprite X Position of Sliding Player Go Text

.org 0x20A2850
.dh -84 //Fix Start Sprite X Position of Sliding Player Icon

.org 0x20A2870
.dh 392 //Fix End Sprite X Position of Sliding Player Name

.org 0x20A28A0
.dh 380 //Fix Sprite X Position of Sliding Player Icon

.org 0x20A28C8
.dh -136 //Fix Start Sprite X Position of Sliding Player Name

.org 0x20A28E0
.dh -136 //Fix Start Sprite X Position of Sliding Player Go Text

.org 0x20A28F8
.dh -136 //Fix Start Sprite X Position of Sliding Player Background

.org 0x20A2930
.dh -88 //Fix End X Position of Left Player Sliding Out in Pen Pals

.org 0x20A29A8
.dh 344 //Fix End X Position of Right Player Sliding Out in Pen Pals

.org 0x20A2C9C
.dh 36 //Fix X Position 1 of Practice Background

.org 0x20A2CA0
.dh -212 //Fix X Position 2 of Practice Background

.org 0x20A2CA4
.dh 36 //Fix X Position 3 of Practice Background

.org 0x20A2CA8
.dh -212 //Fix X Position 4 of Practice Background

.org 0x20A2CAC
.dh 36 //Fix X Position 5 of Practice Background

.org 0x20A2CB0
.dh -212 //Fix X Position 6 of Practice Background

.org 0x20A2CB4
.dh 36 //Fix X Position 7 of Practice Background

.org 0x20A2CB8
.dh -212 //Fix X Position 8 of Practice Background

.org 0x20A2CBC
.dh 36 //Fix X Position 9 of Practice Background

.org 0x20A2CC0
.dh -212 //Fix X Position 10 of Practice Background

.org 0x20A2CC4
.dh 36 //Fix X Position 11 of Practice Background

.org 0x20A2CC8
.dh -212 //Fix X Position 12 of Practice Background

.org 0x20A2E7C
.dh -84 //Fix X Position of P1 HUD in Slide Out

.org 0x20A2E80
.dh 340 //Fix X Position of P2 HUD in Slide Out

.org 0x20A2E84
.dh -84 //Fix X Position of P3 HUD in Slide Out

.org 0x20A2E88
.dh 340 //Fix X Position of P4 HUD in Slide Out

.org 0x20AA8F4
.dh -4 //Fix X Position of P1 HUD

.org 0x20AA8F8
.dh 260 //Fix X Position of P2 HUD

.org 0x20AA8FC
.dh -4 //Fix X Position of P3 HUD

.org 0x20AA900
.dh 260 //Fix X Position of P4 HUD

.org 0x20AAC5C
.dh 160 //Fix End X Position of Start Text

.org 0x20AAC80
.dh -160 //Fix Start X Position of Start Text

.org 0x20AACDA
.dh 200 //Fix End X Position of Start Text

.org 0x20AAD7C
.dh 160 //Fix End X Position of Start Text

.org 0x20AAD5A
.dh 160 //Fix End X Position of Start Text

.org 0x20AAD7C
.dh 160 //Fix Start X Position of Start Text

.org 0x20AAD8E
.dh -160 //Fix Middle X Position of Start Text

.org 0x20AADA0
.dh -160 //Fix Middle X Position of Start Text

.org 0x20AADD6
.dh 160 //Fix Middle X Position of Start Text


.headersize 0x1FF8000-(0x20B9800-0x2004000) //ITCM Code

.org 0x1FFBABC
adds r1, r1, 0x29 //Fix Minimum Affine Sprite X Position

.org 0x1FFBAC4
cmp r10, 0x150 //Set Max Affine Sprite X Position
bge 0x1FFBC8C //Fix Affine Sprite Range

.org 0x1FFBB1C
adds r1, r1, 0x29 //Fix Minimum Sprite X Position

.org 0x1FFBB24
cmp r10, 0x150 //Set Max Sprite X Position
bge 0x1FFBC8C //Fix Sprite Range

.org 0x1FFBD28
adds r0, r0, 0x29 //Fix Minimum Extended Palette Sprite X Position

.org 0x1FFBD30
cmp r9, 0x150 //Set Max Extended Palette Sprite X Position
bge 0x1FFBE74 //Fix Extended Palette Sprite Range

.org 0x1FFC7F0
b fix_touch_pos //Jump to Code to Fix Canvas Range

.org 0x1FFC818
b 0x1FFC828 //Expand Touch Horizontal Range

.close

.open "overlay/overlay_0001.bin", 0x215BB40 //Goomba Wrangler Scene Overlay

.org 0x215ED1C
bl fix_goomba_top_screen_layer_pos //Fix Top Screen X Position for Goomba Wrangler Background

.org 0x215ED60
bl fix_goomba_top_screen_layer_pos //Fix Top Screen X Position for Goomba Wrangler Score

.org 0x215F9C8
b fix_goomba_wrangler_score_icons //Fix X Position of Goomba Wrangler Score Icons

.org 0x215F9D0
sub r1, r1, 24 //Fix 4-Player Mode Goomba Wrangler Score Icons Base Position

.org 0x215FAAC
bl fix_goomba_wrangler_score_spacing //Fix 4-Player Mode Goomba Wrangler Score Digit 1

.org 0x215FAB4
sub r0, r0, 8 //Fix 4-Player Mode Goomba Wrangler Score Digit 1 Base Position

.org 0x215FB60
bl fix_goomba_wrangler_score_spacing //Fix 4-Player Mode Goomba Wrangler Score Digit 2

.org 0x215FB68
add r0, r0, 0 //Fix 4-Player Mode Goomba Wrangler Score Digit 2 Base Position

.org 0x215FC14
bl fix_goomba_wrangler_score_spacing //Fix 4-Player Mode Goomba Wrangler Score Digit 3

.org 0x215FC1C
add r0, r0, 8 //Fix 4-Player Mode Goomba Wrangler Score Digit 3 Base Position

.org 0x215FD1C
bl fix_goomba_wrangler_score_spacing //Fix Duel Mode Goomba Wrangler Score Digit 1

.org 0x215FD24
sub r0, r0, 8 //Fix Duel Mode Goomba Wrangler Score Digit 1 Base Position

.org 0x215FDD4
bl fix_goomba_wrangler_score_spacing //Fix Duel Mode Goomba Wrangler Score Digit 2

.org 0x215FDDC
add r0, r0, 0 //Fix Duel Mode Goomba Wrangler Score Digit 2 Base Position

.org 0x215FE8C
bl fix_goomba_wrangler_score_spacing //Fix Duel Mode Goomba Wrangler Score Digit 3

.org 0x215FE94
add r0, r0, 8 //Fix Duel Mode Goomba Wrangler Score Digit 2 Base Position

.org 0x2161408
mov r2, 0 //Fix Goomba Wrangler Ending Cutscene Initial Background Color

.org 0x21614B8
mov r2, 0 //Fix Goomba Wrangler Ending Cutscene Background Color

.org 0x2163288
b fix_goomba_target_pos //Fix Target for Picked Up Goomba

.org 0x21637DC
bl fix_goomba_final_target_pos //Fix Final Target for Picked Up Goomba

.org 0x2163F34
bl fix_goomba_final_target_pos //Fix Final Target for Picked Up Goomba

.org 0x21646B8
b fix_goomba_disappear //Fix Goomba Disappear Range in Goomba Wrangler

.org 0x2166740
.dh -72 //Fix X Position of Top-Left Entering Goombas

.org 0x2166750
.dh 296 //Fix X Position of Top-Right Entering Goombas

.org 0x2166760
.dh -72 //Fix X Position of Top-Left Entering Goombas

.org 0x2166770
.dh 296 //Fix X Position of Bottom-Right Entering Goombas

.org 0x2166800
.dh -24 //Fix Starting X Position of 4-Player HUD in Goomba Wrangler
.dh 67 //Fix Starting X Position of Duel Mode HUD in Goomba Wrangler

.org 0x21668BE
.db 1 //Force BG Width of Top-Screen Goomba Wrangler Background

.org 0x21668C8
.db 1 //Force BG Width of Top-Screen Goomba Wrangler UI

.org 0x21668CA
.db 10 //Move BG Address of Top-Screen Goomba Wrangler UI

.org 0x21668D2
.db 1 //Force BG Width of Top-Screen Goomba Wrangler UI

.org 0x21668D4
.db 10 //Move BG Address of Top-Screen Goomba Wrangler UI

.close

.open "overlay/overlay_0002.bin", 0x215BB40 //Rail Riders Scene Overlay

.org 0x215C474
mov r1, 296 //Fix Maximum X Position for Rail Riders BG Repeat

.org 0x215C484
mov r3, 248 //Fix Minimum X Position for Rail Riders BG Repeat

.org 0x215C998
mov r7, -8 //Set P1/P3 HUD X Position in Rail Riders
mov r8, 220 //Set P2/P4 HUD X Position in Rail Riders

.org 0x215CDB4
mov r1, -24 //Fix X Position of Rail Riders P1 Icon

.org 0x215CDD0
mov r1, 8 //Fix X Position of Rail Riders P1 Bar

.org 0x215CE04
mov r1, 280 //Fix X Position of Rail Riders P2 Icon

.org 0x215CE20
mov r1, 248 //Fix X Position of Rail Riders P2 Bar

.org 0x215CE54
mov r1, -24 //Fix X Position of Rail Riders P3 Icon

.org 0x215CE70
mov r1, 8 //Fix X Position of Rail Riders P3 Bar

.org 0x215CEA4
mov r1, 280 //Fix X Position of Rail Riders P4 Icon

.org 0x215CEC0
mov r1, 248 //Fix X Position of Rail Riders P4 Bar

.org 0x215CEF0
mov r1, -24 //Fix X Position of Rail Riders Duel P1 Icon

.org 0x215CF00
mov r1, 8 //Fix X Position of Rail Riders Duel P1 Bar

.org 0x215CF4C
.dw 334 //Fix Starting X Position of Rail Riders Speed Digits
.dw 378 //Fix Starting X Position of Rail Riders Speed

.org 0x215CF74
mov r1, 280 //Fix X Position of Rail Riders Duel P2 Icon

.org 0x215CF84
mov r1, 248 //Fix X Position of Rail Riders Duel P2 Bar

.org 0x2162C38
mov r2, 40 //Fix X Position of Rail Riders Blur

.org 0x2163502
.dh -24 //Fix Position of Top Left Touch Indicator

.org 0x2163508
.dh 280 //Fix Position of Top Right Touch Indicator

.org 0x216350E
.dh 280 //Fix Position of Bottom Right Touch Indicator

.org 0x2163514
.dh -24 //Fix Position of Bottom Left Touch Indicator

.org 0x2163538
.dh -24 //Fix Position of Top Left Touch Indicator

.org 0x2163540
.dh 280 //Fix Position of Top Right Touch Indicator

.org 0x2163548
.dh 280 //Fix Position of Bottom Right Touch Indicator

.org 0x2163550
.dh -24 //Fix Position of Bottom Left Touch Indicator

.org 0x2163600
.db 1 //Fix BG Width for Rail Riders Blur Top Layer

.close

.open "overlay/overlay_0003.bin", 0x215BB40 //Dress to Success Scene Overlay

.org 0x2160FE8
bl bg_force_width_512_left //Force Top Screen Dress to Success Background Width to 512

.org 0x2161014
bl bg_force_width_512_left //Force Bottom Screen Dress to Success Background Width to 512

.org 0x2162000
mov r1, 280 //Fix X Position of Lower-Right Player Icon

.org 0x21620D8
mov r1, 280 //Fix X Position of Lower-Right Player Icon Border

.close

.open "overlay/overlay_0004.bin", 0x215BB40 //Camera Shy Scene Overlay

.org 0x215F5DC
bl bg_force_width_512_left //Extend Camera Shy Border Background

.org 0x215F5F0
mov r0, 13 //Move Top Screen Extra Background Address in Camera Shy

.org 0x215F620
mov r0, 14 //Move Top Screen Background Address in Camera Shy

.org 0x215F634
bl bg_force_width_512_left //Extend Camera Shy Top Screen Background

.org 0x215FB44
nop //Prevent BG1 Main from Being Scrolled in Camera Shy

.org 0x215FB68
nop //Prevent BG2 Sub from Being Scrolled in Camera Shy
nop //Prevent BG3 Sub from Being Scrolled in Camera Shy

.org 0x215FC8C
mov r1, 218 //Fix X Position of 1st Charge Meter Icon in Camera Shy
mov r2, 176 //Fix Y Position of 1st Charge MeterIcon in Camera Shy

.org 0x215FCC0
mov r1, 232 //Fix X Position of 2nd Charge Meter Icon in Camera Shy

.org 0x215FCF4
mov r1, 246 //Fix X Position of 3rd Charge Meter Icon in Camera Shy

.org 0x215FD28
mov r1, 260 //Fix X Position of 4th Charge Meter Icon in Camera Shy

.org 0x215FD64
mov r1, 280 //Fix X Position of Charge Meter Last Icon Marker in Camera Shy

.org 0x215FDA0
mov r1, 280 //Fix X Position of Charge Meter Last Icon in Camera Shy

.org 0x2160540
mov r1, 12 //Fix X Position of P1 Bar in Camera Shy

.org 0x2160558
mov r1, 244 //Fix X Position of P2 Bar in Camera Shy

.org 0x2160570
mov r1, 12 //Fix X Position of P3 Bar in Camera Shy

.org 0x2160588
mov r1, 244 //Fix X Position of P4 Bar in Camera Shy

.org 0x2162F1C
.dh -22 //Fix X Position of P1 Icons in Camera Shy

.org 0x2162F20
.dh 278 //Fix X Position of P2 Icons in Camera Shy

.org 0x2162F24
.dh -22 //Fix X Position of P3 Icons in Camera Shy

.org 0x2162F28
.dh 278 //Fix X Position of P4 Icons in Camera Shy

.org 0x2162FDC
.dh 2 //Fix X Position of P1 Player Icon 1 in Camera Shy

.org 0x2162FE0
.dh 20 //Fix X Position of P1 Player Icon 2 in Camera Shy

.org 0x2162FE4
.dh 38 //Fix X Position of P1 Player Icon 3 in Camera Shy

.org 0x2162FE8
.dh 254 //Fix X Position of P2 Player Icon 1 in Camera Shy

.org 0x2162FEC
.dh 236 //Fix X Position of P2 Player Icon 2 in Camera Shy

.org 0x2162FF0
.dh 218 //Fix X Position of P2 Player Icon 3 in Camera Shy

.org 0x2162FF4
.dh 2 //Fix X Position of P3 Player Icon 1 in Camera Shy

.org 0x2162FF8
.dh 20 //Fix X Position of P3 Player Icon 2 in Camera Shy

.org 0x2162FFC
.dh 38 //Fix X Position of P3 Player Icon 3 in Camera Shy

.org 0x2163000
.dh 254 //Fix X Position of P4 Player Icon 1 in Camera Shy

.org 0x2163004
.dh 236 //Fix X Position of P4 Player Icon 2 in Camera Shy

.org 0x2163008
.dh 218 //Fix X Position of P4 Player Icon 3 in Camera Shy

.close

.open "overlay/overlay_0005.bin", 0x215BB40 //Hedge Honcho Scene Overlay

.org 0x215C93C
mov r1, -29 //Fix X Position of Hedge Honcho Progress Icons

.org 0x2162280
cmp r3, -641 //Fix Minimum Projected X Position for Viewport 3D to 2D in Hedge Honcho

.org 0x216228C
cmp r3, 4736 //Fix Maximum Projected X Position for Viewport 3D to 2D in Hedge Honcho

.org 0x2165B54
mov r0, 6 //Move Addres of Top Screen Background of Hedge Honcho

.org 0x2165B6C
bl bg_force_width_512_left //Force Top Screen Background of Hedge Honcho to 512 Wide

.org 0x2165D0C
mov r1, -29 //Fix X Position of Hedge Honcho Progress Bar

.org 0x21677A4
.dw 4 //Fix X Position of P1 Decathlon Score in Hedge Honcho

.org 0x21677AC
.dw 252 //Fix X Position of P2 Decathlon Score in Hedge Honcho

.org 0x21677B4
.dw 4 //Fix X Position of P3 Decathlon Score in Hedge Honcho

.org 0x21677BC
.dw 252 //Fix X Position of P4 Decathlon Score in Hedge Honcho

.close

.open "overlay/overlay_0006.bin", 0x215BB40 //Study Fall Scene Overlay

.org 0x215CAA8
mov r3, 44 //Fix X Position of Left Side Sprite Overlay

.org 0x215CAF0
mov r3, 211 //Fix X Position of Right Side Sprite Overlay

.org 0x215D520
mov r0, 0x8000 //Fix Size of Allocation for Study Fall Map

.org 0x215D578
orr r0, r0, ((336/8) << 16) //Fix Width of Study Fall Background

.org 0x215D5B8
mov r2, ((336/8)*40) //Fix Size of Temporary Tilemap Copy in Study Fall

.org 0x215D5CC
add r8, r8, ((336/8)*40) //Fix Size of Temporary Tilemap Copy in Study Fall

.org 0x215D5E4
mov r11, ((336/8)*64) //Fix Middle Page Copy Size in Study Fall

.org 0x215D618
add r8, r8, ((336/8)*64) //Fix Middle Page Copy Pitch in Study Fall

.org 0x215D62C
mov r2, ((336/8)*24) //Fix  Last Page Copy Size in Study Fall

.org 0x215D63C
add r8, r8, ((336/8)*24) //Fix Last Page Copy Pitch in Study Fall

.org 0x215D66C
mov r2, ((336/8)*64) //Fix Middle Page Copy Size in Study Fall

.org 0x215D684
add r8, r8, ((336/8)*64) //Fix Middle Page Copy Pitch in Study Fall

.org 0x215D698
mov r2, ((336/8)*40) //Fix Size of Temporary Tilemap Copy in Study Fall

.org 0x215D6A4
add r8, r8, ((336/8)*40) //Fix Size of Temporary Tilemap Copy in Study Fall

.org 0x215D6AC
mov r4, ((336/8)*10) //Fix Size of Temporary Tilemap Copy in Study Fall

.org 0x215D6C8
add r8, r8, ((336/8)*10) //Fix Size of Temporary Tilemap Copy in Study Fall

.org 0x215D6D4
sub r0, r8, ((336/8)*80) //Fix Size of Temporary Tilemap Copy in Study Fall

.org 0x215D6DC
mov r2, ((336/8)*24) //Fix Size of Temporary Tilemap Copy in Study Fall

.org 0x215D72C
mov r3, 336 //Fix X Position of Tile Seam

.org 0x2160054
.dw ((336/8)*40), ((336/8)*104), ((336/8)*168), ((336/8)*256), ((336/8)*320), ((336/8)*384), ((336/8)*232), ((336/8)*448), ((336/8)*488) //Fix Tilemap Copy Offsets

.close

.open "overlay/overlay_0007.bin", 0x215BB40 //Domino Effect Scene Overlay

.org 0x216105C
cmp r3, -641 //Fix Minimum Projected X Position for Viewport 3D to 2D in Domino Effect

.org 0x2161068
cmp r3, 4736 //Fix Maximum Projected X Position for Viewport 3D to 2D in Domino Effect

.org 0x2161464
mov r0, 6 //Move Top Screen Background Address in Domino Effect

.org 0x216147C
bl bg_force_width_512_left //Force Top Screen Background Width in Domino Effect to 512

.org 0x2161494
mov r1, 14 //Move Top Screen Foreground Address in Domino Effect

.org 0x21614A8
bl bg_force_width_512_left //Force Top Screen Foreground Width in Domino Effect to 512

.org 0x2163744
.dw 4 //Fix X Position of P1 Decathlon Score

.org 0x216374C
.dw 252 //Fix X Position of P2 Decathlon Score

.org 0x2163754
.dw 4 //Fix X Position of P3 Decathlon Score

.org 0x216375C
.dw 252 //Fix X Position of P4 Decathlon Score

.close

.open "overlay/overlay_0008.bin", 0x215BB40 //Cherry Go Round Scene Overlay

.org 0x215C3C0
mov r1, -31 //Fix X Position of Timer Digits in Cherry Go Round

.org 0x215C434
mov r0, -36 //Fix X Position of Timer Background in Cherry Go Round

.org 0x215C4E8
mov r8, -8 //Fix X Position of Cherry Go Round P1/P3 Score
mov r9, 220 //Fix X Position of Cherry Go Round P2/P4 Score

.org 0x215C8EC
mov r1, -25 //Fix X Position of Cherry Go Round P1 Score Icon

.org 0x215C904
mov r1, 8 //Fix X Position of Cherry Go Round P1 Score Box 

.org 0x215C938
mov r1, 280 //Fix X Position of Cherry Go Round P2 Score Icon

.org 0x215C950
mov r1, 248 //Fix X Position of Cherry Go Round P2 Score Box 

.org 0x215C984
mov r1, -25 //Fix X Position of Cherry Go Round P3 Score Icon

.org 0x215C99C
mov r1, 8 //Fix X Position of Cherry Go Round P3 Score Box 

.org 0x215C9D0
mov r1, 280 //Fix X Position of Cherry Go Round P4 Score Icon

.org 0x215C9E8
mov r1, 248 //Fix X Position of Cherry Go Round P4 Score Box 

.org 0x215D0E4
mvn r7, 0x8 //Fix Starting X Position of Cherry Go Round Initial P2 Score
mov r9, 220 //Fix Starting X Position of Cherry Go Round Initial P2 Score

.org 0x215D170
mov r1, -25 //Fix X Position of Cherry Go Round P1 Score Icon

.org 0x215D194
mov r1, 280 //Fix X Position of Cherry Go Round P2 Score Icon

.org 0x215D1B8
mov r1, 8 //Fix X Position of Cherry Go Round P1 Score Box

.org 0x215D1E4
mov r1, 248 //Fix X Position of Cherry Go Round P2 Score Box

.org 0x2162A20
mov r4, 1 //Force Enable Mosaic for Cherry Go Round Backgrounds

.org 0x2162B8C
b fix_cherry_go_round_scroll //Fix Scroll of Cherry Go Round Background

.org 0x2163386
.db 1 //Force BG Width 512 for Bottom Screen Cherry Go Round Background

.org 0x21633E8
.db 1 //Force BG Width 512 for Cherry Go Round Score Boxes

.org 0x21633EA
.db 3 //Move BG Address for Cherry Go Round Score Boxes

.org 0x21633FC
.db 1 //Force BG Width 512 for Cherry Go Round Duel Score Boxes

.org 0x21633FE
.db 3 //Move BG Address for Cherry Go Round Duel Score Boxes

.close

.open "overlay/overlay_0013.bin", 0x215BB40 //Pedal Pushers Overlay

.org 0x215C90C
bl bg_force_wrap //Force Wrap Pedal Pushers Background Color

.org 0x215C988
mov r0, 6 //Move Pedal Pushers Main BG Address

.org 0x215C964
bl bg_force_width_512_left //Widen Pedal Pushers Main FG

.org 0x215C9A0
bl bg_force_width_512_left //Widen Pedal Pushers Main BG

.org 0x215DF40
mov r1, -29 //Move Initial Progress Player Icons Left in Pedal Pushers

.org 0x215E1C4
mov r1, -29 //Move Progress Bar Left in Pedal Pushers

.org 0x215FA04
mov r1, -29 //Move Progress Player Icons Left in Pedal Pushers

.org 0x2161F38
.dh 4 //Fix X Position of P1 Decathlon Colons

.org 0x2161F3C
.dh 252 //Fix X Position of P2 Decathlon Colons

.org 0x2161F40
.dh 4 //Fix X Position of P3 Decathlon Colons

.org 0x2161F44
.dh 252 //Fix X Position of P4 Decathlon Colons

.org 0x2161F48
.dh -12 //Fix X Position of P1 Decathlon Time

.org 0x2161F4C
.dh 220 //Fix X Position of P2 Decathlon Time

.org 0x2161F50
.dh -12 //Fix X Position of P3 Decathlon Time

.org 0x2161F54
.dh 220 //Fix X Position of P4 Decathlon Time

.org 0x2161F58
.dh -28 //Fix X Position of P1 Decathlon Icons

.org 0x2161F5C
.dh 284 //Fix X Position of P2 Decathlon Icons

.org 0x2161F60
.dh -28 //Fix X Position of P3 Decathlon Icons

.org 0x2161F64
.dh 284 //Fix X Position of P4 Decathlon Icons

.close

.open "overlay/overlay_0014.bin", 0x215BB40 //Roller Coasters Overlay

.org 0x2166384
mov r2, 40 //Fix X Position of Top Screen of Roller Coasters

.org 0x2166CB2
.db 1 //Fix Width of Top Screen Foreground of Roller Coasters

.org 0x2166CBC
.db 1 //Fix Width of Top Screen Background of Roller Coasters

.close

.open "overlay/overlay_0015.bin", 0x215BB40 //Get the Lead Out Overlay

.org 0x215BCE8
mov r0, 6 //Move Get the Lead Out Main FG Address

.org 0x215BD00
bl bg_force_width_512_left //Widen Get the Lead Out Main FG

.org 0x215BD14
mov r0, 14 //Move Get the Lead Out Main FG Address

.org 0x215BD2C
bl bg_force_width_512_left //Widen Get the Lead Out Main BG

.org 0x215CDBC
mov r6, -36 //Fix Minimum X Position of Scores in Get the Lead Out
mov r5, 216 //Fix Maximum X Position of Scores in Get the Lead Out

.org 0x215CE10
cmp r0, -36 //Check Minimum X Position of Scores in Get the Lead Out

.org 0x215CE1C
cmp r0, 216 //Check Maximum X Position of Scores in Get the Lead Out

.org 0x215EC30
.dh -4, 84, 172, 260 //Fix X Position of 4-Player HUD Icons in Get the Lead Out
.dh 76, 180 //Fix X Position of Duel HUD Icons in Get the Lead Out

.org 0x215EC40
.dh 1, 12, 23, 34 //Fix X Position of 4-Player HUDs in Get the Lead Out
.dh 11, 24 //Fix X Position of Duel HUDs in Get the Lead Out

.close

.open "overlay/overlay_0016.bin", 0x215BB40 //Shortcut Circuit Overlay

.org 0x2162FA4
orr r0, r0, (42 << 16) //Fix Width of Shortcut Circuit Background

.org 0x2162FD0
mov r2, (42*40*2) //Fix Size of Shortcut Circuit Background Top Copy

.org 0x2162FE4
mov r8, (42*40*2) //Base Offset of Shortcut Circuit Background Middle Copy
mov r5, (42*32*2) //Fix Size of Shortcut Circuit Background Middle Copy

.org 0x2163004
add r0, r1, r8 //Fix Offset of Shortcut Circuit Background Middle Copy

.org 0x2163018
add r8, r8, (42*32*2) //Fix Pitch of Shortcut Circuit Background Middle Copy

.org 0x216302C
mov r2,(42*32*2) //Fix Size of Shortcut Circuit Background Bottom Copy

.org 0x2163034
b fix_shortcut_penult_copy_ofs

.org 0x2163048
mov r2,(42*32*2) //Fix Size of Shortcut Circuit Background Bottom Copy

.org 0x2163050
b fix_shortcut_last_copy_ofs

.org 0x2163098
mov r3, 336 //Fix Width of Shortcut Circuit Background Copy

.org 0x21630C0
mov r3, 336 //Fix Width of Shortcut Circuit Background Copy

.org 0x21630E4
.dw (42*232*2)+4 //Fix Size of Shortcut Circuit Background Allocation

.org 0x2163BBB
.db 14 //Change Shortcut Circuit Background Address

.close

.open "overlay/overlay_0017.bin", 0x215BB40 //Big Blowout Scene Overlay

.org 0x215C92C
mov r2, 2 //Load BG Address of Big Blowout Microphone Icons
str r2, [r13, 0Ch] //Set BG Address of Big Blowout Microphone Icons

.org 0x215C93C
mov r0, 1 //Load Screen of Big Blowout Microphone Icons

.org 0x215C970
mov r3, 0x1800 //Fix Graphics Offset for Microphone Icons in Big Blowout

.org 0x215C984
mov r0, 192 //Fix Tile Offset for Microphone Icons in Big Blowout

.org 0x215C9C4
bl bg_force_width_512_left //Expand Big Blowout Bottom Screen Background

.org 0x215CBB0
mov r1, -29 //Fix X Position of Big Blowout Progress Bar

.org 0x215CBF4
mov r6, -29 //Fix X Position of Big Blowout Progress Icons

.close

.open "overlay/overlay_0018.bin", 0x215BB40 //Trash Landing Scene Overlay

.org 0x21611A0
mov r8, 0xCC0

.org 0x2161218
orr r0, r0, 0x2A0000 //Fix BG Width of Trash Landing
mov r1, r2, lsl 7h //Fix Allocation Size of Trash Landing BG

.org 0x21612FC
mov r3, 336 //Fix Right Side of Trash Landing BG

.org 0x2162770
.dw 252 //Fix Length of Trash Landing BG Copy 1

.org 0x216277C
.dw 252 //Fix Length of Trash Landing BG Copy 2

.org 0x2162788
.dw 252 //Fix Length of Trash Landing BG Copy 3

.org 0x2162794
.dw 252 //Fix Length of Trash Landing BG Copy 4

.org 0x21627A0
.dw 252 //Fix Length of Trash Landing BG Copy 5

.org 0x21627AC
.dw 252 //Fix Length of Trash Landing BG Copy 6

.org 0x21627B8
.dw 756 //Fix Length of Trash Landing BG Copy 7

.org 0x21627C4
.dw 252 //Fix Length of Trash Landing BG Copy 8

.close

.open "overlay/overlay_0019.bin", 0x215BB40 //Cheep Cheep Chance Scene Overlay

.org 0x215C3BC
mov r2, 40 //Fix X Position of Cheep Cheep Chance Background

.org 0x215C3DC
mov r3, 0 //Fix Y Position of Cheep Cheep Chance Background

.org 0x216143C
.dw 1 //Fix Cheep Cheep Chance Background Width

.close

.open "overlay/overlay_0020.bin", 0x215BB40 //Whomp-a-Thon Scene Overlay

.org 0x215E590
mov r2, 40 //Fix X Position of Whomp-a-Thon Top Screen Background

.org 0x215E5B0
mov r3, 0 //Fix Y Position of Whomp-a-Thon Top Screen Background

.org 0x2164D34
.dw 252 //Fix X Position of Whomp-a-Thon Timer

.org 0x2164DB0
.dw 4 //Fix X Position of P1 Decathlon HUD in Whomp-a-Thon

.org 0x2164DB8
.dw 252 //Fix X Position of P2 Decathlon HUD in Whomp-a-Thon

.org 0x2164DC0
.dw 4 //Fix X Position of P3 Decathlon HUD in Whomp-a-Thon

.org 0x2164DC8
.dw 252 //Fix X Position of P4 Decathlon HUD in Whomp-a-Thon

.org 0x2165268
.dw ((((0x3E-128)*336)/256)+128) //X Position of Top Screen Flower 1
.dw ((((0x76-192)*336)/256)+192) //Y Position of Top Screen Flower 1

.org 0x2165274
.dw ((((0x33-128)*336)/256)+128) //X Position of Top Screen Flower 2
.dw ((((0x48-192)*336)/256)+192) //Y Position of Top Screen Flower 2

.org 0x2165280
.dw ((((0x35-128)*336)/256)+128) //X Position of Top Screen Flower 3
.dw ((((0x20-192)*336)/256)+192) //Y Position of Top Screen Flower 3

.org 0x216528C
.dw ((((0x63-128)*336)/256)+128) //X Position of Top Screen Flower 4
.dw ((((0x5F-192)*336)/256)+192) //Y Position of Top Screen Flower 4

.org 0x2165298
.dw ((((0x6A-128)*336)/256)+128) //X Position of Top Screen Flower 5
.dw ((((0xE-192)*336)/256)+192) //Y Position of Top Screen Flower 5

.org 0x21652A4
.dw ((((0x4-128)*336)/256)+128) //X Position of Top Screen Flower 6
.dw ((((0x6D-192)*336)/256)+192) //Y Position of Top Screen Flower 6

.org 0x21652B0
.dw ((((0x1C-128)*336)/256)+128) //X Position of Top Screen Flower 7
.dw ((((0x91-192)*336)/256)+192) //Y Position of Top Screen Flower 7

.org 0x21652BC
.dw ((((0x95-128)*336)/256)+128) //X Position of Top Screen Flower 8
.dw ((((0x46-192)*336)/256)+192) //Y Position of Top Screen Flower 8

.org 0x21652C8
.dw ((((0x9A-128)*336)/256)+128) //X Position of Top Screen Flower 9
.dw ((((0x18-192)*336)/256)+192) //Y Position of Top Screen Flower 9

.org 0x21652D4
.dw ((((0x99-128)*336)/256)+128) //X Position of Top Screen Flower 10
.dw ((((0x92-192)*336)/256)+192) //Y Position of Top Screen Flower 10

.org 0x21652E0
.dw ((((0xEF-128)*336)/256)+128) //X Position of Top Screen Flower 11
.dw ((((0x2F-192)*336)/256)+192) //Y Position of Top Screen Flower 11

.org 0x21652EC
.dw ((((0xC5-128)*336)/256)+128) //X Position of Top Screen Flower 12
.dw ((((0x24-192)*336)/256)+192) //Y Position of Top Screen Flower 12

.org 0x21652F8
.dw ((((0xE0-128)*336)/256)+128) //X Position of Top Screen Flower 13
.dw ((((0x58-192)*336)/256)+192) //Y Position of Top Screen Flower 13

.org 0x2165304
.dw ((((0xE9-128)*336)/256)+128) //X Position of Top Screen Flower 14
.dw ((((0x5-192)*336)/256)+192) //Y Position of Top Screen Flower 14

.org 0x2165310
.dw ((((0xE1-128)*336)/256)+128) //X Position of Top Screen Flower 15
.dw ((((0x96-192)*336)/256)+192) //Y Position of Top Screen Flower 15

.org 0x216531C
.dw ((((0x56-128)*336)/256)+128) //X Position of Top Screen Flower 16
.dw ((((0x31-192)*336)/256)+192) //Y Position of Top Screen Flower 16

.org 0x2165328
.dw ((((0x22-128)*336)/256)+128) //X Position of Top Screen Flower 17
.dw ((((0x68-192)*336)/256)+192) //Y Position of Top Screen Flower 17

.org 0x2165334
.dw ((((0x5A-128)*336)/256)+128) //X Position of Top Screen Flower 18
.dw ((((0x95-192)*336)/256)+192) //Y Position of Top Screen Flower 18

.org 0x2165340
.dw ((((0x6-128)*336)/256)+128) //X Position of Top Screen Flower 19
.dw ((((0x2D-192)*336)/256)+192) //Y Position of Top Screen Flower 19

.org 0x216534C
.dw ((((0xE-128)*336)/256)+128) //X Position of Top Screen Flower 20
.dw ((((0x48-192)*336)/256)+192) //Y Position of Top Screen Flower 20

.org 0x2165358
.dw ((((0x78-128)*336)/256)+128) //X Position of Top Screen Flower 21
.dw ((((0x84-192)*336)/256)+192) //Y Position of Top Screen Flower 21

.org 0x2165364
.dw ((((0x8C-128)*336)/256)+128) //X Position of Top Screen Flower 22
.dw ((((0x6B-192)*336)/256)+192) //Y Position of Top Screen Flower 22

.org 0x2165370
.dw ((((0x73-128)*336)/256)+128) //X Position of Top Screen Flower 23
.dw ((((0x3B-192)*336)/256)+192) //Y Position of Top Screen Flower 23

.org 0x216537C
.dw ((((0x10-128)*336)/256)+128) //X Position of Top Screen Flower 24
.dw ((((0xA-192)*336)/256)+192) //Y Position of Top Screen Flower 24

.org 0x2165388
.dw ((((0xFB-128)*336)/256)+128) //X Position of Top Screen Flower 25
.dw ((((0x76-192)*336)/256)+192) //Y Position of Top Screen Flower 25

.org 0x2165394
.dw ((((0xBD-128)*336)/256)+128) //X Position of Top Screen Flower 26
.dw ((((0x86-192)*336)/256)+192) //Y Position of Top Screen Flower 26

.org 0x21653A0
.dw ((((0xB2-128)*336)/256)+128) //X Position of Top Screen Flower 27
.dw ((((0x68-192)*336)/256)+192) //Y Position of Top Screen Flower 27

.org 0x21653AC
.dw ((((0xBB-128)*336)/256)+128) //X Position of Top Screen Flower 28
.dw ((((0x46-192)*336)/256)+192) //Y Position of Top Screen Flower 28

.org 0x21653B8
.dw ((((0xB4-128)*336)/256)+128) //X Position of Top Screen Flower 29
.dw ((((0x5-192)*336)/256)+192) //Y Position of Top Screen Flower 29

.org 0x21653C4
.dw ((((0xD4-128)*336)/256)+128) //X Position of Top Screen Flower 30
.dw ((((0x76-192)*336)/256)+192) //Y Position of Top Screen Flower 30

.close

.open "overlay/overlay_0021.bin", 0x215BB40 //Twist and Route Scene Overlay

.org 0x215D5CC
mov r1, -29 //Fix X Position of Player Icons on Progress Bar

.org 0x215DC48
bl bg_force_left //Left-Align Bottom Screen Background

.org 0x215F334
mov r2, -29 //Fix X Position of Player Icons on Progress Bar

.org 0x215F7A4
mov r7, -29 //Fix Initial X Position of Player Icons on Progress Bar

.org 0x215FECC
mov r6, 1 //Force Twist and Route Objects to be Always Visible

.org 0x2160060
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x21601F4
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x2160388
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x216051C
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x21607F8
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x216098C
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x2160B20
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x2160C78
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x2160E30
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x2160FC4
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x2161158
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x21612EC
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.org 0x2161444
mov r5, 1 //Force Twist and Route Objects to be Always Visible

.close

.open "overlay/overlay_0022.bin", 0x215BB40 //Crater Crawl Scene Overlay

.org 0x215C294
bl bg_force_width_512_left //Fix Crater Crawl Mountain Background

.org 0x215C2D0
bl bg_force_wrap //Fix Crater Crawl Sky

.org 0x215CBEC
mov r1, 244 //Fix X Position of Crater Crawl Timer Background

.org 0x215CD80
mov r1, 256 //Fix X Position of Crater Crawl Timer Left Digit

.org 0x215CE6C
mov r1, 272 //Fix X Position of Crater Crawl Timer Right Digit

.org 0x215D5EC
mov r1, 264 //Fix X Position of Crater Crawl Timer Center Digit

.close

.open "overlay/overlay_0023.bin", 0x215BB40 //Boogie Beam Scene Overlay

.org 0x215BFA8
mov r0, 14 //Fix BG Address in Boogie Beam

.org 0x215BFC0
bl bg_force_width_512_left //Fix BG Width in Boogie Beam

.org 0x215C554
mov r1, 108 //Fix X Position of Pressed Left Button in Boogie Beam

.org 0x215C5B0
mov r1, 148 //Fix X Position of Pressed Right Button in Boogie Beam

.org 0x215C600
mov r1, 108 //Fix X Position of Waiting Left Button in Boogie Beam

.org 0x215C650
mov r1, 148 //Fix X Position of Waiting Right Button in Boogie Beam

.org 0x215F2E0
.dh -12 //Fix X Position of P1 Score Box in Boogie Beam

.org 0x215F2E4
.dh 268 //Fix X Position of P2 Score Box in Boogie Beam

.org 0x215F2E8
.dh -12 //Fix X Position of P3 Score Box in Boogie Beam

.org 0x215F2EC
.dh 268 //Fix X Position of P4 Score Box in Boogie Beam

.org 0x215F2F0
.dh -24 //Fix X Position of P1 Score Icon in Boogie Beam

.org 0x215F2F4
.dh 280 //Fix X Position of P2 Score Icon in Boogie Beam

.org 0x215F2F8
.dh -24 //Fix X Position of P3 Score Icon in Boogie Beam

.org 0x215F2FC
.dh 280 //Fix X Position of P4 Score Icon in Boogie Beam

.org 0x215F300
.dh -12 //Fix X Position of P1 Score in Boogie Beam

.org 0x215F304
.dh 252 //Fix X Position of P2 Score in Boogie Beam

.org 0x215F308
.dh -12 //Fix X Position of P3 Score in Boogie Beam

.org 0x215F30C
.dh 252 //Fix X Position of P4 Score in Boogie Beam

.org 0x215F310
.dw (44 << 12) //Fix X Position of Left Button Center in Boogie Beam

.org 0x215F318
.dw (212 << 12) //Fix X Position of Right Button Center in Boogie Beam

.close

.open "overlay/overlay_0024.bin", 0x215BB40 //Parachuting Gallery Scene Overlay

.org 0x216344C
mov r1, 0 //Move BG Address for Parachuting Gallery Blur Layer 1

.org 0x2163464
bl bg_force_width_512_left //Force Parachuting Gallery Blur Layer 1 to Widen

.org 0x2163478
mov r1, 2 //Move BG Address for Parachuting Gallery Blur Layer 2

.org 0x2163490
bl bg_force_width_512_left //Force Parachuting Gallery Blur Layer 1 to Widen

.close

.open "overlay/overlay_0025.bin", 0x215BB40 //Boo Tag Scene Overlay

.org 0x215BFF8
mov r0, 14 //Fix Boo Tag Upper Layer Address

.org 0x215C010
bl bg_force_width_512_left //Expand Boo Tag Upper Layer

.org 0x215C04C
bl bg_force_left //Force Boo Tag Lower Layer Left

.org 0x216186C
cmp r0, -8 //Minimum X Position of Boo in Boo Tag

.org 0x21618E4
cmp r0, 264 //Maximum X Position of Boo in Boo Tag

.org 0x2162F94
.dw -4 //Fix X Position of P1 HUD Bar in Boo Tag

.org 0x2162F9C
.dw 260 //Fix X Position of P2 HUD Bar in Boo Tag

.org 0x2162FA4
.dw -4 //Fix X Position of P3 HUD Bar in Boo Tag

.org 0x2162FAC
.dw 260 //Fix X Position of P4 HUD Bar in Boo Tag

.org 0x2162FB4
.dw 12 //Fix X Position of P1 HUD Icon in Boo Tag

.org 0x2162FBC
.dw 212 //Fix X Position of P2 HUD Icon in Boo Tag

.org 0x2162FC4
.dw 12 //Fix X Position of P3 HUD Icon in Boo Tag

.org 0x2162FCC
.dw 212 //Fix X Position of P4 HUD Icon in Boo Tag

.org 0x2162FD4
.dw 28 //Fix X Position of P1 HUD Timer in Boo Tag

.org 0x2162FDC
.dw 228 //Fix X Position of P2 HUD Timer in Boo Tag

.org 0x2162FE4
.dw 28 //Fix X Position of P3 HUD Timer in Boo Tag

.org 0x2162FEC
.dw 228 //Fix X Position of P4 HUD Timer in Boo Tag


.close

.open "overlay/overlay_0026.bin", 0x215BB40 //Dust Buddies Scene Overlay

.org 0x215BC38
bl bg_force_wrap //Force Wrap Top Screen Background in Dust Buddies

.org 0x215BC50
mov r0, 13h //Move Dust Buddies Top Screen Table BG Address

.org 0x215BC68
bl bg_force_width_512 //Extend Dust Buddies Top Screen Table BG

.org 0x215BC7C
mov r1, 1Ah //Move Dust Buddies Bottom Screen Background BG Address

.org 0x215BC94
bl bg_force_wrap //Force Wrap Bottom Screen Background in Dust Buddies

.org 0x215BCAC
mov r2, 1Bh //Move Dust Buddies Bottom Screen Table BG Address

.org 0x215BCC0
bl bg_force_width_512 //Extend Dust Buddies Bottom Screen Table BG

.org 0x215D9E4
mvn r0, 0x18 //Fix Player Left Range in Dust Buddies

.org 0x215DA00
mov r0, 280 //Fix Player Right Range in Dust Buddies

.org 0x215F008
mov r0, -32 //Fix X Position of Left Table Leg in Dust Buddies

.org 0x215F020
mov r0, 288 //Fix X Position of Right Table Leg in Dust Buddies

.org 0x215F394
cmp r0, -8 //Fix CPU Player Minimum Position in Dust Buddies

.org 0x215F3C8
cmp r0, 264 //Fix CPU Player Maximum Position in Dust Buddies

.org 0x215F568
cmp r0, -8 //Fix CPU Player Minimum Position in Dust Buddies

.org 0x215F59C
cmp r0, 264 //Fix CPU Player Maximum Position in Dust Buddies

.org 0x215F71C
cmp r0, -8 //Fix CPU Player Minimum Position in Dust Buddies

.org 0x215F750
cmp r0, 264 //Fix CPU Player Maximum Position in Dust Buddies

.org 0x215FC38
add r2, r4, 40 //Fix X Position of Top Screen Table in Dust Buddies Shake

.org 0x215FC70
add r2, r4, 40 //Fix X Position of Bottom Screen Table in Dust Buddies Shake

.org 0x215FD5C
mov r2, 40 //Left Align Dust Buddies Table BG

.org 0x215FFDC
mov r1, -28 //Fix Alternate X Position of Progress Bar Icons in Dust Buddies

.org 0x215FFE8
mov r1, -28 //Fix Alternate X Position of Progress Bar in Dust Buddies

.org 0x2160004
.float -28 //Fix X Position of Progress Bar in Dust Buddies

.org 0x21600F4
mov r0, 280 //Fix Maximum X Position of Initial Constricted Dust Buddies Movement

.org 0x21601FC
mov r0, 280 //Fix Maximum X Position of Constricted Dust Buddies Movement

.org 0x2160968
sub r0, r2, r3 //Calculate Minimum X Position for Dust Buddies Draw Box
cmp r0, -40 //Fix Minimum X Position for Dust Buddies Object

.org 0x2160974
add r0, r3, 296 //Fix Maximum X Position for Dust Buddies Objects

.org 0x21615D0
mov r0, 84 //Fix Width of Random Position for Object in Dust Buddies

.org 0x21615D8
add r1, r0, 86 //Fix Base X Position of Random Position for Object in Dust Buddies

.org 0x2161624
mov r0, 84 //Fix Width of Random Position for Duel Object in Dust Buddies

.org 0x216162C
add r1, r0, 86 //Fix Base X Position of Random Position for Duel Object in Dust Buddies

.org 0x2161C54
mov r0, 304 //Fix Range of Objects in Dust Buddies

.org 0x2161C5C
sub r0, r0, 24 //Fix Minimum X Position of Objects in Dust Buddies

.org 0x2162600
sub r2, r1, 0x430 //Fix Y/Z Scale of Dust Buddies Vacuum

.org 0x216264C
sub r2, r1, 0x430 //Fix Y/Z Scale of Dust Buddies Vacuum Dust

.org 0x2162DCC
.dw 4301 //Fix Scale of Dust Buddies Vaccum Cleaner

.org 0x216363C
.dw ((((80-128)*336)/256)+128) //Fix X Position of Duel P1 in Dust Buddies

.org 0x2163644
.dw ((((176-128)*336)/256)+128) //Fix X Position of Duel P2 in Dust Buddies

.org 0x2163690
.dw ((((56-128)*336)/256)+128) //Fix X Position of P1 in Dust Buddies

.org 0x2163698
.dw ((((104-128)*336)/256)+128) //Fix X Position of P2 in Dust Buddies

.org 0x21636A0
.dw ((((152-128)*336)/256)+128) //Fix X Position of P3 in Dust Buddies

.org 0x21636A8
.dw ((((201-128)*336)/256)+128) //Fix X Position of P4 in Dust Buddies

.org 0x21638FE
.dh ((((64-128)*336)/256)+128) //Fix X Position of Object 1 in Dust Buddies

.org 0x216390E
.dh ((((192-128)*336)/256)+128) //Fix X Position of Object 3 in Dust Buddies

.org 0x2163916
.dh ((((40-128)*336)/256)+128) //Fix X Position of Object 4 in Dust Buddies

.org 0x216391E
.dh ((((99-128)*336)/256)+128) //Fix X Position of Object 5 in Dust Buddies

.org 0x2163926
.dh ((((157-128)*336)/256)+128) //Fix X Position of Object 6 in Dust Buddies

.org 0x216392E
.dh ((((216-128)*336)/256)+128) //Fix X Position of Object 7 in Dust Buddies

.org 0x216393E
.dh ((((64-128)*336)/256)+128) //Fix X Position of Object 9 in Dust Buddies

.org 0x2163946
.dh ((((192-128)*336)/256)+128) //Fix X Position of Object 10 in Dust Buddies

.org 0x2163956
.dh ((((64-128)*336)/256)+128) //Fix X Position of Object 12 in Dust Buddies

.org 0x216395E
.dh ((((192-128)*336)/256)+128) //Fix X Position of Object 13 in Dust Buddies

.close

.open "overlay/overlay_0027.bin", 0x215BB40 //Cyber Scamper Scene Overlay

.org 0x215C1C0
bl bg_force_width_512_left //Force Top Screen Background Width to 512 in Cyber Scamper

.org 0x215C1EC
bl bg_force_width_512_left //Force Bottom Screen Background Width to 512 in Cyber Scamper

.org 0x215DB30
mov r2, 0 //Fix OOB Animation Index

.org 0x215DB68
mov r1, -30 //Fix X Position of Progress Bar in Cyber Scamper

.org 0x215E8B4
add r1, r1, 0x6C000 //Fix Maximum Player X Position in Cyber Scamper

.org 0x215E91C
sub r1, r1, 0x65000 //Fix Minimum Player X Position in Cyber Scamper

.org 0x2161F48
mov r1, -30 //Fix X Position of Progress Bar Icons in Cyber Scamper

.close

.open "overlay/overlay_0028.bin", 0x215BB40 //Soap Surfers Scene Overlay

.org 0x215CAE4
mov r2, 40 //Fix X Position of Soap Surfers Background

.org 0x215CB04
mov r3, 0 //Fix Y Position of Soap Surfers Background

.org 0x21612AC
.dw 252 //Fix X Position of Soap Surfers Timer

.close

.open "overlay/overlay_0029.bin", 0x215BB40 //Sweet Sleuth Scene Overlay

.org 0x21621A4
.dw 4 //Fix X Position of P1 Duel HUD in Sweet Sleuth

.org 0x21621AC
.dw 256 //Fix X Position of P2 Duel HUD in Sweet Sleuth

.org 0x21621B0
.dw -8 //Fix X Position of P1/P3 HUD in Sweet Sleuth

.org 0x21621B8
.dw 264 //Fix X Position of P2/P4 HUD in Sweet Sleuth

.org 0x21621BC
.dw -16 //Fix X Position of P1/P3 HUD in Sweet Sleuth

.org 0x21621C4
.dw 272 //Fix X Position of P2/P4 HUD in Sweet Sleuth

.org 0x2162218
.dw 0 //Fix BG Width of Bottom Screen in Sweet Sleuth

.close 

.open "overlay/overlay_0030.bin", 0x215BB40 //Tidal Fools Scene Overlay

.org 0x215E1A4
mov r0, 0x81000 //Fix Zoom of Ending in Tidal Fools

.org 0x215E358
mov r6, 0x4F000 //Fix Player Left Side Range in Tidal Fools

.org 0x215E360
add r5, r6, 0x17000

.org 0x215E370
sub r0, r6, 0x11000

.org 0x215E438
cmp r0, 0x4F000 //Fix Player Right Side Range in Tidal Fools
movgt r0, 0x4F000 //Clamp Player Right Side Range in Tidal Fools

.org 0x2160F04
mov r2, (42*24*2) //Fix Shore Clear Size

.org 0x2160F14
add r0, r0, 36 //Fix Base Offset for Shore Clear
add r0, r0, 0x1780 //Fix Main Offset for Shore Clear

.org 0x21611EC
mov r2, (42*24*2) //Fix Shore Copy Size

.org 0x2161208
add r0, r3, 36 //Fix Base Offset for Shore Copy
add r0, r0, 0x1780 //Fix Main Offset for Shore Copy

.org 0x21615F8
mov r0, 128 //Range for Random Objects
bl 0x2020C74 //Call frandmod
mov r0, r0, lsl 0Ch //Scale Range for Random Objects
b 0x2161620 //Skip Over Useless Code

.org 0x2161620
sub r1, r0, 0x45000 //Minimum X Position for Random Objects

.org 0x21622D4
orr r0, r0, (42*144*2) //Fix Size of Tidal Fools Map

.org 0x21622DC
orr r0, r0, 0x2A0000 //Fix Width of Tidal Fools Map

.org 0x2162338
mov r2, (42*24*2) //Fix Copy Size of Tidal Fools Water

.org 0x2162354
mov r2, (42*24*2) //Fix Copy Size of Tidal Fools Second Water

.org 0x2162360
add r0, r0, (42*24*2) //Fix Offset of Tidal Fools Second Water

.org 0x2162374
mov r2, (42*24*2) //Fix Copy Size of Tidal Fools Third Water

.org 0x2162380
add r0, r0, (42*48*2) //Fix Offset of Tidal Fools Third Water

.org 0x2162398
orr r0, r0, 0x7E0 //Fix Size of Tidal Fools Map

.org 0x21623A0
orr r0, r0, 0x2A0000 //Fix Width of Tidal Fools Map

.org 0x21623C8
mov r11, (42*24*2) //Fix Copy Size of Tidal Fools Temporary Map

.org 0x21624C8
mov r2, (42*24*2) //Fix Copy Size of Tidal Fools Shore

.org 0x21624E0
add r0, r0, 36 //Fix Base Offset for Shore
add r0, r0, 0x1780 //Fix Main Offset for Shore

.org 0x2162564
mov r3, 336 //Fix BG Width of Tidal Fools

.org 0x2162570
mov r3, 336 //Fix Initial Scroll of Tidal Fools

.org 0x2162584
.dw (42*144*2)+4 //Fix Allocation Size for Tidal Fools Map

.org 0x216258C
.dw (42*24*2)+4 //Fix Allocation Size for Tidal Fools Map Copy

.org 0x216276C
mov r4, 1 //Force Wrap Tidal Fools Layers

.org 0x2162938
mov r2, 40 //Left-Align Tidal Fools Layers

.org 0x2162E38
.dh -16, 59, 179, 254 //Fix X Position of HUD in Tidal Fools

.org 0x2162E82
.db 1 //Force Tide Layer Width to 512

.org 0x2162E96
.db 1 //Force Sand Layer Width to 512

.org 0x2162EA0
.db 1 //Force Sky Layer Width to 512

.org 0x2162EA2
.db 0x15 //Move Sky Layer Address

.close

.open "overlay/overlay_0031.bin", 0x215BB40 //Raft Riot Scene Overlay

.org 0x215BD2C
bl bg_force_wrap //Force Raft Riot Top Screen Background to Wrap

.org 0x215E790
mov r3, -30 //Fix X Position of Raft Riot Progress Bar

.org 0x2162FA4
mov r1, -30 //Fix X Position of Raft Riot Progress Icons

.org 0x2164260
.dw 4 //Fix X Position of P1 Score in Raft Riot

.org 0x2164268
.dw 252 //Fix X Position of P2 Score in Raft Riot

.org 0x2164270
.dw 4 //Fix X Position of P3 Score in Raft Riot

.org 0x2164278
.dw 252 //Fix X Position of P4 Score in Raft Riot

.close

.open "overlay/overlay_0032.bin", 0x215BB40 //All Geared Up Scene Overlay

.org 0x215EB30
mov r0, 6h //Fix Main BG Address in All Geared Up

.org 0x215EB48
bl bg_force_width_512_left //Extend Main BG in All Geared Up

.org 0x2160284
mov r0, 0x4B0000 //Fix Camera Z Position in All Geared Up

.close

.open "overlay/overlay_0033.bin", 0x215BB40 //Power Washer Scene Overlay

.org 0x215F408
mov r1, 280 //Fix X Position of Power Washer Timer Single Digit

.org 0x215F430
mov r1, 280 //Fix X Position of Power Washer Timer Digit 2

.org 0x216038C
mov r0, 14 //Move BG Address for Power Washer

.org 0x21603A4
bl bg_force_width_512_left //Extend Top Screen BG for Power Washer

.org 0x2160754
mov r8, 264 //Fix X Position of Power Washer Timer Digits

.org 0x2160904
mov r1, 252 //Fix X Position of Power Washer Timer Box

.close

.open "overlay/overlay_0034.bin", 0x215BB40 //Peek-a-Boo Scene Overlay

.org 0x215BF30
mov r2, 1Ch //Move Peek-a-Boo Inside BG Address

.org 0x215BF48
bl bg_force_width_512_left //Extend Peek-a-Boo Inside BG

.org 0x215BF78
bl bg_force_width_512_left //Extend Peek-a-Boo Outside BG

.close

.open "overlay/overlay_0035.bin", 0x215BB40 //Fast Food Frenzy Scene Overlay

.org 0x215E348
mov r3, -36 //Load X Position of Timer in Fast Food Frenzy
str r8, [r13] //Store 4 for Y Position of Timer in Fast Food Frenzy

.org 0x2160D40
sub r1, r8, 0x5C000 //Fix Minimum X Position of Objects in Fast Food Frenzy

.org 0x2160D50
cmp r2, 0x5C000 //Fix Maximum X Position of Objects in Fast Food Frenzy

.org 0x2162510
cmp r0, 0x56000 //Fix End X Position of Conveyor in Fast Food Frenzy

.close

.open "overlay/overlay_0036.bin", 0x215BB40 //Track Star Scene Overlay

.org 0x215C640
mov r1, 272 //Fix X Position of Track Star Timer Digit

.org 0x215EE14
mov r0, 0Dh //Move Top Screen Background Address of Track Star

.org 0x215EE2C
bl bg_force_width_512_left //Expand Top Screen Background Address of Track Star

.org 0x215FBD8
mov r1, 252 //Fix X Position of Track Star Timer

.close

.open "overlay/overlay_0037.bin", 0x215BB40 //Shuffleboard Showdown Scene Overlay

.org 0x215D220
mov r0, 0x38800 //Fix Minimum X Position in Shuffleboard Showdown

.org 0x215D240
cmp r0, 0x38800 //Check Maximum X Position in Shuffleboard Showdown

.org 0x215D248
mov r0, 0x38800 //Clamp Maximum X Position in Shuffleboard Showdown

.org 0x215DB34
mov r2, 0x1E //Move Top Screen Chip Address in Shuffleboard Showdown

.org 0x215DB48
bl bg_force_width_512_left //Extend Top Screen Chip Background in Shuffleboard Showdown

.org 0x215DB60
mov r2, 0x1C //Move Top Screen Background Address in Shuffleboard Showdown

.org 0x215DB74
bl bg_force_width_512_left //Extend Top Screen Background in Shuffleboard Showdown

.org 0x215DBA0
mov r0, 0x16 //Move Bottom Screen Chip Address in Shuffleboard Showdown

.org 0x215DBB8
bl bg_force_width_512_left //Extend Bottom Screen Chip Background in Shuffleboard Showdown

.org 0x215DBDC
mov r0, 0x14 //Move Bottom Screen Background Address in Shuffleboard Showdown

.org 0x215DBF4
bl bg_force_width_512_left //Extend Bottom Screen Background in Shuffleboard Showdown

.org 0x215E164
nop //Disable BG1 Main Scroll Move in Shuffleboard Showdown

.org 0x215E16C
nop //Disable BG2 Main Scroll Move in Shuffleboard Showdown

.org 0x215E17C
nop //Disable BG0 Sub Scroll Move in Shuffleboard Showdown
nop //Disable BG1 Sub Scroll Move in Shuffleboard Showdown

.org 0x215FF68
cmp r0, 256 //Fix Maximum X Position of Chips in Shuffleboard Showdown

.org 0x215FFCC
cmp r0, 0 //Fix Minimum X Position of Chips in Shuffleboard Showdown

.org 0x21609F0
cmp r4, 296 //Check for Maximum Touch X Position
mov r5, r0 //Copy Y Touch Position
movge r4, 0 //Nullify X Touch Position
movge r5, r4 //Nullify Y Touch Position

.close

.open "overlay/overlay_0038.bin", 0x215BB40 //Flash and Dash Scene Overlay

.org 0x215C494
bl bg_force_wrap //Force Screen Filter to Wrap in Flash and Dash

.org 0x215C4A8
mov r0, 0Eh //Move Top Screen BG Address in Flash and Dash

.org 0x215C4C0
bl bg_force_width_512_left //Extend Top Screen BG in Flash and Dash

.close

.open "overlay/overlay_0039.bin", 0x215BB40 //Rubber Ducky Rodeo Scene Overlay

.org 0x215D6E0
mov r2, 0x70000 //Extend Sprite Minimum Coordinate

.org 0x215D6E8
sub r2, r8, 0x70000 //Extend Sprite Left Side Range

.org 0x215D6F8
//Extend Sprite Right Side Range
add r11, r2, 0x70000 //Extend Sprite Right End Box Range
sub r2, r2, 0x70000 //Extend Sprite Left End Box Range

.org 0x215D79C
cmple r4, 0x470000 //Distend Maximum Sprite Coordinate

.org 0x21600FC
b fix_rubber_ducky_skew //Fix Skew Center of Water Plane in Rubber Ducky Rodeo

.close

.open "overlay/overlay_0040.bin", 0x215BB40 //Plush Crush Scene Overlay

.org 0x215F3FC
mov r0, 0Dh //Move Bottom Screen BG Address in Plush Crush

.org 0x215F414
bl bg_force_width_512_left //Extend Plush Crush BG

.close

.open "overlay/overlay_0041.bin", 0x215BB40 //Rotisserie Rampage Scene Overlay

.org 0x215C088
mov r1, -16 //Fix X Position of Single Timer Digit in Rotisserie Rampage

.org 0x215CCA8
bl bg_force_wrap //Force Grass Layer to Wrap in Rotisserie Rampage

.org 0x215CCE4
bl bg_force_wrap //Force Sky Layer to Wrap in Rotisserie Rampage

.org 0x215D4E0
mov r8, -24 //Fix Timer Digit X Position in Rotisserie Rampage

.org 0x215D67C
mov r1, -36 //Fix Timer X Position in Rotisserie Rampage

.org 0x215E410
bl spr_set_pos_scaled //Set Scaled Position of Sprite

.close

.open "overlay/overlay_0042.bin", 0x215BB40 //Nothing to Luge Scene Overlay

.org 0x215C2C8
bl bg_force_wrap //Force Nothing to Luge BG to Wrap

.org 0x215C2DC
mov r0, 6h //Move Top Screen BG Address in Nothing to Luge

.org 0x215C2F4
bl bg_force_width_512_left //Extend Top Screen BG in Nothing to Luge

.close

.open "overlay/overlay_0043.bin", 0x215BB40 //Penny Pinchers Scene Overlay

.org 0x215E63C
cmp r4, 280 //Fix Maximum Grab X Position in Penny Pinchers

.org 0x215E64C
cmp r4, -24 //Fix Minimum Grab X Position in Penny Pinchers

.org 0x2160E98
cmp r0, 280 //Fix Maximum X Position of Coins in Penny Pincher
 
.org 0x2160EA0
mov r0, 280 //Fix Maximum X Position of Coins in Penny Pincher

.org 0x2160EAC
mov r0, -1 //Fix Constant for Speed Flip in Penny Pinchers

.org 0x2160F24
cmp r0, -24 //Fix Minimum X Position of Coins in Penny Pincher
 
.org 0x2160F2C
mov r0, -24 //Fix Minimum X Position of Coins in Penny Pincher

.org 0x2160F38
mov r0, -1 //Fix Constant for Speed Flip in Penny Pinchers

.org 0x21634B4
mov r2, 40 //Left-Align Bottom Screen BG in Penny Pinchers

.org 0x2163C3A
.db 1 //Force Bottom Screen BG Width to 512 in Penny Pinchers

.org 0x2163C3C
.db 6 //Change Bottom Screen BG Address in Penny Pinchers

.close

.open "overlay/overlay_0044.bin", 0x215BB40 //Gusty Blizzard Scene Overlay

.org 0x215CBD0
mov r2, 2h //Load Address for Gusty Blizzard Mic Background
str r2, [r13, 0Ch] //Set Address for Gusty Blizzard Mic Background

.org 0x215CBDC
mov r0, 1 //Load Screen for Gusty Blizzard Mic Background

.org 0x215CC14
mov r3, 0x1800 //Fix VRAM Allocation Size for Gusty Blizzard Mic Background

.org 0x215CC28
mov r0, 0xC0 //Fix Tile Base for Gusty Blizzard Mic Background

.org 0x215CC9C
mov r3, 0x2000 //Fix VRAM Allocation Size for Gusty Blizzard Mic Background

.org 0x215CCB0
mov r3, 0x100 //Fix Tile Base for Gusty Blizzard Background

.org 0x215CC6C
bl bg_force_width_512_left //Extend Gusty Blizzard Bottom Screen Background

.org 0x215E77C
b 0x215E794 //Skip Hiding Gusty Blizzard 3D Model

.close

.open "overlay/overlay_0045.bin", 0x215BB40 //Soil Toil Scene Overlay

.org 0x215D9C0
bl bg_force_wrap //Force Soil Toil Background Color to Wrap

.org 0x215D9D4
mov r0, 0x0D //Move Soil Toil Bottom Screen Background Address

.org 0x215D9EC
bl bg_force_width_512_left //Extend Soil Toil Bottom Screen Background

.org 0x215EDFC
mov r9, -24 //Fix Left Icon X Position in Soil Toil

.org 0x215EEBC
add r9, r9, 304 //Fix Right Icon Offset in Soil Toil

.close

.open "overlay/overlay_0046.bin", 0x215BB40 //Double Vision Scene Overlay

.org 0x21641C4
b double_vision_force_bg_wrap //Force Wood Background Wrapping in Double Vision

.close

.open "overlay/overlay_0047.bin", 0x215BB40 //Memory Mash Scene Overlay

.org 0x215BDA4
bl bg_force_width_512_left //Extend Memory Mash Top Screen BG

.close

.open "overlay/overlay_0048.bin", 0x215BB40 //Cube Crushers Scene Overlay

.org 0x215BFAC
mov r0, 05h //Change Cube Crushers BG Address

.org 0x215BFC4
bl bg_force_width_512_left //Extend Cube Crushers BG Address

.close

.open "overlay/overlay_0049.bin", 0x215BB40 //Mole Thrill Scene Overlay

.org 0x215C280
bl bg_force_wrap //Force Rock Passage to Wrap in Mole Thrill

.org 0x215C2B0
bl bg_force_wrap //Force Dirt to Wrap in Mole Thrill

.org 0x215C338
mov r0, 6h //Move Main Top Screen BG Address in Mole Thrill

.org 0x215C350
bl bg_force_width_512_left //Extend Main Top Screen BG in Mole Thrill

.close

.open "overlay/overlay_0050.bin", 0x215BB40 //Sprinkler Scalers Scene Overlay

.org 0x215C108
mov r0, 0Eh //Move BG Address in Sprinkler Scalera

.org 0x215C120
bl bg_force_width_512_left //Extend BG in Sprinkler Scalers

.close

.open "overlay/overlay_0051.bin", 0x215BB40 //Cucumberjacks Scene Overlay

.org 0x215C234
bl bg_force_width_512_left //Extend Bottom Screen BG in Cucumberjacks

.org 0x215C260
bl bg_force_width_512_left //Extend Bottom Screen BG in Cucumberjacks

.org 0x215C2C4
mov r2, 288 //Fix Initial X Scrolling of Cucumberjacks Slicer

.org 0x215C2D8
mov r2, 288 //Fix Initial X Scrolling of Cucumberjacks Left Side

.org 0x215C2EC
mov r2, 288 //Fix Initial X Scrolling of Cucumberjacks Right Side

.org 0x215C85C
mov r3, 32 //Fix Chopper X Position in Cucumberjacks

.org 0x215D98C
rsb r0, r4, 120h //Fix Offset for Cucumberjacks Bottom Screen

.org 0x215DA18
ldrsh r1, [r10] //Fix Signedness of Current Touch Position
ldrsh r0, [r0] //Fix Signedness of Last Touch Position

.org 0x215DA68
cmp r0, -0x1E0001 //Compare Minimum X Position for Backing Slicer

.org 0x215DAD8
cmp r0, 0xEE0000 //Compare Maximum X Position for Backing Slicer

.org 0x215DC54
cmp r1, -0x280001 //Compare Minimum X Position for Cucumberjacks Bar
movle r1, -0x280001 //Set Minimum X Position for Cucumberjacks Bar

.org 0x215DC70
cmp r0, 0xF80000 //Compare Maximum X Position for Cucumberjacks Bar
movge r0, 0xF80000 //Set Maximum X Position for Cucumberjacks Bar

.org 0x215DFA8
cmp r0, -0x1E0001 //Compare Minimum X Position for CPU Backing Slicer

.org 0x215DFB0
cmp r0, 0xEE0000 //Compare Maximum X Position for CPU Backing Slicer

.org 0x215E05C
ldrsh r0, [r1, r9] //Fix Sign of Touch Position in Cucumberjacks

.org 0x215E064
cmp r0, -24 //Fix Minimum Touch Position in Cucumberjacks
blt 0x215E088
cmp r0, 280 //Fix Maximum Touch Position in Cucumberjacks
bge 0x215E088

.org 0x215EF96
.dh -24 //Fix Upper-Left Touch Icon X Position in Cucumberjacks

.org 0x215EF9C
.dh 280 //Fix Upper-Right Touch Icon X Position in Cucumberjacks

.org 0x215EFA2
.dh 280 //Fix Lower-Right Touch Icon X Position in Cucumberjacks

.org 0x215EFA8
.dh -24 //Fix Lower-Left Touch Icon X Position in Cucumberjacks

.org 0x215EFCC
.dh -24 //Fix Upper-Left Touch Icon X Position in Cucumberjacks

.org 0x215EFD4
.dh 280 //Fix Upper-Right Touch Icon X Position in Cucumberjacks

.org 0x215EFDC
.dh 280 //Fix Lower-Right Touch Icon X Position in Cucumberjacks

.org 0x215EFE4
.dh -24 //Fix Lower-Left Touch Icon X Position in Cucumberjacks

.close

.open "overlay/overlay_0052.bin", 0x215BB40 //Hanger Management Scene Overlay

.org 0x215F6E0
mov r0, 06h //Move BG Address in Hanger Management

.org 0x215F6F8
bl bg_force_width_512_left //Extend BG in Hanger Management

.org 0x21620F4
.dw -28 //Fix X Position of P1 Icon in Hanger Management

.org 0x21620FC
.dw 284 //Fix X Position of P2 Icon in Hanger Management

.org 0x2162104
.dw -28 //Fix X Position of P3 Icon in Hanger Management

.org 0x216210C
.dw 284 //Fix X Position of P4 Icon in Hanger Management

.org 0x2162114
.dw 8 //Fix X Position of P1 Timer in Hanger Management

.org 0x216211C
.dw 240 //Fix X Position of P2 Timer in Hanger Management

.org 0x2162124
.dw 8 //Fix X Position of P3 Timer in Hanger Management

.org 0x216212C
.dw 240 //Fix X Position of P4 Timer in Hanger Management

.org 0x2162134
.dw 4 //Fix X Position of P1 Box in Hanger Management

.org 0x216213C
.dw 252 //Fix X Position of P2 Box in Hanger Management

.org 0x2162144
.dw 4 //Fix X Position of P3 Box in Hanger Management

.org 0x216214C
.dw 252 //Fix X Position of P4 Box in Hanger Management

.close

.open "overlay/overlay_0053.bin", 0x215BB40 //Book It Scene Overlay

.org 0x215C1A4
mov r0, 0Eh //Move BG Address in Book It

.org 0x215C1BC
bl bg_force_width_512_left //Extend BG in Book It

.org 0x215D5E0
mov r1, -24 //Fix X Position of Initial Player Icon in Book It

.org 0x215D708
mov r1, -4 //Fix X Position of Buttons in Book It

.org 0x215F1FC
mov r1, -24 //Fix X Position of Left Player Icon in Book It

.org 0x215F210
mov r1, 16 //Fix X Position of Right Player Icon in Book It

.close

.open "overlay/overlay_0054.bin", 0x215BB40 //Airbrushers Scene Overlay

.org 0x215D188
b fix_airbrushers_bg_coin_culling //Fix Other Team Coin Culling in Airbrushers

.org 0x215DF9C
b fix_airbrushers_culling //Fix Object Culling in Airbrushers

.org 0x215E164
mov r1, 0xFA000 //Fix Culling Width of Launchpad 1 in Airbrushers

.org 0x215E190
mov r1, 0xFA000 //Fix Culling Width of Launchpad 2 in Airbrushers

.org 0x215E1C0
mov r1, 0x13C000 //Fix Culling Width of Object in Airbrushers

.org 0x215E1F8
sub r2, r2, 0xE5000 //Fix Offset of Floor Pieces in Airbrushers
mov r1, 5 //Number of Floor Pieces in Airbrushers

.org 0x215E220
sub r2, r1, 0xE5000 //Fix Offset of Wall Pieces in Airbrushers

.org 0x215E230
mov r1, 5 //Number of Wall Pieces in Airbrushers

.close

.open "overlay/overlay_0055.bin", 0x215BB40 //Toppling Terror Scene Overlay

.org 0x215C7D4
mov r2, 40 //Move Whomp BG Left in Toppling Terror

.org 0x2160D9C
mov r0, 14h //Move Sky BG Address in Toppling Terror

.org 0x2160DB4
bl bg_force_width_512_left //Extend Sky BG in Toppling Terror

.org 0x2160DC8
mov r1, 3h //Extend Whomp BG in Toppling Terror

.org 0x2160F4C
b 0x20073D8 //Replace func_2160F4C

.close

.open "overlay/overlay_0056.bin", 0x215BB40 //Crazy Crosshairs Scene Overlay

.org 0x215D488
mov r2, 40 //Fix X Position of Background in Crazy Crosshairs

.org 0x215D4A8
mov r3, 0 //Fix Y Position of Background in Crazy Crosshairs

.org 0x21612D8
add r0, r7, r1 //Calculate Minimum X Position for Crazy Crosshairs Sprites
cmp r0, -40 //Fix Minimum X Position for Crazy Crosshairs Sprites

.org 0x21612E4
add r0, r1, 296 //Fix Maximum X Position for Crazy Crosshairs Sprites

.org 0x2162730
mov r5, 276 //Fix X Position of Right Player Icon in Crazy Crosshairs
mov r7, -20 //Fix X Position of Left Player Icon in Crazy Crosshairs

.org 0x21638A8
.dw 168*4096 //Fix Center X Position

.org 0x2163A04
.dw 4 //Fix X Position of P1 Icon in Crazy Crosshairs

.org 0x2163A0C
.dw 256 //Fix X Position of P2 Icon in Crazy Crosshairs

.org 0x2163A10
.dw -8 //Fix X Position of P1 Icon in Crazy Crosshairs

.org 0x2163A18
.dw 264 //Fix X Position of P2 Icon in Crazy Crosshairs

.org 0x2163A1C
.dw -16 //Fix X Position of P1 Icon in Crazy Crosshairs

.org 0x2163A24
.dw 272 //Fix X Position of P2 Icon in Crazy Crosshairs

.org 0x2163D44
.dw 1 //Force BG Width to 512 in Crazy Crosshairs

.close

.open "overlay/overlay_0057.bin", 0x215BB40 //Shorty Scorers Scene Overlay

.org 0x215F864
mov r2, 40 //Fix X Position of Background in Shorty Scorers

.org 0x215F884
mov r3, 0 //Fix Y Position of Background in Shorty Scorers

.org 0x2162604
mov r0, 0x33000 //Fix Minimum Camera X Position in Shorty Scorers

.org 0x2162620
cmp r0, 0x33000 //Fix Maximum Camera X Position in Shorty Scorers
mov r0, 0x33000 //Set Maximum Camera X Position in Shorty Scorers

.org 0x2168694
.dw 4 //Fix X Position of P1 HUD in Shorty Scorers

.org 0x216869C
.dw 256 //Fix X Position of P2 HUD in Shorty Scorers

.org 0x21686A0
.dw -8 //Fix X Position of P1 HUD in Shorty Scorers

.org 0x21686A8
.dw 264 //Fix X Position of P2 HUD in Shorty Scorers

.org 0x21686AC
.dw -16 //Fix X Position of P1 HUD in Shorty Scorers

.org 0x21686B4
.dw 272 //Fix X Position of P2 HUD in Shorty Scorers

.org 0x21687D4
.dw 0x33000 //Fix X Position of Camera in Intro in Shorty Scorers

.close

.open "overlay/overlay_0058.bin", 0x215BB40 //Cheep Chump Scene Overlay

.org 0x215F764
mov r0, 0Eh //Move BG Address in Cheep Chump

.org 0x215F778
bl bg_force_width_512_left //Extend BG in Cheep Chump

.org 0x2161E1C
.dh 13 //Fix Zoom in Cheep Chump

.org 0x2161E40
.dh 31 //Fix Zoom in Cheep Chump Ending

.close

.open "overlay/overlay_0060.bin", 0x215BB40 //Short Fuse Scene Overlay

.org 0x2162E28
b fix_short_fuse_bg //Fix X Position of Short Fuse BG

.org 0x21632CA
.db 1 //Fix Width of Short Fuse BG

.close

.open "overlay/overlay_0061.bin", 0x215BB40 //Globe Gunners Scene Overlay

.org 0x215F798
mov r0, 06h //Fix BG Address in Globe Gunners

.org 0x215F7B0
bl bg_force_width_512_left //Extend BG in Globe Gunners

.org 0x2160C78
mov r1, 12 //Fix X Position of P1 HUD Box in Globe Gunners

.org 0x2160CA4
mov r1, 244 //Fix X Position of P2 HUD Box in Globe Gunners

.org 0x2160CD0
mov r1, 12 //Fix X Position of P1 HUD Box in Globe Gunners

.org 0x2160CF8
mov r1, 244 //Fix X Position of P2 HUD Box in Globe Gunners

.org 0x2162A1C
.dw -4 //Fix X Position of P1 HUD in Globe Gunners

.org 0x2162A24
.dw 260 //Fix X Position of P2 HUD in Globe Gunners

.org 0x2162A2C
.dw -4 //Fix X Position of P3 HUD in Globe Gunners

.org 0x2162A34
.dw 260 //Fix X Position of P4 HUD in Globe Gunners

.close

.open "overlay/overlay_0062.bin", 0x215BB40 //Chips and Dips Scene Overlay

.org 0x215CA50
mov r2, 40 //Fix X Position of Chips and Dips Background

.org 0x215CA70
mov r3, 0 //Fix Y Position of Chips and Dips Background

.org 0x21641E0
.dw 1 //Fix BG Width in Chips and Dips

.close

.open "overlay/overlay_0063.bin", 0x215BB40 //Feed and Seed Scene Overlay

.org 0x215C10C
mov r2, 1Dh //Move Main BG Address in Feed and Seed

.org 0x215C120
bl bg_force_width_512_left //Extend Main BG in Feed and Seed

.org 0x215C150
mov r0, 0Eh //Move Leaves BG Address in Feed and Seed

.org 0x215C168
bl bg_force_width_512_left //Extend Leaves BG in Feed and Seed

.org 0x215C18C
mov r0, 0Ch //Move Sub BG Address in Feed and Seed

.org 0x215C1A4
bl bg_force_width_512_left //Extend Sub BG in Feed and Seed

.org 0x215C2D0
mov r0, 0x5000 //Fix BG Tiles Address for Practice in Feed and Seed

.org 0x215C2E8
mov r2, 10h //Fix BG Map Address for Practice in Feed and Seed

.org 0x215C83C
nop //Disable Main BG2 Scroll Reset in Feed and Seed

.org 0x215C854
nop //Disable Sub BG0 Scroll Reset in Feed and Seed
nop //Disable Sub BG1 Scroll Reset in Feed and Seed

.org 0x215CBF0
mov r1, -40 //Fix X Position of Seed 1 in Feed and Seed

.org 0x215CC14
mov r1, -40 //Fix X Position of Seed 2 in Feed and Seed

.org 0x215CC38
mov r1, -40 //Fix X Position of Seed 3 in Feed and Seed

.org 0x215CC54
mov r1, 296 //Fix X Position of Right Seeds in Feed and Seed

.org 0x215FFAC
cmp r4, -24 //Check Maximum X Position of Player in Feed and Seed 

.org 0x215FFDC
cmp r4, 232 //Check Maximum X Position of Player in Feed and Seed 

.org 0x2160000
cmp r4, 24 //Check Minimum X Position of Player in Feed and Seed 
movlt r0, (24*10) //Fix Minimum X Position of Player in Feed and Seed 

.org 0x2160024
cmp r4, 232 //Check Maximum X Position of Player in Feed and Seed 
movgt r0, (232*10) //Fix Maximum X Position of Player in Feed and Seed 

.org 0x216026C
sub r0, r0, 21 //Fix Left Move Speed of Sinking Player in Feed and Seed

.org 0x2160288
add r0, r0, 21 //Fix Right Move Speed of Sinking Player in Feed and Seed

.org 0x21614E0
mov r0, (328*10) //Fix X Position of Right Seeds in Feed and Seed

.org 0x2161BA0
sub r0, r0, 21 //Fix Left Move Speed of Sinking Seeds in Feed and Seed

.org 0x2161BB8
add r0, r0, 21 //Fix Right Move Speed of Sinking Seeds in Feed and Seed

.org 0x21630A8
.dw -12, -12, -12 //Fix X Position of Left Seeds
.dw 268, 268, 268 //Fix X Position of Right Seeds

.close

.open "overlay/overlay_0064.bin", 0x215BB40 //Hammer Chime Scene Overlay

.org 0x215E8D8
mov r1, 276 //Fix X Position of Boss Icon in Hammer Chime

.org 0x215E910
mov r1, -20 //Fix X Position of Player Icon in Hammer Chime

.org 0x215E9C4
mov r7, 276 //Fix X Position of Boss Hearts in Hammer Chime

.org 0x215EA3C
mov r5, -20 //Fix X Position of Player Hearts in Hammer Chime

.org 0x2162E44
mov r1, 06h //Move Light BG Address in Hammer Chime

.org 0x2162E58
bl bg_force_width_512_left //Extend Light BG In Hammer Chime

.org 0x2162E6C
mov r1, 1Dh //Move Main BG Address in Hammer Chime

.org 0x2162E84
bl bg_force_width_512_left //Extend Main BG In Hammer Chime

.org 0x2162E98
mov r2, 1Fh //Move Textbox BG Address in Hammer Chime

.close

.open "overlay/overlay_0065.bin", 0x215BB40 //Hexoskeleton Scene Overlay

.org 0x215BE6C
mov r0, 4h //Move Top Screen Main BG Address in Hexoskeleton

.org 0x215BE84
bl bg_force_width_512_left //Extend Top Screen Main BG in Hexoskeleton

.org 0x215D7A4
mov r7, 276 //Fix X Position of Boss Hearts in Hexoskeleton

.org 0x215D7E4
sub r7, r7, 296 //Fix X Offset of Player Hearts in Hexoskeleton
 
.org 0x215D8BC
mov r1, 276 //Fix X Position of Boss Icon in Hexoskeleton
 
.org 0x215DA88
mov r1, -20 //Fix X Position of Player Icon in Hexoskeleton

.close

.open "overlay/overlay_0066.bin", 0x215BB40 //Book Bash Scene Overlay

.org 0x215E72C
mov r6, -20 //Fix X Position of Player Hearts in Book Bash

.org 0x215E7E8
mov r6, 276 //Fix X Position of Boss Hearts in Book Bash

.org 0x215E8C0
mov r0, -20 //Fix X Position of Player Icon in Book Bash

.org 0x215E950
mov r0, 276 //Fix X Position of Boss Icon in Book Bash

.org 0x216A6F8
mov r2, 40 //Fix X Position of Book Bash Top Screen Background

.org 0x216AB1D
.db 1 //Fix Width of Book Bash Top Scren Background

.org 0x216AB1F
.db 0 //Fix BG Address in Book Bash

.close

.open "overlay/overlay_0067.bin", 0x215BB40 //Bowser's Block Party Scene Overlay

.org 0x215CB74
mov r2, 0Eh //Move BG Address in Bowser's Block Party

.org 0x215CB88
bl bg_force_width_512_left //Extend BG in Bowser's Block Party

.org 0x2167838
mov r6, 276 //Fix X Position of Boss Hearts in Bowser's Block Party

.org 0x21678B0
mov r6, -20 //Fix X Position of Player Hearts in Bowser's Block Party

.org 0x2167988
mov r1, 276 //Fix X Position of Boss Icon in Bowser's Block Party

.org 0x21679C8
mov r1, -20 //Fix X Position of Player Icon in Bowser's Block Party

.close

.open "overlay/overlay_0075.bin", 0x217BB40 //Wiggler's Garden Scene Overlay

.org 0x2180F38
add r1, r1, 56 //Fix X Offset of Shop Costs

.org 0x2181C48
add r1, r0, 0x5000 //Fix Items Offset in Shops

.org 0x2182628
add r1, r1, 44 //Fix X Offset of Cursor in Shops

.org 0x2182F54
mov r2, 40 //Fix X Position of Shop Background

.org 0x2186BF8
mov r2, 32 //Fix X Position of Set Hex Text

.org 0x2188F40
nop //Disable Difficulty Bar Clear in Bowser Time

.org 0x218A6A8
sub r1, r1, 272 //Fix Start Position of Last 5 Turns Move

.org 0x218A6FC
cmp r4, 0x1300 //Fix Duration of Last 5 Turns Move

.org 0x218A7A0
mov r3, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218A7C0
mov r0, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218A874
mov r1, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218A898
mov r2, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x2197B58
.dh 296 //Fix Hit Test X Position of Y Button

.org 0x2197B5C
.dh 296 //Fix Hit Test X Position of X Button

.org 0x2197B68
.dh 28 //X Position of Lamp 1 in Shops

.org 0x2197B6C
.dh 228 //X Position of Lamp 2 in Shops

.org 0x2197DAC
.dh 40 //Fix X Position of Shop Item Coin Box

.org 0x2197DB4
.dh 40 //Fix X Position of Shop Item Coins

.org 0x2197DBC
.dh 56 //Fix X Position of Shop Item Coin Digit 1

.org 0x2197DC4
.dh 64 //Fix X Position of Shop Item Coin Digit 2

.org 0x2197DCC
.dh 296 //Fix X Position of Coin Count Box in Shops

.org 0x2197DD4
.dh 264 //Fix X Position of Coin Count Digit 1 in Shops

.org 0x2197DDC
.dh 274 //Fix X Position of Coin Count Digit 2 in Shops

.org 0x2197DE4
.dh 284 //Fix X Position of Coin Count Digit 3 in Shops

.org 0x2198178
.dh 296 //Fix X Position of Y Button

.org 0x2198180
.dh 296 //Fix X Position of X Button

.org 0x21981CE
.dh -16 //Fix X Position of Left Arrow in Map View

.org 0x21981D6
.dh 272 //Fix X Position of Right Arrow in Map View

.close

.open "overlay/overlay_0076.bin", 0x217BB40 //Toadette's Music Room Scene Overlay

.org 0x2180A38
add r1, r1, 56 //Fix X Offset of Shop Costs

.org 0x2181748
add r1, r0, 0x5000 //Fix Items Offset in Shops

.org 0x2182128
add r1, r1, 44 //Fix X Offset of Cursor in Shops

.org 0x2182A54
mov r2, 40 //Fix X Position of Shop Background

.org 0x21866F8
mov r2, 32 //Fix X Position of Set Hex Text

.org 0x2188A40
nop //Disable Difficulty Bar Clear in Bowser Time

.org 0x218A1A8
sub r1, r1, 272 //Fix Start Position of Last 5 Turns Move

.org 0x218A1FC
cmp r4, 0x1300 //Fix Duration of Last 5 Turns Move

.org 0x218A2A0
mov r3, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218A2C0
mov r0, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218A374
mov r1, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218A398
mov r2, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x21981D2
.dh 296 //Fix Hit Test X Position of Y Button

.org 0x21981D6
.dh 296 //Fix Hit Test X Position of X Button

.org 0x21981E2
.dh 28 //X Position of Lamp 1 in Shops

.org 0x21981E6
.dh 228 //X Position of Lamp 2 in Shops

.org 0x2198488
.dh 40 //Fix X Position of Shop Item Coin Box

.org 0x2198490
.dh 40 //Fix X Position of Shop Item Coins

.org 0x2198498
.dh 56 //Fix X Position of Shop Item Coin Digit 1

.org 0x21984A0
.dh 64 //Fix X Position of Shop Item Coin Digit 2

.org 0x21984A8
.dh 296 //Fix X Position of Coin Count Box in Shops

.org 0x21984B0
.dh 264 //Fix X Position of Coin Count Digit 1 in Shops

.org 0x21984B8
.dh 274 //Fix X Position of Coin Count Digit 2 in Shops

.org 0x21984C0
.dh 284 //Fix X Position of Coin Count Digit 3 in Shops

.org 0x2198850
.dh 296 //Fix X Position of Y Button

.org 0x2198858
.dh 296 //Fix X Position of X Button

.org 0x2198870
.dh -16 //Fix X Position of Left Arrow in Map View

.org 0x2198878
.dh 272 //Fix X Position of Right Arrow in Map View

.close

.open "overlay/overlay_0077.bin", 0x217BB40 //DK's Stone Statue Scene Overlay

.org 0x2180430
add r1, r1, 56 //Fix X Offset of Shop Costs

.org 0x2181140
add r1, r0, 0x5000 //Fix Items Offset in Shops

.org 0x2181B20
add r1, r1, 44 //Fix X Offset of Cursor in Shops

.org 0x218244C
mov r2, 40 //Fix X Position of Shop Background

.org 0x21860F0
mov r2, 32 //Fix X Position of Set Hex Text

.org 0x2188438
nop //Disable Difficulty Bar Clear in Bowser Time

.org 0x2189BA0
sub r1, r1, 272 //Fix Start Position of Last 5 Turns Move

.org 0x2189BF4
cmp r4, 0x1300 //Fix Duration of Last 5 Turns Move

.org 0x2189C98
mov r3, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x2189CB8
mov r0, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x2189D6C
mov r1, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x2189D90
mov r2, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x21983A0
.dh 28 //X Position of Lamp 1 in Shops

.org 0x21983A4
.dh 228 //X Position of Lamp 2 in Shops

.org 0x21983E8
.dh 296 //Fix Hit Test X Position of Y Button

.org 0x21983EC
.dh 296 //Fix Hit Test X Position of X Button

.org 0x219863C
.dh 40 //Fix X Position of Shop Item Coin Box

.org 0x2198644
.dh 40 //Fix X Position of Shop Item Coins

.org 0x219864C
.dh 56 //Fix X Position of Shop Item Coin Digit 1

.org 0x2198654
.dh 64 //Fix X Position of Shop Item Coin Digit 2

.org 0x219865C
.dh 296 //Fix X Position of Coin Count Box in Shops

.org 0x2198664
.dh 264 //Fix X Position of Coin Count Digit 1 in Shops

.org 0x219866C
.dh 274 //Fix X Position of Coin Count Digit 2 in Shops

.org 0x2198674
.dh 284 //Fix X Position of Coin Count Digit 3 in Shops

.org 0x2198A04
.dh 296 //Fix X Position of Y Button

.org 0x2198A0C
.dh 296 //Fix X Position of X Button

.org 0x2198A24
.dh -16 //Fix X Position of Left Arrow in Map View

.org 0x2198A2C
.dh 272 //Fix X Position of Right Arrow in Map View

.close

.open "overlay/overlay_0078.bin", 0x217BB40 //Kamek's Library Scene Overlay

.org 0x217BCF4
b fix_kamek_canvas //Fix Touch Coordinates for Kamek's Library Canvas

.org 0x217CA10
mov r0, r6 //Run Replaced Instruction
mov r2, 0 //Load Y Position of Kamek's Library Canvas
sub r1, r2, 163840 //Load X Position of Kamek's Library Canvas
sub r3, r2, 2048 //Load Z Position of Kamek's Library Canvas

.org 0x217CA28
mov r1, (336*4096) //Fix X Scale of Kamek's Library Canvas

.org 0x2184B0C
add r1, r1, 56 //Fix X Offset of Shop Costs

.org 0x218581C
add r1, r0, 0x5000 //Fix Items Offset in Shops

.org 0x21861FC
add r1, r1, 44 //Fix X Offset of Cursor in Shops

.org 0x2186B28
mov r2, 40 //Fix X Position of Shop Background

.org 0x218A7CC
mov r2, 32 //Fix X Position of Set Hex Text

.org 0x218CB14
nop //Disable Difficulty Bar Clear in Bowser Time

.org 0x218E27C
sub r1, r1, 272 //Fix Start Position of Last 5 Turns Move

.org 0x218E2D0
cmp r4, 0x1300 //Fix Duration of Last 5 Turns Move

.org 0x218E374
mov r3, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218E394
mov r0, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218E448
mov r1, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218E46C
mov r2, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x219B734
.dh 296 //Fix Hit Test X Position of Y Button

.org 0x219B73C
.dh 296 //Fix Hit Test X Position of X Button

.org 0x219B744
.dh 28 //X Position of Lamp 1 in Shops

.org 0x219B748
.dh 228 //X Position of Lamp 2 in Shops

.org 0x219B988
.dh 40 //Fix X Position of Shop Item Coin Box

.org 0x219B990
.dh 40 //Fix X Position of Shop Item Coins

.org 0x219B998
.dh 56 //Fix X Position of Shop Item Coin Digit 1

.org 0x219B9A0
.dh 64 //Fix X Position of Shop Item Coin Digit 2

.org 0x219B9A8
.dh 296 //Fix X Position of Coin Count Box in Shops

.org 0x219B9B0
.dh 264 //Fix X Position of Coin Count Digit 1 in Shops

.org 0x219B9B8
.dh 274 //Fix X Position of Coin Count Digit 2 in Shops

.org 0x219B9C0
.dh 284 //Fix X Position of Coin Count Digit 3 in Shops

.org 0x219BD40
.dh 296 //Fix X Position of Y Button

.org 0x219BD48
.dh 296 //Fix X Position of X Button

.org 0x219BD88
.dh -16 //Fix X Position of Left Arrow in Map View

.org 0x219BD90
.dh 272 //Fix X Position of Right Arrow in Map View

.close

.open "overlay/overlay_0079.bin", 0x217BB40 //Bowser's Pinball Machine Scene Overlay

.org 0x2183654
add r1, r1, 56 //Fix X Offset of Shop Costs

.org 0x2184364
add r1, r0, 0x5000 //Fix Items Offset in Shops

.org 0x2184D44
add r1, r1, 44 //Fix X Offset of Cursor in Shops

.org 0x2185670
mov r2, 40 //Fix X Position of Shop Background

.org 0x2189314
mov r2, 32 //Fix X Position of Set Hex Text

.org 0x218B65C
nop //Disable Difficulty Bar Clear in Bowser Time

.org 0x218CDC4
sub r1, r1, 272 //Fix Start Position of Last 5 Turns Move

.org 0x218CE18
cmp r4, 0x1300 //Fix Duration of Last 5 Turns Move

.org 0x218CEBC
mov r3, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218CEDC
mov r0, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218CF90
mov r1, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x218CFB4
mov r2, r9, lsl 09h //Double Speed of Last 5 Turns Background

.org 0x219A23C
.dh 296 //Fix Hit Test X Position of Y Button

.org 0x219A240
.dh 296 //Fix Hit Test X Position of X Button

.org 0x219A24C
.dh 28 //X Position of Lamp 1 in Shops

.org 0x219A250
.dh 228 //X Position of Lamp 2 in Shops

.org 0x219A490
.dh 40 //Fix X Position of Shop Item Coin Box

.org 0x219A498
.dh 40 //Fix X Position of Shop Item Coins

.org 0x219A4A0
.dh 56 //Fix X Position of Shop Item Coin Digit 1

.org 0x219A4A8
.dh 64 //Fix X Position of Shop Item Coin Digit 2

.org 0x219A4B0
.dh 296 //Fix X Position of Coin Count Box in Shops

.org 0x219A4B8
.dh 264 //Fix X Position of Coin Count Digit 1 in Shops

.org 0x219A4C0
.dh 274 //Fix X Position of Coin Count Digit 2 in Shops

.org 0x219A4C8
.dh 284 //Fix X Position of Coin Count Digit 3 in Shops

.org 0x219A824
.dh 296 //Fix X Position of Y Button

.org 0x219A82C
.dh 296 //Fix X Position of X Button

.org 0x219A880
.dh -16 //Fix X Position of Left Arrow in Map View

.org 0x219A888
.dh 272 //Fix X Position of Right Arrow in Map View

.close

.open "overlay/overlay_0080.bin", 0x217BB40 //Pen Pals Scene Overlay

.org 0x217EDF0
bl bg_force_width_512_left //Extend Top Screen BG in Pen Pals

.org 0x217F2D0
mov r2, 08h //Move BG Address for Pen Pals Logo

.org 0x217F310
bl bg_force_width_512_left //Extend BG for Pen Pals Intro Background

.org 0x217F31C
bl fix_extra_logo_scroll //Fix Scroll of Pen Pals Logo in Intro

.org 0x21822E8
mov r9, -16 //Fix Base X Position of Left Digit for Dice Roll in Pen Pals

.org 0x21822F0
mov r6, 44 //Fix Base X Position of Middle Digit for Dice Roll in Pen Pals

.org 0x21823D8
add r9, r9, 168 //Fix Offset of Player 2 Left Digit for Dice Roll in Pen Pals
add r5, r5, 168  //Fix Offset of Player 2 Right Digit for Dice Roll in Pen Pals
add r6, r6, 168 //Fix Offset of Player 2 Middle Digit for Dice Roll in Pen Pals

.org 0x21827EC
mov r0, 44 //Fix Target X Position for P1 Dice Digits in Pen Pals

.org 0x21827F8
mov r0, 60 //Fix Target X Position for P1 Right Dice Digits in Pen Pals

.org 0x2182DB4
add r0, r0, 168 //Fix Offset of P2 Left Dice Digits in Pen Pals

.org 0x2182DC4
add r0, r0, 168 //Fix Offset of P2 Right Dice Digits in Pen Pals

.org 0x21836E0
mov r2, -8 //Fix X Position of Back Button in Pen Pals

.org 0x2186F48
mov r2, 5 //Change Congratulations BG Address

.org 0x2186F5C
bl bg_force_width_512_left //Force Congratulations Background Width to 512

.org 0x21876D8
mov r2, 384 //Fix X Scale of Pen Pals Bar

.org 0x2187E38
mov r2, -8 //Fix X Position of Move End Back Button in Pen Pals

.org 0x2187E4C
mov r2, 264 //Fix X Position of Move End OK Button in Pen Pals

.org 0x21882B8
.dh 44, 212 //Fix X Position of Movement Dice Digits

.close

.open "overlay/overlay_0081.bin", 0x217BB40 //Desert Duel Scene Overlay

.org 0x217C514
mov r1, (336*4096) //Fix X Scale of Desert Duel Filter

.org 0x217C530
mov r1, -((40*4096)+1) //Fix X Position of Desert Duel Filter

.org 0x217C540
mov r2, 0 //Fix Y Position of Desert Duel Filter
sub r3, r2, 0x1000 //Fix Z Position of Desert Duel Filter

.org 0x217C9C8
mov r0, 0Bh //Change Desert Duel Map VRAM Address

.org 0x217C9E0
bl bg_force_width_512_left //Force Desert Duel Intro Map Width to 512

.org 0x217C9EC
bl fix_extra_logo_scroll //Fix Scroll of Desert Duel Logo in Intro

.org 0x2181148
mov r2, -8 //Fix X Position of Desert Duel Move Back Button

.org 0x2183DB4
bl bg_force_width_512_left //Force Top Screen Desert Duel Map to 512 Width

.org 0x2184008
moveq r1, -20 //Load P1 Icon X Position in Desert Duel
movne r1, 276 //Load P2 Icon X Position in Desert Duel

.org 0x2184104
mov r5, 264 //Load P1 Base HUD X Position in Desert Duel
mov r6, -7 //Load P2 Base HUD X Position in Desert Duel

.org 0x2184500
moveq r0, -25 //Load P1 Base HUD X Position in Desert Duel
movne r0, 248 //Load P2 Base HUD X Position in Desert Duel

.org 0x21845E4
moveq r0, -8 //Load P1 Counter X Position in Desert Duel
movne r0, 240 //Load P2 Counter X Position in Desert Duel

.org 0x2185D9C
str r2, [r13, 10h] //Fix Tile Base for Desert Duel Congratulations Text

.org 0x2185DEC
mov r3, 0x3800 //Fix Load Offset for Desert Duel Congratulations Text

.org 0x2185E08
mov r0, 0xE0 //Fix Clear Value for Desert Duel Congratulations Text

.org 0x2185E1C
mov r0, 0xE0 //Fix Tile Base for Desert Duel Congratulations Text

.org 0x2185EB8
mov r2, 5 //Change Congratulations BG Address

.org 0x2185ECC
bl bg_force_width_512_left //Force Congratulations Background Width to 512

.org 0x2186648
mov r2, 384 //Fix Expanding Bar in Desert Duel

.org 0x2186EEC
mov r2, -8 //Fix X Position of Desert Duel Back Button

.org 0x2186F00
mov r2, 264 //Fix X Position of Desert Duel OK Button

.close

.open "overlay/overlay_0082.bin", 0x217BB40 //Rocket Rascals Scene Overlay

.org 0x217CA78
mov r0, 4 //Move Rocket Rascals BG Address

.org 0x217CA90
bl bg_force_width_512_left //Extend Top Screen Rocket Rascals BG

.org 0x217F374
b 0x217F3A4 //Skip Create of Current Player Bar

.org 0x217F76C
b 0x217F794 //Skip Create of Current COM Bar

.org 0x2184DA0
bx lr  //Skip Delete of Player Bar

.close

.open "overlay/overlay_0083.bin", 0x217BB40 //Logos Scene Overlay

.org 0x217BC0C
bl bg_force_width_512_left //Force Center Top Screen Background

.org 0x217BC38
bl bg_force_width_512_left //Force Center Bottom Screen Background

.close

.open "overlay/overlay_0085.bin", 0x217BB40 //File Select Scene Overlay

.org 0x217C214
bl bg_force_wrap //Enable Wrapping for File Select Background

.org 0x217CDD4
moveq r7, -297 //Fix Start X Position of File Icons

.org 0x217DB00
bl bg_force_wrap //Enable Wrapping for File Name Entry Background

.org 0x217EF30
cmp r0, 24 //Fix Maximum X Position of Back Button Hitbox for File Name Entry
bge 0x217EF6C //Change Comparison

.org 0x217EF78
cmp r0, 232 //Fix Minimum X Position of OK Button Hitbox for File Name Entry

.org 0x217EF8C
cmp r0, 296 //Fix Maximum X Position of OK Button Hitbox for File Name Entry

.org 0x218052C
bl fix_menu_sprites //Jump to Code to Fix File Select Sprites

.org 0x218126A
.dh -8 //Fix X Position of Name Entry Back Button

.org 0x2181272
.dh 264 //Fix X Position of Name Entry OK Button

.close

.open "overlay/overlay_0086.bin", 0x217BB40 //Main Menu Scene Overlay

.org 0x217BC24
bl bg_force_wrap //Enable Wrapping for Top-Screen Main Menu Background

.org 0x217BCD8
bl bg_force_wrap //Enable Wrapping for Top-Screen Main Menu Background

.org 0x217BFE4
mov r5, 296 //Fix Start X Position of Mode Icons

.org 0x217CEC8
bl fix_menu_sprites //Jump to Code to Fix Main Menu Sprites

.org 0x217DB5C
mov r2, 216 //Fix X Position of MP Points Bar

.org 0x217DBA8
mov r10, 200 //Fix X Position of MP Points Number

.org 0x217DCA0
mov r0, 260 //Fix X Position of MP Points Icon

.close

.open "overlay/overlay_0087.bin", 0x217BB40 //Multiplayer Main Menu Scene Overlay

.org 0x217BE78
mov r5, 296 //Fix Start X Position of Multiplayer Mode Icons

.org 0x217CC38
bl bg_force_wrap //Enable Wrapping for Top-Screen Multiplayer Mode Background

.org 0x217CC60
bl bg_force_width_512_left //Increase Width of Multiplayer Bar Layer to 512

.org 0x217CCEC
bl bg_force_wrap //Enable Wrapping for Bottom-Screen Multiplayer Mode Background

.org 0x217D3CC
bl fix_menu_sprites //Jump to Code to Fix Multiplayer Menu Sprites

.org 0x217E0A8
mov r2, 216 //Fix X Position of MP Points Bar

.org 0x217E0F4
mov r10, 200 //Fix X Position of MP Points Number

.org 0x217E1EC
mov r0, 260 //Fix X Position of MP Points Icon

.close

.open "overlay/overlay_0088.bin", 0x217BB40 //Multiplayer Menu Scene Overlay

.org 0x217BC14
bl bg_force_wrap //Froce Wrap Top Screen BG in Multiplayer Menu

.org 0x217BC3C
bl bg_force_width_512_left //Extend Multiplayer Bar in Multiplayer Menu

.org 0x217BCC8
bl bg_force_wrap //Froce Wrap Bottom Screen BG in Multiplayer Menu

.org 0x217C3C4
bl fix_menu_sprites //Fix Multiplayer Menu Sprites

.org 0x217D116
.dh 152 //Fix X Position of P1 Name in Multiplayer Menu

.org 0x217D11A
.dh 168 //Fix X Position of P2 Name in Multiplayer Menu

.org 0x217D11E
.dh 168 //Fix X Position of P3 Name in Multiplayer Menu

.org 0x217D122
.dh 168 //Fix X Position of P4 Name in Multiplayer Menu

.org 0x217D166
.dh 0 //Fix X Position of Multiplayer Icon in Multiplayer Menu

.org 0x217D16E
.dh 196 //Fix X Position of P1 Icon in Multiplayer Menu

.org 0x217D176
.dh 204 //Fix X Position of P2 Icon in Multiplayer Menu

.org 0x217D17E
.dh 204 //Fix X Position of P3 Icon in Multiplayer Menu

.org 0x217D186
.dh 204 //Fix X Position of P4 Icon in Multiplayer Menu

.close

.open "overlay/overlay_0089.bin", 0x217BB40 //Party Mode Menu Scene Overlay

.org 0x217C1F8
mov r2, 1h //Extend Bar BG in Party Mode Menu

.org 0x217C254
mov r2, 40 //Move Bar BG Left in Party Mode Menu

.org 0x217C2B4
movne r6, 37 //Fix Write X Position of Party Mode Box

.org 0x217C2BC
moveq r6, 19 //Fix Write X Position of Party Mode Box on Save/Load Screen

.org 0x217C834
mov r1, 200 //Fix X Position of Game Mode in Party Mode Menu

.org 0x217C998
mov r2, 40 //Move Down-Moving Game Mode Bar BG Left in Party Mode Menu

.org 0x217CA44
mov r2, 40 //Move Up-Moving Game Mode Bar BG Left in Party Mode Menu

.org 0x217CC60
mov r1, 224 //Fix X Position of Board Logo on Load Game Screen

.org 0x217E82C
mov r1, -104 //Fix Start X Position of Sliding Player Name Box Highlight

.org 0x217E860
mov r0, -104 //Fix End X Position of Sliding Out Player Name Boxes

.org 0x217E924
mov r0, -104 //Fix Start X Position of Sliding In Player Name Boxes

.org 0x217EBEC
mov r0, -104 //Fix Start X Position of Sliding Out Player Name Boxes

.org 0x2181AA0
sub r0, r0, 360 //Fix Start X Offset for Sliding Team Icons

.org 0x2181AB4
add r0, r2, 360 //Fix Start X Offset for Sliding Team Icons

.org 0x218236C
mov r10, -104 //Fix Sliding New Game Sprites

.org 0x21823E0
mov r4, -104 //Fix Sliding New Game Sprites

.org 0x2183130
mov r4, -104 //Fix Sliding Game Modes

.org 0x2183D78
mov r4, -104 //Fix Starting Sliding Player Icons

.org 0x2183E0C
mov r4, -104 //Fix Starting Sliding Player Icons

.org 0x2183E98
mov r4, -104 //Fix Sliding Player Icons

.org 0x2183FC4
mov r5, -104 //Fix Starting Sliding Player Icons

.org 0x2186E88
mov r10, -104 //Fix Starting Sliding Board Icons

.org 0x2186EF8
mov r4, -104 //Fix Starting Sliding Board Icons

.org 0x2186FA8
mov r4, -104 //Fix Sliding Board Icons

.org 0x2187088
mov r4, -104 //Fix Ending Sliding Board Icons

.org 0x2187C94
mov r10, -104 //Fix Sliding Default/Previous Settings Icons

.org 0x2187D20
mov r4, -104 //Fix Sliding Default/Previous Settings Icons

.org 0x2188EA0
mov r7, -104 //Fix Sliding Settings Icons

.org 0x2188F28
mov r11, -104 //Fix Sliding Settings Icons

.org 0x2189558
mov r10, -104 //Fix Sliding Turns Icons

.org 0x21895E4
mov r4, -104 //Fix Sliding Turns Icons

.org 0x2189CA0
mov r1, -104 //Fix Sliding Minigame Set Icons

.org 0x2189D2C
mov r4, -104 //Fix Sliding Minigame Set Icons

.org 0x218A3FC
mov r10, -104 //Fix Sliding Bonus Star Icons

.org 0x218A488
mov r4, -104 //Fix Sliding Bonus Star Icons

.org 0x218B1E8
mov r4, -104 //Fix Sliding CPU Difficulty Icons

.org 0x218B268
mov r4, -104 //Fix Sliding CPU Difficulty Icons

.org 0x218B33C
mov r4, -104 //Fix Sliding CPU Difficulty Icons

.org 0x218B434
mov r9, -104 //Fix Sliding CPU Difficulty Icons

.org 0x218C968
mov r4, -104 //Fix Sliding Handicap Icons

.org 0x218C9F0
mov r4, -104 //Fix Sliding Handicap Icons

.org 0x218CAD8
mov r4, -104 //Fix Sliding Handicap Icons

.org 0x218CBD8
mov r9, -104 //Fix Sliding Handicap Icons

.org 0x218E05C
bl bg_force_wrap //Wrap Top Screen BG in Party Mode Menu

.org 0x218E0DC
bl bg_force_width_512_left //Extend Bar BG in Party Mode Menu

.org 0x218E110
bl bg_force_wrap //Wrap Bottom Screen BG in Party Mode Menu

.org 0x218E820
bl fix_menu_sprites //Fix Party Mode Menu Sprites

.org 0x218F540
mov r2, 216 //Fix X Position of Mario Party Points Box in Party Mode

.org 0x218F58C
mov r10, 200 //Fix X Position of Mario Party Points Icon in Party Mode

.org 0x218F684
mov r0, 260 //Fix X Position of Mario Party Points Icon in Party Mode

.org 0x218FD2C
.dh 48 //Fix X Position of Team VS Icon

.org 0x218FD34
.dh 48 //Fix X Position of Duel VS Icon

.org 0x218FDE0
.dh 48 //Fix X Position of Team 1 HUD on Load Game Screen

.org 0x218FDE4
.dh 48 //Fix X Position of Team 2 HUD on Load Game Screen

.org 0x218FE00
.dh 48 //Fix X Position of Duel Player 1 HUD on Load Game Screen

.org 0x218FE04
.dh 48 //Fix X Position of Duel Player 2 HUD on Load Game Screen

.org 0x218FF50
.dh 248 //Fix X Position of Turns Box on Load Game Screen

.org 0x218FF58
.dh 248 //Fix X Position of Minigame Set Box on Load Game Screen

.org 0x218FF60
.dh 248 //Fix X Position of Bonus Stars Box on Load Game Screens

.org 0x218FFC8
.dh 52 //Fix X Position of P1 HUD on Load Screen

.org 0x218FFCC
.dh 52 //Fix X Position of P2 HUD on Load Screen

.org 0x218FFD0
.dh 52 //Fix X Position of P3 HUD on Load Screen

.org 0x218FFD4
.dh 52 //Fix X Position of P4 HUD on Load Screen

.close

.open "overlay/overlay_0090.bin", 0x217BB40 //Party Results Scene Overlay

.org 0x217BC70
bl bg_force_width_512_left //Extend Party Results Fire Background

.org 0x217BCD4
bl bg_force_width_512 //Extend Party Results Scrolling Background

.org 0x217BEBC
mov r2, 40 //Fix X Position of Party Results Scrolling Background

.org 0x217C1A8
b fix_party_results_button //Jump to Code to Fix Party Results Buttons

.org 0x217C3F0
b fix_party_results_button_touch //Jump to Code to Fix Party Results Button Touch

.org 0x217C6A8
b fix_party_results_button_cursor //Jump to Code to Fix Party Results Button Cursor

.org 0x217E724
bl bg_force_width_512_left //Extend Party Results Lights Background

.org 0x217E7E8
mov r2, 40 //Fix X Position of Party Results Non-Scrolling Background

.org 0x2183E1C
bl bg_force_wrap //Force Party Results Top Screen Background to Wrap

.org 0x2183E48
bl bg_force_width_512_left //Extend Party Results Curtains Background

.org 0x2183EB8
bl bg_force_wrap //Force Party Results Bottom Screen Background to Wrap

.org 0x2184578
mov r1, 380 //Fix Base X Position of Turn Counter

.org 0x2185E2C
sub r11, r0, 296 //Fix X Offset of Player Result Name Slide Out

.org 0x2185EA8
sub r0, r2, 312 //Fix X Offset of Player Result Name Slide Out

.org 0x2185F98
sub r1, r0, 296 //Fix X Offset of Team Player Result Score Slide Out

.org 0x2186010
sub r0, r8, 312 //Fix X Offset of Team Player Result Name Slide Out

.org 0x2186094
sub r0, r8, 312 //Fix X Offset of Team Player Result Name Slide Out

.org 0x21860F8
sub r0, r8, 312 //Fix X Offset of Team Player Result Name Slide Out

.org 0x2186244
add r0, r3, 380 //Fix Base X Position of Turn Counter

.org 0x2186778
sub r11, r0, 296 //Fix X Offset of Player Result Score Slide Out

.org 0x21867FC
sub r8, r2, 312 //Fix X Offset of Player Result Name Slide Out

.org 0x2186900
sub r0, r11, 296 //Fix X Offset of Player Result Score Slide Out

.org 0x2186980
sub r0, r8, 312 //Fix X Offset of Player Result Name Slide Out

.org 0x2186A04
sub r0, r8, 312 //Fix X Offset of Player Result Name Slide Out

.org 0x2186A68
sub r0, r8, 312 //Fix X Offset of Player Result Name Slide Out

.org 0x2186BAC
b fix_turn_counter_slideout //Fix Base X Position of Turn Counter

.close

.open "overlay/overlay_0091.bin", 0x217BB40 //Main Minigame Menu Scene Overlay

.org 0x217C0E8
mov r5, 296 //Fix Minigame Mode Icon Start Offset

.org 0x217CCE8
bl bg_force_wrap //Force Wrap Top-Screen Background

.org 0x217CD9C
bl bg_force_wrap //Force Wrap Bottom-Screen Background

.org 0x217D47C
bl fix_menu_sprites //Fix Minigame Menu Sprites

.org 0x217E184
mov r2, 216 //Fix X Position of Mario Party Points Box

.org 0x217E1D0
mov r10, 200 //Fix X Position of Mario Party Points Digits

.org 0x217E2C8
mov r0, 260 //Fix X Position of Mario Party Points Icon

.close

.open "overlay/overlay_0092.bin", 0x217BB40 //Free Play Menu Scene Overlay

.org 0x217C09C
mov r1, 200 //Fix Default X Position of Minigame Free Play Game Type

.org 0x217C1A8
mov r2, 200 //Fix X Position of Minigame Free Play Game Type

.org 0x217C1D4
mov r1, -32 //Fix Destination Y Position of Free Play Game Type

.org 0x217D06C
mov r0, -104 //Fix Start X Position of Left Side Player Bars

.org 0x217D078
mov r9, 360 //Fix Start X Position of Right Side Player Bars

.org 0x217D168
mov r4, -104 //Fix Start X Position of Left Side Player Icons

.org 0x217D1B0
addge r0, r8, 304 //Fix Start X Position of Right Side Player Icons

.org 0x217EAE4
mov r0, -104 //Fix Start X Position of COM Difficulty Icons

.org 0x217F634
mov r1, 4h //Move Free Play Menu List BG Address

.org 0x217F644
bl bg_force_width_512 //Extend Free Play Menu List to 512 Wide

.org 0x217F69C
mov r0, 0x380 //Change Tile Base for Free Play Menu List

.org 0x217FE2C
mov r2, 40 //Fix X Position of Free Play List

.org 0x21819B0
mov r2, 40 //Fix Default X Position of Free Play Menu Minigame Mode Bar

.org 0x21826E0
mov r0, -104 //Fix Start X Position of Match Style Icons

.org 0x2182E24
sub r1, r6, 104 //Fix Start X Position of Free Play Sliding Names

.org 0x2182E2C
sub r2, r2, 128 //Fix Start X Position of Free Play Sliding VS

.org 0x218314C
mov r2, 40 //Fix X Position of Free Play Menu Minigame Mode Bar

.org 0x21837E4
bl bg_force_wrap //Force Top Screen Free Play Menu Background to Wrap

.org 0x2183864
bl bg_force_width_512 //Extend Free Play Menu Minigame Mode Bar

.org 0x2183898
bl bg_force_wrap //Force Bottom Screen Free Play Menu Background to Wrap

.org 0x2183FA8
bl fix_menu_sprites //Fix Minigame Free Play Menu Sprites

.org 0x218513A
.dh -26 //Fix X Position of Left Up Arrow in Minigame Free Play Menu

.org 0x2185148
.dh -26 //Fix X Position of Left Down Arrow in Minigame Free Play Menu

.org 0x2185156
.dh 282 //Fix X Position of Left Up Arrow in Minigame Free Play Menu

.org 0x2185164
.dh 282 //Fix X Position of Left Down Arrow in Minigame Free Play Menu

.org 0x21851C6
.dh -8 //Fix X Position of Back in Minigame Free Play Menu

.org 0x21851D4
.dh 264 //Fix X Position of OK in Minigame Free Play Menu

.close

.open "overlay/overlay_0093.bin", 0x217BB40 //Step It Up Scene Overlay

.org 0x217BC80
bl bg_force_wrap //Force Menu Top Screen Background Wrapping

.org 0x217BCC0
mov r0, 14 //Move BG Address for Minigame Mode Bar

.org 0x217BCD8
bl bg_force_width_512 //Extend Minigame Mode Bar

.org 0x217BD04
mov r1, 6 //Move BG Address for Step it Up Settings Box

.org 0x217BD64
bl bg_force_wrap //Force Menu Bottom Screen Background Wrapping

.org 0x217C320
mov r0, 19 //Fix X Position of Settings Box

.org 0x217D6D0
bl fix_mpp_sprites //Fix Step it Up Menu Sprites

.org 0x217D99C
bl fix_step_menu_cursor //Fix Cursor for Step it Up Menu

.org 0x217DC94
b fix_step_menu_sprites_touch //Fix Touching Step it Up Menu Sprites

.org 0x217F5A0
mov r2, 40 //Fix X Position of Step it Up Minigame Mode Bar

.org 0x217F694
sub r2, r0, 128 //Fix End X Position of Step it Up Player Bars

.org 0x217F8E8
mov r7, 360 //Fix Start X Position of Right Character Icons
mov r11, -104 //Fix Start X Position of Left Character Icons

.org 0x217FA20
addge r0, r7, 264 //Fix Slide Start X Position of Right Character Icons

.org 0x217FFF8
mov r0, -104 //Fix Sliding Menu Icons

.org 0x2181B48
mov r8, -104 //Fix Sliding COM DIfficulty Icons

.org 0x2181C38
sub r1, r7, 104 //Fix Sliding Empty Difficulty Icons

.org 0x2181DA4
sub r3, r1, 119 //Fix Sliding Difficulty Cursor

.org 0x21834EC
mov r1, 424 //Fix Start X Position of Sliding Team Players Box

.org 0x2183520
mov r5, 424 //Fix Start X Position of Sliding Team Players

.org 0x218435C
bl bg_force_width_512 //Extend Step it Up Top Screen Stairs Background

.org 0x2184388
bl bg_force_wrap //Force Step it Up Clouds Background to Wrap

.org 0x218441C
bl bg_force_wrap //Force Step it Up Bottom Screen Background to Wrap

.org 0x21844E8
mov r2, 40 //Fix X Position of Step it Up Top Screen Stairs Background
mov r3, 0 //Fix Y Position of Step it Up Top Screen Stairs Background

.org 0x2187EE4
bl bg_force_width_512_left //Extend Step it Up Congratulations Lights

.org 0x2188074
bl bg_force_width_512_left //Extend Step it Up Win Corner

.org 0x21880A0
bl bg_force_wrap //Force Step it Up Bottom Screen Background to Wrap

.org 0x2188308
mov r0, 288 //Fix Range of Win Particles in Step it Up

.org 0x2188310
sub r1, r0, 16 //Fix Base X Position of Win Particles in Step it Up

.org 0x21888F4
mov r2, 40 //Fix X Position of Minigame Mode Bar
mov r3, 0 //Fix Y Position of Minigame Mode Bar

.org 0x218A664
mov r1, 52 //Fix X Position of VS Icon

.org 0x218A7A4
.dh 52 //Fix X Position of P1 on 1 vs 3 Wins Needed

.org 0x218A7A8
.dh 52 //Fix X Position of P2 on 1 vs 3 Wins Needed

.org 0x218A7AC
.dh 52 //Fix X Position of P3 on 1 vs 3 Wins Needed

.org 0x218A7B0
.dh 52 //Fix X Position of P4 on 1 vs 3 Wins Needed

.org 0x218A7D4
.dh 52 //Fix X Position of P1 on 2 vs 2 Wins Needed

.org 0x218A7D8
.dh 52 //Fix X Position of P2 on 2 vs 2 Wins Needed

.org 0x218A7DC
.dh 52 //Fix X Position of P3 on 2 vs 2 Wins Needed

.org 0x218A7E0
.dh 52 //Fix X Position of P4 on 2 vs 2 Wins Needed

.org 0x218A870
.dh 248 //Fix X Position of Wins Needed Setting

.org 0x218A878
.dh 248 //Fix X Position of Minigame Type Setting

.org 0x218A8E4
.dh 52 //Fix X Position of P1 on Wins Needed

.org 0x218A8E8
.dh 52 //Fix X Position of P2 on Wins Needed

.org 0x218A8EC
.dh 52 //Fix X Position of P3 on Wins Needed

.org 0x218A8F0
.dh 52 //Fix X Position of P4 on Wins Needed

.close

.open "overlay/overlay_0094.bin", 0x217BB40 //Battle Cup Scene Overlay

.org 0x217C0E0
mov r0, 14 //Change Win BG Address in Battle Cup

.org 0x217C0F8
bl bg_force_width_512 //Extend Win BG In Battle Cup

.org 0x217C19C
mov r2, 40 //Fix X Position of Congratulations Background

.org 0x217C284
mov r2, 40 //Fix X Position of Win Corner Background

.org 0x217C45C
mov r0, 288 //Fix Range of Win Particles

.org 0x217C464
sub r1, r0, 16 //Fix Offset of Win Particles

.org 0x217D3DC
bl bg_force_width_512 //Extend Win Corner BG in Battle Cup

.org 0x217D3F4
mov r12, 5 //Move Stage Background Address in Battle Cup

.org 0x217D40C
bl bg_force_wrap //Force Wrap Stage Background in Battle Cup

.org 0x217D5B8
bl bg_force_wrap //Force Wrap Top Screen Background in Battle Cup

.org 0x217D5E4
bl bg_force_width_512 //Extend Minigame Mode Bar in Battle Cup

.org 0x217D5F0
mov r2, 40 //Left Align Minigame Mode Bar in Battle Cup

.org 0x217D688
bl bg_force_wrap //Force Wrap Bottom Screen Background in Battle Cup

.org 0x217D6E4
bl bg_force_width_512 //Extend Minigame List Window in Battle Cup

.org 0x217E144
b fix_battlecup_sprites //Fix Sprites in Battle Cup

.org 0x2181B88
bl fix_step_menu_cursor //Fix Battle Cup Cursor

.org 0x2181E6C
b fix_battlecup_sprites_touch //Fix Touching Battle Cup Sprites

.org 0x21835FC
mov r2, 40 //Fix X Position of Minigame Mode Bar

.org 0x2183604
mov r3, 0 //Fix Y Position of Minigame Mode Bar

.org 0x2184430
mov r2, 40 //Left Align Minigame Mode Bar in Battle Cup

.org 0x21844A4
mov r2, -104 //Left Align Minigame Icons in Battle Cup

.org 0x2184524
mov r2, -104 //Fix Stop X Position of Player Icons in Battle Cup

.org 0x218452C
mov r1, -104 //Fix Stop X Position of Player Icons in Battle Cup

.org 0x2184838
mov r7, 360 //Fix Start X Position of Right Side Player Icons
mov r11, -104 //Fix Start X Position of Left Side Player Icons

.org 0x2184924
mov r11, -104 //Fix Start X Position of Left Side Player Icons

.org 0x2184968
addge r0, r7, 264 //Fix Start X Position of Right Side Player Icons

.org 0x2184FB0
mov r4, -104 //Fix Start X Position of Difficulty Icons

.org 0x2185ED8
mov r0, -104 //Fix Start X Position of Event List

.org 0x218708C
mov r2, 40 //Left Align Minigame List Window in Battle Cup

.close

.open "overlay/overlay_0095.bin", 0x217BB40 //Score Scuffle Scene Overlay

.org 0x217BBD0
b fix_scoreattack_menu_sprites //Fix X Position of Score Scuffle Menu Sprites

.org 0x217C35C
bl fix_step_menu_cursor //Fix Cursor for Score Scuffle Menu

.org 0x217C754
b fix_scoreattack_menu_sprites_touch //Fix Touching Score Scuffle Menu Sprites

.org 0x217CDD4
mov r0, 288 //Fix Range of Win Particles

.org 0x217CDDC
sub r1, r0, 16 //Fix Left Edge of Win Particles

.org 0x217CFD4
mov r0, 21 //Move Win BG Address

.org 0x217CFEC
bl bg_force_width_512_left //Extend Win BG in Score Scuffle

.org 0x217D148
mov r2, 128 //Fix Win BG Palette Cycle Offset

.org 0x217D178
bl bg_force_width_512 //Extend Win BG in Score Scuffle

.org 0x217FF18
mov r4, -104 //Fix Sliding Difficulty Icons

.org 0x2181EAC
mov r2, 40 //Fix X Position of Minigame Mode Bar in Score Scuffle

.org 0x2181F8C
mov r4, -104 //Fix Sliding P1 Score Icons in Score Scuffle

.org 0x2182194
mov r7, 360 //Fix Right Side Player Icons Slide
mov r11, -104 //Fix Left Side Player Icons Slide

.org 0x2182F1C
mov r2, 40 //Fix Offset of Win BG Corners in Score Scuffle

.org 0x2183548
bl bg_force_wrap //Force Bottom Screen Background Wrap in Score Scuffle

.org 0x21835D8
mov r1, 6 //Move FG Address in Score Scuffle

.org 0x21835EC
bl bg_force_width_512_left //Extend FG in Score Scuffle

.org 0x2183600
mov r0, 4 //Move BG Address in Score Scuffle

.org 0x2183618
bl bg_force_width_512_left //Extend BG in Score Scuffle

.org 0x218374C
bl bg_force_wrap //Force Wrapping of Top Screen BG in Score Scuffle

.org 0x2183778
bl bg_force_width_512 //Extend Minigame Mode Bar in Score Scuffle

.org 0x2183784
mov r2, 40 //Fix X Position of Minigame Mode Bar in Score Scuffle

.org 0x218381C
bl bg_force_wrap //Force Wrapping of Bottom Screen BG in Score Scuffle

.close

.open "overlay/overlay_0096.bin", 0x217BB40 //Boss Bash Scene Overlay

.org 0x217C6EC
b fix_boss_bash_menu_sprites //Fix Menu Sprites in Boss Bash

.org 0x217C94C
bl fix_step_menu_cursor //Fix Cursor for Boss Bash Menu

.org 0x217CA80
bl fix_mpp_sprites_touch //Fix Touching Boss Bash Menu Sprites

.org 0x217D2F4
mov r6, -104 //Fix X Offset of Left Boss Bash Menu Characters

.org 0x217D358
add r0, r2, 264 //Fix X Offset of Right Boss Bash Menu Characters

.org 0x217DC3C
add r0, r0, 104 //Fix Movement Velocity of Show Icons

.org 0x217DC60
sub r0, r0, 104 //Fix Offset of Show Icons

.org 0x217EF24
mov r0, r0, lsl 5h //Fix Speed of Boss Bash Scores

.org 0x217F364
mov r1, 30 //Move BG Address for Congratulations Screen

.org 0x217F378
bl bg_force_width_512_left //Extend Congratulations Boss Bash Background

.org 0x217F550
mov r5, 12 //Move BG Address for Congratulations Screen

.org 0x217F568
bl bg_force_width_512 //Extend Congratulations Boss Bash Background

.org 0x217F5A8
mov r2, 40 //Align Congratulations Boss Bash Background

.org 0x217F70C
mov r0, 336 //Extend Boss Bash Particles Range

.org 0x217F714
sub r5, r0, 40 //Center Boss Bash Particles Range

.org 0x217FA2C
mov r0, 13 //Move Boss Bash Minigame Bar BG Address

.org 0x217FA44
bl bg_force_width_512_left //Extend Boss Bash Minigame Bar Background

.org 0x217FA70
bl bg_force_wrap //Force Boss Bash Background to Wrap

.org 0x217FAD4
bl bg_force_wrap //Force Boss Bash Background to Wrap

.org 0x217FB34
mov r0, 19 //Fix Write X Position of Box

.org 0x217FE30
mov r1, 248 //Fix Initial X Position of Description Setting

.org 0x21801C4
rsb r1, r1, 248 //Fix Base X Position of Description Setting

.org 0x2180264
mov r2, 40 //Fix Boss Bash Minigame Bar

.org 0x21802D8
mov r2, 40 //Fix Boss Bash Minigame Bar

.org 0x21803A4
sub r1, r2, 104 //Fix Start X Position of Player Name in Boss Bash

.org 0x21803EC
add r6, r6, 232 //Fix Speed of Player Name Slide In in Boss Bash

.org 0x2180498
sub r5, r5, 288 //Fix Speed of Player Name Slide Out in Boss Bash

.org 0x2180918
bl bg_force_width_512_left //Extend Top Screen Boss Bash Background

.org 0x2180920
mov r2, 40 //Left Align Top Screen Boss Bash Background

.org 0x2180944
mov r1, 30 //Move Top Screen Boss Bash Ring Background Address

.org 0x2180958
bl bg_force_width_512_left //Extend Top Screen Boss Bash Ring Background

.org 0x2180960
mov r2, 40 //Left Align Top Screen Boss Bash Ring Background

.org 0x2180968
mov r3, 0 //Top Align Top Screen Boss Bash Ring Background

.org 0x2180A14
bl bg_force_wrap //Extend Bottom Screen Boss Bash Background

.org 0x218108C
mov r4, 0 //Fix Boss Bash Background

.org 0x21825EC
.dh 52 //Fix X Position of Left-Side Player in Boss Bash

.close

.open "overlay/overlay_0097.bin", 0x217BB40 //Rocket Rascals Ending Scene Overlay

.org 0x217C950
bl bg_force_wrap //Force Bottom Screen Background Wrap in Rocket Rascals Menu

.org 0x217C990
mov r0, 4h //Move BG Address for Minigame Mode Bar in Rocket Rascals

.org 0x217C9A8
bl bg_force_width_512 //Extend BG for Minigame Mode Bar in Rocket Rascals

.org 0x217D0A0
mov r2, 40 //Left-Align Minigame Mode Bar in Rocket Rascals

.org 0x217D114
mov r2, 40 //Left-Align Minigame Mode Bar in Rocket Rascals

.org 0x217D1F4
mov r4, -104 //Fix Start X Offset of Player Information in Rocket Rascals

.org 0x217D2E0
mov r5, -104 //Fix Start X Offset of Player Information in Rocket Rascals

.org 0x217ED94
mov r4, -104 //Fix Start X Offset of Left Players in Rocket Rascals

.org 0x217EDF8
add r0, r1, 264 //Fix Start X Offset of Right Players in Rocket Rascals

.org 0x2180BFC
mov r1, 3 //Move Congratulations Corner Icons BG Address

.org 0x2180C14
bl bg_force_width_512_left //Extend Congratulations Corner Icons BG

.org 0x2180C40
bl bg_force_wrap //Force Wrap Bottom Screen Background in Rocket Rascals Ending

.org 0x2180C6C
bl bg_force_width_512_left //Extend Rocket Background in Rocket Rascals Ending

.org 0x2180C80
mov r0, 14 //Move BG Address for Background in Rocket Rascals Ending

.org 0x2180C98
bl bg_force_width_512_left //Extend Background in Rocket Rascals Ending

.org 0x2181198
mov r0, 336 //Extend Rocket Rascals Particles Range

.org 0x21811A0
sub r5, r0, 40 //Center Rocket Rascals Particles Range

.org 0x2181C8E
.dh 264 //Fix X Position of OK Button in Rocket Rascals Menu

.org 0x2181C98
.dh -8 //Fix X Position of Back Button in Rocket Rascals Menu

.close

.open "overlay/overlay_0098.bin", 0x217BB40 //Story Mode Menu Scene Overlay

.org 0x217BE68
mov r1, 19 //Fix X Position of Minigame Set Box Write

.org 0x217C5E4
mov r0, 248 //Fix Base X Position of Minigame Set Icon

.org 0x217CD00
mov r5, -104 //Fix Start X Position of Story New Game Sprites

.org 0x217CEE4
mov r5, -104 //Fix Start X Position of Story New Game Sprites

.org 0x217D9C0
mov r10, 360 //Fix Start X Position of Right Player Name Sprites

.org 0x217D9D0
mov r4, -104 //Fix Start X Position of Left Player Name Sprites

.org 0x217DA64
mov r4, -104 //Fix Start X Position of Left Player Name Sprites

.org 0x217DA88
addge r0, r9, 264 //Fix Start X Position of Right Player Name Sprites

.org 0x217DAFC
mov r1, -104 //Fix Start X Position of Sliding Player Icon Sprites

.org 0x217DB14
mov r1, -104 //Fix Start X Position of Sliding Player Icon Sprites

.org 0x217DB6C
mov r9, 360 //Fix Start X Position of Right Player Name Sprites

.org 0x217DB74
mov r4, -104 //Fix Start X Position of Left Player Name Sprites

.org 0x217DCA0
mov r5, -104 //Fix Start X Position of Left Player Name Sprites

.org 0x217DCC4
addge r0, r7, 264 //Fix Start X Offser of Right Player Name Sprites

.org 0x217DD84
add r0, r0, 104 //Fix X Offset for Player Name Move Speed

.org 0x217DD9C
sub r0, r6, 104 //Fix X Offset for Player Names

.org 0x217E204
mov r1, -104 //Fix End X Position for Story Mode Player Icon

.org 0x217EA2C
mov r4, -104 //Fix Start X Position of Sliding Mic Icons

.org 0x217EA9C
mov r7, -104 //Fix Start X Position of Sliding Story Board Icons

.org 0x217EB24
mov r1, 360 //Fix Start X Position of Minigame Set Icon

.org 0x217EB60
mov r4, -104 //Fix Start X Position of Minigame Set Types

.org 0x217EC4C
add r1, r0, 104 //Fix Start X Position Offset of Sliding Story Board Icons

.org 0x217EC64
sub r1, r3, 104 //Fix Start X Position Offset of Sliding Story Board Icons

.org 0x217ED20
add r0, r4, 360 //Fix Base X Position of Minigame Set Icon

.org 0x217ED34
cmp r0, 248 //Fix Minimum X Position of Minigame Set Icon

.org 0x217ED3C
mov r0, 248 //Set Minimum X Position of Minigame Set Icon

.org 0x217EDB4
sub r0, r4, 140 //Fix X Speed for Moving Player Icon for Story Mode Setup

.org 0x217EDE0
cmp r0, 52 //Fix Minimum X Position for Player Icon in Story Mode Setup

.org 0x217EDE8
mov r0, 52 //Set Minimum X Position for Player Icon in Story Mode Setup

.org 0x217F0F8
add r0, r4, 248 //Fix Start X Position of Minigame Set Slide Out

.org 0x217F10C
cmp r0, 360 //Fix Stop X Position for Minigame Set Slide Out

.org 0x217F114
cmp r0, 360 //Set Stop X Position for Minigame Set Slide Out

.org 0x217F140
mov r0, 76 //Fix Speed of Centering Player Bar

.org 0x217F154
add r0, r3, 52 //Fix Base X Position of Centering Player Bar

.org 0x217FAC8
bl bg_force_wrap //Extend Story Mode Menu Top Screen Background

.org 0x217FB48
bl bg_force_width_512_left //Extend Story Mode Bar Background

.org 0x217FB7C
bl bg_force_wrap //Extend Story Mode Menu Bottom Screen Background

.org 0x218028C
bl fix_menu_sprites //Fix Story Mode Menu Sprites

.org 0x2180E08
mov r2, 216 //Fix X Position of MPP Point Bar

.org 0x2180E54
mov r10, 200 //Fix X Position of MPP Point Count

.org 0x2180F4C
mov r0, 260 //Fix X Position of MPP Point Badge

.org 0x218131C
.dh 52 //Fix X Position of Story Mode Player Icon

.close

.open "overlay/overlay_0099.bin", 0x217BB40 //Extras Mode Scene Overlay

.org 0x217C774
mov r1, 19 //Fix Map X Position of Minigame Set Box

.org 0x217CD74
mov r2, 40 //Fix X Position of Extras Mode Bar when Scrolling Down

.org 0x217CDF0
mov r2, 40 //Fix X Position of Extras Mode Bar when Scrolling Up

.org 0x217D030
mov r0, 248 //Fix End X Position of Minigame Set Slide In

.org 0x217D050
mov r2, 376 //Fix Start X Position of Minigame Set Slide In

.org 0x217D0B0
mov r0, 376 //Fix End X Position of Minigame Set Slide Out

.org 0x217D0D0
mov r2, 248 //Fix Start X Position of Minigame Set Slide Out

.org 0x217D5F4
mov r11, -136 //Fix Start X Position of Pen Pals Player Boxes Scrolling In

.org 0x217D7CC
mov r5, -136 //Fix End X Position of Pen Pals Player Boxes Scrolling Out

.org 0x217D9A8
sub r2, r1, 151 //Fix Start X Position of Pen Pals Vs Scrolling In

.org 0x217D9C0
mov r1, -136 //Fix End X Position of Pen Pals VS Scrolling Out

.org 0x217E0FC
mov r0, -136 //Load Start X Position of Desert Duel Player Boxes Scrolling In
str r0, [r13, 14h] //Write Start X Position of Desert Duel Player Boxes Scrolling In
mov r0, -1 //Load -1
str r0, [r13, 18h] //Write -1 to Stack Value

.org 0x217E118
mov r0, -1 //Load -1 Properly

.org 0x217E268
sub r2, r1, 171 //Fix Start X Position of Desert Duel Player Names

.org 0x217E294
mov r11, -136 //Load End X Position of Desert Duel Player Boxes Scrolling Out

.org 0x217E29C
mov r0, -1 //Load -1 Properly

.org 0x217E3CC
mov r2, -156 //Fix End X Position of Desert Duel Player Boxes Scrolling Out

.org 0x217E460
sub r2, r1, 151 //Fix Start X Position of Desert Duel Vs Scrolling In

.org 0x217E478
mov r1, -136 //Fix End X Position of Desert Duel VS Scrolling Out

.org 0x217EC7C
mov r7, -104 //Fix Start X Position of Extras Mode Games

.org 0x217FC9C
sub r4, r6, 76 //Fix Start X Position of Left Side Sliding Players

.org 0x217FCC4
addge r0, r9, 264 //Fix Start X Position of Right Side Sliding Players

.org 0x2180EB0
mov r5, -104 //Fix Start X Position of Extras Mode Rules Boxes

.org 0x21813AC
mov r7, -104 //Fix Start X Position of Extras Mode Settings Boxes

.org 0x21816F0
mov r7, -104 //Fix Start X Position of Extras Mode  SetsMinigame

.org 0x2182098
mov r4, -104 //Fix Base X Position of Extras Mode Boxes

.org 0x2182170
mov r4, -104 //Fix Base X Position of Extras Mode Empty Difficulty

.org 0x2182230
mov r0, 192 //Fix Movement Speed of Player Difficulty Boxes

.org 0x218224C
sub r0, r4, 104 //Fix Base X Position of Player Difficulty Boxes

.org 0x2182294
mov r0, 116 //Fix Movement Speed of Player Difficulty Player Numbers

.org 0x21822B0
sub r0, r4, 104 //Fix Base X Position of Player Difficulty Player Numbers

.org 0x2183054
bl bg_force_wrap //Wrap Top Screen Background in Extras Mode

.org 0x21830D4
bl bg_force_width_512 //Extend Extras Mode BG Bar

.org 0x2183108
bl bg_force_wrap //Wrap Bottom Screen Background in Extras Mode

.org 0x2183818
bl fix_menu_sprites //Fix X Position of Menu Sprites in Extras Mode

.org 0x218467C
.dh 48 //Fix X Position of Pen Pals VS Icon

.org 0x2184684
.dh 48 //Fix X Position of Desert Duel VS Icon

.org 0x2184710
.dh 48 //Fix X Position of P1/P2 HUD in Pen Pals Configure Menu

.org 0x2184714
.dh 48 //Fix X Position of P3/P4 HUD in Pen Pals Configure Menu

.org 0x2184730
.dh 48 //Fix X Position of P1 HUD in Desert Duel Configure Menu

.org 0x2184734
.dh 48 //Fix X Position of P2 HUD in Desert Duel Configure Menu

.org 0x2184832
.db 33 //Fix X Position of Left Rules Button in Extra Mode

.org 0x2184840
.db 223 //Fix X Position of Right Rules Button in Extra Mode

.close

.open "overlay/overlay_0100.bin", 0x217BB40 //Puzzle Mode Scene Overlay

.org 0x217D3FC
mov r0, -104 //Fix X Position of Sliding Player Icons

.org 0x217D408
mov r9, 360 //Fix X Position of Sliding Player Icons

.org 0x217D4F4
mov r4, -104 //Fix X Position of Sliding Player Icons

.org 0x217D538
addge r0, r8, 264 //Fix X Position of Sliding Player Icons

.org 0x217EABC
mov r2, 40 //Fix Initial Top Screen Puzzle Mode Bar X Position

.org 0x217F410
mov r0, -104 //Fix X Position of Sliding Puzzle Modes

.org 0x217F7B8
mov r2, 40 //Fix Top Screen Puzzle Mode Bar X Position

.org 0x217F974
mov r5, -104 //Fix X Position of Sliding Player Icon

.org 0x217FE38
bl bg_force_wrap //Fix Top Screen Puzzle Mode Background

.org 0x217FEB8
bl bg_force_width_512 //Fix Top Screen Puzzle Mode Bar

.org 0x217FEEC
bl bg_force_wrap //Fix Bottom Screen Puzzle Mode Background

.org 0x21805FC
bl fix_menu_sprites //Fix Camera View Button Sprites

.org 0x218119C
mov r2, 216 //Fix X Position of Mario Party Points Bar

.org 0x21811E8
mov r10, 200 //Fix X Position of Mario Party Points Bar Digits

.org 0x21812E0
mov r0, 260 //Fix X Position of Mario Party Points Bar

.close

.open "overlay/overlay_0101.bin", 0x217BB40 //Gallery Scene Overlay

.org 0x217BCCC
mov r2, 216 //Fix X Position of MP Points Bar

.org 0x217BD18
mov r10, 200 //Fix X Position of MP Points Digits

.org 0x217BE30
mov r0, 260 //Fix X Position of MP Points Icon

.org 0x217D998
bl fix_menu_sprites //Fix Camera View Button Sprites

.org 0x217E734
mov r0, 6 //Fix Address of Textbox BG In Gallery

.org 0x217E774
bl bg_force_width_512 //Extend BG1 in Gallery

.org 0x217E7A0
bl bg_force_wrap //Force Wrap BG2 in Gallery

.org 0x217E7B4
mov r0, 1Ch //Fix BG3 Address in Gallery

.org 0x217E7CC
bl bg_force_width_512 //Extend BG3 in Gallery

.org 0x217EF5C
mov r2, 40 //Fix Gallery Text Init X Scroll
mov r3, 0 //Fix Gallery Text Init Y Scroll

.org 0x217EFE0
mov r2, 40 //Fix Gallery Text Down X Scroll

.org 0x217F030
mov r2, 40 //Fix Gallery Text Up X Scroll

.org 0x217F394
mov r2, 3 //Fix Size of Bottom Screen Background

.org 0x217F474
mov r2, 40 //Fix Bottom Screen Background Up X Scroll

.org 0x217F4D0
mov r2, 40 //Fix Bottom Screen Background Down X Scroll

.org 0x217F760
mov r5, -104 //Fix Start X Position of Gallery Menu Options

.org 0x217FD84
mov r2, 3 //Fix Size of Top Screen Record Background

.org 0x217FE1C
mov r2, 3 //Fix Size of Bottom Screen Record Background

.org 0x2180230
bl fix_gallery_sprites //Fix Record View Buttons Scrolling Up

.org 0x21802E8
mov r2, 40 //Fix Record View Top Up X Scroll

.org 0x2180308
mov r5, 40 //Fix Record View Bottom Up X Scroll

.org 0x218035C
bl fix_gallery_sprites //Fix Record View Buttons Scrolling Down

.org 0x21803E0
mov r2, 40 //Fix Record View Top Down X Scroll

.org 0x21803F4
mov r5, 40 //Fix Record View Bottom Down X Scroll

.org 0x218297C
bl fix_gallery_sprites //Fix Story View Buttons Scrolling Up

.org 0x21829E8
bl fix_gallery_sprites //Fix Story View Buttons Scrolling Down

.org 0x2182DB4
mov r5, -104 //Fix Start X Position of Gallery Menu Sound Choices

.org 0x218321C
bl fix_gallery_sprites //Fix Music Player View Buttons Scrolling Up

.org 0x2183288
bl fix_gallery_sprites //Fix Music Player View Buttons Scrolling Down

.org 0x21838C8
bl fix_gallery_sprites //Fix Music Player View Buttons Scrolling Up

.org 0x2183990
bl fix_gallery_sprites //Fix Music Player View Buttons Scrolling Down

.org 0x21848B4
mov r5, -104 //Fix Start X Position of Gallery Menu Minigame Sets

.org 0x2184D44
bl fix_gallery_sprites //Fix Minigame Set View Buttons Scrolling Up

.org 0x2184D9C
bl fix_gallery_sprites //Fix Minigame Set View Buttons Scrolling Down

.org 0x21857EC
mov r2, -32 //Fix X Position of Collection Count

.org 0x21858B0
mov r2, -32 //Fix X Position of Collection Count

.org 0x2185A48
mov r5, -104 //Fix Start X Position of Collection Menu Options

.org 0x21869AC
bl fix_gallery_sprites //Fix Gallery Buttons Scrolling Up

.org 0x21869F0
moveq r3, -104 //Fix Start X Position of Sliding In Gallery Box

.org 0x2186A88
bl fix_gallery_sprites //Fix Gallery Buttons Scrolling Down

.org 0x2186AC4
moveq r0, -104 //Fix Start X Position of Sliding Out Gallery Box

.org 0x2187308
mov r2, -20 //Fix End X Position of Left Arrow in Collection Viewer

.org 0x2187318
sub r2, r1, 119 //Fix Start X Offset of Left Arrow in Collection Viewer

.org 0x2187330
mov r2, 276 //Fix End X Position of Left Arrow in Collection Viewer

.org 0x2187340
mov r2, 360 //Fix Start X Position of Right Arrow in Collection Viewer

.org 0x2187370
mov r2, 208 //Fix X Position of Zoom Controls in Collection Viewer

.org 0x2187398
mov r2, 208 //Fix X Position of Zoom Controls in Collection Viewer

.org 0x2187428
mov r1, -104 //Fix End X Position of Left Arrow in Collection Viewer

.org 0x2187430
mov r2, -20 //Fix Startt X Position of Left Arrow in Collection Viewer

.org 0x218744C
mov r1, 360 //Fix End X Position of Right Arrow in Collection Viewer

.org 0x2187454
mov r2, 276 //Fix Start X Position of Left Arrow in Collection Viewer

.org 0x2187470
mov r2, 208 //Fix X Position of Zoom Controls in Collection Viewer

.org 0x2187C34
cmp r0, 24 //Fix Maximum X Position for Left Arrow
ble 0x2187C7C //Fix Comparison

.org 0x2187C48
cmp r0, 232 //Fix Minimum X Position for Right Arrow
bgt 0x2187C7C //Fix Comparison

.org 0x2187E9C
cmp r0, 152 //Fix Minimum Position for Zoom Icon
movlt r0, 152 //Set Minimum Position for Zoom Icon

.org 0x2187EAC
cmp r0, 264 //Fix Maximum Position for Zoom Icon
movge r0, 264 //Set Maximum Position for Zoom Icon

.org 0x2187ECC
rsb r1, r1, 216 //Fix Center Position for Zoom Calculation

.org 0x2188538
bl fix_gallery_sprites //Fix Badge Collection Buttons Scrolling Up

.org 0x21885AC
bl fix_gallery_sprites //Fix Badge Collection Buttons Scrolling Down

.org 0x2188B44
mov r2, 216 //Fix X Position of MP Points Bar Bump

.org 0x2188B88
mov r10, 200 //Fix X Position of MP Points Bar Digit Bump

.org 0x2188BE4
mov r2, 260 //Fix X Position of MP Points Bar Icon Bump

.org 0x218A25C
bl fix_menu_sprites //Fix Gallery Menu Button Sprites

.close

.open "overlay/overlay_0102.bin", 0x217BB40 //Credits Scene Overlay

.org 0x217BC38
bl bg_force_width_512_left //Extend Credits BG

.org 0x217CD14
mov r10, 60 //Fix Movement Range of Star During Star Movement

.org 0x217CD98
mov r6, 8 //Fix Start X Position of Star

.org 0x217CDC4
mov r1, 8 //Fix X Position of Star During Left Vertical Movement

.org 0x217CE78
mov r6, 8 //Fix X Position of Star During Left Vertical Movement

.org 0x217CF3C
mov r2, 120 //Fix Movement Range of Star from Left to Right

.org 0x217CFB0
mov r6, 248 //Fix X Position of Star During Right Vertical Movement

.org 0x217D000
mov r6, 248 //Fix X Position of Star During Right Vertical Movement

.org 0x217D0C0
mov r2, 120 //Fix Movement Range of Star from Right to Left

.org 0x217D134
mov r6, 8 //Fix X Position of Star During Left Vertical Movement

.close

.open "overlay/overlay_0103.bin", 0x217BB40 //Mario Party Points Scene Overlay

.org 0x217BC78
bl bg_force_wrap //Force Mario Party Points Top Screen Background Wrap

.org 0x217BCDC
bl bg_force_wrap //Force Mario Party Points Bottom Screen Background Wrap

.org 0x217BD20
mov r1, 4 //Move Mario Party Points Bar Background Address

.org 0x217BD38
bl bg_force_width_512 //Extend Mario Party Points Bar Background to 512

.org 0x217C768
mov r0, 260 //Fix X Position of MP Points Icon

.org 0x217C914
mov r0, 216 //Fix X Position of MP Points Bar

.org 0x217D3BC
bl fix_mpp_sprites_touch //Fix Touching Mario Party Points Sprites

.org 0x217D08C
bl fix_mpp_sprites //Fix Mario Party Points Sprites

.org 0x2180908
mov r2, 40 //Move Mario Party Points Bar Background

.org 0x2180CF4
mov r2, 40 //Move Mario Party Points Bar Background

.org 0x21817D0
.dh 200 //Fix X Position of MP Points Digit 1

.org 0x21817D4
.dh 208 //Fix X Position of MP Points Digit 2

.org 0x21817D8
.dh 216 //Fix X Position of MP Points Digit 3

.org 0x21817DC
.dh 224 //Fix X Position of MP Points Digit 4

.org 0x21817E0
.dh 232 //Fix X Position of MP Points Digit 5

.close

.open "overlay/overlay_0104.bin", 0x217BB40 //Mic Test Scene Overlay

.org 0x217C170
mvn r1, 0x7 //Fix X Position of Back Button on Mic Test

.org 0x217C44C
cmp r0, 24 //Fix Maximum X Position of Back Button Hitbox for Mic Test
bge 0x217C498

.org 0x217BE54
bl bg_force_wrap //Enable Wrapping for Mic Test Background

.close

.open "overlay/overlay_0105.bin", 0x217BB40 //Story Cutscenes Scene Overlay

.org 0x217C4BC
bl bg_force_wrap //Force Wrap Top-Screen Background of Walking Story

.org 0x217DDF8
sub r2, r0, 0x3C000 //Fix Playe Start Offset in Walking Story

.org 0x217F024
mov r1, 168 //Fix X Position of The End Text

.close

