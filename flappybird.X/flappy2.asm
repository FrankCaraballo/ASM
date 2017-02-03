#include p16f887.inc

 __CONFIG _CONFIG1, _FOSC_EXTRC_NOCLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_ON & _FCMEN_ON & _LVP_OFF

 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    org 0x000

    d1 EQU 0x15
    d2 EQU 0x16
    d3 EQU 0x17
    d4 EQU 0x18
    d5 EQU 0x19
    d6 EQU 0x20
    bird EQU 0X19
                    ; select bank 1 (so that we can edit some status bits)

    banksel TRISC				; select bank 1 (so that we can edit some status bits)
    movlw b'00000000' 				; set PORTB all outputs
    movwf TRISC						;				; set PORTA all outputs except for bit 5
    movwf TRISD 					;
    banksel ANSEL
    clrf ANSEL
    clrf ANSELH
    banksel PORTC
    clrf PORTC
    clrf PORTD

    movlw b'00010000'
    movwf bird

    movlw 0x03
    movwf cnt


    goto main
    org 0x030

main:

    call Level
 
    goto main2


    goto main





Level:

    movlw b'11001111'
    movwf PORTC
    call Display


    movlw b'11100111'
    movwf PORTC
    call Display


    movlw b'11110011'
    movwf PORTC
    call Display

    return


Display:

    movlw b'11000000';1
    movwf PORTD
    call Delay


    movlw b'01100000';2
    movwf PORTD
    call Delay


    movlw b'00110000';3
    movwf PORTD
    call Delay


    movlw b'00011000';4
    movwf PORTD
    call Delay


    movlw b'00001100';5
    movwf PORTD
    call Delay


    movlw b'00000110';6
    movwf PORTD
    call Delay


    movlw b'00000011';7
    movwf PORTD
    call Delay


    return

Delay:
    movlw	0x03
    movwf	d1
    movlw	0x18
    movwf	d2
    movlw	0x02
    movwf	d3
Delay_0:
    decfsz	d1, f
    goto	$+2
    decfsz	d2, f
    goto	$+2
    decfsz	d3, f
    goto	Delay_0

                ;6 cycles
    goto	$+1
    goto	$+1
    goto	$+1

    return
Delay3:
		;199998 cycles
	movlw	0x3F
	movwf	d5
	movlw	0x9D
	movwf	d6
Delay_1:
	decfsz	d5, f
	goto	$+2
	decfsz	d6, f
	goto	Delay_1

			;2 cycles
	goto	$+1
    return

main2:
    movfw bird
    movwf PORTC
    bsf PORTD,4
    rrf bird,1

    btfsc PORTB,0
    call flappy
    call Delay

    btfsc STATUS,0
    GOTO LOSE

    goto main2

flappy:
    rlf bird,1
    rlf bird,1
    call Delay
    return

LOSE:
    movlw	0xFF
    movwf PORTC
    movlw	0xFF
    movwf PORTD
    btfsc PORTB,0
    GOTO restore
    GOTO LOSE

restore:
    movlw	b'00010000'
    movwf PORTC
    CLRF PORTD
    bsf PORTD,4
    bcf STATUS,0
    goto main2

end