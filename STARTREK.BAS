                    '************************************
                    '*           Star  Trek             *
                    '*          By Alex Ford            *
                    '*          Version 8.0             *
                    '*     March 1, - May 30, 20001     *
                    '*   Action Packed Adventure Game!  *
                    '************************************
'****************************************************************************
SCREEN 12
RANDOMIZE TIMER
CONST true = -1, false = 0
CONST PI = 3.14
CONST empty = 0, WALL = 1, shipup = 2, shipdown = 3, shipleft = 4
CONST shipright = 5, enemy = 6, bonus = 7, exits = 8, screenwall = 9
CONST up = 1, down = 2, lefty = 3, righty = 4, stopped = 5
DIM board(19, 25)
DIM numenemies(500)
DIM erow(500)
DIM ecol(500)
DIM enemydir(500)
DIM shipup(625)
DIM shipdown(625)
DIM wormhole(625)
DIM shipleft(625)
DIM PHASERfire(625)
DIM shipright(625)
DIM enemy(625)
DIM WALL(625)
DIM bonus(625)
DIM brow(500)
DIM bcol(500)
DIM empty(625)
DIM exits(625)
DIM openexit(625)
CLS
IF donemain = false THEN
COLOR 2
INPUT "What do you want the speed to be? (Default = 32000): ", SPEED
IF SPEED = 0 THEN
        SPEED = 32000
END IF
liveses = 10
ekill$ = "Y"
enemyshot$ = "N"
cheatcode = 0
X = 1
'Main Program
CLS
GOSUB colorplt
GOSUB drawpics
GOSUB colorplt
GOSUB titlescreen
GOSUB game
END IF
'CHAIN "C:\WINDOWS\PROFILES\ALEX\DESKTOP\Q-BASI~1\GAMEINTO"
RESETFILE:
    OPEN "topten.dat" FOR OUTPUT AS #1
    FOR X = 1 TO 10
    PRINT #1, "Nobody"
    PRINT #1, 0
    NEXT X
    CLOSE #1
'RETURN
'****************************************************************************
'****************************************************************************
titlescreen:
CLS
FOR row = 1 TO 19
FOR col = 1 TO 25
PUT ((col - 1) * 25, (row - 1) * 25), empty, PSET
NEXT col
NEXT row
erow = 18
ecol = 24
col = 1
row = 1
PUT ((col - 1) * 25, (row - 1) * 25), shipright, PSET
PUT ((ecol - 1) * 25, (erow - 1) * 25), enemy, PSET
PUT ((11 - 1) * 25, ((1 - 1) * 25)), bonus, PSET
PUT ((11 - 1) * 25, ((18 - 1) * 25)), bonus, PSET
FOR col = 2 TO 11
PUT ((col - 2) * 25, (row - 1) * 25), empty, PSET
PUT ((col - 1) * 25, (row - 1) * 25), shipright, PSET
FOR DELAY = 1 TO SPEED
NEXT DELAY
NEXT col
FOR row = 2 TO 18
PUT ((11 - 1) * 25, (row - 2) * 25), empty, PSET
PUT ((11 - 1) * 25, (row - 1) * 25), shipdown, PSET
FOR DELAY = 1 TO SPEED
NEXT DELAY
NEXT row
PUT ((10) * 25, (18 - 1) * 25), shipright, PSET
FOR DELAY = 1 TO SPEED: NEXT DELAY

FOR col = 12 TO 23
PUT ((col - 1) * 25, (18 - 1) * 25), PHASERfire, PSET
FOR DELAY = 1 TO SPEED
NEXT DELAY
NEXT col
'explosion
FOR radius = 1 TO 15
CIRCLE (((ecol - 1) * 25) + 13, ((erow - 1) * 25) + 13), radius, 4
FOR DELAY = 1 TO SPEED
NEXT DELAY
NEXT radius
FOR radius = 15 TO 1 STEP -1
CIRCLE (((ecol - 1) * 25) + 13, ((erow - 1) * 25) + 13), radius, 0
FOR DELAY = 1 TO SPEED
NEXT DELAY
NEXT radius
LOCATE 12, 37
COLOR 2
PRINT "STAR TREK"
LOCATE 13, 36
COLOR 4
PRINT "Version 12.0"
LOCATE 14, 36
COLOR 2
PRINT "By Alex Ford "
LOCATE 15, 35
COLOR 1
PRINT "March 10, 2001"
DO
CLR = INT(RND * 2) + 1
IF CLR = 1 THEN
        COLOR 1
ELSEIF CLR = 2 THEN
        COLOR 2
END IF
LOCATE 16, 25
PRINT "NOTE: You can't really shoot phasers"
FOR DELAY = 1 TO SPEED
NEXT DELAY
LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
DEF SEG = &H40
POKE &H17, (PEEK(&H17) OR 64)
DEF SEG
RETURN
'****************************************************************************
blackplt:
CLS
FOR X = 1 TO 15
    PALETTE X, 0 * 65536 + 0 * 256 + 0
NEXT X
PALETTE 12, 63 * 65536 + 63 * 256 + 63
RETURN
'****************************************************************************
colorplt:
CLS
PALETTE 0, 0
PALETTE 1, 40 * 65536
PALETTE 2, 40 * 256
PALETTE 12, 63 * 256
PALETTE 3, 50 * 65536 + 50 * 256
PALETTE 4, 30
PALETTE 6, 0 * 65536 + 19 * 256 + 29
PALETTE 8, 20 * 65536 + 20 * 256 + 20
PALETTE 5, 32 * 65536 + 50 * 256 + 53
PALETTE 14, 63 * 256 + 63
PALETTE 13, 30 * 256 + 30
PALETTE 11, 33 * 65536 + 33 * 256 + 33
PALETTE 7, 50 * 65536 + 50 * 256 + 50
PALETTE 10, 20 * 65536 + 40 * 256 + 20
PALETTE 9, 30 * 65536 + 30 * 256 + 30
PALETTE 15, 30
RETURN
'****************************************************************************
drawpics:
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
GOSUB readempty
FOR DELAY = 1 TO SPEED: NEXT DELAY
GOSUB readwall
FOR DELAY = 1 TO SPEED: NEXT DELAY
GOSUB readstarship
FOR DELAY = 1 TO SPEED: NEXT DELAY
GOSUB readenemy
FOR DELAY = 1 TO SPEED: NEXT DELAY
GOSUB readexit
FOR DELAY = 1 TO SPEED: NEXT DELAY
GOSUB readBONUS
FOR DELAY = 1 TO SPEED: NEXT DELAY
GOSUB readPHASER
FOR DELAY = 1 TO SPEED: NEXT DELAY
GOSUB opnexit
FOR DELAY = 1 TO SPEED: NEXT DELAY
GOSUB Readwormhole
FOR DELAY = 1 TO SPEED: NEXT DELAY
RETURN
Readwormhole:
CLS
CIRCLE (13, 13), 13, 15
CIRCLE (13, 13), 12, 0
CIRCLE (13, 13), 11, 4
CIRCLE (13, 13), 10, 4
CIRCLE (13, 13), 9, 0
CIRCLE (13, 13), 8, 0
CIRCLE (13, 13), 7, 2
CIRCLE (13, 13), 6, 0
CIRCLE (13, 13), 5, 2
CIRCLE (13, 13), 4, 15
CIRCLE (13, 13), 3, 15
CIRCLE (13, 13), 2, 0
CIRCLE (13, 13), 1, 2
CIRCLE (13, 13), 0, 0
GET (1, 1)-(25, 25), wormhole
RETURN
readstarship:
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
RESTORE starship
FOR col = 1 TO 25
        FOR row = 1 TO 25
                READ c
                PSET (col, row), c
                FOR DELAY = 1 TO 1
                NEXT DELAY
        NEXT row
NEXT col
GET (1, 1)-(25, 25), shipup
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
RESTORE starship
FOR col = 1 TO 25
        FOR row = 1 TO 25
                READ c
                PSET (col, (24 - row)), c
                FOR DELAY = 1 TO 1
                NEXT DELAY
        NEXT row
NEXT col
GET (1, 1)-(25, 25), shipdown
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
RESTORE starship
FOR row = 1 TO 25
        FOR col = 1 TO 25
                READ c
                PSET (col, row), c
                FOR DELAY = 1 TO 1
                NEXT DELAY
        NEXT col
NEXT row
GET (1, 1)-(25, 25), shipleft
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
RESTORE starship
FOR row = 1 TO 25
        FOR col = 1 TO 25
                READ c
                PSET ((24 - col), row), c
                FOR DELAY = 1 TO 1
                NEXT DELAY
        NEXT col
NEXT row
GET (1, 1)-(25, 25), shipright
RETURN
'............................................................................
readenemy:
CLS
LINE (1, 12)-(15, 25), 8, B' Front box face
LINE (1, 12)-(10, 5), 8' diagonal line from top left of box
LINE (10, 5)-(23, 5), 8' horizontal line from top left diagonal
LINE (23, 5)-(15, 12), 8' middle diagonal from top horizontal
LINE (23, 5)-(23, 18), 8' far right vertical
LINE (15, 25)-(23, 18), 8' far right bottom diagonal
LINE (5, 11)-(5, 24), 1' left blue on flat face square
LINE (10, 11)-(10, 24), 2' right green on flat face square
LINE (5, 11)-(13, 6), 2' left green on top square
LINE (10, 11)-(18, 6), 1' right blue on top square
LINE (2, 16)-(15, 16), 1' top blue on flat face square
LINE (2, 20)-(15, 20), 2' bottom green on flat face square
LINE (15, 16)-(22, 10), 2' top green on right square
LINE (15, 20)-(22, 14), 1' bottom blue on right square
LINE (8, 7)-(21, 7), 1' top blue on top square
LINE (6, 9)-(18, 9), 2' bottom green on top square
LINE (21, 7)-(21, 18), 2' right green on right square
LINE (18, 9)-(18, 20), 1' left blue on right square
GET (1, 1)-(25, 25), enemy
RETURN
'............................................................................
readempty:
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
numstar = 0
DO
starrow = INT(RND * 25) + 1
starcol = INT(RND * 25) + 1
starcolo = INT(RND * 3) + 1
IF starcolo = 1 THEN
        starcolor = 1
