    ORG    $1000
INITIALISE:

    MOVE.B  #3, D0
    MOVE.B  #0, D1
    
GAME_LOOP:

    CMP.B   #1, D0

    ; Byte Not Equal
    BNE     GAME_POINTS
    
    ; Byte Equal
    BEQ     GAME_OVER
    
GAME_POINTS:

    ADD.B   #10, D1
    SUB.B   #1, D0
    BRA     GAME_LOOP
    
GAME_OVER:

    MOVE.B  #0, D0

    SIMHALT
    
    END     INITIALISE
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
