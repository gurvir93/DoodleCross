	processor 6502
; ======================
; | KERNAL SUBROUTINES |
; ======================
SCNKEY		.equ   	$FF9F	; Address for kernal routine SCNKEY
CHROUT		.equ	$FFD2	; Address for kernal routine CHROUT
GETIN 		.equ   	$FFE4	; Address for kernal routine GETIN
PLOT		.equ	$FFF0	; Address for kernal routine PLOT
RDTIM		.equ	$FFDE	; Memory address for read system time - uses a, x, y
SETTIM		.equ	$FFDB	; Memory address for setting system time - uses a, x, y

; ====================
; | SYSTEM VARIABLES |
; ====================
CLEAR		.equ	$93		; CHR$ code for clear screen
RASTER		.equ	$9004	; Current raster count -- used to generate random number
DDRA		.equ	$9113	; Data direction register for port A
OUTPUTRA 	.equ	$9111	; Output register A
DDRB		.equ	$9122	; Data direction register for port B
OUTPUTRB 	.equ	$9120	; Output register B
JIFFYCLOCK	.equ	$00A2	; Memory address for the lowest byte in the jiffy clock (1/60th of a second)
WHITE		.equ	$01
RED			.equ	$02
GREEN		.equ	$05

; ==============
; | MEMORY MAP |
; ==============
; --- User Variables ---
COUNTER		.equ	$1D50
XSTORAGE	.equ	$1D51
YSTORAGE	.equ	$1D52
ASTORAGE	.equ	$1D53
TIME 		.equ	$1D54
NUMOFLIVES	.equ	$1D55
LIVESXCOORD	.equ	$1D56
GAMECOUNTER .equ	$1D57
GAMESPEED	.equ	$1D58
DELAYTIME	.equ	$1D59
STARTGAME	.equ	$1D5A

MAXSCREENX  .equ	#21
MAXSCREENY	.equ	#22
ZERO		.equ	$30		; CHR$ code for 0
CIRCLE		.equ	$51		; CHR$ code for circle
SPACE		.equ	$20		; CHR$ code for space
ONE			.equ	$31
TWO			.equ	$32

ENEMYSYM	.equ	$66		; Weird square
POINTSYM	.equ	$5A		; Diamond
POWERUPSYM	.equ	$41		; Spade
POWERDNSYM	.equ	$56		; X
LIFESYM		.equ	$53		; Heart

INITLIVES	.equ	#3		; starting number of lives
LIVESX		.equ	#0
LIVESY		.equ	#0
MAXLIVES	.equ	#6		; position to plot first life//max number of lives

SCOREX		.equ	#13
SCOREY		.equ	#0
SCOREHUNDX	.equ	#19
SCORETENSX	.equ	#20
STOREONESX	.equ	#21

DIRUP		.equ	#1
DIRRIGHT	.equ	#2
DIRDOWN		.equ	#3
DIRLEFT		.equ	#4
; ----------------------

; --- Array of Objects ---
SCOREHUND	.equ	$1D00
SCORETENS	.equ	$1D01
SCOREONES	.equ	$1D02

PLAYERSYM	.equ	$1D03
PLAYERX		.equ	$1D04
PLAYERY		.equ	$1D05
PLAYERASSET	.equ	$1D06

ITEM1SYM	.equ	$1D07
ITEM1X		.equ	$1D08
ITEM1Y		.equ	$1D09
ITEM1DIR	.equ	$1D0A

ITEM2SYM	.equ	$1D0B
ITEM2X		.equ	$1D0C
ITEM2Y		.equ	$1D0D
ITEM2DIR	.equ	$1D0E

ITEM3SYM	.equ	$1D0F
ITEM3X		.equ	$1D10
ITEM3Y		.equ	$1D11
ITEM3DIR	.equ	$1D12

ITEM4SYM	.equ	$1D13
ITEM4X		.equ	$1D14
ITEM4Y		.equ	$1D15
ITEM4DIR	.equ	$1D16

ITEM5SYM	.equ	$1D17
ITEM5X		.equ	$1D18
ITEM5Y		.equ	$1D19
ITEM5DIR	.equ	$1D1A

ITEM6SYM	.equ	$1D1B
ITEM6X		.equ	$1D1C
ITEM6Y		.equ	$1D1D
ITEM6DIR	.equ	$1D1E

ITEM7SYM	.equ	$1D1F
ITEM7X		.equ	$1D20
ITEM7Y		.equ	$1D21
ITEM7DIR	.equ	$1D22

ITEM8SYM	.equ	$1D23
ITEM8X		.equ	$1D24
ITEM8Y		.equ	$1D25
ITEM8DIR	.equ	$1D26

ITEM9SYM	.equ	$1D27
ITEM9X		.equ	$1D28
ITEM9Y		.equ	$1D29
ITEM9DIR	.equ	$1D2A

ITEM10SYM	.equ	$1D2B
ITEM10X		.equ	$1D2C
ITEM10Y		.equ	$1D2D
ITEM10DIR	.equ	$1D2E

ITEM11SYM	.equ	$1D2F
ITEM11X		.equ	$1D30
ITEM11Y		.equ	$1D31
ITEM11DIR	.equ	$1D32

ITEM12SYM	.equ	$1D33
ITEM12X		.equ	$1D34
ITEM12Y		.equ	$1D35
ITEM12DIR	.equ	$1D36

