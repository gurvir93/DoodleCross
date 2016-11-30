	processor 6502
	
CLEAR	.equ	$93		; CHR$ code for clear screen
CHROUT	.equ	$FFD2	; Address for kernal routine CHROUT
RDTIM	.equ	$FFDE	; Memory address for read system time - uses a, x, y
TIME 	.equ	$1770	; RAM location to store 1 byte of data
SETTIM	.equ	$FFDB	; Memory address for setting system time - uses a, x, y
ddra		.equ	$9113	; Data direction register for port A
outputra 	.equ	$9111	; Output register A
ddrb		.equ	$9122	; Data direction register for port B
outputrb 	.equ	$9120	; Output register B
SNDCH1	.equ	$900A	; Memory location for sound channel 1
SNDVOL	.equ	$900E	; Memory location for system sound volume, 
						;  must be set to hear sound -- 0-15 volume levels.

GETIN 	.equ   	$FFE4	;address for kernal routine GETIN
SCNKEY	.equ   	$FF9F	;address for kernal routine SCNKEY
RIGHT	.equ	$1d 	;29
LEFT	.equ	$9d 	;157
UP		.equ	$91		;17
DOWN	.equ	$11		;145
PLOT	.equ	$FFF0	;address for kernal routine PLOT

CIRCLE	.equ	$51		;CHR$ code for circle
HEART	.equ	$53
SPACE	.equ	$20		;CHR$ code for space

WHITE		.equ	$01
PURPLE		.equ	$04

XX		.equ	$1D02	;store x axis
YY		.equ	$1D03	;store y axis
MAX_SCN	.equ	#20		;max screen size

ZERO	.equ	$30		; CHR$ code
RASTER	.equ	$9004		; Current raster count -- used to generate random number
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
	LDA 	#CLEAR
	JSR		CHROUT
	LDA		#8	;POKE 36879,8
	STA		$900F
	LDX		#15			; Set x=15
	STX		SNDVOL		; Set sound volume to 15
	LDX		#0
;	
;	JMP		loop
;loop: 
;	LDA		welcome,x	; Load specific byte x into accumulator
;	JSR		CHROUT  ; Jump to character out subroutine
;	INX				; Increment x
;	CPX		#23		; Compare x with total length of string going to be outputted
;	BNE		loop 	; If not equal, branch to loop
;
;	LDX		#0
;	LDA		linefeed,x
;	JSR		CHROUT
;	LDA		carriagereturn,x
;	JSR		CHROUT
;	JSR		birthday
;loop2:
;	LDA		start,x	; Load specific byte x into accumulator
;	JSR		CHROUT  ; Jump to character out subroutine
;	INX				; Increment x
;	CPX		#31		; Compare x with total length of string going to be outputted
;	BNE		loop2 	; If not equal, branch to loop
;	LDX		#0
;	LDA		linefeed,x
;	JSR		CHROUT
;	LDA		carriagereturn,x
;	JSR		CHROUT
;	JMP		startgame				; Return to BASIC	
;
;
startgame:
	LDA		game_start,x	; Load specific byte x into accumulator
	JSR		CHROUT  ; Jump to character out subroutine
	INX				; Increment x
	CPX		#12		; Compare x with total length of string going to be outputted
	BNE		startgame 	; If not equal, branch to loop
	LDA		#0
	TAX
	TAY
	JMP 	clr
;
;
;
;
;playwinsound:
;	LDY 	sound
;	STY		SNDCH1
;	LDA		#0
;	STA		162
;	JSR		WAIT
;	LDY		#0
;	STY		SNDCH1
;	LDA		#0
;	STA		162
;	JSR		WAIT
;	RTS
;
;
;
;	
;sound: 
;	.byte	$E1,$E4,$E7,$E8,$EB,$ED,$EF,$F0,$EE,$E3
;birthday:
;	LDY		sound		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+1		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT		; Set x=128 -- Sound values range from 128-255
;	LDY		sound+3		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+2		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT		; Set x=128 -- Sound values range from 128-255
;	LDY		sound		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+1		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	
;	LDY		sound+4		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+3		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	
;	LDY		sound		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	
;	LDY		sound+7		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+5		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+3	; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	
;	
;	LDY		sound+2		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	
;	LDY		sound+9		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	
;	LDY		sound+8		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+8		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+5		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+3		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+4		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY		sound+3		; Set x=128 -- Sound values range from 128-255
;	STY		SNDCH1		; Set sound channel 1 to 128
;	LDA #0
;    STA 162
;	JSR		WAIT
;	LDY	#0
;	STY		SNDCH1
;	RTS
WAIT:
	LDA 162
    CMP #4
    BNE WAIT
    RTS

clr: 
	LDA 	#CLEAR
	JSR		CHROUT
	JSR		printscore
	LDA		#10
	STA		YY
	STA		XX
	
	JMP 	plotheart

