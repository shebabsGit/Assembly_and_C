    ORG    $1000
START:
    
    ; User input to I/O window
    ; Move Trap Task to D0
    MOVE.B  #2, D0
    ; Interrupt and Trap Task
    TRAP  #15

    ; Prints MESSAGE in I/O window
    LEA     MESSAGE, A1
    MOVE.B  #13, D0
    TRAP  #15
    
    
END_PROG:
    
    SIMHALT

MESSAGE:    DC.B    'Trap Task Test', 0

    END    START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
