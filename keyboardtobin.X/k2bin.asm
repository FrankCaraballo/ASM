; Frank Caraballo ID:1043377 / Mat: 10-0217;
;Este programa lee desde un teclado matricial 8x8 y da salida en formato binario mediante 4 salidas;
;del numero en hexadecimal introducido desplazando a las siguientes 4 salidas el valor anterior;


#include "p16F887.inc"

; CONFIG1
; __config 0xFFFF
 __CONFIG _CONFIG1, _FOSC_EXTRC_CLKOUT & _WDTE_ON & _PWRTE_OFF & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_ON & _FCMEN_ON & _LVP_ON
; CONFIG2
; __config 0xFFFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF




    STATUS equ 03h              ;direcion del registro status
    PORTA  equ 05h              ;direcion del registro de porta
    PORTB  equ 06h              ;direcion del registro de portb
    PORTC  equ 07h              ;direcion del registro de portc
    TRISA  equ 85h              ;direcion del registro de tristate para porta, entrada del teclado
    TRISB  equ 86h              ;direcion del registro de tristate para portb, salida del teclado
    TRISC  equ 87h              ;direcion del registro de tristate para portc , donde estaran los led

    COUNT1 equ 08h              ;contador1 para el delay
    COUNT2 equ 09h              ;contador2 para el delay

    ORG    0x000


    bsf STATUS,5                ;moviendonos al banco 1

    movlw 01h
    movwf TRISA                 ;configurar los pines de PORTA como entrada

    movlw 00h
    movwf TRISB                 ;configurar los pines de PORTB como salida

    movlw 00h
    movwf TRISC                 ;configurar los pines de PORTC como salida

    bcf STATUS,5                ;moviendonos al banco 0

START                           ;loop principal

FILA1    
    movlw   01h                 ;Mandando un uno a la primera fila
    movwf   PORTA

    btfsc   PORTB,0             ;verifica si ha un uno en la primera columna
    call    BIN1

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,1             ;verifica si ha un uno en la segunda columna
    call    BIN2

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,2             ;verifica si ha un uno en la tercera columna
    call    BIN3

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,3             ;verifica si ha un uno en la cuarta columna
    call    BIN4

    call    DELAY               ;retraza para que no lea varias veces

    goto    FILA2

FILA2
    movlw   02h                 ;Mandando un uno a la segunda fila
    movwf   PORTA

    btfsc   PORTB,0             ;verifica si ha un uno en la primera columna
    call    BIN5

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,1             ;verifica si ha un uno en la segunda columna
    call    BIN6

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,2             ;verifica si ha un uno en la tercera columna
    call    BIN7

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,3             ;verifica si ha un uno en la cuarta columna
    call    BIN8

    call    DELAY               ;retraza para que no lea varias veces

    goto    FILA3

FILA3
    movlw   04h                 ;Mandando un uno a la tercera fila
    movwf   PORTA

    btfsc   PORTB,0             ;verifica si ha un uno en la primera columna
    call    BIN9

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,1             ;verifica si ha un uno en la segunda columna
    call    BIN0

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,2             ;verifica si ha un uno en la tercera columna
    call    BINA

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,3             ;verifica si ha un uno en la cuarta columna
    call    BINB

    call    DELAY               ;retraza para que no lea varias veces
    
    goto    FILA4

FILA4
    movlw   08h                 ;Mandando un uno a la tercera fila
    movwf   PORTA

    btfsc   PORTB,0             ;verifica si ha un uno en la primera columna
    call    BINC

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,1             ;verifica si ha un uno en la segunda columna
    call    BIND

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,2             ;verifica si ha un uno en la tercera columna
    call    BINE

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTB,3             ;verifica si ha un uno en la cuarta columna
    call    BINF    

    call    DELAY               ;retraza para que no lea varias veces

    goto    START               ;FINAL del LOOP principal


DELAY                           ;delay de tiempo

LOOP1
    decfsz  COUNT1,1
    goto    LOOP1
LOOP2
    drcfsz  COUNT2,1
    goto    LOOP1
    return






BIN1
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bsf     PORTC,0             ;Mandando un 1 a binario a PORTC
    bcf     PORTC,1
    bcf     PORTC,2
    bcf     PORTC,3

    return
BIN2
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bcf     PORTC,0             ;Mandando un 2 a binario a PORTC
    bsf     PORTC,1
    bcf     PORTC,2
    bcf     PORTC,3

    return

BIN3
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bsf     PORTC,0             ;Mandando un 3 a binario a PORTC
    bsf     PORTC,1
    bcf     PORTC,2
    bcf     PORTC,3

    return

BIN4
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bcf     PORTC,0             ;Mandando un 4 a binario a PORTC
    bcf     PORTC,1
    bsf     PORTC,2
    bcf     PORTC,3

    return

BIN5
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bsf     PORTC,0             ;Mandando un 5  binario a PORTC
    bcf     PORTC,1
    bsf     PORTC,2
    bcf     PORTC,3

    return

BIN6
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bcf     PORTC,0             ;Mandando un 6 a binario a PORTC
    bsf     PORTC,1
    bsf     PORTC,2
    bcf     PORTC,3

    return

BIN7
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bsf     PORTC,0             ;Mandando un 7 a binario a PORTC
    bsf     PORTC,1
    bsf     PORTC,2
    bcf     PORTC,3

    return

BIN8
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bcf     PORTC,0             ;Mandando un 8 a binario a PORTC
    bcf     PORTC,1
    bcf     PORTC,2
    bsf     PORTC,3

    return

BIN9
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bsf     PORTC,0             ;Mandando un 9 a binario a PORTC
    bcf     PORTC,1
    bcf     PORTC,2
    bsf     PORTC,3

    return

BIN0
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bcf     PORTC,0             ;Mandando un 0 a binario a PORTC
    bcf     PORTC,1
    bcf     PORTC,2
    bcf     PORTC,3

    return

BINA
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bcf     PORTC,0             ;Mandando un 10 a binario a PORTC
    bsf     PORTC,1
    bcf     PORTC,2
    bsf     PORTC,3

    return

BINB
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bsf     PORTC,0             ;Mandando un 11 a binario a PORTC
    bsf     PORTC,1
    bcf     PORTC,2
    bsf     PORTC,3

    return

BINC
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bcf     PORTC,0             ;Mandando un 12 a binario a PORTC
    bcf     PORTC,1
    bsf     PORTC,2
    bsf     PORTC,3

    return

BIND
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bsf     PORTC,0             ;Mandando un 13 a binario a PORTC
    bcf     PORTC,1
    bsf     PORTC,2
    bsf     PORTC,3

    return

BINE
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bcf     PORTC,0             ;Mandando un 14 a binario a PORTC
    bsf     PORTC,1
    bsf     PORTC,2
    bsf     PORTC,3

    return

BINF
    swapf   PORTC               ;Mueve los 4 bits del primer nible al segundo nible
    bsf     PORTC,0             ;Mandando un 15 a binario a PORTC
    bsf     PORTC,1
    bsf     PORTC,2
    bsf     PORTC,3

    return

END







