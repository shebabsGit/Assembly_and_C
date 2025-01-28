    ORG    $1000
START:

    LEA     $4000, A1   ; A1 points towards memory location $4000
    MOVE.B  #100, (A1)  ; base10 100 is written in the memory location that A1 points to

    SIMHALT

    END    START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
