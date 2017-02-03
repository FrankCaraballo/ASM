;Frank Caraballo
;ID:1043377
;MAT: 10-0217
;TAREA #2


#include p16f887.inc
LIST   P=PIC16F887

__CONFIG _CONFIG1 ,_WDT_OFF & _LVP_OFF & _MCLRE_ON & _INTRC_OSC_NOCLKOUT


    STATUS equ 0x03               ;direcion del registro status
    PORTB  equ 0x06               ;direcion del registro de portb
    PORTC  equ 0x07               ;direcion del registro de portc
    PORTD  equ 0x08               ;direcion del registro de portd
    TRISB  equ 0x86               ;direcion del registro de tristate para portb, salida hacia 7 segmentos
    TRISC  equ 0x87               ;direcion del registro de tristate para portc, salida del teclado y bits de selecion
    TRISD  equ 0x88               ;direcion del registro de tristate para portc , entrada del teclado

    temp   equ 0x21               ;registro temporal
    temp2  equ 0x22               ;registro temporal2

    COUNT1 equ 0x08               ;contador1 para el delay
    COUNT2 equ 0x09               ;contador2 para el delay

    ORG    0x000


    bsf STATUS,5                ;moviendonos al banco 1
    bcf STATUS,6

    movlw b'00000000'
    movwf TRISB                 ;configurar los pines de PORTB como salida

    movlw b'00000000'
    movwf TRISC                 ;configurar los pines de PORTC como salida

    movlw b'00001111'
    movwf TRISD                 ;configurar los pines de PORTD como salida



    bcf STATUS,5                ;moviendonos al banco 0
    bcf STATUS,6

START                           ;loop principal

print

bsf PORTC,3                     ;seleciona el primer 7 segmento
movlw temp                      ;coloca en w el contenido de temp
movwf PORTB                     ;coloca en el primer 7 segmento el contenido de w
bcf PORTC,3                     ;deselaciona el primer 7 segmento

bsf PORTC,2                     ;seleciona el segundo 7 segmento
movlw temp2                     ;coloca en w el contenido de temp2
movwf PORTB                     ;coloca en el segundo 7 segmento el contenido de w
bcf PORTC,2                     ;deselaciona el primer 7 segmento


goto FILA1


FILA1
    movlw   b'00010000'         ;Mandando un uno a la primera fila
    movwf   PORTD

    btfsc   PORTD,0             ;verifica si ha un uno en la primera columna
    call    DEC1

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTD,1             ;verifica si ha un uno en la segunda columna
    call    DEC2

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTD,2             ;verifica si ha un uno en la tercera columna
    call    DEC3

    call    DELAY               ;retraza para que no lea varias veces

    goto    FILA2
   
FILA2
    movlw   b'00100000'         ;Mandando un uno a la segunda fila
    movwf   PORTD

    btfsc   PORTD,0             ;verifica si ha un uno en la primera columna
    call    DEC4

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTD,1             ;verifica si ha un uno en la segunda columna
    call    DEC5

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTD,2             ;verifica si ha un uno en la tercera columna
    call    DEC6

    call    DELAY               ;retraza para que no lea varias veces

    goto    FILA3

FILA3
    movlw   b'01000000'         ;Mandando un uno a la tercera fila
    movwf   PORTD

    btfsc   PORTD,0             ;verifica si ha un uno en la primera columna
    call    DEC7

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTD,1             ;verifica si ha un uno en la segunda columna
    call    DEC8

    call    DELAY               ;retraza para que no lea varias veces

    btfsc   PORTD,2             ;verifica si ha un uno en la tercera columna
    call    DEC9

    call    DELAY               ;retraza para que no lea varias veces

    goto    FILA4

FILA4
    movlw   b'10000000'         ;Mandando un uno a la tercera fila
    movwf   PORTD

    btfsc   PORTD,1             ;verifica si ha un uno en la tercera columna
    call    DEC0

    call    DELAY               ;retraza para que no lea varias veces

    goto    START               ;FINAL del LOOP principal


DELAY                           ;delay de tiempo

LOOP1
    decfsz  COUNT1,1
    goto    LOOP1
LOOP2
    decfsz  COUNT2,1
    goto    LOOP1

    return

DEC0
call COPIA                      ;copia el contenido de temp en temp2
movlw 0xAA
movwf temp                      ;Poene un 0 en codigo de 7 segementos
return

DEC1
call COPIA                      ;copia el contenido de temp en temp2
movlw 0xEF
movwf temp                      ;Poene un 1 en codigo de 7 segementos
return

DEC2
call COPIA                      ;copia el contenido de temp en temp2
movlw 0x05
movwf temp                      ;Poene un 2 en codigo de 7 segementos
return

DEC3
call COPIA                      ;copia el contenido de temp en temp2
movlw 0x92
movwf temp                      ;Poene un 3 en codigo de 7 segementos
return

DEC4
call COPIA                      ;copia el contenido de temp en temp2
movlw 0x64
movwf temp                      ;Poene un 4 en codigo de 7 segementos
return

DEC5
call COPIA                      ;copia el contenido de temp en temp2
movlw 0xCA
movwf temp                      ;Poene un 5 en codigo de 7 segementos
return

DEC6
call COPIA                      ;copia el contenido de temp en temp2
movlw 0x9F
movwf temp                      ;Poene un 6 en codigo de 7 segementos
return

DEC7
call COPIA                      ;copia el contenido de temp en temp2
movlw 0x85
movwf temp                      ;Poene un 7 en codigo de 7 segementos
return

DEC8
call COPIA                      ;copia el contenido de temp en temp2
movlw 0x52
movwf temp                      ;Poene un 7 en codigo de 7 segementos
return

DEC9
call COPIA                      ;copia el contenido de temp en temp2
movlw 0xD4
movwf temp                      ;Poene un 8 en codigo de 7 segementos
return

COPIA
movlw temp
movwf temp2                     ;copia el contenido de temp en temp2
return

END