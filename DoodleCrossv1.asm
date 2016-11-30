	processor 6502
; ======================
; | KERNAL SUBROUTINES |
; ======================
CHROUT		.equ	$FFD2	; Address for kernal routine CHROUT
PLOT		.equ	$FFF0	; Address for kernal routine PLOT

; ====================
; | SYSTEM VARIABLES |
; ====================
CLEAR		.equ	$93		; CHR$ code for clear screen
RASTER		.equ	$9004	; Current raster count -- used to generate random number

; ==============
; | MEMORY MAP |
; ==============
; --- User Variables ---
ENEMYSYM	.equ	$1D50
POINTSYM	.equ	$1D15

MAXSCREENX  .equ	#21
MAXSCREENY	.equ	#22
ZERO		.equ	$30		; CHR$ code for 0

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
	LDX		#0
	LDA		#0

initializeArray:
	STA		SCOREHUND,x	; First item in array offset by x
	INX
	CPX		#$32		; Compare with hex 32 (size of array)
	BNE		initializeArray

clearScreen:
	LDA		#CLEAR
	JSR		CHROUT

gameLoop:
	JSR		refreshScreen
	JSR		incScore
	JMP		gameLoop
	
	RTS

; Screen refresh subroutine - uses A, X, and Y
refreshScreen:
	LDA		#CLEAR
	JSR		CHROUT

	JSR		printScoreText
	JSR		plotCurrentScore
	JSR		plotItem
	RTS
	
printScoreText:
	LDX		#SCOREY			; Y AXIS VALUE
	LDY		#SCOREX			; X AXIS VALUE
	CLC						; Set carry bit - needed to call kernal routine PLOT
	JSR		PLOT
	LDX		#0

printScoreTextLoop:
	LDA		score,x			; Load specific byte x into accumulator
	JSR		CHROUT  		; Jump to character out subroutine
	INX						; Increment x
	CPX		#6				; Compare x with total length of string going to be outputted
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
	RTS
; ============================= Incrementing Score =============================
;	Uses - x
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
score:
	.byte	"SCORE:"