ELSEIF starcolo = 2 THEN
        starcolor = 2
ELSEIF starcolo = 3 THEN
        starcolor = 15
END IF
PSET (starcol, starrow), starcolor
numstar = numstar + 1
LOOP UNTIL numstar = 12
GET (1, 1)-(25, 25), empty
RETURN
'............................................................................
readPHASER:
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
PUT (1, 1), empty, PSET
LINE (1, 13)-(25, 13), 4
GET (1, 1)-(25, 25), PHASERfire
RETURN
'............................................................................
readexit:
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
PUT (1, 1), empty, PSET
LINE (1, 1)-(25, 25), exitcolor, B
LINE (1, 25)-(25, 1), exitcolor, B
LINE (1, 1)-(25, 25), exitcolor, B
GET (1, 1)-(25, 25), exits
RETURN
'............................................................................
readwall:
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
wallcolor = INT(RND * 2) + 1
IF wallcolor = 2 THEN
        exitcolor = 1
ELSEIF wallcolor = 1 THEN
        exitcolor = 2
END IF
PUT (1, 1), empty, PSET
LINE (1, 1)-(25, 25), wallcolor, B
LINE (1, 25)-(25, 1), wallcolor, B
LINE (1, 1)-(25, 25), wallcolor, B
GET (1, 1)-(25, 25), WALL
RETURN
'............................................................................
opnexit:
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
CIRCLE (13, 13), 12, 6, 0 * PI, 2 * PI, .5
PAINT (13, 13), 15, 6
LINE (13, 1)-(1, 25), 15
LINE (13, 1)-(25, 25), 15
LINE (25, 25)-(17, 17), 15
LINE (17, 17)-(1, 25), 15
PAINT (13, 13), 15, 15
GET (1, 1)-(25, 25), openexit
RETURN
'............................................................................
readBONUS:
CLS
LOCATE 13, 30
COLOR 12
PRINT "Please Wait..."
CIRCLE (13, 13), 12, 6, 0 * PI, 2 * PI, .5
PAINT (13, 13), 6, 6
LINE (13, 1)-(1, 25), 8
LINE (13, 1)-(25, 25), 8
LINE (25, 25)-(17, 17), 8
LINE (17, 17)-(1, 25), 8
PAINT (13, 13), 8, 8
GET (1, 1)-(25, 25), bonus
RETURN
game:
GOSUB menu
RETURN
playgame:
CLS
COLOR 2
PRINT "Enter Level Password: ";
COLOR 4
INPUT "", pass$
IF pass$ = "WARP" THEN
        level = 2
ELSEIF pass$ = "REACTOR" THEN
        level = 3
ELSEIF pass$ = "HELM" THEN
        level = 4
ELSEIF pass$ = "INTREPID CLASS" THEN
        level = 5
ELSEIF pass$ = "PORT" THEN
        level = 6
ELSEIF pass$ = "PHASER" THEN
        level = 7
ELSEIF pass$ = "PHOTON" THEN
        level = 8
ELSEIF pass$ = "GALAXY CLASS" THEN
        level = 9
ELSEIF pass$ = "STARSHIP" THEN
        level = 10
ELSEIF pass$ = "SHIELDS" THEN
        level = 11
ELSEIF pass$ = "STARBASE" THEN
        level = 12
ELSEIF pass$ = "STARFLEET" THEN
        level = 13
ELSEIF pass$ = "SICKBAY" THEN
        level = 14
ELSEIF pass$ = "DELTA" THEN
        level = 15
ELSEIF pass$ = "CAPTAIN" THEN
        level = 16
ELSEIF pass$ = "ENSIGN" THEN
        level = 17
ELSEIF pass$ = "PICARD" THEN
        level = 18
ELSEIF pass$ = "BEVERLY" THEN
        level = 19
ELSEIF pass$ = "PILOT" THEN
        level = 20
ELSEIF pass$ = "VOYAGER" THEN
        level = 21
ELSEIF pass$ = "QUADRANT" THEN
        level = 22
ELSEIF pass$ = "DATA" THEN
        level = 23
ELSEIF pass$ = "ROMULANS" THEN
        level = 24
ELSEIF pass$ = "FEDERATION" THEN
        level = 25
ELSEIF pass$ = "STAR TREK" THEN
        CLS
        COLOR 2
        PRINT "Enter Level: ";
        COLOR 4
        INPUT "", level
        IF level > 25 THEN
            level = 25
        END IF
ELSE
        level = 1
END IF
scorecatch = 0
c$ = INKEY$
donegame = false
donelev = false
GOSUB lchanger
WHILE NOT donegame
    lives = liveses
    transport = 3
    direction = stopped
    allenemies = numenemies
    board(exitrow, exitcol) = WALL
    bonuscatch = 0
    WHILE NOT donelev
        IF colorcheat$ = "Y" OR colorcheat$ = "y" THEN
        pcolors = INT(RND * 63) + 0
        pcolrs2 = INT(RND * 63) + 0
        pcolrs3 = INT(RND * 63) + 0
        IF Siezurecheat$ = "Y" OR Siezurecheat$ = "y" THEN
        COLR = INT(RND * 15) + 0
        ELSE
        COLR = INT(RND * 15) + 1
        END IF
        PALETTE COLR, pcolrs * 65536 + pcolrs2 * 256 + pcolrs3
        END IF
        IF dircheat$ = "Y" THEN
                bonuscatch = allbonus
                direction = INT(RND * righty) + up
        END IF
        IF c$ <> "" THEN
            GOSUB keystruck
        END IF
        LOCATE 1, 1
        COLOR exitcolor
        PRINT "Lives: "; lives; ", Score: "; scorecatch; ", Speed: "; SPEED; "    "
        P = INT(RND * 63) + 1
        p2 = INT(RND * 63) + 1
        p3 = INT(RND * 63) + 1
        PALETTE 15, P * 65536 + p2 * 256 + p3

        GOSUB move
        IF youfaster$ = "Y" OR youfaster$ = "y" THEN
            GOSUB move
        END IF
        IF enemywallcheat$ = "Y" THEN
            board(srow, scol) = screenwall
        END IF
        IF enemyshot$ = "N" OR enemyshot$ = "n" THEN
        FOR X = 1 TO numenemies
        IF srow = erow(X) AND scol = ecol(X) THEN
                lives = lives - 1: board(srow, scol) = empty
                scorecatch = scorecatch - 1000
                'PLAY "T255o2l1dl4dl1g"
                direction = stopped
M = 0
DO
FOR s = 850 TO 810 STEP -1
        SOUND (RND * 100 + s / 10 + 30), .1
NEXT s
M = M + 1
LOOP UNTIL M = 7
                SLEEP 1
                PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
                IF invisiship$ = "Y" OR invisiship$ = "y" OR level = 23 THEN
                PUT ((startcol - 1) * 25, (startrow - 1) * 25), empty, PSET
                ELSE
                PUT ((startcol - 1) * 25, (startrow - 1) * 25), shipup, PRESET
                END IF
                srow = startrow
                scol = startcol
        END IF
        NEXT X
        END IF
        IF scorecatch < 0 THEN
                scorecatch = 0
        END IF
        IF lives <= 0 THEN
                CLS
                COLOR 4
                PRINT "Too Bad!"
                DO
                LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
                donelev = true
                donegame = true
        END IF
        GOSUB enemymove
        IF enemyfaster$ = "Y" OR enemyfaster$ = "y" THEN
            GOSUB enemymove
        END IF
        FOR DELAY = 1 TO SPEED
        NEXT DELAY
        c$ = INKEY$
    IF srow = startrow AND scol = startcol THEN
        PUT ((startcol - 1) * 25, (startrow - 1) * 25), shipup, PRESET
    END IF
    IF WALLAPEAR$ = "Y" THEN
    brow = INT(RND * 17) + 2
    bcol = INT(RND * 23) + 2
    IF brow = exitrow AND bcol = exitcol THEN
    ELSE
    IF board(brow, bcol) < WALL THEN
    PUT ((bcol - 1) * 25, (brow - 1) * 25), exits, PSET
    board(brow, bcol) = exits
    END IF
    END IF
    END IF
   
    IF bonuscatch >= allbonus THEN
        board(exitrow, exitcol) = exits
        PUT ((exitcol - 1) * 25, (exitrow - 1) * 25), openexit, PSET
    END IF
    WEND
    IF donegame = false THEN
        COLOR 2
        LOCATE 15, 35
        PRINT "Good job!"
        COLR = 0
        DO
        row = INT(RND * 481) + 0
        col = INT(RND * 641) + 0
        row2 = INT(RND * 481) + 0
        col2 = INT(RND * 641) + 0
        row3 = INT(RND * 481) + 0
        col3 = INT(RND * 641) + 0
        PSET (col, row), COLR
        PSET (col2, row2), COLR
        FOR radius = 1 TO 10
        CIRCLE (col3, row3), radius, COLR
        NEXT radius
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        FOR radius = 1 TO 400
        CIRCLE (320, 240), radius, 4
        NEXT radius
        FOR radius = 400 TO 1 STEP -1
        CIRCLE (320, 240), radius, 0
        NEXT radius
        COLOR 2
        LOCATE 15, 35
        PRINT "Good job!"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        GOSUB colorplt
        level = level + 1
        GOSUB lchanger
        donelev = false
    END IF
WEND
GOSUB topten
GOSUB colorplt
RETURN
'************************************************************************************************************
'this subroutine checks witch way to move
keystruck:
IF c$ = CHR$(0) + "H" THEN
    direction = up
    IF ch$ = "yes" THEN
        ch$ = "no"
        board(srow, scol) = empty
    END IF
    board(startrow, startcol) = screenwall
