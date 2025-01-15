

START:

    MOVE.L #%00001111,D1  ; "0F" moved to D1
    MOVE.B D1,D2          ; contents of D1 moved to D2
    MOVE.B D1,$2000       ; contents to D1 moved to memory location 2000
    MOVE.B $2000,D2       ; contents of memory location 2000 moved to D2
    MOVE.B $2000,$3000    ; contents of memory location 2000 moved to memory location 3000
    
                          ; All registers and memory locations named above have "00001111" or "0F" stored on them


    END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