ITEM13SYM	.equ	$1D37
ITEM13X		.equ	$1D38
ITEM13Y		.equ	$1D39
ITEM13DIR	.equ	$1D3A

ITEM14SYM	.equ	$1D3B
ITEM14X		.equ	$1D3C
ITEM14Y		.equ	$1D3D
ITEM14DIR	.equ	$1D3E

ITEM15SYM	.equ	$1D3F
ITEM15X		.equ	$1D40
ITEM15Y		.equ	$1D41
ITEM15DIR	.equ	$1D42
; ------------------------

main: 
	.org   $1001	; Memory address 4097
	.byte $0c		; Start
	.byte $10
	.byte $10
	.byte $0a
	.byte $9e		; SYS
	.byte $20		; ' '
	.byte $34		; 4 
	.byte $31 		; 1
	.byte $31		; 1
	.byte $30 		; 0
	.byte $00		; '\n'
	.byte $00		; End of program
	.byte $00

; Start of Items is $1D00
; Each item is 3 bytes
;	1 - Ascii Character
;	2 - X coordinate
;	3 - Y coordinate
; ------------------
;  || Memory Map ||
; ------------------
; Score (5 bytes)
;	$1D00 - Hundreds
;	$1D01 - Tens
; 	$1D02 - Ones
; Player (3 bytes)
;	$1D03 - Ascii value (Circle: $51)
;	$1D04 - X coordinate
;	$1D05 - Y coordinate
;	$1D06 - Extra player value
; Item1 (3 bytes)
;	$1D07 - Ascii value
;	$1D08 - X coordinate
;	$1D09 - Y coordinate
;	$1D0A - Item 1 direction
; Item2 (3 bytes)
;	$1D0B - Ascii value
;	$1D0C - X coordinate
;	$1D0D - Y coordinate
;	$1D0E - Item 2 direction
; Item3 (3 bytes)
;	$1D0F - Ascii value
;	$1D10 - X coordinate
;	$1D11 - Y coordinate
;	$1D12 - Item 3 direction
; Item4 (3 bytes)
;	$1D13 - Ascii value
;	$1D14 - X coordinate
;	$1D15 - Y coordinate
;	$1D16 - Item 4 direction
; Item5 (3 bytes)
;	$1D17 - Ascii value
;	$1D18 - X coordinate
;	$1D19 - Y coordinate
;	$1D1A - Item 5 direction
; Item6 (3 bytes)
;	$1D1B - Ascii value
;	$1D1C - X coordinate
;	$1D1D - Y coordinate
;	$1D1E - Item 6 direction
; Item7 (3 bytes)
;	$1D1F - Ascii value
;	$1D20 - X coordinate
;	$1D21 - Y coordinate
;	$1D22 - Item 7 direction
; Item8 (3 bytes)
;	$1D23 - Ascii value
;	$1D24 - X coordinate
;	$1D25 - Y coordinate
;	$1D26 - Item 8 direction
; Item9 (3 bytes)
;	$1D27 - Ascii value
;	$1D28 - X coordinate
;	$1D29 - Y coordinate
;	$1D2A - Item 9 direction
; Item10 (3 bytes)
;	$1D2B - Ascii value
;	$1D2C - X coordinate
;	$1D2D - Y coordinate
;	$1D2E - Item 10 direction
; Item11 (3 bytes)
;	$1D2F - Ascii value
;	$1D30 - X coordinate
;	$1D31 - Y coordinate
;	$1D32 - Item 11 direction
; Item12 (3 bytes)
;	$1D33 - Ascii value
;	$1D34 - X coordinate
;	$1D35 - Y coordinate
;	$1D36 - Item 12 direction
; Item13 (3 bytes)
;	$1D37 - Ascii value
;	$1D38 - X coordinate
;	$1D39 - Y coordinate
;	$1D3A - Item 13 direction
; Item14 (3 bytes)
;	$1D3B - Ascii value
;	$1D3C - X coordinate
;	$1D3D - Y coordinate
;	$1D3E - Item 14 direction
; Item15 (3 bytes)
;	$1D3F - Ascii value
;	$1D40 - X coordinate
;	$1D41 - Y coordinate
;	$1D42 - Item 15 direction

startInitialization:
	LDA		#8				; POKE 36879,8
	STA		$900F
	LDX		#0
	LDA		#0
	
initializeLives:
	LDA		#INITLIVES
	STA		NUMOFLIVES
	LDA		#MAXLIVES
	STA		LIVESXCOORD
	LDA		#0
	STA		COUNTER
	
initializeArray:
	STA		SCOREHUND,x		; First item in array offset by x
	INX
	CPX		#$42			; Compare with hex 32 (size of array)
	BNE		initializeArray

setArrayAttributes:
	LDA		#3
	STA		DELAYTIME
	LDA		#CIRCLE
	STA		PLAYERSYM
	LDA		#11				; Middle of screen
	STA		PLAYERX
	STA		PLAYERY

;	LDA		#POINTSYM
;	STA		ITEM1SYM
;	LDA		#3
;	STA		ITEM1X
;	STA		ITEM1Y
;	LDA		#DIRDOWN
;	STA		ITEM1DIR

