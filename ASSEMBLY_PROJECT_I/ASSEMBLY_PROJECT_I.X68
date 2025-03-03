*               ----------------------------------------------------------------------
*               | Title      : Ping Pong                                             |
*               | Student ID : C00295178                                             |
*               | Written by : Shehab Ahmed                                          |
*               | Date Create: 17/02/2025                                            |
*               | Description: 1-player Ping pong vs bot - Score accumulation style  |
*               ----------------------------------------------------------------------
*   ---------------------------------------------------------------------------------------------------
*   MAKE SURE .WAV FILE DECLARATIONS HAVE THE CORRECT FULL PATH TO DIRECTORY IN ORDER FOR AUDIO TO PLAY
*   ---------------------------------------------------------------------------------------------------
*   ---------------------------------------------------------------------------------------------------
*                                                   ENJOY!!
*   ---------------------------------------------------------------------------------------------------

   ORG   $1000

GRAY    EQU   $00808080
BLACK   EQU   $00000000
BLUE    EQU   $00FF0000
GREEN   EQU   $0000FF00


START:


GAME_LOOP:
* Echo off
    MOVE.B      #12, D0
    MOVE.B      #0, D1
    TRAP        #15

* Ball stats
    MOVE.L      #320, BALLX
    MOVE.L      #120, BALLY
    MOVE.L      #5, DELTAX
    MOVE.L      #5, DELTAY
    MOVE.L      #7, BALLSIZE

* Paddle stats
    MOVE.L      #32, PADDLESIZE

* Paddle 0 (Player)
    MOVE.L      #4, PADDLE0X
    MOVE.L      #240, PADDLE0Y
    MOVE.L      #0, PADDLE0D

* Paddle 1 (Bot)
    MOVE.L      #635, PADDLE1X
    MOVE.L      #240, PADDLE1Y
    MOVE.L      #0, PADDLE1D

* Scores
    MOVE.B      #0, SCORE0
    MOVE.B      #3, LIVES

* Enable double buffering
    MOVE.B      #92, D0
    MOVE.B      #17, D1
    TRAP        #15

UPDATE:
* draw stuff
    BSR         DRAWCOURT
    BSR         DRAWBALL
    BSR         DRAWPADDLE0
    BSR         DRAWPADDLE1
    BSR         DRAWSCORE

* pause for a bit and do input!

    MOVE.B      #8, D0      ; Get initial counter value
    TRAP        #15
    MOVE.L      D1, D2      ; Move it into temp space

PAUSE_LOOP:
    MOVE.B      #7, D0
    TRAP        #15
    CMP.B       #0, D1
    BEQ         FAILDOWN0
    MOVE.B      #5, D0
    TRAP        #15

    CMP.B       #'w', D1
    BNE         FAILUP0
    MOVE.L      #-4, PADDLE0D

FAILUP0:
    CMP.B       #'s', D1
    BNE         FAILDOWN0
    MOVE.L      #4, PADDLE0D

FAILDOWN0:
    MOVE.B      #8, D0      ; Get counter value
    TRAP        #15
    SUB.L       D2, D1      ; Subtract inital value from it
    CMP         #2, D1      ; Check if we have passed through 2/100ths of a second
    BLT         PAUSE_LOOP

* position paddles and move
    MOVE.L      PADDLE0Y, D6
    ADD.L       PADDLE0D, D6
    MOVE.L      D6, PADDLE0Y

* Bot logic: Move paddle1 toward the ball's Y position
    MOVE.L      BALLY, D6          ; Load ball's Y position
    MOVE.L      PADDLE1Y, D7       ; Load bot paddle's Y position
    CMP.L       D6, D7             ; Compare bot paddle Y with ball Y
    BLT         botMoveDown        ; If paddle is above the ball, move down
    BGT         botMoveUp          ; If paddle is below the ball, move up
    BRA         botMoveDone        ; If aligned, do nothing

botMoveDown:
    MOVE.L      #4, PADDLE1D    ; Move bot paddle down (slower than ball)
    BRA         botMoveDone

botMoveUp:
    MOVE.L      #-4, PADDLE1D   ; Move bot paddle up (slower than ball)
    BRA         botMoveDone

botMoveDone:
    MOVE.L      PADDLE1Y, D6
    ADD.L       PADDLE1D, D6
    MOVE.L      D6, PADDLE1Y

* fix paddles to screen
    MOVE.L      PADDLE0Y, D6
    SUB.L       PADDLESIZE, D6
    CMP         #16, D6
    BGT         PADDLE0NOFIX
    MOVE.L      #0, PADDLE0D

PADDLE0NOFIX:
    MOVE.L      PADDLE1Y, D6
    SUB.L       PADDLESIZE, D6
    CMP         #16, D6
    BGT         PADDLE1NOFIX
    MOVE.L      #0, PADDLE1D

