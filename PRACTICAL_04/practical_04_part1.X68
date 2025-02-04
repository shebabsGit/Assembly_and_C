    ORG    $1000
START:

    ; Move 100HP to memory location $3000
    MOVE.B  #100, $3000

    ; Load memory address $3000 into Address Register A1
    LEA     $3000, A1
    
    ; Hit for 20DMG
    SUB.B   #20, (A1)
    
    ; 10HP gained from health pack
    ADD.B   #10, (A1)

    SIMHALT

    END    START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
