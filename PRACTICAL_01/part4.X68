    ORG $1000
START:
    LEA text, A1
    MOVE #4,D0
    TRAP #15    ; asks for input
    MOVE #14,D0
    TRAP #15    ; goes to address from A1 and displays
    MOVE #3,D0
    TRAP #15    ; concatenates input to text and displays
            
    SIMHALT
text dc.b 'Data Register: ',0
    END START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