;	LDA		#ENEMYSYM
;	STA		ITEM8SYM
;	LDA		#6
;	STA		ITEM8X
;	STA		ITEM8Y
;	LDA		#DIRRIGHT
;	STA		ITEM8DIR
	
;	LDA		#LIFESYM
;	STA		ITEM15SYM
;	LDA		#0
;	STA		ITEM15X
;	LDA		#1
;	STA		ITEM15Y
;	LDA		#DIRRIGHT
;	STA		ITEM15DIR

;	LDA		#POINTSYM
;	STA		ITEM2SYM
;	LDA		#20
;	STA		ITEM2X
;	STA		ITEM2Y
;	LDA		#DIRLEFT
;	STA		ITEM2DIR

;	LDA		#POWERUPSYM
;	STA		ITEM3SYM
;	LDA		#15
;	STA		ITEM3X
;	STA		ITEM3Y
;	LDA		#DIRUP
;	STA		ITEM3DIR

;	LDA		#POWERDNSYM
;	STA		ITEM4SYM
;	LDA		#6
;	STA		ITEM4X
;	LDA		#21
;	STA		ITEM4Y
;	LDA		#DIRUP
;	STA		ITEM4DIR

; ======================= Main Menu/Splash Screen =======================
initSplashScreen:
	JSR		clearScreen
	LDA		#0
	STA		STARTGAME
splashMsg:
	LDX		#0
	LDY		#0
	CLC
	JSR		PLOT
	LDX		#0
splashMsgLoop:					; print welcome message
	LDA		welcome,x
	JSR		CHROUT
	INX
	CPX		#21
	BNE		splashMsgLoop
splashSelectMsg:
	LDX		#6
	LDY		#1
	CLC
	JSR		PLOT
	LDX		#0
selectMsgLoop:					; print selection message
	LDA		select,x
	JSR		CHROUT
	INX
	CPX		#19
	BNE		selectMsgLoop
splashOptionOne:
	LDX		#8
	LDY		#4
	CLC
	JSR		PLOT
	LDX		#0
optionOneLoop:					; print option 1 of selection
	LDA		optionOne,x
	JSR		CHROUT
	INX
	CPX		#13
	BNE		optionOneLoop
splashOptionTwo:
	LDX		#10
	LDY		#3
	CLC
	JSR		PLOT
	LDX		#0
optionTwoLoop:					; print option 2 of selection
	LDA		optionTwo,x
	JSR		CHROUT
	INX
	CPX		#15
	BNE		optionTwoLoop
checkSelection:
	JSR		SCNKEY				; probe for keyboard input
	JSR		GETIN				; get character from keyboard
	CMP		#ONE
	BEQ		jumpToStart			; go to first selection - start game
	CMP		#TWO
	BEQ		instructionScreen	; go to second selection - display instructions
	LDX		STARTGAME
	CPX		#0
	BEQ		checkSelection		; loop until a valid selection
	
; ======================== End Main Menu/Splash Screen ========================
	
clearScreen:
	LDA		#CLEAR
	JSR		CHROUT
	RTS
	
; ============================ How To Play Screen ============================

instructionScreen:
	JSR		clearScreen
	LDX		#1
	LDY		#6
	CLC
	JSR		PLOT
	LDX		#0
instructionLoop:				; print user character
	LDA		player,x
	JSR		CHROUT
	INX
	CPX		#8
	BNE		instructionLoop
	LDA		#$71
	JSR		CHROUT
instructMsg:
	LDX		#3
	CLC
	LDY		#0
	JSR		PLOT
	LDX		#0
instructLoop:					; print player movement message
	LDA		instruct,x
	JSR		CHROUT
	INX
	CPX		#20
	BNE		instructLoop
	JMP		collectMsg
collectMsg:
	LDX		#5
	LDY		#4
	CLC
	JSR		PLOT
	LDX		#0	
collectLoop:					; print collect message
	LDA		collect,x
	JSR		CHROUT
	INX
	CPX		#8
	BNE		collectLoop
pointsMsg:
	LDX		#7
	LDY		#6
	CLC
	JSR		PLOT
	LDA		#$7A
	JSR		CHROUT
	LDY		#8
	CLC
	JSR		PLOT
	LDX		#0
pointsLoop:						; print points message
	LDA		points,x
	JSR		CHROUT
	INX
	CPX		#9
	BNE		pointsLoop
	JMP		powerupsMsg
	
jumpToStart:
	JMP		startGame

powerupsMsg:
	LDX		#9
	LDY		#6
	CLC
	JSR		PLOT
	LDA		#$61
	JSR		CHROUT
	LDY		#8
	CLC
	JSR		PLOT
	LDX		#0
powerupsLoop:					; print power-ups message
	LDA		powerups,x
	JSR		CHROUT
	INX
	CPX		#12
	BNE		powerupsLoop
extralifeMsg:
	LDX		#11
	LDY		#6
	CLC
	JSR		PLOT
	LDA		#$73
	JSR		CHROUT
	LDY		#8
	CLC
	JSR		PLOT
	LDX		#0
extralifeLoop:					; print extra life message
	LDA		extralife,x
	JSR		CHROUT
	INX
	CPX		#13
	BNE		extralifeLoop
avoidMsg:
	LDX		#13
	LDY		#4
	CLC
	JSR		PLOT
	LDX		#0	
avoidLoop:						; print avoid message
	LDA		avoid,x
	JSR		CHROUT
	INX
	CPX		#6
	BNE		avoidLoop