ELSEIF c$ = CHR$(0) + "P" THEN
    direction = down
    IF ch$ = "yes" THEN
        ch$ = "no"
        board(srow, scol) = empty
    END IF
    board(startrow, startcol) = screenwall
ELSEIF c$ = CHR$(0) + "K" THEN
    direction = lefty
    IF ch$ = "yes" THEN
        ch$ = "no"
        board(srow, scol) = empty
    END IF
    board(startrow, startcol) = screenwall
ELSEIF c$ = CHR$(0) + "M" THEN
    direction = righty
    IF ch$ = "yes" THEN
        ch$ = "no"
        board(srow, scol) = empty
    END IF
    board(startrow, startcol) = screenwall
ELSEIF c$ = "F" OR c$ = "f" THEN
        IF scorecatch >= 100 THEN
        board(srow, scol) = screenwall
        ch$ = "yes"
        IF direction = up THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipup, PRESET
        ELSEIF direction = down THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipdown, PRESET
        ELSEIF direction = lefty THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipleft, PRESET
        ELSEIF direction = righty THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipright, PRESET
        ELSEIF direction = stopped THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipup, PRESET
        END IF
        direction = stopped
        END IF
ELSEIF c$ = "8" THEN
        SPEED = SPEED - 500
        IF SPEED < 0 THEN
                SPEED = 0
        END IF
ELSEIF c$ = "2" THEN
        SPEED = SPEED + 500
ELSEIF c$ = "`" THEN
        IF cheatkeys$ = "Y" THEN
        bonuscatch = allbonus
        END IF
ELSEIF c$ = "=" THEN
        IF cheatkeys$ = "Y" THEN
        numenemies = numenemies + 1
        IF numenemies > allenemies THEN
                numenemies = allenemies
        END IF
        END IF
ELSEIF c$ = "-" THEN
        IF cheatkeys$ = "Y" THEN
        IF numenemies > 0 THEN
        FOR radius = 1 TO 13
        CIRCLE (((ecol(numenemies) - 1) * 25) + 12, ((erow(numenemies) - 1) * 25) + 12), radius, 4
        FOR DELAY = 1 TO SPEED
        NEXT DELAY
        NEXT radius
        FOR radius = 13 TO 1 STEP -1
        CIRCLE (((ecol(numenemies) - 1) * 25) + 12, ((erow(numenemies) - 1) * 25) + 12), radius, 0
        FOR DELAY = 1 TO SPEED
        NEXT DELAY
        NEXT radius
        END IF
        numenemies = numenemies - 1
        IF numenemies < 0 THEN
                numenemies = 0
        END IF
        END IF
ELSEIF c$ = "~" THEN
        IF cheatkeys$ = "Y" THEN
        srow = exitrow
        scol = exitcol
        END IF
ELSEIF c$ = CHR$(27) THEN
        donegame = true
        donelev = true
ELSEIF c$ = CHR$(32) THEN
        direction = stopped
        IF wallblock$ = "Y" THEN
           board(srow, scol) = WALL
        END IF
ELSEIF c$ = "S" OR c$ = "s" THEN
        IF scorecatch >= 10000 THEN
        transport = transport + 1
        scorecatch = scorecatch - 10000
        END IF
END IF
RETURN
'************************************************************************************************************
'this subroutine makes the player move
move:
        IF srow = exitrow AND scol = exitcol THEN
                donelev = true
        END IF
        IF colorcheat$ = "Y" OR colorcheat$ = "y" THEN
        pcolors = INT(RND * 63) + 0
        pcolrs2 = INT(RND * 63) + 0
        pcolrs3 = INT(RND * 63) + 0
        COLR = INT(RND * 15) + 1
        PALETTE COLR, pcolrs * 65536 + pcolrs2 * 256 + pcolrs3
        END IF
        IF ekill$ = "y" OR ekill$ = "Y" THEN
        FOR X = 1 TO numenemies
        IF srow = erow(X) AND scol = ecol(X) THEN
                lives = lives - 1: board(srow, scol) = empty
                
                scorecatch = scorecatch - 1000
                'PLAY "T255o2l1dl4dl1g"
                direction = stopped
M = 0
DO
FOR s = 850 TO 810 STEP -1
        SOUND (RND * 100 + s / 10 + 30), .1
NEXT s
M = M + 1
LOOP UNTIL M = 7

                SLEEP 1
                PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
                IF invisiship$ = "Y" OR invisiship$ = "y" OR level = 23 THEN
                PUT ((startcol - 1) * 25, (startrow - 1) * 25), empty, PSET
                ELSE
                PUT ((startcol - 1) * 25, (startrow - 1) * 25), shipup, PRESET
                END IF
                srow = startrow
                scol = startcol
        END IF
        NEXT X
        END IF
IF direction = up THEN
   IF board(srow - 1, scol) <> WALL THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
        srow = srow - 1
        IF invisiship$ = "Y" OR invisiship$ = "y" OR level = 23 THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
        ELSE
         PUT ((scol - 1) * 25, (srow - 1) * 25), shipup, PSET
        END IF
    END IF
ELSEIF direction = down THEN
    IF board(srow + 1, scol) <> WALL THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
        srow = srow + 1
        IF invisiship$ = "Y" OR invisiship$ = "y" OR level = 23 THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
        ELSE
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipdown, PSET
        END IF
    END IF
ELSEIF direction = lefty THEN
    IF board(srow, scol - 1) <> WALL THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
        scol = scol - 1
        IF invisiship$ = "Y" OR invisiship$ = "y" OR level = 23 THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
        ELSE
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipleft, PSET
        END IF
    END IF
ELSEIF direction = righty THEN
    IF board(srow, scol + 1) <> WALL THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
        scol = scol + 1
        IF invisiship$ = "Y" OR invisiship$ = "y" OR level = 23 THEN
        PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
        ELSE
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipright, PSET
        END IF
    END IF
END IF
IF board(srow, scol) = bonus THEN
        bonuscatch = bonuscatch + 1
        scorecatch = scorecatch + 1000
        board(srow, scol) = empty
ELSEIF board(srow, scol) = exits THEN
        board(srow, scol) = empty
        IF WALLAPEAR$ = "Y" THEN
        ELSE
        PLAY "L30DAC"
        END IF
        scorecatch = scorecatch + 5000
END IF
        IF srow = exitrow AND scol = exitcol THEN
                donelev = true
        END IF
IF srow >= 19 AND board(srow, scol) = 10 THEN
        srow = 2
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipdown, PSET
        PUT ((scol - 1) * 25, (19 - 1) * 25), wormhole, PSET
ELSEIF srow <= 1 AND board(srow, scol) = 10 THEN
        srow = 18
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipup, PSET
        PUT ((scol - 1) * 25, (1 - 1) * 25), wormhole, PSET
ELSEIF scol >= 25 AND board(srow, scol) = 10 THEN
        scol = 2
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipright, PSET
        PUT ((25 - 1) * 25, (srow - 1) * 25), wormhole, PSET
ELSEIF scol <= 1 AND board(srow, scol) = 10 THEN
        scol = 24
        PUT ((scol - 1) * 25, (srow - 1) * 25), shipleft, PSET
        PUT ((1 - 1) * 25, (srow - 1) * 25), wormhole, PSET
END IF

RETURN
'************************************************************************************************************
'this subroutine makes the enemy move
enemymove:
IF ch$ = "yes" THEN
    scorecatch = scorecatch - 100
    IF scorecatch <= 0 THEN
        ch$ = "no"
    PUT ((scol - 1) * 25, (srow - 1) * 25), shipup, PSET
    END IF
END IF
FOR X = 1 TO numenemies
        IF colorcheat$ = "Y" OR colorcheat$ = "y" THEN
        pcolors = INT(RND * 63) + 0
        pcolrs2 = INT(RND * 63) + 0
        pcolrs3 = INT(RND * 63) + 0
        COLR = INT(RND * 15) + 1
        PALETTE COLR, pcolrs * 65536 + pcolrs2 * 256 + pcolrs3
        END IF
IF ekill$ = "y" OR ekill$ = "Y" THEN
        IF srow = erow(X) AND scol = ecol(X) THEN
                lives = lives - 1: board(srow, scol) = empty
                
                direction = stopped
M = 0
DO
FOR s = 850 TO 810 STEP -1
        SOUND (RND * 100 + s / 10 + 30), .1
NEXT s
M = M + 1
LOOP UNTIL M = 7
                SLEEP 1
                PUT ((scol - 1) * 25, (srow - 1) * 25), empty, PSET
                IF invisiship$ = "Y" OR invisiship$ = "y" OR level = 23 THEN
                PUT ((startcol - 1) * 25, (startrow - 1) * 25), empty, PSET
                ELSE
                PUT ((startcol - 1) * 25, (startrow - 1) * 25), shipup, PRESET
                END IF
                srow = startrow
                scol = startcol
        END IF
END IF
    numchoices = 0
    IF enemydir(X) = up THEN
        IF board(erow(X) - 1, ecol(X)) <> WALL AND board(erow(X) - 1, ecol(X)) <> exits AND board(erow(X) - 1, ecol(X)) <> bonus AND board(erow(X) - 1, ecol(X)) <> screenwall THEN
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), empty, PSET
            erow(X) = erow(X) - 1
IF erow(X) >= 19 THEN
        erow(X) = 2
        PUT ((ecol(X) - 1) * 25, (19 - 1) * 25), wormhole, PSET
ELSEIF erow(X) <= 1 THEN
        erow(X) = 18
        PUT ((ecol(X) - 1) * 25, (1 - 1) * 25), wormhole, PSET
ELSEIF ecol(X) >= 25 THEN
        ecol(X) = 2
        PUT ((25 - 1) * 25, (erow(X) - 1) * 25), wormhole, PSET
ELSEIF ecol(X) <= 1 THEN
        ecol(X) = 24
        PUT ((1 - 1) * 25, (erow(X) - 1) * 25), wormhole, PSET
