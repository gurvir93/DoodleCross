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
NUMOFLIVES	.equ	$1D57
LIVESXCOORD	.equ	$1D58
GAMECOUNTER .equ	$1D59
GAMESPEED	.equ	$1D60

MAXSCREENX  .equ	#21
MAXSCREENY	.equ	#22
ZERO		.equ	$30		; CHR$ code for 0
CIRCLE		.equ	$51		; CHR$ code for circle
HEART		.equ	$53
ENEMY		.equ	$56
SPACE		.equ	$20

INITLIVES	.equ	#3
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

	LDA		#HEART
	STA		ITEM8SYM
	LDA		#6
	STA		ITEM8X
	STA		ITEM8Y
	
	LDA		#HEART
	STA		ITEM15SYM
	LDA		#15
	STA		ITEM15X
	STA		ITEM15Y

clearScreen:
	LDA		#CLEAR
	JSR		CHROUT

startGameInstance:
	LDA		#0
	STA		GAMECOUNTER
	LDA		#4
	STA		GAMESPEED
	JSR		refreshScreenStart

; ============================= Main Game Loop =============================
gameLoop:
	LDA		GAMECOUNTER
	CMP		GAMESPEED
	BNE		gameLoopRefreshCont
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
	CPX		#02
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

; ===== X-Axis ======
	INY						; Move to item X-axis position

	LDX		ITEM1SYM,Y		; Load current position
	CPX		#MAXSCREENX	
	BCS		offScreenX		; If x-axis position is >= 1 position more than max screen x

	INX						; Increase position by 1
	TXA
	STA		ITEM1SYM,Y		; Store value back into memory

; ===== Y-Axis ======
	INY						; Move to item Y-axis position

	LDX		ITEM1SYM,Y		; Load current position
	CPX		#MAXSCREENY	
	BCS		offScreenY		; If x-axis position is >= 1 position more than max screen x
	
	INX						; Increase position by 1
	TXA
	STA		ITEM1SYM,Y		; Store value back into memory

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
	INY						; Move to next item in array
	CPY		#$3C			; Check for end of array ((Item15DIR - Item1SYM) + 1 = 3C)
	BNE		moveItemsLoop

	RTS
; ============================= End Move Items =============================


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

	DEY						; Move to item X-axis position
	DEY						; Move to item symbol position

	LDA		#0
	STA		ITEM1SYM,Y

	DEC		NUMOFLIVES
	JSR		incScore
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
	JSR		delay

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
	BNE		checkForHeart
	LDA		#WHITE
	JSR		plotColour
	JMP		plotAtPosition
checkForHeart:
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
	CPX		#$40				; Compare with hex 32 (size of array - score)
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
    CPX 	#3
    BNE		waitLoop
    RTS

lives:
	.byte	"LIVES:"
	
score:
	.byte	"SCORE:"

.seed        
	DC.B	$33				; Initial seed value -- new values also stored in same location