enemiesMsg:
	LDX		#15
	LDY		#6
	CLC
	JSR		PLOT
	LDA		#$A6
	JSR		CHROUT
	LDY		#8
	CLC
	JSR		PLOT
	LDX		#0
enemiesLoop:					; print enemies message
	LDA		enemies,x
	JSR		CHROUT
	INX
	CPX		#10
	BNE		enemiesLoop
powerdownsMsg:
	LDX		#17
	LDY		#6
	CLC
	JSR		PLOT
	LDA		#$76
	JSR		CHROUT
	LDY		#8
	CLC
	JSR		PLOT
	LDX		#0
powerdownsLoop:					; print power-downs message
	LDA		powerdowns,x
	JSR		CHROUT
	INX
	CPX		#14
	BNE		powerdownsLoop
returnMsg:
	LDX		#21
	LDY		#2
	CLC
	JSR		PLOT
	LDX		#0
returnLoop:						; print return to main menu message
	LDA		backToMenu,x
	JSR		CHROUT
	INX
	CPX		#16
	BNE		returnLoop
waitForInput:					; wait for key input
	JSR		SCNKEY
	JSR		GETIN
	BEQ		waitForInput
	JMP		initSplashScreen	; return to main menu/splash screen
	
; ======================== End How To Play Screen =========================	
startGame:
	JSR		clearScreen
startGameInstance:
	LDA		#0
	STA		GAMECOUNTER
	LDA		#3
	STA		GAMESPEED
	JSR		refreshScreenStart
; ============================= Main Game Loop =============================
gameLoop:
	LDA		GAMECOUNTER
	CMP		GAMESPEED
	BNE		gameLoopRefreshCont
	JSR		spawnItems
	JSR		moveItems
	LDA		#0
	STA		GAMECOUNTER
gameLoopRefreshCont:
	JSR		refreshScreen
gameLoopSkipRefresh:
	JSR		takeInput
	JMP		checkCollision
gameLoopContinue:
	INC		GAMECOUNTER
	JMP		gameLoop
	RTS
; ============================= End Game Loop =============================

; ============================= Start Input =============================
takeInput:
	LDA		#127
	STA 	DDRB
	CLC
	LDA 	#0
;loop:
	LDA 	OUTPUTRB
	ASL		
	LDX		#0
	BCC		moveRight
	CLC
notRight: 
	LDA 	#0
	STA 	DDRA
	LDA 	OUTPUTRA
	ASL						; Shift to 5th bit
	ASL
	ASL
	LDX		#0
	BCC 	doneInput
	ASL						; Shift to 4th bit
	LDX 	#0
	BCC 	moveLeft
	ASL						; Shift to 3rd bit
	BCC 	moveDown
	ASL						; Shift to 2nd bit
	BCS 	doneInput 		; If carry is not set
	LDX		#0
	JMP		moveUp			; Else print up
doneInput:
	RTS

moveRight:
	LDX		PLAYERX
	CPX		#MAXSCREENX
	BEQ		doneInput
	INC		PLAYERX
	JMP 	doneInput

moveLeft:
	LDX		PLAYERX
	CPX		#0
	BEQ		doneInput
	DEC		PLAYERX
	JMP 	doneInput

moveDown:
	LDX		PLAYERY
	CPX		#MAXSCREENY
	BEQ		doneInput
	INC		PLAYERY
	JMP 	doneInput

moveUp:
	LDX		PLAYERY
	CPX		#1
	BEQ		doneInput
	DEC		PLAYERY
	JMP 	doneInput

;---------------------------------------------------------------------------------
; Find Position
; Purpose: Takes in an X and Y, and returns the position on the screen to draw to
;	in $00 and $01 ($01 = MSB, $00 = LSB).
; Usage: Load X and Y values into X,Y registers such that 0>=X<=21, 0>=Y<=22
;	then store indirectly ascii/custom character set needed in that position.
;---------------------------------------------------------------------------------

findScreenPosition:
	LDA		#00
	STY		$03

initializeScreenPosition:
	STX		$00		
	LDA		#$1E	
	STA		$01
	LDY		#$00

addYLevels:
	CPY		$03
	BEQ		foundPosition
	INY
	LDX		#00
add22:		
	INC		$00
	INX
	LDA		$00
	CMP		#00					; Changed from 255: Wouldn't plot to 1EFF??
	BNE		dontAddCarry	
	INC		$01
dontAddCarry:
	CPX		#22
	BNE		add22
	JMP 	addYLevels
foundPosition:
	RTS
;------------------------------------------------------

plotPosition:
	LDY		#$00
	STA		($00),Y
	RTS
;---------------------------------------------------------------------------------
; Find Colour
; Purpose: Takes in an X and Y and returns the position on the screen to draw to
;	In $04 and $05 ($05 = MSB, $04 = LSB)
; Usage: Load X and Y values into X,Y registers such that 0>=X<=21 and 0>=Y<=22
;	and call findColourPosition, then load colour value into accumulator and call
;	plotColour subroutine.
;---------------------------------------------------------------------------------

findColourPosition:
;	LDA		#$AA
;	STA		$1D0F
	LDA		#00
	STA		$06
	STY		$07

initializeColourPosition:
	STX		$04		
	LDA		#$96	
	STA		$05
	LDY		#$00