END IF
            IF invisienemy$ = "Y" OR invisienemy$ = "y" OR level = 24 THEN
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), empty, PSET
            ELSE
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), enemy, PSET
            END IF
        END IF
        IF board(erow(X), ecol(X) - 1) <> WALL AND board(erow(X), ecol(X) - 1) <> exits AND board(erow(X), ecol(X) - 1) <> bonus AND board(erow(X), ecol(X) - 1) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = lefty
        END IF
        IF board(erow(X) - 1, ecol(X)) <> WALL AND board(erow(X) - 1, ecol(X)) <> exits AND board(erow(X) - 1, ecol(X)) <> bonus AND board(erow(X) - 1, ecol(X)) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = up
        END IF
        IF board(erow(X), ecol(X) + 1) <> WALL AND board(erow(X), ecol(X) + 1) <> exits AND board(erow(X), ecol(X) + 1) <> bonus AND board(erow(X), ecol(X) + 1) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = righty
        END IF
        IF numchoices > 0 THEN
            enemydir(X) = choices(INT(RND * numchoices) + 1)
        ELSE
            enemydir(X) = down
        END IF
    ELSEIF enemydir(X) = down THEN
        IF board(erow(X) + 1, ecol(X)) <> WALL AND board(erow(X) + 1, ecol(X)) <> exits AND board(erow(X) + 1, ecol(X)) <> bonus AND board(erow(X) + 1, ecol(X)) <> screenwall THEN
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), empty, PSET
            erow(X) = erow(X) + 1
IF erow(X) >= 19 THEN
        erow(X) = 2
        PUT ((ecol(X) - 1) * 25, (19 - 1) * 25), wormhole, PSET
ELSEIF erow(X) <= 1 THEN
        erow(X) = 18
        PUT ((ecol(X) - 1) * 25, (1 - 1) * 25), wormhole, PSET
ELSEIF ecol(X) >= 25 THEN
        ecol(X) = 2
        PUT ((25 - 1) * 25, (erow(X) - 1) * 25), wormhole, PSET
ELSEIF ecol(X) <= 1 THEN
        ecol(X) = 24
        PUT ((1 - 1) * 25, (erow(X) - 1) * 25), wormhole, PSET
END IF
            IF invisienemy$ = "Y" OR invisienemy$ = "y" OR level = 24 THEN
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), empty, PSET
            ELSE
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), enemy, PSET
            END IF
        END IF
        IF board(erow(X), ecol(X) - 1) <> WALL AND board(erow(X), ecol(X) - 1) <> exits AND board(erow(X), ecol(X) - 1) <> bonus AND board(erow(X), ecol(X) - 1) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = lefty
        END IF
      IF board(erow(X) + 1, ecol(X)) <> WALL AND board(erow(X) + 1, ecol(X)) <> exits AND board(erow(X) + 1, ecol(X)) <> bonus AND board(erow(X) + 1, ecol(X)) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = down
        END IF
        IF board(erow(X), ecol(X) + 1) <> WALL AND board(erow(X), ecol(X) + 1) <> exits AND board(erow(X), ecol(X) + 1) <> bonus AND board(erow(X), ecol(X) + 1) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = righty
        END IF
        IF numchoices > 0 THEN
            enemydir(X) = choices(INT(RND * numchoices) + 1)
        ELSE
            enemydir(X) = up
        END IF
    ELSEIF enemydir(X) = lefty THEN
        IF board(erow(X), ecol(X) - 1) <> WALL AND board(erow(X), ecol(X) - 1) <> exits AND board(erow(X), ecol(X) - 1) <> bonus AND board(erow(X), ecol(X) - 1) <> screenwall THEN
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), empty, PSET
            ecol(X) = ecol(X) - 1
IF erow(X) >= 19 THEN
        erow(X) = 2
        PUT ((ecol(X) - 1) * 25, (19 - 1) * 25), wormhole, PSET
ELSEIF erow(X) <= 1 THEN
        erow(X) = 18
        PUT ((ecol(X) - 1) * 25, (1 - 1) * 25), wormhole, PSET
ELSEIF ecol(X) >= 25 THEN
        ecol(X) = 2
        PUT ((25 - 1) * 25, (erow(X) - 1) * 25), wormhole, PSET
ELSEIF ecol(X) <= 1 THEN
        ecol(X) = 24
        PUT ((1 - 1) * 25, (erow(X) - 1) * 25), wormhole, PSET
END IF
            IF invisienemy$ = "Y" OR invisienemy$ = "y" OR level = 24 THEN
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), empty, PSET
            ELSE
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), enemy, PSET
            END IF
        END IF
        IF board(erow(X) - 1, ecol(X)) <> WALL AND board(erow(X) - 1, ecol(X)) <> exits AND board(erow(X) - 1, ecol(X)) <> bonus AND board(erow(X) - 1, ecol(X)) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = up
        END IF
        IF board(erow(X) + 1, ecol(X)) <> WALL AND board(erow(X) + 1, ecol(X)) <> exits AND board(erow(X) + 1, ecol(X)) <> bonus AND board(erow(X) + 1, ecol(X)) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = down
        END IF
        IF board(erow(X), ecol(X) - 1) <> WALL AND board(erow(X), ecol(X) - 1) <> exits AND board(erow(X), ecol(X) - 1) <> bonus AND board(erow(X), ecol(X) - 1) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = lefty
        END IF
        IF numchoices > 0 THEN
            enemydir(X) = choices(INT(RND * numchoices) + 1)
        ELSE
            enemydir(X) = righty
        END IF
    ELSEIF enemydir(X) = righty THEN
        IF board(erow(X), ecol(X) + 1) <> WALL AND board(erow(X), ecol(X) + 1) <> exits AND board(erow(X), ecol(X) + 1) <> bonus AND board(erow(X), ecol(X) + 1) <> screenwall THEN
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), empty, PSET
            ecol(X) = ecol(X) + 1
IF erow(X) >= 19 THEN
        erow(X) = 2
        PUT ((ecol(X) - 1) * 25, (19 - 1) * 25), wormhole, PSET
ELSEIF erow(X) <= 1 THEN
        erow(X) = 18
        PUT ((ecol(X) - 1) * 25, (1 - 1) * 25), wormhole, PSET
ELSEIF ecol(X) >= 25 THEN
        ecol(X) = 2
        PUT ((25 - 1) * 25, (erow(X) - 1) * 25), wormhole, PSET
ELSEIF ecol(X) <= 1 THEN
        ecol(X) = 24
        PUT ((1 - 1) * 25, (erow(X) - 1) * 25), wormhole, PSET
END IF
            IF invisienemy$ = "Y" OR invisienemy$ = "y" OR level = 24 THEN
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), empty, PSET
            ELSE
            PUT ((ecol(X) - 1) * 25, (erow(X) - 1) * 25), enemy, PSET
            END IF
        END IF
        IF board(erow(X) - 1, ecol(X)) <> WALL AND board(erow(X) - 1, ecol(X)) <> exits AND board(erow(X) - 1, ecol(X)) <> bonus AND board(erow(X) - 1, ecol(X)) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = up
        END IF
        IF board(erow(X) + 1, ecol(X)) <> WALL AND board(erow(X) + 1, ecol(X)) <> exits AND board(erow(X) + 1, ecol(X)) <> bonus AND board(erow(X) + 1, ecol(X)) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = down
        END IF
        IF board(erow(X), ecol(X) + 1) <> WALL AND board(erow(X), ecol(X) + 1) <> exits AND board(erow(X), ecol(X) + 1) <> bonus AND board(erow(X), ecol(X) + 1) <> screenwall THEN
            numchoices = numchoices + 1
            choices(numchoices) = righty
        END IF
        IF numchoices > 0 THEN
            enemydir(X) = choices(INT(RND * numchoices) + 1)
        ELSE
            enemydir(X) = lefty
        END IF
    END IF
IF erow(X) >= 19 THEN
        erow(X) = 2
        PUT ((ecol(X) - 1) * 25, (19 - 1) * 25), wormhole, PSET
ELSEIF erow(X) <= 1 THEN
        erow(X) = 18
        PUT ((ecol(X) - 1) * 25, (1 - 1) * 25), wormhole, PSET
ELSEIF ecol(X) >= 25 THEN
        ecol(X) = 2
        PUT ((25 - 1) * 25, (erow(X) - 1) * 25), wormhole, PSET
ELSEIF ecol(X) <= 1 THEN
        ecol(X) = 24
        PUT ((1 - 1) * 25, (erow(X) - 1) * 25), wormhole, PSET
END IF
NEXT X
RETURN
menu:
GOSUB colorplt
CLS
donemenu = false
WHILE NOT donemenu
CLS
numstar = 0
DO
l1 = INT(RND * 640) + 1
l2 = INT(RND * 480) + 1
scolr = INT(RND * 2) + 1
PSET (l1, l2), scolr
numstar = numstar + 1
LOOP UNTIL numstar = 1000
LOCATE 12, 30
COLOR 2
PRINT "Main STAR TREK Menu"
COLOR 1
LOCATE 13, 30
PRINT "1) Instructions"
LOCATE 14, 30
PRINT "2) Play Game"
LOCATE 15, 30
PRINT "3) Cheats"
LOCATE 16, 30
PRINT "4) Speed"
LOCATE 17, 30
PRINT "5) Top Ten"
LOCATE 18, 30
PRINT "6) Exit"
COLOR 2
LOCATE 19, 30
INPUT "What is your choice?: ", mainchc
IF mainchc = 1 THEN
        GOSUB instructions
ELSEIF mainchc = 2 THEN
        GOSUB playgame
ELSEIF mainchc = 3 THEN
        GOSUB cheatmenu
ELSEIF mainchc = 4 THEN
        CLS
        COLOR 2
        INPUT "What do you want speed to be? (32000 = Default): ", SPEED
        IF SPEED = 0 THEN
                SPEED = 32000
        END IF
        CLS
ELSEIF mainchc = 5 THEN
        CLS
        GOSUB topten
ELSEIF mainchc = 6 THEN
        donemenu = true
ELSE
        BEEP
