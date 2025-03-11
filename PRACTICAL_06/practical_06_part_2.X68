    ORG    $1000
START:
    
    ; Task 13 - With CR, LF
    MOVE.B  #13, D0
    LEA     MESSAGE, A1
    TRAP  #15
    
    ; Task 14 - No CR, LF
    MOVE.B  #14, D0
    LEA     MESSAGE, A1
    TRAP  #15
    
    ; Task 2 -------- Read characters and store in A1
    MOVE.B  #2, D1
    MOVE.B  #2, D0
    TRAP  #15
    
    MOVE.B  #13, D0
    TRAP  #15
    ; ---------------
    
    ; Task 4 - Read Number and store in D1
    MOVE.B  #4, D0
    TRAP  #15
    
    ; Task 5 - Read single character and store in D1
    MOVE.B  #5, D0
    TRAP  #15
    
    ; Task 14 & 3
    LEA     MESSAGE, A1
    MOVE.B  #14, D0
    TRAP  #15
    
    MOVE.B  #3, D0
    MOVE.L  #16, D1
    TRAP  #15
    
    ; Task 9 - Terminate Program - SIMHALT
    MOVE.B  #9, D0
    TRAP  #15
    ; --------------------------
    
    ; Shouldn't execute because program terminated at "Task 9"
    MOVE.B  #$FE, D3
    LEA     $4323, A3

END_PROG:
    
    SIMHALT

MESSAGE:    DC.B    'Trap Task Test', 0

    END    START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