addCYLevels:
	CPY		$07
	BEQ		foundCPosition
	INY
	LDX		#00
addC22:		
	INC		$04
	INX
	LDA		$04
	CMP		#00
	BNE		dontAddCCarry	
	INC		$05
dontAddCCarry:
	CPX		#22
	BNE		addC22
	JMP 	addCYLevels
foundCPosition:
	RTS

plotColour:
	LDY		#00
	STA		($04),Y
	RTS	

storeState:
	STX		XSTORAGE
	STY		YSTORAGE
	STA		ASTORAGE
	RTS

loadState:
	LDX		XSTORAGE
	LDY		YSTORAGE
	LDA		ASTORAGE
	RTS

; ============================= Move Items =============================
moveItems:
	LDY		#0
moveItemsLoop:
	LDX		ITEM1SYM,Y
	CPX		#0
	BEQ		notItem
	
	INY						; Move to item X-axis position
	INY						; Move to item Y-axis position
	INY						; Move to item direction position

	LDX		ITEM1SYM,Y

	CPX		#DIRUP
	BEQ		moveItemsUp

	CPX		#DIRRIGHT
	BEQ		moveItemsRight

	CPX		#DIRDOWN
	BEQ		moveItemsDown

	CPX		#DIRLEFT
	BEQ		moveItemsLeft

	JMP		moveItemsNext

moveItemsUp:
	DEY						; Move to item Y-axis position

	LDX		ITEM1SYM,Y		; Load current position
	CPX		#2
	BCC		offScreenY		; If y-axis position is < 1 position more than minimum screen
	
	DEX						; Increase position by 1
	TXA
	STA		ITEM1SYM,Y		; Store value back into memory

	JMP		moveItemsCheck

moveItemsRight:
	DEY						; Move to item Y-axis position
	DEY						; Move to item X-axis position

	LDX		ITEM1SYM,Y		; Load current position
	CPX		#MAXSCREENX	
	BCS		offScreenX		; If x-axis position is >= 1 position more than max screen x

	INX						; Increase position by 1
	TXA
	STA		ITEM1SYM,Y		; Store value back into memory

	INY						; Move to item Y-axis position
	JMP		moveItemsCheck

moveItemsDown:
	DEY						; Move to item Y-axis position

	LDX		ITEM1SYM,Y		; Load current position
	CPX		#MAXSCREENY	
	BCS		offScreenY		; If y-axis position is >= 1 position more than max screen x
	
	INX						; Increase position by 1
	TXA
	STA		ITEM1SYM,Y		; Store value back into memory

	JMP		moveItemsCheck
moveItemsLeft:
	DEY						; Move to item Y-axis position
	DEY						; Move to item X-axis position

	LDX		ITEM1SYM,Y		; Load current position
	CPX		#1	
	BCC		offScreenX		; If x-axis position is < 1 position more than minimum screen

	DEX						; Increase position by 1
	TXA
	STA		ITEM1SYM,Y		; Store value back into memory

	INY						; Move to item Y-axis position
	JMP		moveItemsCheck

offScreenX:
	DEY
	LDA		#0
	STA		ITEM1SYM,Y
	INY
	INY
	JMP		moveItemsCheck
offScreenY:
	DEY
	DEY
	LDA		#0
	STA		ITEM1SYM,Y
	INY
	INY
	JMP		moveItemsCheck

notItem:
	INY						; Move to item X-axis position
	INY						; Move to item Y-axis position
moveItemsCheck:
	INY						; Move to item direction position
moveItemsNext:
	INY						; Move to next item in array
	CPY		#$3C			; Check for end of array ((Item15DIR - Item1SYM) + 1 = 3C)
	BEQ		return1
	JMP		moveItemsLoop

return1:
	RTS
; ============================= End Move Items =============================

gameOver:
	LDA		#CLEAR
	JSR		CHROUT
	LDX		#10
	LDY		#6
	JSR		PLOT
	LDX		#0
printGameOver:
	LDA		gameovertext,x			; Load specific byte x into accumulator
	JSR		CHROUT  			; Jump to character out subroutine
	INX							; Increment x
	CPX		#10					; Compare x with the total length of string going to be outputted
	BNE		printGameOver		; If not equal, branch to loop

	LDA		#255
	STA		DELAYTIME
	JSR		delay
	JSR		clearScreen

	JMP		startInitialization

; ============================= Start Collision Detection =============================
checkCollision:
	LDY		#0

checkCollisionLoop:
	LDA		ITEM1SYM,Y
	CMP		#0
	BEQ		noCollision0

	INY						; Move to item X-axis position

	LDA		ITEM1SYM,Y
	CMP		PLAYERX
	BNE		noCollision1

	INY						; Move to item Y-axis position

	LDA		ITEM1SYM,Y
	CMP		PLAYERY
	BNE		noCollision2

collisionDetected:
	DEY						; Move to item X-axis position
	DEY						; Move to item symbol position

	LDX		ITEM1SYM,Y

	LDA		#0
	STA		ITEM1SYM,Y		; Reset symbol

	CPX		#POINTSYM
	BEQ		collisionPoint

	CPX		#ENEMYSYM
	BEQ		collisionEnemy

	CPX		#POWERUPSYM
	BEQ		collisionPowerUp

	CPX		#POWERDNSYM
	BEQ		collisionPowerDown

	CPX		#LIFESYM
	BEQ		collsionLife

	JMP		gameLoopSkipRefresh

