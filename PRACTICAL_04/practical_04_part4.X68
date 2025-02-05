    ORG    $1000
START:

    ; Player Health at $3000
    MOVE.B  #100, $3000
    
    ; Boss Health
    MOVE.B  #200, $3002
    
    ; Player Damage
    MOVE.B  #$10, $3004
    
    
    MOVE.B  $3002, D2 ; Boss Health
    MOVE.B  $3004, D3 ; Player DMG
    LEA     $3000, A1 ; Player Health

    BSR     TAKING_DAMAGE ; Branch to Sub-Routine (Go and come back)
    
BACK_IN_THE_GAME:

    BSR     HEALTH_PICKUP
    BSR     DAMAGE_INCREASE
    BSR     DAMAGE_DEALT
    BSR     PLAYERBOSSHEALTH

    BRA     GAME_END ; BRanch Always (Go to)

DAMAGE_INCREASE:

    ADD.B   #2, D3 ; 2 + Player Damage
    MOVE.B  D3, $3004
    RTS

PLAYERBOSSHEALTH:

    OR.B    D2, (A1)
    RTS

DAMAGE_DEALT:

    SUB.B   D3, D2 ; Boss Health - Player DMG
    MOVE.B  D2, $3002
    RTS

TAKING_DAMAGE:

    SUB.B   #20, (A1) ; Player HP - 20
    BRA     BACK_IN_THE_GAME

HEALTH_PICKUP:

    ADD.B   #10, (A1) ; Player HP + 10
    
    ; Return To Sub-routine (Return to where got called from)
    RTS

GAME_END:

    MOVE.B  #$00, (A1) ; Player Death, Game Over
    MOVE.B  #14, D0    
    LEA     GAMEOVER, A1
    TRAP    #15
    LEA     TRYAGAIN, A1
    TRAP    #15

    SIMHALT
    
GAMEOVER    dc.b    'Game Over :(', $0D, $0A, 0 ; $0D = Inserts carriage return
TRYAGAIN    dc.b    'Try Again :)', 0           ; $0A = Insert line feed        Both == Newline

    END    START



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
