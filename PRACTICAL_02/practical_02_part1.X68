    ORG    $1000
START:

    MOVE.L #%100, D0    ; stores binary 100 in D0 as hex
    MOVE.L #$100, D1    ; stores hex 100 in D1 as hex
    MOVE.L #100, D2     ; stores decimal 100 in D2 as hex
    
    MOVE.L D0, $3000    ; writes content of D0 in memory location 3000 using 32 bits
    MOVE.W D1, $3010    ; writes content of D1 in memory location 3010 using 16 bits
    MOVE.B D2, $3020    ; writes content of D2 in memory location 3020 using 8 bits
    
    SIMHALT


    END    START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
