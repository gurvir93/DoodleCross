	processor 6502
; ======================
; | KERNAL SUBROUTINES |
; ======================
CHROUT		.equ	$FFD2	; Address for kernal routine CHROUT
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
ENEMYSYM	.equ	$1D50
POINTSYM	.equ	$1D51
COUNTER		.equ	$1D52
XSTORAGE	.equ	$1D53
YSTORAGE	.equ	$1D54
ASTORAGE	.equ	$1D55
TIME 		.equ	$1D56


MAXSCREENX  .equ	#21
MAXSCREENY	.equ	#22
ZERO		.equ	$30		; CHR$ code for 0
CIRCLE		.equ	$51		; CHR$ code for circle
HEART		.equ	$53


SCOREX		.equ	#13
SCOREY		.equ	#0
SCOREHUNDX	.equ	#19
SCORETENSX	.equ	#20
STOREONESX	.equ	#21
; ----------------------

; --- Array of Objects ---
SCOREHUND	.equ	$1D00
SCORETENS	.equ	$1D01
SCOREONES	.equ	$1D02

PLAYERSYM	.equ	$1D03
PLAYERX		.equ	$1D04
PLAYERY		.equ	$1D05

ITEM1SYM	.equ	$1D06
ITEM1X		.equ	$1D07
ITEM1Y		.equ	$1D08

ITEM2SYM	.equ	$1D09
ITEM2X		.equ	$1D0A
ITEM2Y		.equ	$1D0B

ITEM3SYM	.equ	$1D0C
ITEM3X		.equ	$1D0D
ITEM3Y		.equ	$1D0E

ITEM4SYM	.equ	$1D0F
ITEM4X		.equ	$1D10
ITEM4Y		.equ	$1D11

ITEM5SYM	.equ	$1D12
ITEM5X		.equ	$1D13
ITEM5Y		.equ	$1D14

ITEM6SYM	.equ	$1D15
ITEM6X		.equ	$1D16
ITEM6Y		.equ	$1D17

ITEM7SYM	.equ	$1D18
ITEM7X		.equ	$1D19
ITEM7Y		.equ	$1D1A

ITEM8SYM	.equ	$1D1B
ITEM8X		.equ	$1D1C
ITEM8Y		.equ	$1D1D

ITEM9SYM	.equ	$1D1E
ITEM9X		.equ	$1D1F
ITEM9Y		.equ	$1D20

ITEM10SYM	.equ	$1D21
ITEM10X		.equ	$1D22
ITEM10Y		.equ	$1D23

ITEM11SYM	.equ	$1D24
ITEM11X		.equ	$1D25
ITEM11Y		.equ	$1D26

ITEM12SYM	.equ	$1D27
ITEM12X		.equ	$1D28
ITEM12Y		.equ	$1D29

ITEM13SYM	.equ	$1D2A
ITEM13X		.equ	$1D2B
ITEM13Y		.equ	$1D2C

ITEM14SYM	.equ	$1D2D
ITEM14X		.equ	$1D2E
ITEM14Y		.equ	$1D2F

ITEM15SYM	.equ	$1D30
ITEM15X		.equ	$1D31
ITEM15Y		.equ	$1D32
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
; Item1 (3 bytes)
;	$1D06 - Ascii value
;	$1D07 - X coordinate
;	$1D08 - Y coordinate
; Item2 (3 bytes)
;	$1D09 - Ascii value
;	$1D0A - X coordinate
;	$1D0B - Y coordinate
; Item3 (3 bytes)
;	$1D0C - Ascii value
;	$1D0D - X coordinate
;	$1D0E - Y coordinate
; Item4 (3 bytes)
;	$1D0F - Ascii value
;	$1D10 - X coordinate
;	$1D11 - Y coordinate
; Item5 (3 bytes)
;	$1D12 - Ascii value
;	$1D13 - X coordinate
;	$1D14 - Y coordinate
; Item6 (3 bytes)
;	$1D15 - Ascii value
;	$1D16 - X coordinate
;	$1D17 - Y coordinate
; Item7 (3 bytes)
;	$1D18 - Ascii value
;	$1D19 - X coordinate
;	$1D1A - Y coordinate
; Item8 (3 bytes)
;	$1D1B - Ascii value
;	$1D1C - X coordinate
;	$1D1D - Y coordinate
; Item9 (3 bytes)
;	$1D1E - Ascii value
;	$1D1F - X coordinate
;	$1D20 - Y coordinate
; Item10 (3 bytes)
;	$1D21 - Ascii value
;	$1D22 - X coordinate
;	$1D23 - Y coordinate
; Item11 (3 bytes)
;	$1D24 - Ascii value
;	$1D25 - X coordinate
;	$1D26 - Y coordinate
; Item12 (3 bytes)
;	$1D27 - Ascii value
;	$1D28 - X coordinate
;	$1D29 - Y coordinate
; Item13 (3 bytes)
;	$1D2A - Ascii value
;	$1D2B - X coordinate
;	$1D2C - Y coordinate
; Item14 (3 bytes)
;	$1D2D - Ascii value
;	$1D2E - X coordinate
;	$1D2F - Y coordinate
; Item15 (3 bytes)
;	$1D30 - Ascii value
;	$1D31 - X coordinate
;	$1D32 - Y coordinate

