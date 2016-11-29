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
CHKOUT	.equ	$FFC9	;address for kernal routine CHKOUT
PLOT	.equ	$FFF0	;address for kernal routine PLOT

CIRCLE	.equ	$71		;CHR$ code for circle
HEART	.equ	$73
SPACE	.equ	$20		;CHR$ code for space

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
	LDX		#15			; Set x=15
	STX		SNDVOL		; Set sound volume to 15
	LDX		#0
	
	JMP		loop
loop: 
	LDA		welcome,x	; Load specific byte x into accumulator
	JSR		CHROUT  ; Jump to character out subroutine
	INX				; Increment x
	CPX		#23		; Compare x with total length of string going to be outputted
	BNE		loop 	; If not equal, branch to loop

	LDX		#0
	LDA		linefeed,x
	JSR		CHROUT
	LDA		carriagereturn,x
	JSR		CHROUT
loop2:
	LDA		start,x	; Load specific byte x into accumulator
	JSR		CHROUT  ; Jump to character out subroutine
	INX				; Increment x
	CPX		#31		; Compare x with total length of string going to be outputted
	BNE		loop2 	; If not equal, branch to loop
	LDX		#0
	LDA		linefeed,x
	JSR		CHROUT
	LDA		carriagereturn,x
	JSR		CHROUT
	JMP		startgame				; Return to BASIC	


startgame:
	LDA		game_start,x	; Load specific byte x into accumulator
	JSR		CHROUT  ; Jump to character out subroutine
	INX				; Increment x
	CPX		#12		; Compare x with total length of string going to be outputted
	BNE		startgame 	; If not equal, branch to loop
	JSR		playwinsound
	JSR		playwinsound
	JSR		playwinsound
	JSR		playwinsound
	JSR		playwinsound
	JSR		playwinsound
	JSR		playwinsound
	JSR		playwinsound
	LDA		#0
	TAX
	TAY
	JMP 	clr


playwinsound:
	LDY 	sound
	STY		SNDCH1
	LDA		#0
	STA		162
	JSR		WAIT
	LDY		#0
	STY		SNDCH1
	LDA		#0
	STA		162
	JSR		WAIT
	RTS

	
sound: 
	.byte	$E1,$E4,$E7,$E8,$EB,$ED,$EF,$F0,$EE,$E3

WAIT:   
	LDA 162
    CMP #5
    BNE WAIT
    RTS
WAIT2:  
	LDA 162
    CMP #1
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
; ============================= End Random Generator =============================

update_score:
	JSR		playwinsound
	JSR		jumptoinc
	

plotheart:	
	JSR		randomizer
	STA		$1D00		; Y Axis Value

;	CMP		#00
;	BEQ		plotheart
;	CMP		#01
;	BEQ		plotheart
	JSR		randomizer
	STA		$1D01		; X Axis Value
	CMP		#$00
	BEQ		plotheart
	CMP		#01
	BEQ 	plotheart
	LDX		$1D00	

contplot:
	TAY
	CLC
	JSR		PLOT
	LDA		#HEART
	JSR		CHROUT
	JSR		printcircle
	JMP		readinput

collsion:
	CPX		$1D00
	BNE		retu
	CPY		$1D01
	BEQ		update_score
retu:
	RTS
	
printcircle:	
	LDX		YY			;Y AXIS VALUE
	LDY		XX			;X AXIS VALUE
	CLC					;clear carry bit - needed to call kernal routine PLOT
	JSR		PLOT
	LDA		#CIRCLE
	JSR		CHROUT
	LDA	#0
	STA	162
	JSR	WAIT2

; ============================= Start Score =============================
readinput:
	JSR 	SCNKEY
	JSR 	GETIN
	CMP 	#00
	BEQ		readinput
	CMP 	#RIGHT
	BEQ 	moveright
	CMP 	#LEFT
	BEQ 	moveleft
	CMP 	#UP
	BEQ	 	moveup
	CMP 	#DOWN
	BEQ 	movedown
	JMP 	readinput
	RTS

moveright:
	LDY		XX
	CPY		#20
	BEQ		readinput
	LDX		YY
	CLC
	JSR		PLOT
	LDA		#SPACE
	JSR		CHROUT		;clears the current position of cursor (prints space)
    INY					;increment x axis by 1
	STY		XX
	JSR		collsion
	JMP 	printcircle
	
moveleft:     
	LDY		XX
	CPY		#1
	BEQ		readinput
	LDX		YY
	CLC
	JSR		PLOT
	LDA		#SPACE
	JSR		CHROUT
    DEY					;decrement x axis by 1
	STY		XX
	JSR		collsion
	JMP 	printcircle
moveup:
	LDX		YY
	CPX		#2
	BEQ		readinput
	LDY		XX
	CLC
	JSR		PLOT
	LDA		#SPACE
	JSR		CHROUT
    DEX					;decrement y axis by 1
	STX		YY
	JSR		collsion
	JMP		printcircle
movedown:   
	LDX		YY
	CPX		#22
	BEQ		readinput
	LDY		XX
	CLC
	JSR		PLOT
	LDA		#SPACE
	JSR		CHROUT
    INX					;increment y axis by 1
	STX		YY
	JSR		collsion
	JMP		printcircle
; ============================= End Input =============================

; ============================= Start Score =============================
jumptoinc:
	JSR		inc_score
	RTS
	
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

