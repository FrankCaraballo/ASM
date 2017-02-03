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
bird EQU 0X21
cnt EQU 0x22

d7 EQU 0x24


banksel TRISC
movlw b'00000000'
movwf TRISC
movwf TRISD
banksel ANSEL
clrf ANSEL
clrf ANSELH
banksel PORTC
clrf PORTC
clrf PORTD

movlw b'00010000'
movwf bird

movlw b'10111011'
movwf cnt

goto main
org 0x030

bcf STATUS,0
main:
    rrf cnt,1
    btfss cnt,0
    call Display1

    rrf cnt,1
    btfss cnt,0
    call Display2
    
    rrf cnt,1
    btfss cnt,0
    call Display3

    
    goto main

button:
    clrf PORTC
    clrf PORTD
    movfw bird
    movwf PORTC
    bsf PORTD,2
    bcf STATUS,0
    rrf bird,1

    btfsc PORTB,0
    call flappy
    call Delay

    btfsc STATUS,0
    GOTO LOSE

    return

flappy:
rlf bird,1
rlf bird,1
call Delay
return

LOSE:
movlw	0xff
movwf PORTC
movlw	0xff
movwf PORTD
btfsc PORTB,0
GOTO restore
call Delay
call Delay
rrf cnt,1
GOTO LOSE

restore:
movlw	b'00010000'
movwf PORTC
CLRF PORTD
bsf PORTD,4
bcf STATUS,0
goto main

Delay:
				;699998 cycles
	movlw	0x5F
	movwf	d1
	movlw	0xEB
	movwf	d2
Delay_0:
    decfsz	d1, f
	goto	$+2
	decfsz	d2, f
	goto	Delay_0

			;2 cycles
	goto	$+1
return

Display1:
    movlw b'11001111'
    movwf PORTC
    

    movlw b'11000000';1
    movwf PORTD
    call Delay
    call button

    movlw b'11001111'
    movwf PORTC
    movlw b'01100000';2
    movwf PORTD
    call Delay
    call button
    

    movlw b'11001111'
    movwf PORTC
    movlw b'00110000';3
    movwf PORTD
    call Delay
    call button
    

    movlw b'11001111'
    movwf PORTC
    movlw b'00011000';4
    movwf PORTD
    call Delay
    call button
    

    movlw b'11001111'
    movwf PORTC
    movlw b'00001100';5
    movwf PORTD
    call Delay
    call button
    call check1

    movlw b'11001111'
    movwf PORTC
    movlw b'00000110';6
    movwf PORTD
    call Delay
    call button
    call check1

    movlw b'11001111'
    movwf PORTC
    movlw b'00000011';7
    movwf PORTD
    call Delay
    call button

    return

Display2:
    movlw b'11100111'
    movwf PORTC

    movlw b'11000000';1
    movwf PORTD
    call Delay
    call button

    movlw b'11100111'
    movwf PORTC
    movlw b'01100000';2
    movwf PORTD
    call Delay
    call button
    rrf cnt,1

    movlw b'11100111'
    movwf PORTC
    movlw b'00110000';3
    movwf PORTD
    call Delay
    call button
    

    movlw b'11100111'
    movwf PORTC
    movlw b'00011000';4
    movwf PORTD
    call Delay
    call button
    

    movlw b'11100111'
    movwf PORTC
    movlw b'00001100';5
    movwf PORTD
    call Delay
    call button
    call check2

    movlw b'11100111'
    movwf PORTC
    movlw b'00000110';6
    movwf PORTD
    call Delay
    call button
    call check2

    movlw b'11100111'
    movwf PORTC
    movlw b'00000011';7
    movwf PORTD
    call Delay
    call button

    return

Display3:
   
    movlw b'11110011'
    movwf PORTC
    movlw b'11000000';1
    movwf PORTD
    call Delay
    call button

    movlw b'11110011'
    movwf PORTC
    movlw b'01100000';2
    movwf PORTD
    call Delay
    call button
    

    movlw b'11110011'
    movwf PORTC
    movlw b'00110000';3
    movwf PORTD
    call Delay
    call button
    

    movlw b'11110011'
    movwf PORTC
    movlw b'00011000';4
    movwf PORTD
    call Delay
    call button
    

    movlw b'11110011'
    movwf PORTC
    movlw b'00001100';5
    movwf PORTD
    call Delay
    call button
    call check3

    movlw b'11110011'
    movwf PORTC
    movlw b'00000110';6
    movwf PORTD
    call Delay
    call button
    call check3

    movlw b'11110011'
    movwf PORTC
    movlw b'00000011';7
    movwf PORTD
    call Delay
    call button

    return

    check1:
    btfss PORTC,4
    call LOSE
    BTFSS PORTC,5
    CALL LOSE
    return

    check2:
    btfss PORTC,3
    call LOSE
    BTFSS PORTC,4
    CALL LOSE
    return

    check3:
    btfss PORTC,2
    call LOSE
    BTFSS PORTC,3
    CALL LOSE
    return
end


