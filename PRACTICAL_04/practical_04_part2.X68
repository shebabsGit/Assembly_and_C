    ORG    $1000
START:

    MOVE.B  #100, $3000
    
    ; 01010101
    MOVE.B  #85, D2
    
    ; 11001100
    MOVE.B  #204, D3
    
    ; Bitwise AND D2 and D3 and store result in D3
    ; 01000100
    AND.B   D2, D3
    
    MOVE.B  #204, D3
    
    ; Bitwise OR operation
    OR.B    D2, D3
    
    MOVE.B  #204, D3
    
    ; Bitwise Exclusive OR (NOT) operation
    EOR.B   D2, D3
    
    ; Load Effective Address - LEA
    LEA     $3000, A1
    
    ; Hit for 20DMG
    SUB.B   #$20, (A1)
    
    ; 10HP gained from Health Pack
    ADD.B   #10, (A1)

    SIMHALT
    
    END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