PADDLE1NOFIX:
    MOVE.L      PADDLE0Y, D6
    ADD.L       PADDLESIZE, D6
    CMP         #480, D6
    BLT         PADDLE0NOFIX2
    MOVE.L      #0, PADDLE0D

PADDLE0NOFIX2:
    MOVE.L      PADDLE1Y, D6
    ADD.L       PADDLESIZE, D6
    CMP         #480, D6
    BLT         PADDLE1NOFIX2
    MOVE.L      #0, PADDLE1D

PADDLE1NOFIX2:

* position the ball and move it
    MOVE.L      BALLX, D6
    MOVE.L      BALLY, D7
    ADD.L       DELTAX, D6
    ADD.L       DELTAY, D7
    MOVE.L      D6, BALLX
    MOVE.L      D7, ballY

* check balls position and change delta accordingly

    BSR         SCREENCOLLIDE
    BSR         PADDLE0COLLIDE
    BSR         PADDLE1COLLIDE

    MOVE.B      #94, D0
    TRAP    #15

    MOVE.B      LIVES, D1
    CMP.B       #0, D1
    BEQ         GAME_END

    JMP         UPDATE

GAME_END:
* Clear the screen and display final message

    MOVE.B      #80, D0     ; Change the pen colour
    MOVE.L      #BLACK, D1
    TRAP    #15

    MOVE.B      #81, D0     ; Fill colour
    MOVE.L      #BLACK, D1
    TRAP    #15

    MOVE.L      #0, D1
    MOVE.L      #0, D2
    MOVE.L      #640, D3
    MOVE.L      #480, D4
    MOVE.B      #87, D0
    TRAP    #15

    MOVE.B      #80, D0     ; Change the pen colour
    MOVE.L      #BLUE, D1
    TRAP    #15

    MOVE.B      #81, D0     ; Fill colour
    MOVE.L      #BLACK, D1
    TRAP    #15

    MOVE.B      #11, D0
    MOVE.W      #$FF00,D1
    TRAP    #15
    
    LEA         YIPPEE, A1
    MOVE.B      #1, D1
    MOVE.B      #70, D0
    TRAP    #15
    MOVE.L      #0, D0

PLAYER0:
    MOVE        #14,D0              ; task number 14 (display null string)
    LEA         PLAYERWIN_MSG, A1   ; address of string
    TRAP    #15                     ; display it
    JMP         NOPLAY

* From here to the end of "FORLOOP1" draws final message when game ends

NOPLAY:
    MOVE.L      #0, D1
    MOVE.L      #0, D0
    
    LEA         FINAL_SCORE, A1
    MOVE.B      #13, D0

    MOVE.B      #9, D1
    TRAP    #15
    
    MOVE.B      #3, D0
    MOVE.B      SCORE0, D1
    TRAP    #15
    
    MOVE.L   #0, D7

FORLOOP0:
    MOVE.L      #0, D6

FORLOOP1:
    MOVE.B      #83, D0
    MOVE.L      D6, D1
    MOVE.L      D7, D2
    TRAP    #15
    MOVE.L      D0, D1
    MOVE.B      #80, D0
    TRAP    #15
    MOVE.L      D6, D1
    MOVE.L      D7, D2
    LSL.L       #2, D1
    LSL.L       #2, D2
    ADD.L       #96, D1
    ADD.L       #164, D2
    MOVE.L      D1, D3
    MOVE.L      D2, D4
    ADD.L       #6, D3
    ADD.L       #6, D4
    MOVE.B      #91, D0
    TRAP    #15
    ADD         #1, D6
    CMP         #320, D6
    BLT         FORLOOP1
    ADD         #1, D7
    CMP         #16, D7
    BLT         FORLOOP0
    MOVE.B      #94, D0
    TRAP    #15

* Clear the text off...
    MOVE.B   #80, D0   ; Change the pen colour
    MOVE.L   #BLACK, D1
    TRAP     #15

    MOVE.B  #81, D0    ; Fill colour
    MOVE.L   #BLACK, D1
    TRAP     #15

    MOVE.L   #0, D1
    MOVE.L   #0, D2
    MOVE.L   #320, D3
    MOVE.L   #16, D4

    MOVE.B   #87, D0
    TRAP     #15

* Now to quit
    STOP   #$2000