; 


startGame:
	LDA		#8				; POKE 36879,8
	STA		$900F

	LDX		#0
	LDA		#0

initializeArray:
	STA		SCOREHUND,x		; First item in array offset by x
	INX
	CPX		#$32			; Compare with hex 32 (size of array)
	BNE		initializeArray

setArrayAttributes:
	LDA		#CIRCLE
	STA		PLAYERSYM
	LDA		#11				; Middle of screen
	STA		PLAYERX
	STA		PLAYERY

	LDA		#HEART
	STA		ITEM1SYM
	LDA		#3
	STA		ITEM1X
	STA		ITEM1Y

clearScreen:
	LDA		#CLEAR
	JSR		CHROUT
gameLoop:
	JSR		refreshScreen
	; JSR		incScore
	JSR		takeInput
	JMP		gameLoop
	
	RTS

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
	CPX		#02
	BEQ		doneInput
	DEC		PLAYERY
	JMP 	doneInput


	;-------------------------------------------------------------------------------
	;FIND POSITION
	;PURPOSE: TAKES IN AN X AN Y AND RETURNS THE POSITION ON THE SCREEN TO DRAW TO
	;	IN $00 AND $01 ($01 = MSB, $00 = LSB). 
	;USAGE: LOAD X AND Y VALUES INTO X,Y REGISTERS S.T. 0>=X<=21, 0>=Y<=22
	;	THEN STORE INDIRECTLY ASCII/CUSTOM CHARACTER SET NEEDED IN THAT POSITION


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
	CMP		#00					; CHANGED FROM 255:WOULDNT PLOT TO 1EFF?
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
;--------------------------------------------------------------------------------
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

; ============================= Start Random Generator =============================
randomizer:
	LDA		$0
	CLC
	ADC		.seed			; Add seed value to accumulator
	ADC		RASTER			; Add current raster count to accumulator
	STA		.seed			; Update seed value with new random number
	RTS
; ============================= Start Random Generator =============================

;----------------------------------------------
; Screen refresh subroutine - uses A, X, and Y
;----------------------------------------------
refreshScreen:
;	LDA		#CLEAR
;	JSR		CHROUT
	JSR		clearPlayField
	JSR		printScoreText
	JSR		plotCurrentScore
	JSR		plotItem
	JSR		delay

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
	CPX		#6					; Compare x with total length of string going to be outputted
	BNE		printScoreTextLoop	; If not equal, branch to loop

	RTS

plotCurrentScore:
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
	STX		COUNTER

plotItemLoop:
	INC		COUNTER

	LDY		COUNTER
	LDX		PLAYERSYM,Y
	INC		COUNTER
	TXA
	LDX		COUNTER
	LDY		PLAYERSYM,X
	TAX
	JSR		findScreenPosition

	DEC		COUNTER

	LDY		COUNTER
	LDX		PLAYERSYM,Y
	INC		COUNTER
	TXA
	LDX		COUNTER
	LDY		PLAYERSYM,X
	TAX
	JSR		findColourPosition

	DEC		COUNTER
	DEC		COUNTER
	LDX		COUNTER
	LDA		PLAYERSYM,X
	CMP		#CIRCLE				;CHECK PLAYERSYM FOR WHAT COLOUR TO SET
	BNE		CHECKFORHEART
	LDA		#WHITE
	JSR		plotColour
	JMP		plotAtPosition
CHECKFORHEART:
	LDX		COUNTER
	LDA		PLAYERSYM,X
	CMP		#HEART
	BNE		colourEnemy
	LDA		#GREEN
	JSR		plotColour
	JMP		plotAtPosition
colourEnemy:
	LDA		#RED
	JSR		plotColour	


plotAtPosition:
;	DEC		COUNTER
;	DEC		COUNTER
	LDX		COUNTER
	LDA		PLAYERSYM,X			; First item in array offset by X
	CMP		#0
	BEQ		dontPlot
	JSR		plotPosition
dontPlot:
	INC		COUNTER
	INC		COUNTER
	INC		COUNTER

	LDX		COUNTER	
	CPX		#$30				; Compare with hex 32 (size of array)
	BNE		plotItemLoop



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


	;-------------------------------------------------------------------------------
	;FIND PLAYFIELD
	;PURPOSE: CLEARS THE GAME PLAYFIELD (EVERYTHING UNDERNEATH SCORE AND LIVES)
	;USAGE:	JSR clearPlayField
	;--------------------------------------------------------------------------------

clearPlayField:
	LDX		#00
;	CLC
clearLoop1:
	LDA		#32
	STA		$1E16,X
	INX
	CPX		#255
	BNE		clearLoop1
;	BCC		clearLoop1
	LDX		#00
clearLoop2:
	LDA		#32
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
    CPX 	#2
    BNE		waitLoop
    RTS

score:
	.byte	"SCORE:"

.seed        
	DC.B	$33				; Initial seed value -- new values also stored in same location