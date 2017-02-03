#include p16f887.inc
LIST   P=PIC16F887

__CONFIG _CONFIG1&_WDT_OFF & _LVP_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT


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



