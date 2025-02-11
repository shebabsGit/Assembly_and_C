    ORG    $1000
START:

    LEA     PLAYER_POSITION, A1
    LEA     ENEMY_POSITION, A2
    
    MOVE.B  (A1)+, D1 ; Load first element of array at A1 into D1 and increment pointer by one byte
    MOVE.B  (A2)+, D2 ; ---
    MOVE.B  (A1), D3 ; Incremented pointer loads value at new memory location into D3
    MOVE.B  (A2), D4 ; ---
    
COLLISION_CHECK:
    CMP     D2, D1
    BLT     NEXT_MOVE ; If D1 < D2, go to NEXT_MOVE
    BEQ     NEXT_CHECK ; If D1 == D2, go to NEXT_CHECK
    
NEXT_CHECK:
    CMP     D4, D3
    BLT     NEXT_Y
    BEQ     COLLISION
    
NEXT_Y:
    ADD.B   #1, D3
    BRA     NEXT_CHECK

NEXT_MOVE:
    ADD.B   #1, D1
    BRA     COLLISION_CHECK
    
COLLISION:
    BRA     GAME_OVER
    
GAME_OVER:

    SIMHALT

PLAYER_POSITION:    DC.B 10, 15
ENEMY_POSITION:     DC.B 50, 55

    END    START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
