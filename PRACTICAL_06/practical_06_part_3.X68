    ORG    $1000
START:
    ; A7 - hardware stack pointer
    ; Meaning it's used for subroutine calls and exception handling
    LEA $4000, A7
    
    MOVE.B  #1, -(A7)
    MOVE.B  #2, -(A7)
    MOVE.B  #3, -(A7)
    MOVE.B  #4, -(A7)
    
    MOVE.B  (A7)+, D1
    MOVE.B  (A7)+, D1
    MOVE.B  (A7)+, D1
    MOVE.B  (A7)+, D1
    
END:
    
    SIMHALT

    END    START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