END IF
WEND
END
cheatmenu:
GOSUB colorplt
CLS
enemycheat$ = "N"
IF cheatcode = 0 THEN
COLOR 2
PRINT "Enter Password: ";
COLOR 4
INPUT "", cheatpass$
IF cheatpass$ = "USS ENTERPRISE NCC 1701D" THEN
        cheatcode = 1
ELSE
        cheatcode = 0
END IF
END IF
IF cheatcode = 1 THEN
        CLS
        COLOR 2
        PRINT "Do you want enemies to kill you every time they hit you? (Y\N): ";
        COLOR 4
        INPUT "", ekill$
        IF ekill$ = "N" OR ekill$ = "n" THEN
                COLOR 2
                PRINT "Do you want to be invivcible? (Y\N): ";
                COLOR 4
                INPUT "", enemyshot$
        END IF
        COLOR 2
        PRINT "Do you want invisibility for your ship? (Y/N): ";
        COLOR 4
        INPUT "", invisiship$
        COLOR 2
        PRINT "Do you want invisibility for the enemies? (Y/N): ";
        COLOR 4
        INPUT "", invisienemy$
        COLOR 2
        PRINT "Do you want invisibility for the walls? (Y/N): ";
        COLOR 4
        INPUT "", invisiwall$
        COLOR 2
        PRINT "Do you want your ship to be a Borg Cube? (Y/N): ";
        COLOR 4
        INPUT "", enemycheat$
        COLOR 2
        PRINT "Do you want multicolored levels? (Y/N): ";
        COLOR 4
        INPUT "", colorcheat$
        COLOR 2
        PRINT "Do you want to enable random appearing walls? (Y/N): ";
        COLOR 4
        INPUT "", WALLAPEAR$
        GOSUB blackplt
        IF enemycheat$ = "Y" OR enemycheat$ = "y" THEN
            CLS
            PUT (1, 1), enemy, PSET
            GET (1, 1)-(25, 25), shipup
            GET (1, 1)-(25, 25), shipdown
            GET (1, 1)-(25, 25), shipleft
            GET (1, 1)-(25, 25), shipright
        ELSE
        GOSUB readstarship
        END IF
        GOSUB colorplt
END IF
RETURN
instructions:
CLS
COLOR 4
PRINT "This is the Star Fleet Insignia"
PUT (1, 25), bonus, PSET
DO
LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
CLS fs
PRINT "These are the wormholes"
PUT (1, 25), wormhole, PSET
DO
p1 = INT(RND * 63) + 1
p2 = INT(RND * 63) + 1
p3 = INT(RND * 63) + 1
PALETTE 15, p1 * 65536 + p2 * 256 + p3
LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
CLS
PRINT "This is your ship (The Enterprise D)"
PUT (1, 25), shipup, PSET
DO
p1 = INT(RND * 63) + 1
p2 = INT(RND * 63) + 1
p3 = INT(RND * 63) + 1
PALETTE 15, p1 * 65536 + p2 * 256 + p3
LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
CLS
PRINT "This is your enemy (The Borg)"
PUT (1, 25), enemy, PSET
DO
LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
CLS
PRINT "These are the walls"
PUT (1, 25), WALL, PSET
DO
p1 = INT(RND * 63) + 1
p2 = INT(RND * 63) + 1
p3 = INT(RND * 63) + 1
PALETTE 15, p1 * 65536 + p2 * 256 + p3
LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
CLS
PRINT "This is the exit"
PUT (1, 25), openexit, PSET
DO
p1 = INT(RND * 63) + 1
p2 = INT(RND * 63) + 1
p3 = INT(RND * 63) + 1
PALETTE 15, p1 * 65536 + p2 * 256 + p3
LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
COLOR 4
CLS
PRINT "The object of the game is to get all the Star Fleet Insignia"
PRINT "(Com Badges) and then get to the exit without hitting any enemies."
PRINT "If you hit an enemy you loose one of your "; liveses; " lives"
PRINT "and are sent to the starting point of that level. If you go through"
PRINT "one of the wormholes you will apear on the other side. Also you have"
PRINT "shields, when you use shields it takes 100 points from your score"
PRINT "until you shut off shields. To shut off shields just start moving."
PRINT "GOOD LUCK!"
PRINT
COLOR 3
PRINT
PRINT "Up: up arrow"
PRINT "Down: down arrow"
PRINT "Left: left arrow"
PRINT "Right: right arrow"
PRINT "Stop: Space Bar"
PRINT "Speed faster: 8"
PRINT "Speed slower: 2"
PRINT "Exit level: Escape"
PRINT "Shields: F"
PRINT "Trade 10000 score points for transports: S"
PRINT "Transport: T"
DO
LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
RETURN
lchanger:
CLS
numenemies = 0
allbonus = 0
COLOR 4
IF level = 1 THEN
        PRINT "Level 1"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level1
ELSEIF level = 0 THEN
        RESTORE level17
ELSEIF level = 2 THEN
        PRINT "Level 2"
        PRINT "Password:  WARP"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level2
ELSEIF level = 3 THEN
        PRINT "Level 3"
        PRINT "Password:  REACTOR"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level3
ELSEIF level = 4 THEN
        PRINT "Level 4"
        PRINT "Password:  HELM"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level4
ELSEIF level = 5 THEN
        PRINT "Level 5"
        PRINT "Password:  INTREPID CLASS"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level5
ELSEIF level = 6 THEN
        PRINT "Level 6"
        PRINT "Password:  PORT"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level6
ELSEIF level = 7 THEN
        PRINT "Level 7"
        PRINT "Password:  PHASER"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level7
ELSEIF level = 8 THEN
        PRINT "Level 8"
        PRINT "Password:  PHOTON"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level8
ELSEIF level = 9 THEN
        PRINT "Level 9"
        PRINT "Password:  GALAXY CLASS"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level9
ELSEIF level = 10 THEN
        PRINT "Level 10"
        PRINT "Password:  STARSHIP"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level10
ELSEIF level = 11 THEN
        PRINT "Level 11"
        PRINT "Password:  SHIELDS"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level11
ELSEIF level = 12 THEN
        PRINT "Level 12"
        PRINT "Password:  STARBASE"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level12
ELSEIF level = 13 THEN
        PRINT "Level 13"
        PRINT "Password: STARFLEET"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level13
ELSEIF level = 14 THEN
        PRINT "Level 14"
        PRINT "Password: SICKBAY"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level14
ELSEIF level = 15 THEN
        PRINT "Level 15"
        PRINT "Password: DELTA"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level15
ELSEIF level = 16 THEN
        COLOR 4
        LOCATE 15, 10
        PRINT "The password to the cheat menu is: ";
        COLOR 2
        PRINT "USS ENTERPRISE NCC 1701D"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        CLS
        COLOR 4
        PRINT "Level 16"
        PRINT "Password: CAPTAIN"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level16
ELSEIF level = 17 THEN
        PRINT "Level 17"
        PRINT "Password: ENSIGN"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level17
ELSEIF level = 18 THEN
        PRINT "Level 18"
        PRINT "Password: PICARD"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level18
ELSEIF level = 19 THEN
        PRINT "Level 19"
        PRINT "Password: BEVERLY"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level19
ELSEIF level = 20 THEN
        PRINT "Level 20"
        PRINT "Password: PILOT"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level20
ELSEIF level = 21 THEN
        PRINT "Level 21"
        PRINT "Password: VOYAGER"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level21
ELSEIF level = 22 THEN
        PRINT "Level 22"
        PRINT "Password: QUADRANT"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level22
ELSEIF level = 23 THEN
        PRINT "Level 23"
        PRINT "Password: DATA"
        COLOR 2
        PRINT "You will be invisible in this level!"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level23
ELSEIF level = 24 THEN
        PRINT "Level 24"
        PRINT "Password: ROMULANS"
        COLOR 2
        PRINT "The enemies will be invisible in this level!"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level24
ELSEIF level = 25 THEN
        PRINT "Level 25"
        PRINT "Password: FEDERATION"
        COLOR 2
        PRINT "The walls will be invisible in this level!"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE level25
ELSEIF level = 26 THEN
        COLOR 2
        LOCATE 15, 20
        PRINT "You won the whole game congratulations!"
        DO
        LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
        RESTORE starship
        donelev = true
        donegame = true
END IF
FOR row = 1 TO 19
FOR col = 1 TO 25
READ board(row, col)
IF board(row, col) = WALL THEN
        IF invisiwall$ = "Y" OR invisiwall$ = "y" OR level = 25 THEN
        PUT ((col - 1) * 25, (row - 1) * 25), empty, PSET
        ELSE
        PUT ((col - 1) * 25, (row - 1) * 25), WALL, PSET
        END IF
ELSEIF board(row, col) = empty THEN
        PUT ((col - 1) * 25, (row - 1) * 25), empty, PSET
ELSEIF board(row, col) = shipup OR board(row, col) = shipdown OR board(row, col) = shipleft OR board(row, col) = shipright THEN
        srow = row
        scol = col
        startrow = srow
        startcol = scol
        IF invisiship$ = "Y" OR invisiship$ = "y" OR level = 23 THEN
        PUT ((col - 1) * 25, (row - 1) * 25), empty, PSET
        ELSE
        PUT ((col - 1) * 25, (row - 1) * 25), shipup, PRESET
        END IF
        board(row, col) = screenwall
ELSEIF board(row, col) = enemy THEN
        numenemies = numenemies + 1
        board(row, col) = empty
        erow(numenemies) = row
        ecol(numenemies) = col
        enemydir(numenemies) = INT(RND * 4) + 1
        IF invisienemy$ = "Y" OR invisienemy$ = "y" OR level = 24 THEN
        PUT ((col - 1) * 25, (row - 1) * 25), empty, PSET
        ELSE
        PUT ((col - 1) * 25, (row - 1) * 25), enemy, PSET
        END IF
ELSEIF board(row, col) = bonus THEN
        allbonus = allbonus + 1
        PUT ((col - 1) * 25, (row - 1) * 25), bonus, PSET
