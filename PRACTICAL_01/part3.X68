    ORG    $1000
START:

    MOVE.B #$64,D1
    LEA text, A1    ; puts address of text in A1
    MOVE #7,D0      
    TRAP #15        ; executes set of instructons based on value in D0
    
    MOVE #7,D0
    TRAP #13        ; executes different set of instructions based on value of D0
    
    MOVE #3,D4

    SIMHALT

text dc.b 'Data Register: ',0   ; text = "Data Register"; stored as Byte

    END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