; ============================= Start Random Generator =============================
randomizer:
	LDA		$0				; Get zero page value
	ADC		.seed			; Add seed value to accumulator
	ADC		RASTER			; Add current raster count to accumulator
	STA		.seed			; Update seed value with new random number

	ASL
	ASL
	ASL
	ASL
	LSR
	LSR
	LSR
	LSR
	
	STA		$1D00
	RTS

	; LDA		#0
	; ADC		.seed
	; ASL
	; ASL
	; CLC
	; ADC		.seed
	; CLC
	; ADC		#23
	; STA		.seed
	; ASL
	; ASL
	; ASL
	; ASL
	; LSR
	; LSR
	; LSR
	; LSR
	
	; STA		$1D00
	; RTS
; ============================= End Random Generator =============================

update_score:
;	JSR		playwinsound
	JSR		jumptoinc
	

plotheart:	
	LDY		$1D01
	LDX		$1D00
	JSR		FINDCOLOURPOSITION		;COLOUR OLD HEART POSITION
	LDA		#WHITE
	JSR		PLOTCOLOUR
	
	JSR		randomizer
	STA		$1D00
	JSR		randomizer
	STA		$1D01
	CMP		#$00
	BEQ		plotheart
	CMP		#01
	BEQ 	plotheart
	LDY		$1D00
	TAX
	CLC

	JSR		FINDCOLOURPOSITION		;COLOUR NEW HEART POSITION
	LDA		#$AA
	STA		$1D10
	LDA		#PURPLE
	JSR		PLOTCOLOUR
	LDY		$1D01
	LDX		$1D00
	JSR		FINDSCREENPOSITION
	LDA		#HEART
	JSR		PLOTPOSITION
	JSR		printcircle

	JMP		readinput

collsion:
	LDX		XX
	CPX		$1D00
	BNE		retu
	LDY		YY
	CPY		$1D01
	BEQ		update_score
retu:
	RTS
	
printcircle:	
	LDX		XX			;Y AXIS VALUE
	LDY		YY			;X AXIS VALUE
	CLC					;clear carry bit - needed to call kernal routine PLOT
	JSR		FINDSCREENPOSITION
	LDA		#CIRCLE
	JSR		PLOTPOSITION
	LDA	#0
	STA	162
	JSR	WAIT

; ============================= Start Input =============================
readinput:
		LDA		#127
		STA 	ddrb
		CLC
		LDA 	#00
loop:	LDA 	outputrb
		ASL		
		LDX		#0
		BCC		moveright
		CLC
notright: 
		LDA 	#00
		sta 	ddrb
		LDA 	outputra
		ASL					;shift to 5th bit
		ASL
		ASL
		LDX		#0
		BCC 	printfire
		ASL					;shift to 4th bit
		LDX 	#0
		BCC 	moveleft
		ASL					;shift to 3rd bit
		BCC 	movedown
		ASL					;shift to 2nd bit
		BCS 	readinput 	;if carry is not set
		LDX		#0
		JMP		moveup		;else print up
		JMP 	readinput
		RTS

printfire:
	JMP		readinput

moveright:
	LDX		XX
	CPX		#21
	BEQ		readinput
	LDY		YY
	LDX		XX
	JSR		FINDSCREENPOSITION
	LDA		#SPACE
	JSR		PLOTPOSITION		;clears the current position of cursor (prints space)
	INC		XX
	JSR		collsion
	JMP 	printcircle

rdinput:
	JMP		readinput

moveleft:     
	LDX		XX
	CPX		#0
	BEQ		readinput
	LDY		YY
	JSR		FINDSCREENPOSITION
	LDA		#SPACE
	JSR		PLOTPOSITION
    DEC		XX				;decrement x axis by 1
	JSR		collsion
	JMP 	printcircle
moveup:
	LDY		YY
	CPY		#2
	BEQ		readinput
	LDX		XX
;	CLC
	JSR		FINDSCREENPOSITION
	LDA		#SPACE
	JSR		PLOTPOSITION
    DEC		YY					;decrement y axis by 1
	JSR		collsion
	JMP		printcircle
movedown:   
	LDY		YY
	CPY		#22
	BEQ		rdinput
	LDX		XX
;	CLC
	JSR		FINDSCREENPOSITION
	LDA		#SPACE
	JSR		PLOTPOSITION
    INC		YY				;increment y axis by 1

	JSR		collsion
	JMP		printcircle
; ============================= End Input =============================


jumptoinc:
	JSR		inc_score
	RTS

; ============================= Start Score =============================
printscore:
	LDX		#0			; Y AXIS VALUE
	LDY		#13			; X AXIS VALUE
	CLC					; Set carry bit - needed to call kernal routine PLOT
	JSR		PLOT
	LDX		#0
	JSR		printscoretext
	
	LDX		#0
	LDY		#0
	JSR		storeintomemory
	
	LDA		#ZERO
	JSR		CHROUT
	JSR		CHROUT
	RTS

inc_score:
	JSR		loadfrommemory
	JSR		scoreonespos
	CPY		#9
	BEQ		inc_score_tens
	INY
	JSR		storeintomemory
	TYA
	ADC		#ZERO
	JSR		CHROUT
	JMP		plotheart
	