ELSEIF board(row, col) = exits THEN
        exitrow = row
        exitcol = col
        PUT ((col - 1) * 25, (row - 1) * 25), exits, PSET
ELSEIF board(row, col) = 10 THEN
        PUT ((col - 1) * 25, (row - 1) * 25), wormhole, PSET
END IF
NEXT col
NEXT row
PUT ((exitcol - 1) * 25, (exitrow - 1) * 25), WALL, PSET
RETURN
'****************************************************************************
starship:
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,0
DATA 0,0,0,8,8,8,8,8,8,0,0,0,0,8,8,10,10,10,10,10,10,10,8,8,0
DATA 0,0,8,8,8,8,8,8,8,8,0,0,0,8,8,10,15,15,15,15,15,10,8,8,0
DATA 0,8,8,8,8,2,2,2,8,8,0,0,0,8,8,10,15,15,15,15,15,10,8,8,0
DATA 8,8,8,2,2,2,2,2,2,8,8,0,0,8,8,10,10,10,10,10,10,10,8,8,0
DATA 8,8,2,2,2,2,2,2,2,2,8,0,0,8,8,8,8,8,8,8,8,8,8,8,0
DATA 8,8,2,2,2,2,2,2,2,2,8,8,0,0,8,8,8,8,8,8,8,8,8,0,0
DATA 8,8,2,2,2,1,1,1,2,2,2,8,8,0,0,0,8,8,8,0,0,0,0,0,0
DATA 8,8,2,2,1,1,1,1,1,2,2,2,8,8,8,8,8,8,8,8,0,0,0,0,0
DATA 8,8,2,2,1,15,15,15,1,2,2,2,8,8,8,8,8,8,8,8,0,0,0,0,0
DATA 8,8,2,2,1,15,15,15,1,2,2,2,8,8,8,8,8,8,8,8,0,0,0,0,0
DATA 8,8,2,2,1,15,15,15,1,2,2,2,8,8,8,8,8,8,8,8,0,0,0,0,0
DATA 8,8,2,2,1,1,1,1,1,2,2,8,8,8,8,8,8,8,8,8,0,0,0,0,0
DATA 8,8,2,2,2,1,1,1,2,2,8,8,0,0,0,0,8,8,8,0,0,0,0,0,0
DATA 8,8,2,2,2,2,2,2,2,2,8,0,0,0,8,8,8,8,8,8,8,8,8,0,0
DATA 8,8,8,2,2,2,2,2,2,8,8,0,0,8,8,8,8,8,8,8,8,8,8,8,0
DATA 0,8,8,8,2,2,2,2,8,8,0,0,0,8,8,10,10,10,10,10,10,10,8,8,0
DATA 0,0,8,8,8,8,8,8,8,8,0,0,0,8,8,10,15,15,15,15,15,10,8,8,0
DATA 0,0,0,8,8,8,8,8,8,0,0,0,0,8,8,10,15,15,15,15,15,10,8,8,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,10,10,10,10,10,10,10,8,8,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,0,0
DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
level1:
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,7,0,0,1
DATA 1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,7,0,0,1
DATA 1,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,1,0,7,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,8,1,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,2,1,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,1,7,1,0,0,0,0,1,7,1,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,8,8,7,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,1,7,1,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,1,1
DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,6,6,6,6,6,6,1
DATA 1,0,0,0,0,1,0,0,0,1,1,8,1,1,1,0,0,1,0,0,0,0,0,0,1
DATA 1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1
DATA 10,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,6,1,7,0,10
DATA 1,0,1,1,7,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,8,8,8,8,1
DATA 10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,7,1,7,0,10
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level2:
DATA 1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,0,8,7,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,0,1,0,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,0,1,0,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1,1,0,1
DATA 1,0,1,0,1,0,0,1,0,1,0,1,1,1,1,1,0,1,1,7,7,0,1,0,1
DATA 1,0,1,0,1,0,1,1,0,1,0,1,0,0,0,1,0,0,6,0,1,0,1,0,1
DATA 1,0,1,0,1,0,0,1,0,1,0,1,0,1,0,1,0,6,6,0,1,0,1,0,1
DATA 1,0,1,0,1,1,0,1,0,1,0,1,7,1,0,1,0,0,6,0,0,0,1,0,1
DATA 1,0,1,0,0,0,0,1,0,0,0,7,2,1,0,1,1,1,1,1,1,0,1,0,1
DATA 1,0,1,0,1,1,1,1,1,1,1,1,8,1,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,1,0,8,0,0,0,0,0,0,0,8,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,0,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,7,1
DATA 1,0,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,1,1,1,1,1,1,1
DATA 1,0,1,0,1,0,7,1,1,1,0,0,1,0,0,0,0,1,0,0,0,7,0,0,1
DATA 1,0,1,0,1,1,1,0,0,0,1,7,1,0,0,0,0,1,0,0,0,0,0,0,1
DATA 1,0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,1
DATA 1,0,1,1,1,1,1,1,0,1,1,1,1,1,0,1,1,1,0,0,0,0,0,0,1
DATA 10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level3:
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 8,3,0,0,0,0,0,0,0,0,1,0,6,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,6,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,6,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,6,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,6,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,6,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,6,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,6,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,6,0,1,0,0,0,0,0,0,0,0,7,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level4:
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,1
DATA 1,3,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,0,1,0,8,7,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,7,1,0,1
DATA 10,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0,1,1,0,0,10
DATA 1,0,1,0,1,0,0,0,0,0,0,0,1,6,6,6,1,0,1,0,0,0,1,0,1
DATA 1,0,1,0,1,0,0,0,0,0,0,0,1,6,6,0,1,0,1,0,1,0,1,0,1
DATA 1,7,1,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0,1,0,1,0,1
DATA 1,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1
DATA 1,0,1,0,1,1,7,0,0,1,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1
DATA 1,0,1,0,8,8,0,0,0,1,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1
DATA 1,0,1,0,1,1,1,0,0,1,0,0,0,0,7,0,0,0,1,0,1,0,1,0,1
DATA 1,0,1,0,1,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1
DATA 1,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1
DATA 1,0,1,1,1,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,1,0,1,0,1
DATA 1,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,7,0,1
DATA 1,0,1,0,1,0,1,0,0,0,1,0,0,0,0,0,1,1,1,1,1,1,1,0,1
DATA 1,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,8
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level5:
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,0,1,1,1,1,1,1,8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,0,1,0,0,0,6,6,6,6,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,1,0,1,0,0,0,1,8,1,0,0,0,0,0,0,6,6,0,0,0,1,0,1
DATA 1,0,1,0,1,0,0,0,8,8,0,0,0,0,0,0,0,0,0,0,0,7,1,0,1
DATA 1,0,1,0,1,7,1,1,1,1,1,7,1,1,1,0,0,1,1,1,1,1,1,0,1
DATA 1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,1,6,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,1
DATA 1,0,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,1
DATA 1,0,0,0,0,0,1,0,0,0,0,1,1,1,1,1,0,0,0,7,1,1,1,1,1
DATA 1,1,1,1,1,1,1,1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,1,0,1,0,1,1,1,1,1,1,1,1,1,0,0,1
DATA 1,1,1,0,1,0,1,1,0,1,1,1,0,1,0,0,0,0,0,0,0,1,0,1,1
DATA 1,0,0,7,0,0,0,1,0,0,0,0,0,1,0,1,1,0,1,1,0,1,0,0,1
DATA 1,4,1,1,0,1,0,1,1,1,1,1,1,1,0,1,0,0,0,1,0,1,1,0,1
DATA 10,0,0,0,7,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,10
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level6:
DATA 1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,1,1
DATA 10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 10,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 10,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,0,0,0,7,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,0,1,1,1,1
DATA 10,0,0,0,7,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,0,0,0,7,0,0,0,0,0,0,0,1,0,0,0,0,0,0,6,6,6,6,6,1
DATA 10,0,0,0,7,0,0,0,0,0,0,0,1,0,0,0,0,0,0,6,6,6,6,6,10
DATA 1,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,7,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,7,1
DATA 1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,8,1
level7:
DATA 1,8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,6,6,6,6,6,0,0,1,0,0,0,7,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,1
DATA 1,0,0,0,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,1,1,7,1,1,1,1,1,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,7,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1
DATA 1,0,1,7,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,1
DATA 1,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,1,1,0,1,0,1
DATA 1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,1
DATA 1,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,1
DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1,0,1,7,1,1,0,1
DATA 1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,0,1,0,1,1,0,1
DATA 1,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,1,0,1,1,0,1
DATA 1,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,1,1,1,0,1,1,0,1
DATA 1,0,0,0,0,0,0,0,0,7,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,1,1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,1
DATA 10,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,4,0,10
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level8:
DATA 1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,3,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,1
DATA 1,0,1,7,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,0,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,0,1,0,1,0,0,1,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,1,0,0,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,0,0,0,1,7,7,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,7,1,1,1,8,1,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,1,0,0,1
DATA 1,6,6,6,6,6,0,0,0,8,0,0,0,1,0,0,0,0,1,0,0,1,0,0,1
DATA 1,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,1
DATA 1,6,6,6,6,6,1,1,0,0,1,1,1,1,0,0,0,0,1,0,0,1,0,0,1
DATA 1,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0,1,0,0,1,0,0,1
DATA 1,8,0,0,0,1,0,1,0,7,0,0,0,0,0,0,0,7,1,0,0,0,0,0,1
DATA 1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level9:
DATA 1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,1,1,1,1,1,1,0,1,1,7,1,0,0,0,0,0,0,0,1,0,0,1
DATA 1,1,0,1,1,7,1,0,0,0,1,0,1,1,0,0,0,0,0,0,0,1,0,0,1
DATA 1,0,0,1,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,0,0,1,0,0,1
DATA 1,0,0,1,0,1,1,1,1,1,1,0,0,1,1,1,1,1,0,0,0,0,0,0,1
DATA 1,0,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,7,0,1
DATA 1,0,0,1,0,1,1,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1
DATA 1,0,0,1,0,1,7,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1
DATA 1,1,0,1,0,1,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1
DATA 1,0,0,1,0,1,0,1,0,0,1,0,0,1,1,1,1,1,0,0,0,0,0,0,1
DATA 1,0,1,1,0,1,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,1,0,1,0,1,0,0,1,0,0,1,0,0,0,0,1,0,0,1,1,1,1
DATA 1,1,0,1,0,1,0,1,0,0,1,0,0,1,0,7,0,0,1,0,0,0,0,0,1
DATA 1,0,0,1,0,1,0,1,0,0,1,0,0,8,0,0,0,0,1,0,6,6,6,0,1
DATA 1,0,1,1,0,1,0,1,0,0,1,0,0,1,0,0,0,0,1,0,6,6,6,0,1
DATA 1,0,0,0,0,1,0,1,0,0,1,7,7,1,0,0,0,0,1,0,6,6,6,0,1
DATA 1,0,0,0,0,0,0,1,0,0,7,4,0,1,0,0,0,8,1,0,0,6,0,0,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1
level10:
DATA 1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1
DATA 1,0,0,0,1,0,1,0,1,0,0,0,1,6,6,6,6,1,0,0,0,0,0,0,1
DATA 1,0,0,0,1,0,1,0,1,0,0,0,1,0,0,6,0,1,0,1,1,1,1,0,1
DATA 1,0,0,0,1,0,1,0,1,0,0,0,1,0,0,0,0,1,0,1,0,1,0,0,1
DATA 1,0,0,0,1,0,1,0,1,0,0,0,1,0,0,0,0,1,0,1,0,1,0,0,1
DATA 1,0,0,0,1,0,1,0,1,0,0,0,1,6,6,6,6,1,0,1,0,1,0,0,1
DATA 1,0,0,0,1,7,1,0,1,0,0,0,1,0,0,6,0,1,0,1,0,1,0,0,1
DATA 1,0,0,0,1,8,1,0,1,0,0,0,1,0,0,0,7,1,0,7,0,0,0,0,1
DATA 10,0,0,0,1,0,0,0,1,0,0,0,1,0,1,1,1,1,0,1,1,7,0,0,10
DATA 1,1,1,1,7,7,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,7,7,1,1
DATA 1,5,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,8,1
DATA 1,1,1,1,7,7,1,0,1,1,0,0,1,0,0,0,0,0,0,1,0,7,7,1,1
DATA 10,0,0,0,1,0,1,0,1,1,0,0,1,0,0,1,1,1,1,1,1,1,0,0,10
DATA 1,0,0,0,1,0,1,0,1,1,0,0,1,0,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,0,0,1,0,1,1,1,1,1,7,1,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,0,0,0,0,0,0,0,0,0,7,0,7,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1
level11:
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 10,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,3,7,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,7,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,1
DATA 1,1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1
DATA 1,0,0,1,8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,7,1
DATA 1,0,1,6,6,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,1,6,6,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,6,6,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,1,1,1,1,0,1,1,1,1,1,1,0,0,0,7,0,0,1,0,0,0,1
DATA 1,0,8,8,0,0,0,0,0,7,0,0,0,0,0,0,0,7,0,0,1,0,0,0,1
DATA 1,0,1,0,1,1,1,1,1,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,1,0,7,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,0,1,0,0,1,1,1,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,1
DATA 1,0,0,7,7,0,0,0,0,0,0,0,0,0,7,0,7,0,0,0,0,0,0,0,1
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level12:
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 10,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,7,6,0,0,0,0,0,0,10
DATA 1,7,2,7,0,0,0,0,0,0,0,0,0,0,0,7,1,0,0,0,0,0,1,0,1
DATA 1,0,7,0,0,0,0,0,7,0,0,0,0,0,7,0,0,0,0,0,0,1,0,0,1
DATA 1,0,0,0,0,0,0,7,0,0,0,0,0,7,1,0,0,0,0,0,1,0,0,0,1
DATA 1,0,0,0,0,0,7,0,0,0,0,0,7,6,0,0,0,0,0,1,0,0,0,0,1
DATA 1,0,0,0,0,7,0,0,0,0,0,7,1,0,0,0,0,0,1,0,0,0,0,0,1
DATA 1,0,0,0,7,0,0,0,0,0,7,0,0,0,0,0,0,1,0,0,0,0,0,0,1
DATA 1,0,0,7,0,0,0,0,0,7,1,0,0,0,0,0,1,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,7,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,7,1,0,0,0,0,0,8,6,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,7,6,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,7,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,10,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1
DATA 1,7,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,7,6,1
DATA 1,0,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,8,1
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level13:
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,3,0,0,0,0,0,0,0,0,1,1,7,1,1,1,7,1,1,1,1,1,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,1,1,1,1,1,1,1,1,8,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,1,1,1,1,1,1,8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,1,1,1,1,1,1,1,1,8,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 10,0,0,0,0,0,0,0,0,0,0,0,7,7,7,0,0,0,0,0,0,0,0,0,10
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,7,1,1,1,1,0,1,1,8,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,1,1,1,1,1,1,1,1,8,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,1,1,1,1,1,1,8,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1
DATA 1,0,0,0,0,0,0,6,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,1
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level14:
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1
DATA 1,7,0,0,0,0,0,0,7,1,8,1,5,0,7,0,0,0,0,0,0,0,7,7,1
DATA 1,0,0,0,0,0,0,0,0,1,0,1,7,7,0,0,0,0,0,0,0,0,1,1,1
DATA 1,0,0,0,0,0,0,0,0,1,0,7,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,6,6,0,0,6,0,1,1,1,0,1,0,0,0,1,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,7,1,7,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,7,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,7,1
DATA 10,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,6,1,7,0,10
DATA 1,7,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,7,1
DATA 1,0,0,0,0,0,0,0,0,0,7,1,0,1,7,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,7,0,0,0,0,0,1,0,1,0,0,0,6,6,6,6,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1
level15:
DATA 1,8,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1
DATA 1,7,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
DATA 1,0,0,0,0,0,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,1
DATA 1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1
DATA 1,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,1
DATA 1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,7,1,7,1,7,1,0,1,1
DATA 1,0,0,0,0,7,0,0,0,6,6,0,0,6,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
DATA 1,0,0,0,0,0,0,0,0,6,0,0,6,6,0,0,0,0,7,7,7,0,0,0,1
DATA 1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1
DATA 1,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,1
DATA 1,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,0,7,0,0,7,2,1
DATA 1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1
DATA 1,1,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1
level16:
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1
DATA 1,0,1,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1,0,1,8,1
DATA 1,7,7,1,1,1,0,0,1,0,0,6,0,0,0,0,0,0,0,1,1,7,7,0,1
DATA 1,1,7,1,1,1,0,0,1,0,0,0,0,0,0,0,0,6,0,1,0,1,1,7,1
DATA 1,1,7,1,1,1,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,1
DATA 10,0,7,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,7,0,10
DATA 1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,0,1,0,0,1,1,1
DATA 1,1,7,7,7,7,0,0,0,1,6,0,0,0,0,0,6,1,0,0,0,0,1,0,1
DATA 1,0,0,0,0,1,0,0,0,1,0,0,0,6,0,0,0,1,0,0,0,0,1,0,1
DATA 1,0,0,0,0,1,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1
DATA 1,0,0,0,0,1,0,0,0,1,6,0,0,0,0,0,6,1,0,0,1,0,0,0,1
DATA 1,0,0,0,0,1,0,0,0,1,1,1,1,1,1,1,1,1,0,0,1,0,0,0,1
DATA 1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1
DATA 1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,1
DATA 1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,1
DATA 1,0,0,0,0,1,0,6,0,0,0,7,7,0,0,0,6,0,0,0,1,1,1,1,1
DATA 10,0,2,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,7,0,10
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1
level17:
DATA 1,10,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,10,1,1,1,1
DATA 1,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,1,7,7,7,0,1,7,7,1
DATA 1,7,8,0,0,1,0,0,0,0,0,1,0,0,0,0,1,1,7,7,7,8,7,7,1
DATA 1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,7,6,1,1,1,1,0,0,1
DATA 1,1,1,1,0,0,0,0,0,0,0,1,0,0,0,0,1,7,7,7,7,1,0,0,1
DATA 1,0,0,0,0,0,7,0,0,0,0,1,7,7,0,0,1,1,1,1,7,1,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,1,7,7,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,8,1,1,1,1,1,1
DATA 1,0,0,8,1,1,8,0,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,1,1,1,1,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,8,7,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,6,0,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,6,0,0,0,0,1,1,1
DATA 10,0,0,0,0,0,0,7,7,7,7,7,7,7,7,7,1,0,0,0,0,0,8,0,10
DATA 1,1,1,1,1,1,1,1,1,1,7,7,7,7,7,7,1,0,0,1,1,1,1,1,1
DATA 10,0,0,0,0,0,0,0,0,1,7,7,6,7,7,7,1,0,0,1,1,7,7,0,10
DATA 1,7,0,0,0,0,0,0,0,1,1,1,7,1,1,1,1,0,0,8,8,1,7,1,1
DATA 1,0,2,0,0,0,0,0,0,0,0,8,0,8,0,0,0,0,0,1,0,1,7,8,1
DATA 1,10,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,10,1,1,1,1
level18:
DATA 1,10,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,1
DATA 1,7,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,0,1
DATA 1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,7,1,1,1,1,1,0,1
DATA 1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,7,1,7,1,6,1,0,1
DATA 1,0,0,0,0,1,0,0,0,1,1,0,0,0,0,0,1,7,1,7,1,7,1,0,1
DATA 1,6,0,0,1,0,0,0,1,0,0,0,0,0,0,0,1,1,7,7,1,7,1,0,1
DATA 1,0,0,1,0,0,0,1,0,0,1,0,0,0,0,0,1,1,7,1,1,7,1,0,1
DATA 1,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1,1,7,1,1,7,1,0,1
DATA 1,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,1,1,7,1,1,7,1,6,1
DATA 1,0,1,1,1,0,0,1,0,0,0,0,0,0,0,0,1,1,7,7,1,7,1,0,1
DATA 1,0,7,1,0,0,0,0,6,0,0,0,0,0,0,0,1,1,1,7,1,7,1,0,1
DATA 1,0,7,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1,1,7,1,7,1,0,1
DATA 1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,7,1,7,1,0,1
DATA 1,0,1,1,0,6,1,1,1,1,1,1,1,0,0,0,1,1,1,7,1,7,1,0,1
DATA 1,0,1,0,0,0,1,6,7,7,7,7,1,0,0,0,1,1,1,7,1,7,1,7,1
DATA 1,7,1,0,0,0,1,7,7,7,7,7,1,0,0,0,1,1,1,7,1,7,1,1,1
DATA 10,0,2,1,0,0,1,7,0,7,7,7,1,0,0,0,0,0,0,6,1,0,0,0,10
DATA 1,10,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level19:
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,7,0,0,0,7,1,7,0,6,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,8,7,8,6,0,0,0,0,1,7,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,1,7,1,0,0,6,0,0,1,7,7,0,1
DATA 1,0,0,0,6,0,0,0,0,0,0,0,1,7,1,0,0,0,0,0,1,0,7,0,1
DATA 1,0,0,0,0,0,6,0,0,0,0,0,1,7,1,0,0,0,0,8,1,0,7,0,1
DATA 1,7,0,0,0,0,0,0,0,0,0,0,1,7,1,1,1,0,1,1,1,0,0,0,1
DATA 10,0,7,1,0,0,0,0,0,0,0,0,1,7,7,7,1,0,0,0,0,0,0,0,10
DATA 1,7,3,1,0,0,0,0,0,0,0,0,1,7,7,7,1,1,1,1,1,1,1,1,1
DATA 1,7,7,7,1,0,0,0,0,0,0,0,1,1,1,1,1,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,1,0,0,0,0,0,0,1,7,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1
DATA 1,0,1,0,0,0,0,0,7,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,1
DATA 1,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,7,0,0,0,0,0,0,0,1
DATA 1,0,1,0,6,6,6,0,0,0,1,0,0,0,0,0,1,0,0,0,6,0,0,0,1
DATA 1,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1
level20:
DATA 1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,7,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,7,1
DATA 1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6,1
DATA 1,0,0,0,1,0,0,0,7,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,1
DATA 1,0,6,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,1
DATA 1,1,1,1,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,1
DATA 10,0,0,0,0,0,0,0,0,0,0,1,2,1,0,0,0,0,0,0,0,0,0,0,10
DATA 1,0,0,0,0,0,0,0,0,0,0,1,8,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1
DATA 1,6,0,0,0,0,0,0,1,7,7,7,7,7,7,7,7,7,7,7,7,7,1,6,1
DATA 1,7,6,0,0,0,0,0,1,7,7,7,0,7,7,7,7,7,7,7,7,6,1,7,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1
level21:
DATA 1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,7,7,1,0,0,0,0,1,0,1,5,7,0,0,0,0,0,0,0,0,0,7,1
DATA 1,7,7,7,1,0,0,0,0,1,0,7,1,8,1,1,1,0,0,0,0,0,0,0,1
DATA 1,7,7,6,1,0,0,0,0,1,0,1,7,0,0,0,7,1,0,0,0,0,0,0,1
DATA 1,1,1,1,1,0,0,0,0,1,7,0,0,0,0,0,0,0,1,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,6,0,1,7,0,0,0,1
DATA 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1
DATA 1,0,0,0,0,0,0,1,0,0,0,0,0,0,6,0,0,0,0,0,0,1,0,0,1
DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1
DATA 1,0,0,0,8,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,1,0,0,1
DATA 1,0,0,0,1,0,0,0,0,0,0,0,0,0,6,0,0,0,0,0,1,0,0,0,1
DATA 1,0,0,6,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1
DATA 1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,1,0,0,0,7,0,7,0,0,0,1,0,0,0,6,0,0,1
DATA 1,7,0,0,0,0,0,0,1,1,1,1,8,1,1,1,1,1,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,1
DATA 1,10,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1,1
level22:
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1
DATA 1,7,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,7,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,1,7,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,1,7,7,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,6,6,0,0,0,1,1,1,0,0,6,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,7,0,0,0,0,0,0,0,7,1,1,1,0,0,0,0,0,0,0,0,1
DATA 1,7,1,1,1,1,1,1,1,1,1,1,1,6,7,1,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,7,6,1,1,1,1,1,1,1,1,7,1
DATA 1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,7,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,7,0,7,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,6,0,0,0,0,1
DATA 1,1,1,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1
DATA 10,0,2,0,0,0,0,0,0,0,0,0,1,0,1,8,0,0,0,0,0,0,0,0,10
DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1
level23:
DATA 1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,3,7,7,7,7,7,7,7,7,7,7,0,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 10,0,7,7,7,6,0,0,0,0,0,0,0,0,0,6,7,7,7,7,8,7,7,0,10
DATA 1,7,7,7,7,0,7,7,7,7,7,7,7,7,7,0,7,7,7,7,8,7,7,7,1
DATA 1,7,7,7,7,6,7,7,7,7,7,7,7,7,7,6,7,7,7,7,8,7,7,7,1
DATA 1,7,7,7,7,0,7,7,7,7,7,7,7,7,7,0,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,6,0,0,0,0,0,0,0,0,0,6,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1
DATA 1,7,7,7,7,7,7,7,7,7,7,7,0,7,7,7,7,7,7,7,7,7,7,8,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1
level24:
DATA 1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,6,6,6,6,6,6,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,6,6,6,6,6,6,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 10,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,7,7,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1
DATA 1,2,0,0,0,0,0,0,0,0,0,7,0,7,0,0,0,0,0,0,0,0,0,7,1
DATA 1,1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1
level25:
DATA 1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1
DATA 1,0,0,0,7,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,7,1,0,1
DATA 1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,6,0,1,0,0,1,0,0,1
DATA 1,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,1
DATA 1,0,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,1
DATA 1,0,0,0,1,0,0,0,0,0,0,0,0,7,0,0,0,0,1,0,0,1,0,0,1
DATA 1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,1
DATA 1,0,0,0,1,0,0,0,1,1,1,0,0,0,0,0,0,0,1,0,0,1,1,0,1
DATA 1,0,1,0,1,0,0,0,1,7,7,0,0,6,0,0,0,0,0,1,0,1,0,0,1
DATA 1,0,0,0,1,0,0,0,1,7,0,0,1,0,0,1,7,1,0,1,0,1,0,1,1
DATA 1,1,0,1,1,0,0,0,0,1,0,0,1,0,0,7,1,7,0,1,0,1,0,0,1
DATA 1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,1,7,1,0,1,0,1,1,0,1
DATA 1,0,1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,1,0,0,1
DATA 1,0,0,0,1,0,0,1,1,0,0,0,1,0,0,0,0,0,0,1,0,1,6,1,1
DATA 10,0,0,1,1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,1,0,0,10
DATA 1,0,0,0,1,0,0,0,6,0,0,0,0,0,0,0,0,0,0,1,0,1,1,1,1
DATA 1,0,1,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1
DATA 1,2,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,0,1,0,8,1
DATA 1,1,1,1,1,1,1,1,1,1,1,10,1,1,1,1,1,1,1,1,1,1,1,1,1
topten:
    IF mainchc <> 5 THEN
    OPEN "topten.dat" FOR INPUT AS #1
    FOR X = 1 TO 10
    INPUT #1, person$(X)
    INPUT #1, score(X)
    NEXT X
    CLOSE #1
    CLS
    COLOR 2
    PRINT "What is your name?: ";
    INPUT "", newperson$
    newscore = scorecatch
    IF newperson$ = "" THEN
        newperson$ = "Somebody"
    END IF
    found = false
    curscore = 1
    WHILE NOT found AND curscore < 11
        IF newscore > score(curscore) THEN
            found = true
        ELSE
            curscore = curscore + 1
        END IF
    WEND
    IF found THEN
        FOR X = 9 TO curscore STEP -1
            score(X + 1) = score(X)
            person$(X + 1) = person$(X)
        NEXT X
        score(curscore) = newscore
        person$(curscore) = newperson$
    END IF
    OPEN "topten.dat" FOR OUTPUT AS #1
    FOR X = 1 TO 10
    PRINT #1, person$(X)
    PRINT #1, score(X)
    NEXT X
    CLOSE #1
    END IF
    donemain = false
    WHILE NOT donemain
    CLS
