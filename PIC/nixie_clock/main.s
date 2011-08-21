;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Title:	Nixie tube clock				;
;Date:	11-01-2011					;
;Auth:	Ali Raheem					;
;Desc:	connect as descirbed on LetsHackStuff.com	;
;	PIC16F84A controls IV-18 via 4017.		;	
;	PORTA [1:0] clr,clk to 4017			;
;	PORTA [3:2] mode, +				;
;	PortB [7:0] Nixie tube				;
;	Updated: 13/01/2011				;	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
list p=p16F84
#include <p16F84.inc>
#define	clk	0
#define	clr	1
	__CONFIG(0x3FFB) ; CP off, WDT off, PWRT off, RC osc

sec	equ	0x0C
min	equ	0x0D
hr	equ	0x0E
_W	equ	0x0F		;Save w to here in ISR
_STATUS	equ	0x10		;Save STATUS to here in ISR
postScaler	equ	0x11		;PostScaler
temp	equ	0x12
temp1	equ	0x13
temp2	equ	0x14
del	equ	0x15	;Deleminator 0-3

secBCD	equ	0x1D
minBCD	equ	0x1E
hrBCD	equ	0x1F		;0x20=0b00100000 useful for indirect 
references

	org 0x0
	goto init
;
;Interrupt
;Need to add GIE INTCON stuff how big is postScaler (0x255)
	org 0x4
;Save context
	movwf	_W
	swapf	STATUS,W
	movwf	_STATUS
;ISR
	decfsz	postScaler,F
	retfie
	call	addSec
;Load context
	swapf	_STATUS,W
	movwf	STATUS
	swapf	_W,F
	swapf	_W,W
	bcf	INTCON,T0IF
	retfie
;
;INIT
;Run on start up we fall directly into _start and never get back here.
init:
	movlw	b'00000111'	;INT on TMR0 Prescale MAX
	movwf	OPTION_REG
	bsf	INTCON,GIE
	bcf	INTCON,T0IF
	bsf	INTCON,T0IE
	bsf	STATUS,RP0
	movlw	0x0
	movwf	TRISA
	movwf	TRISB
	bcf	STATUS,RP0
	movlw	0xB
	movwf	del
_start:
	call	clear
	movlw	secBCD
	movwf	FSR
loop:
	swapf	INDF,W
	andlw	b'00001111'
	call	cycle
	movfw	INDF
	andlw	b'00001111'
	call	cycle
	movfw	del
	call	cycle	
	incf	FSR,F

	btfss	FSR,5		;FSR==0x20
	goto	loop
	goto	_start

;add* functions adds a second, min, or hour then updates it's BCD.
;call delay and render in BCD in addHr in addSec in addMin
;leads to 4 calls, check your callstack depth.
addSec:
	incf	sec,F
	movfw	sec
	sublw	60
	btfsc	STATUS,Z
	call	addMin
	movfw	sec
	call	BCD
	movwf	secBCD
	return
addMin:
	clrf	sec
	incf	min,F
	movfw	min
	sublw	60
	btfsc	STATUS,Z
	call	addHr
	movfw	min
	call	BCD
	movwf	minBCD
	return
addHr:
	clrf	min
	incf	hr,F
	movfw	hr
	sublw	24
	btfsc	STATUS,Z
	clrf	hr		;Call addDay to implement date.
	movfw	hr
	call	BCD
	movwf	hrBCD
	return

;
;4017 related functions
;
cycle:
	bsf	PORTA,clk
	nop
	nop			; 2 nops = 400ns plenty of time
	bcf	PORTA,clk
	call	render
	movwf	PORTB
	return
clear:
	bsf	PORTA,clr
	nop
	nop			; 2 nops = 400ns plenty of time
	bcf	PORTA,clr
	return
;
;Convert value in w into output for IV-18
;
render:
;12a,10b,4c,3d,5e,11f,9g,2dp
	addwf	PCL,F
	retlw	b'11111100'
	retlw	b'01100000'
	retlw	b'11011010'
	retlw	b'11110010'
	retlw	b'01100110'
	retlw	b'10110110'
	retlw	b'10111110'
	retlw	b'11100000'
	retlw	b'11111110'
	retlw	b'11100110'
	retlw	b'00000001'	;DP
	retlw	b'00000010'	;Bar
	retlw	b'11000110'	;Square top
	retlw	b'00111010'	;Square bottom
;
;Returns the BCD of w in w.
;
BCD:
	clrf	temp1	;BCD tens
	movwf	temp2	;BCD ones
BCD_HIGH:
	sublw	0xA
	btfsc	STATUS,0
	goto	BCD_LOW
	movwf	temp2
	incf	temp1,F
	goto	BCD_HIGH
BCD_LOW:
	movfw	temp1
	addwf	temp2,W
	return

	END