collisionPoint:
	JSR		incScore
	JMP		endCollisionDetection
collisionEnemy:
	DEC		NUMOFLIVES
	; Check for Game Over
	LDA		NUMOFLIVES
	CMP		#0
	BEQ		gameOver

	JMP		endCollisionDetection
collisionPowerUp:
	JSR		powerUp
	JMP		endCollisionDetection
collisionPowerDown:
	JSR		powerDown
	JMP		endCollisionDetection
collsionLife:
	LDA		NUMOFLIVES
	CMP		#MAXLIVES
	BEQ		endCollisionDetection
	INC		NUMOFLIVES

endCollisionDetection:
	JSR		refreshScreenScore
	JMP		gameLoopSkipRefresh

noCollision0:
	INY						; Move to item X-axis position
noCollision1:
	INY						; Move to item Y-axis position
noCollision2:
	INY						; Move to item symbol position
	INY						; Move to next item in array

	CPY		#$3C			; Check for end of array ((Item15DIR - Item1SYM) + 1 = 3C)
	BNE		checkCollisionLoop
	JMP		gameLoopContinue
; ============================= End Collision Detection =============================

; ============================= Item Power Up/Down's =============================
powerUp:
	JSR		randomizer
	JSR		modBy4
	CMP		#0
	BEQ		allPoints
	JMP		decreaseSpeed
afterPowerUp:
	RTS

powerDown:
	JSR		randomizer
	JSR		modBy4
	CMP		#0
	BEQ		allEnemys
	JMP		increaseSpeed
afterPowerDown:	
	RTS

decreaseSpeed:
	LDX		GAMESPEED
	CMP		#4
	BCS		afterPowerDown
	INC		GAMESPEED

	JMP		afterPowerDown

increaseSpeed:
	LDX		GAMESPEED
	CPX		#2
	BCC		afterPowerUp
	DEC		GAMESPEED

	LDX		#0
	STX		GAMECOUNTER			; Safety, ensure gamespeed compare is not missed

	JMP 	afterPowerUp

allPoints:
	LDX		#0
	LDA		#POINTSYM
allPointsLoop:
	STA		ITEM1SYM,X
	CPX		#$38
	BEQ		afterPowerUp
	INX
	INX
	INX
	INX
	JMP		allPointsLoop

allEnemys:
	LDX		#0
	LDA		#ENEMYSYM
allEnemysLoop:
	STA		ITEM1SYM,X
	CPX		#$38
	BEQ		afterPowerDown
	INX
	INX
	INX
	INX
	JMP		allEnemysLoop

; ============================= End Item Power Up/Down's =============================

; ============================= Start Random Generator =============================
randomizer:
	LDA		$0
	CLC
	ADC		.seed			; Add seed value to accumulator
	ADC		RASTER			; Add current raster count to accumulator
	STA		.seed			; Update seed value with new random number
	RTS
; ============================= End Random Generator =============================

;----------------------------------------------
; Screen refresh subroutine - uses A, X, and Y
;----------------------------------------------
refreshScreenStart:
	JSR		printLivesText
	JSR		printScoreText
refreshScreenScore:
	JSR		plotCurrentLives
	JSR		plotCurrentScore

refreshScreen:
	JSR		clearPlayField
	JSR		plotItem
	;JSR		delay

	RTS

printLivesText:
	LDX		#LIVESY				; Y AXIS VALUE
	LDY		#LIVESX				; X AXIS VALUE
	CLC							; Set carry bit - needed to call kernal routine PLOT
	JSR		PLOT
	LDX		#0

printLivesTextLoop:
	LDA		lives,x				; Load specific byte x into accumulator
	JSR		CHROUT  			; Jump to character out subroutine
	INX							; Increment x
	CPX		#6					; Compare x with the length of string going to be outputted
	BNE		printLivesTextLoop	; If not equal, branch to loop
	RTS
	

plotCurrentLives:
	LDA		#0
	STA		COUNTER				; Clear counter
plotLives:
	LDX		COUNTER				; Load counter of lives
	CPX		NUMOFLIVES			; Compare to number of lives
	BEQ		plotSpaces			; Branch to endPrintCurrLives if the counter = number of lives
	LDX		#LIVESY				; Load y coordinate for lives
	LDY		LIVESXCOORD			; Load x coordinate for lives
	CLC		
	JSR		PLOT				; Move cursor
	LDA		#$73				; Load character for heart
	JSR		CHROUT				; Plot heart
	LDX		COUNTER
	INX							; Increment counter
	STX		COUNTER				; Update counter
	INY							; Increment X Coordinate for printing lives
	STY		LIVESXCOORD			; Update x coordinate for printing lives
	JMP		plotLives
plotSpaces:
	LDX		COUNTER
	CPX		#MAXLIVES
	BEQ		endPlotCurrLives
	LDX		#LIVESY
	LDY		LIVESXCOORD
	CLC
	JSR		PLOT
	LDA		#SPACE
	JSR		CHROUT
	LDX		COUNTER
	INX
	STX		COUNTER
	INY
	STY		LIVESXCOORD
	JMP		plotSpaces