LOCATE 10, 30
COLOR 2
PRINT "Top Ten Menu"
COLOR 1
LOCATE 11, 30
PRINT "1) Erase Top Ten"
LOCATE 12, 30
PRINT "2) View Top Ten"
LOCATE 13, 30
PRINT "3) Exit Top Ten Menu"
COLOR 2
LOCATE 14, 30
INPUT "What is your choice?: ", toptenchc
IF toptenchc = 1 THEN
    OPEN "topten.dat" FOR OUTPUT AS #1
    FOR X = 1 TO 10
    PRINT #1, "Nobody"
    PRINT #1, 0
    NEXT X
    CLOSE #1
ELSEIF toptenchc = 2 THEN
    OPEN "topten.dat" FOR INPUT AS #1
    FOR X = 1 TO 10
    INPUT #1, person$(X)
    INPUT #1, score(X)
    NEXT X
    CLOSE #1
    CLS
    FOR X = 1 TO 10
    LOCATE X + 10, 30
    COLOR 1
    PRINT X; ") ";
    PRINT person$(X)
    LOCATE X + 10, 50
    PRINT "-";
    COLOR 4
    PRINT score(X)
    NEXT X
    DO
    LOCATE 25, 1: PRINT "<Press Any Key>": LOOP UNTIL INKEY$ <> ""
ELSEIF toptenchc = 3 THEN
    donemain = true
END IF
WEND
RETURN