* =========== draw court subroutine ============
DRAWCOURT:
    MOVE.B   #80, D0   ; Change the pen colour
    MOVE.L   #BLACK, D1
    TRAP     #15

    MOVE.B   #81, D0   ; Fill colour
    MOVE.L   #BLACK, D1
    TRAP     #15

    MOVE.L   #0, D1
    MOVE.L   #0, D2
    MOVE.L   #640, D3
    MOVE.L   #480, D4
    MOVE.B   #87, D0
    TRAP     #15   

    MOVE.B   #80, D0   ; Change the pen colour
    MOVE.L   #GRAY, D1
    TRAP     #15

    MOVE.B   #81, D0   ; Fill colour
    MOVE.L   #GRAY, D1
    TRAP     #15

    MOVE.L   #319, D1   ; Center line
    MOVE.L   #0, D2
    MOVE.L   #321, D3
    MOVE.L   #480, D4
    MOVE.B   #87, D0
    TRAP     #15

    MOVE.L   #0, D1   ; Center line
    MOVE.L   #15, D2
    MOVE.L   #640, D3
    MOVE.L   #16, D4
    MOVE.B   #87, D0
    TRAP     #15

    MOVE.B   #80, D0   ; Change the pen colour
    MOVE.L   #GREEN, D1
    TRAP     #15

    MOVE.B   #81, D0   ; Fill colour
    MOVE.L   #GREEN, D1
    TRAP     #15
    RTS

* =========== draw score subroutine ============
DRAWSCORE:
    MOVE.B   #81, D0
    MOVE.L   #BLACK, D1
    TRAP     #15

* player score
    MOVE.B   #11, D0
    MOVE.W   #$0500,D1
    TRAP     #15

    MOVE.B      #10, D2
    
    MOVE.B      #14, D0
    MOVE.L      #0, D1
    LEA         SCORE_MSG, A1
    
    MOVE.B      #9, D1
    TRAP        #15
    
    MOVE.B      #3, D0
    MOVE.B      SCORE0, D1
    TRAP        #15


* lives

    MOVE.B      #11, D0
    MOVE.W      #$4300,D1
    TRAP        #15

    MOVE.B      #14, D0
    MOVE.L      #0, D1
    LEA         LIVES_MSG, A1
    
    MOVE.B      #9, D1
    TRAP        #15
    
    MOVE.B      #3, D0
    MOVE.B      LIVES, D1
    TRAP        #15

    RTS

* =========== draw ball subroutine ============
DRAWBALL:
    MOVE.L      BALLX, D6
    MOVE.L      BALLY, D7
    MOVE.L      D6, D1   ; Move X
    MOVE.L      D6, D3   ; Move X
    MOVE.L      D7, D2   ; Move Y
    MOVE.L      D7, D4   ; Move Y

    MOVE.L      BALLSIZE, D5   ; Give the ball a size
    SUB         D5, D1
    SUB         D5, D2
    ADD         D5, D3
    ADD         D5, D4

    MOVE.B      #88, D0   ; Draw a circle
    TRAP        #15

    RTS

* =========== draw paddle 0 subroutine ============
DRAWPADDLE0:
    MOVE.L      PADDLE0X, D6
    MOVE.L      PADDLE0Y, D7
    MOVE.L      D6, D1   ; Move X
    MOVE.L      D6, D3   ; Move X
    MOVE.L      D7, D2   ; Move Y
    MOVE.L      D7, D4   ; Move Y

    MOVE.L      BALLSIZE, D5   ; Give the paddle a size
    SUB         D5, D1
    ADD         D5, D3

    MOVE.L      PADDLESIZE, D5   ; Give the paddle a size
    SUB         D5, D2
    ADD         D5, D4

    MOVE.B      #87, D0   ; Draw a block
    TRAP        #15

    RTS

* =========== draw paddle 1 subroutine ============
DRAWPADDLE1:
    MOVE.L      PADDLE1X, D6
    MOVE.L      PADDLE1Y, D7
    MOVE.L      D6, D1   ; Move X
    MOVE.L      D6, D3   ; Move X
    MOVE.L      D7, D2   ; Move Y
    MOVE.L      D7, D4   ; Move Y

    MOVE.L      BALLSIZE, D5   ; Give the paddle a size
    SUB         D5, D1
    ADD         D5, D3

    MOVE.L      PADDLESIZE, D5   ; Give the paddle a size
    SUB         D5, D2
    ADD         D5, D4

    MOVE.B      #87, D0   ; Draw a block
    TRAP        #15

    RTS

* =========== collision with screen subroutine ============
SCREENCOLLIDE:
    CMP   #640, D6
    BGT   SCNBALLXREV0
    CMP   #0, D6
    BLT   SCNBALLXREV1
    CMP   #480, D7
    BGT   SCNBALLYREV
    CMP   #24, D7
    BLT   SCNBALLYREV
SCNENDY:
    RTS

* ---------- Player scores --------------
SCNBALLXREV0:
    MOVE.B   SCORE0, D0
    ADD.B    #5, D0
    MOVE.B   D0, SCORE0
    MOVE.L   #320, BALLX
    MOVE.L   #120, BALLY
    MOVE.L   #-5, DELTAX
    MOVE.L   #5, DELTAY
    RTS      Why wait when someones already scored?