endPlotCurrLives:
	LDA		#0
	STA		COUNTER				; Clear counter
	LDX		#MAXLIVES
	STX		LIVESXCOORD			; Reset x coordinate of lives to the initial printing point
	LDX		#0
	RTS
	
printScoreText:
	LDX		#SCOREY				; Y AXIS VALUE
	LDY		#SCOREX				; X AXIS VALUE
	CLC							; Set carry bit - needed to call kernal routine PLOT
	JSR		PLOT
	LDX		#0

printScoreTextLoop:
	LDA		score,x				; Load specific byte x into accumulator
	JSR		CHROUT  			; Jump to character out subroutine
	INX							; Increment x
	CPX		#6					; Compare x with the total length of string going to be outputted
	BNE		printScoreTextLoop	; If not equal, branch to loop

	RTS

plotCurrentScore:
	LDX		#SCOREY
	LDY		#SCOREHUNDX
	CLC
	JSR		PLOT

	LDA		SCOREHUND
	CLC
	ADC		#ZERO
	JSR		CHROUT

	LDA		SCORETENS
	CLC
	ADC		#ZERO
	JSR		CHROUT

	CLC
	LDA		SCOREONES
	ADC		#ZERO
	JSR		CHROUT

	RTS


plotItem:
	LDX		#0
	STX		COUNTER				; First position in array

plotItemLoop:
	INC		COUNTER				; Move to item X-axis position

	LDY		COUNTER
	LDX		PLAYERSYM,Y
	INC		COUNTER				; Move to item Y-axis position
	TXA
	LDX		COUNTER
	LDY		PLAYERSYM,X
	TAX
	JSR		findScreenPosition

	DEC		COUNTER				; Move to item X-axis position

	LDY		COUNTER
	LDX		PLAYERSYM,Y
	INC		COUNTER				; Move to item Y-axis position
	TXA
	LDX		COUNTER
	LDY		PLAYERSYM,X
	TAX
	JSR		findColourPosition

	DEC		COUNTER				; Move to item X-axis position
	DEC		COUNTER				; Move to item symbol position
	LDX		COUNTER
	LDA		PLAYERSYM,X
	CMP		#00
	BEQ		dontPlot
	CMP		#CIRCLE				; Check PLAYERSYM for what colour to set
	BNE		checkForPoint
	LDA		#WHITE
	JSR		plotColour
	JMP		plotAtPosition
checkForPoint:
	LDX		COUNTER
	LDA		PLAYERSYM,X
	CMP		#POINTSYM
	BNE		colourEnemy
	LDA		#GREEN
	JSR		plotColour
	JMP		plotAtPosition
colourEnemy:
	LDA		#RED
	JSR		plotColour	
plotAtPosition:
	LDX		COUNTER
	LDA		PLAYERSYM,X			; First item in array offset by X
	CMP		#0
	BEQ		dontPlot
	JSR		plotPosition
dontPlot:
	INC		COUNTER				; Move to item X-axis position
	INC		COUNTER				; Move to item Y-axis position
	INC		COUNTER				; Move to item direction position
	INC		COUNTER				; Move to next item in array

	LDX		COUNTER	
	CPX		#$40				; Compare with hex 40 (size of array - score)
	BEQ		return
	JMP		plotItemLoop
	RTS

; ============================= Incrementing Score =============================
; 	Uses - x |
; ------------
incScore:
	LDX		SCOREONES
	CPX		#9
	BEQ		incScoreTens
	INX
	STX		SCOREONES
return:
	RTS

incScoreTens:
	LDX		SCORETENS
	CPX		#9
	BEQ		incScoreHunds

	INX
	STX		SCORETENS
	LDX		#0
	STX		SCOREONES
	RTS

incScoreHunds:
	LDX		SCOREHUND
	CPX		#9
	BEQ		return

	INX
	STX		SCOREHUND
	LDX		#0
	STX		SCORETENS
	STX		SCOREONES
	RTS
; ============================= END Incrementing Score =============================

;ITEM STRUCTURE:
;	SYMBOL
;	X
;	Y
;	DIRECTION: 1 - UP
;			   2 - RIGHT
;			   3 - DOWN
;			   4 - LEFT

spawnItems:
	LDA		#0
	STA		COUNTER
spawnItemsLoop:
	LDX		COUNTER
	LDA		ITEM1SYM,X
	CMP		#0				;CHECK IF ITEM IS ALREADY SPAWNED
	BEQ		randomizeItem
	JMP		spawnNextItem
randomizeItem:
	JSR		randomizer
	JSR		modBy4
	TAY
	CPY		#1
	BNE		dontSpawnPoint
	LDA		#POINTSYM			;ADD IMPLEMENTATION FOR DIFFERENT ITEMS
	STA		ITEM1SYM,X
	JMP		randomizeDirection
dontSpawnPoint:
	CPY		#2
	BNE		dontSpawnEnemy

	LDA		#ENEMYSYM
	STA		ITEM1SYM,X
	JMP		randomizeDirection
dontSpawnEnemy:
	CPY		#3
	BNE		dontSpawnPowerUp
	LDA		#POWERUPSYM
	STA		ITEM1SYM,X
	JMP		randomizeDirection
dontSpawnPowerUp:
	LDA		#POWERDNSYM
	STA		ITEM1SYM,X
