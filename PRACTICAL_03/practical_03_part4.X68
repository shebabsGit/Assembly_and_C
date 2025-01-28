    ORG    $1000
START:

    LEA     PLAYERHEALTH, A1
    LEA     BOSSHEALTH, A2
    LEA     PLAYERPOINTS, A3

    MOVE.B  #$63, (A1)
    MOVE.B  #$6A, (A2)
    MOVE.B  #$10, (A3)
    
    MOVE.L  BOSSDAMAGE, D1
    MOVE.B  PLAYERDAMAGE, D2
    
    SUB.B D1, (A1)
    SUB.B D2, (A2)
    SUB.B D1, (A1)
    
    ADD.W #$5, (A3)
    ADD.B #$10, (A3)
    SUB.B #$5, (A3)
    
    ADD.B #$10, PLAYERDAMAGE
    SUB.B #$5, (A2)

    SIMHALT

PLAYERHEALTH dc.b $64
BOSSHEALTH dc.b $64
PLAYERPOINTS dc.b $0
PLAYERDAMAGE dc.b $5
BOSSDAMAGE dc.b $10

    END    START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