* ---------- Bot scores -----------------
SCNBALLXREV1:

    MOVE.B      LIVES, D3
    SUB.B       #1, D3
    MOVE.B      D3, LIVES
    
    MOVE.L      #320, BALLX
    MOVE.L      #120, BALLY
    MOVE.L      #4, DELTAX
    MOVE.L      #5, DELTAY
    RTS         Why wait when someones already scored?


SCNBALLYREV: 
    MOVE.L      DELTAY, D0
    NEG.L       D0
    MOVE.L      D0, DELTAY
    JMP         SCNENDY


* =========== paddle0 collision subroutine ============
PADDLE0COLLIDE:
    MOVE.L      BALLX, D0
    MOVE.L      BALLY, D1
    MOVE.L      PADDLE0X, D6
    MOVE.L      PADDLE0Y, D7
    
* first off, are we actually like kinda within the y bounds
    MOVE.L      D7, D5
    SUB.L       PADDLESIZE, D5  ; Paddle Y top
    CMP         D5, D1          ; Compare ball Y with paddle Y
    BLT         FAILPADDLE0     ; If its less than we fail

    MOVE.L      D7, D5
    ADD.L       PADDLESIZE, D5  ; Paddle Y bottom
    CMP         D5, D1          ; Compare ball Y with paddle Y
    BGT         FAILPADDLE0     ; If its greater than we fail

* if its greater than the right
    ADD.L       BALLSIZE, D6
    CMP         D6, D0
    BGT         FAILPADDLE0

* we are colliding! lets invert 
    JMP         PDBALLXREV0
FAILPADDLE0:
    RTS

* =========== paddle1 collision subroutine ============ 
PADDLE1COLLIDE:
    MOVE.L      BALLX, D0
    MOVE.L      BALLY, D1
    MOVE.L      PADDLE1X, D6
    MOVE.L      PADDLE1Y, D7

* first off, are we actually like kinda within the y bounds
    MOVE.L      D7, D5
    SUB.L       PADDLESIZE, D5    ; Paddle Y top
    CMP         D5, D1            ; Compare ball Y with paddle Y
    BLT         FAILPADDLE1       ; If its less than we fail

    MOVE.L      D7, D5
    ADD.L       PADDLESIZE, D5    ; Paddle Y bottom
    CMP         D5, D1            ; Compare ball Y with paddle Y
    BGT         FAILPADDLE1       ; If its greater than we fail

* if its less than the left
    SUB.L       BALLSIZE, D6
    CMP         D6, D0
    BLT         FAILPADDLE1

* we are colliding! lets invert
    JMP         PDBALLXREV1

FAILPADDLE1:
    RTS

* =========== paddle collision response subishroutine ============
PDBALLXREV0:

    MOVE.B      SCORE0, D3
    ADD.B       #2, D3     ; Point adding for hitting the ball back
    MOVE.B      D3, SCORE0
    
    LEA         HITSOUND0, A1
    MOVE.B      #1, D1
    MOVE.B      #70, D0 ; Ping pong sound played
    TRAP    #15
    MOVE.L      #0, D0
    
    MOVE.L      DELTAX, D0
    NEG.L       D0
    MOVE.L      D0, DELTAX
    RTS
    
PDBALLXREV1:
    
    LEA         HITSOUND1, A1
    MOVE.B      #1, D1
    MOVE.B      #70, D0
    TRAP    #15
    MOVE.L      #0, D0
    
    MOVE.L      DELTAX, D0
    NEG.L       D0
    MOVE.L      D0, DELTAX
    
    RTS

BALLX           ds.l    1
BALLY           ds.l    1
DELTAX          ds.l    1
DELTAY          ds.l    1
BALLSIZE        ds.l    1
PADDLESIZE      ds.l    1
PADDLE0X        ds.l    1
PADDLE0Y        ds.l    1
PADDLE0D        ds.l    1
PADDLE1X        ds.l    1
PADDLE1Y        ds.l    1
PADDLE1D        ds.l    1
SCORE0          ds.b    1
LIVES           ds.b    1
PLAYERWIN_MSG   dc.b    'YIPPEEE! :D', $0A, $0D, 0
SCORE_MSG       dc.b    'Score: ', 0
LIVES_MSG       dc.b    'Lives: ', 0
HITSOUND0       dc.b    'C:\Users\user\Desktop\ASSEMBLY_PROJECT_I\pingpongDeep.wav', 0
HITSOUND1       dc.b    'C:\Users\user\Desktop\ASSEMBLY_PROJECT_I\pingpongSoft.wav', 0
YIPPEE          dc.b    'C:\Users\user\Desktop\ASSEMBLY_PROJECT_I\yippeeSound.wav', 0
FINAL_SCORE     dc.b    'FINAL SCORE: ', 0

    END   START
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