randomizeDirection:

	JSR		randomizer
	JSR		modBy4
	TAY
	INY						;INCREASE NUMBER SO RANDOM NUMBER IS
	TYA						;	INBETWEEN 1 - 4
	INX						;MOVE X TO DIRECTION POSITION OF ITEM
	INX
	INX
	STA		ITEM1SYM,X
	CMP		#DIRUP
	BNE		checkDirRight
	DEX						;MOVE TO YPOSITION OF ITEM

	LDA		#MAXSCREENY		;UP MOVING ITEM SPAWNS AT BOTTOM
	STA		ITEM1SYM,X
	DEX						;MOVE TO XPOSITION OF ITEM
	JSR		randomizer
	JSR		modBy22
	STA		ITEM1SYM,X
	JMP		spawnNextItem
checkDirRight:
	CMP		#DIRRIGHT
	BNE		checkDirDown
	DEX						;MOVE TO YPOSITION OF ITEM
	JSR		randomizer
	JSR		modBy22
	TAY
	INY
	TYA
	STA		ITEM1SYM,X
	DEX						;MOVE TO XPOSITION
	LDA		#0
	STA		ITEM1SYM,X
	JMP		spawnNextItem
checkDirDown:
	CMP		#DIRDOWN
	BNE		checkDirLeft
	
	DEX						;MOVE TO YPOSITION
	LDA		#1
	STA		ITEM1SYM,X
	
	DEX						;MOVE TO XPOSITION
	JSR		randomizer		;GENERATE RANDOM X POSITION
	JSR		modBy22
	STA		ITEM1SYM,X
	JMP		spawnNextItem
checkDirLeft:
	DEX						;MOVE TO YPOSITION
	JSR		randomizer
	JSR		modBy22
	TAY						;INCREMENT POSITION SO DOESNT SPAWN
	INY						;	AT TOP OF SCREEN
	TYA
	STA		ITEM1SYM,X
	DEX						;MOVE TO XPOSITION
	LDA		#MAXSCREENX
	STA		ITEM1SYM,X
spawnNextItem:
	INC		COUNTER			;AT ITEMSYM, MOVE TO ITEMX
	INC		COUNTER			;AT ITEMX, MOVE TO ITEMY
	INC		COUNTER			;AT ITEMY, MOVE TO ITEMDIR
	INC		COUNTER			;AT	ITEMDIR, MOVE TO NEXT ITEM

	LDX		COUNTER
	CPX		#60
	BEQ		doneSpawning
	JMP		spawnItemsLoop
doneSpawning:
	RTS

	;-------------------------------------------------------------------------------
	;MOD BY 3
	;PURPOSE: FINDS THE REMAINDER OF A NUMBER DIVIDED BY 3
	;USAGE: LDA	#<NUMBER>
	;		JSR	modBy4
modBy4:
divideBy4:
	SEC
	SBC		#4
	BCS		divideBy4
findRemainder4:
	CLC
	ADC		#4
;	STA		$1D00
	RTS
	;-------------------------------------------------------------------------------
	;MOD BY 22
	;PURPOSE: FINDS THE REMAINDER OF A NUMBER DIVIDED BY 22
	;USAGE: LDA	#<NUMBER>
	;		JSR	modBy22
modBy22:
divideBy22:
	SEC
	SBC		#22
	BCS		divideBy22
findRemainder22:
	CLC
	ADC		#22
;	STA		$1D00
	RTS

;-------------------------------------------------------------------------------
; Find Playfield
; Purpose: Clears the game playfield (everything underneath score and lives)
; Usage: JSR clearPlayField
;--------------------------------------------------------------------------------

clearPlayField:
	LDX		#00
;	CLC
clearLoop1:
	LDA		#SPACE
	STA		$1E16,X
	INX
	CPX		#255
	BNE		clearLoop1
;	BCC		clearLoop1
	LDX		#00
clearLoop2:
	LDA		#SPACE
	STA		$1F15,X
	INX
	CPX		#229
	BNE		clearLoop2
	RTS

delay:
	LDX		#0
	STX		JIFFYCLOCK
waitLoop:
	LDX		JIFFYCLOCK
    CPX 	DELAYTIME
    BNE		waitLoop
    RTS
	

; ============================= STRINGS =============================
backToMenu:
	.byte	"PRESS ANY BUTTON"			;16
player:
	.byte	"YOU ARE: "					;8
instruct:
	.byte	"USE JOYSTICK TO MOVE"		;20
collect:
	.byte	"COLLECT:"					;8
points:
	.byte	" - POINTS"					;9
powerups:
	.byte	" - POWER-UPS"				;12	
extralife
	.byte	" - EXTRA LIFE"				;13
avoid:
	.byte	"AVOID:"					;6
enemies:
	.byte	" - ENEMIES"				;10
powerdowns:
	.byte	" - POWER-DOWNS"			;14
optionOne:
	.byte	"1 - PLAY GAME"				;13
optionTwo:
	.byte	"2 - HOW TO PLAY"			;15
select:
	.byte	"SELECT AN ACTION..."		;19
welcome:
	.byte	"WELCOME 2 DOODLECROSS"		;21
lives:
	.byte	"LIVES:"					;6
score:
	.byte	"SCORE:"					;6
gameovertext:
	.byte	"GAME OVER!"				;10

.seed        
	DC.B	$33				; Initial seed value -- new values also stored in same location