return:
	RTS

inc_score_tens:
	CPX		#9
	BEQ		return
	LDY		#0
	TYA
	ADC		#ZERO
	JSR		CHROUT
	INX
	JSR		storeintomemory
	JSR		scoretenspos
	TXA
	ADC		#ZERO
	JSR		CHROUT
	JMP		plotheart

storeintomemory:
	STX		$1DFE
	STY		$1DFF
	RTS
	
loadfrommemory:
	LDX		$1DFE
	LDY		$1DFF
	RTS

scoreonespos:
	JSR		storeintomemory
	LDX		#0			; Y AXIS VALUE
	LDY		#21			; X AXIS VALUE
	CLC
	JSR		PLOT
	JSR		loadfrommemory
	RTS
	
scoretenspos:
	JSR		storeintomemory
	LDX		#0			; Y AXIS VALUE
	LDY		#20			; X AXIS VALUE
	CLC
	JSR		PLOT
	JSR		loadfrommemory
	RTS
		
printscoretext:
	LDA		score,x			; Load specific byte x into accumulator
	JSR		CHROUT  		; Jump to character out subroutine
	INX						; Increment x
	CPX		#7				; Compare x with total length of string going to be outputted
	BNE		printscoretext 	; If not equal, branch to loop

	RTS						; Return
; ============================= End Score =============================


	
	
	;-------------------------------------------------------------------------------
	;FIND POSITION
	;PURPOSE: TAKES IN AN X AN Y AND RETURNS THE POSITION ON THE SCREEN TO DRAW TO
	;	IN $00 AND $01 ($01 = MSB, $00 = LSB). 
	;USAGE: LOAD X AND Y VALUES INTO X,Y REGISTERS S.T. 0>=X<=21, 0>=Y<=22
	;	THEN STORE INDIRECTLY ASCII/CUSTOM CHARACTER SET NEEDED IN THAT POSITION


FINDSCREENPOSITION:
;	LDX		#21
;	LDY		#22
;	STY		$03
;	LDA		#00
;	STA		$02
;	LDX		XPOS
;	LDY		YPOS
	LDA		#00
;	STA		$02
	STY		$03
INITIALIZEPOSITION:
;	LDA		#$00	;DONT NEED, JUST LOAD X DIRECTLY
;	STA		$00
	STX		$00		
	LDA		#$1E	
	STA		$01
	LDY		#$00

ADDYLEVELS:
	CPY		$03
	BEQ		FOUNDPOSITION
	INY
	LDX		#00
ADD22:		
	INC		$00
	INX
	LDA		$00
	CMP		#00	;CHANGED FROM 255:WOULDNT PLOT TO 1EFF?
	BNE		DONTADDCARRY	
	INC		$01
DONTADDCARRY:
	CPX		#22
	BNE		ADD22
;	INC		$1D0F
	JMP 	ADDYLEVELS
FOUNDPOSITION:
;	LDA		#01
;	LDX		#00
;	STA		($00,X)
;	LDA		#$AA
;	STA		$1D0F
	RTS
	;------------------------------------------------------
PLOTPOSITION:
	LDY		#$00
	STA		($00),Y
	RTS
	;-------------------------------------------------------------------------------
	;FIND COLOUR
	;PURPOSE: TAKES IN AN X AN Y AND RETURNS THE POSITION ON THE SCREEN TO DRAW TO
	;	IN $04 AND $05 ($05 = MSB, $04 = LSB). 
	;USAGE: LOAD X AND Y VALUES INTO X,Y REGISTERS S.T. 0>=X<=21, 0>=Y<=22
	;	AND CALL FINDCOLOURPOSITION, THEN LOAD COLOUR VALUE INTO ACCUMULATOR AND CALL
	;	PLOTCOLOUR SUBROUTINE

FINDCOLOURPOSITION:
;	LDA		#$AA
;	STA		$1D0F
	LDA		#00
	STA		$06
	STY		$07
INITIALIZECPOSITION:
	STX		$04		
	LDA		#$96	
	STA		$05
	LDY		#$00
ADDYCLEVELS:
	CPY		$07
	BEQ		FOUNDCPOSITION
	INY
	LDX		#00
ADDC22:		
	INC		$04
	INX
	LDA		$04
	CMP		#00
	BNE		DONTADDCCARRY	
	INC		$05
DONTADDCCARRY:
	CPX		#22
	BNE		ADDC22
	JMP 	ADDYCLEVELS
FOUNDCPOSITION:
	RTS

PLOTCOLOUR:
	LDY		#00
	STA		($04),Y
	RTS	

score:	
	.byte	"SCORE: "		; String to be printed
welcome: 
	.byte "WELCOME TO DOODLE CROSS"
start:
	.byte "MOVE JOYSTICK TO START THE GAME"
game_start:
	.byte "GAME STARTED"
linefeed:
	.byte $0a
carriagereturn:
	.byte $0d
.seed        
	DC.B	$33				; Initial seed value -- new values also stored in same location
endprogram: BRK	

