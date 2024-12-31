."  HIPPODROME FULL VERSIONS"  CR
 
: HI ." Bonjour tout le monde" ;

: robot CR ."           _  " CR ."        __|_|__   " CR ."       |  o o  |  " CR
."      [|   !   |]  " CR    ."     __|  <=>  |__  " CR  ."    |  ^^^^^^^^   | " CR  ."    |  | robot |  |  " CR
."    |  |_______|  |    " CR ."    |__|       |__|    " CR
; 
 
robot CR

( my own return stack - ma propre pile de retour R )
VARIABLE R   
: >R  R ! ;
: R> R @ ;

( timer env. 1 sec )
: MS ( n -- n sec ) 34333 * FOR I DROP NEXT ;
: X 100 FOR DROP NEXT ;

CODE PAGE
    print('\033c')
END-CODE



."            LEFT______ [**]____RIGHT" CR
."            |          [**]        |"  CR
."                    HIPPODROME"  CR                        
."            |______________________|"  CR
CR
HI  CR
CR CR

( primitives Python )
" motor_stop.fth" LOAD 
" forward_left.fth" LOAD
" forward_right.fth" LOAD
" back_right.fth" LOAD
" back_left.fth" LOAD
" sensor_right.fth" LOAD
" sensor_left.fth" LOAD
" sensor_surface_middle.fth" LOAD
" sensor_surface_left.fth" LOAD
" sensor_surface_right.fth" LOAD
" sensor_side_right.fth" LOAD
" sensor_side_left.fth" LOAD

( primitives Pygmy Forth )

VARIABLE TOKEN

( TURN GOSTRAIGHT  )
: LEFT 0 ;
: RIGHT 1 ;
: TURNRIGHT  5 FOR FORWARDLEFT NEXT ;  ( turn RIGHT )
: TURNLEFT  5 FOR FORWARDRIGHT NEXT ;  ( turn LEFT )
: TURN ( n-- ) IF TURNRIGHT ELSE TURNLEFT THEN ; ( use RIGHT TURN LEFT TURN )
: 1= 1 = ;   : BOTH-OFF? AND 0= ;
: GOSTRAIGHT FORWARDLEFT FORWARDRIGHT ;

( TURN  CENTER )
: TURN_RIGHT90_CENTER_LEFT 70 FOR FORWARDLEFT BACKRIGHT NEXT ; 
: TURN_LEFT90_CENTER_LEFT 65 FOR FORWARDRIGHT BACKLEFT NEXT ;
: TURN_RIGHT90_CENTER_RIGHT 65 FOR FORWARDLEFT BACKRIGHT NEXT ; 
: TURN_LEFT90_CENTER_RIGHT 70 FOR FORWARDRIGHT BACKLEFT NEXT ;

( TURN  PI )
: TURN_PI_RIGHT 135 FOR FORWARDLEFT BACKRIGHT NEXT ;
: TURN_PI_LEFT 135 FOR FORWARDRIGHT BACKLEFT NEXT ;


( PATH OF BYPASS ) 
: MOVE_DOWN_LEFT 80 FOR GOSTRAIGHT NEXT ;
: MOVE_FLAT_LEFT 175 FOR GOSTRAIGHT NEXT ;
: MOVE_UP_LEFT 80 FOR GOSTRAIGHT NEXT ;
: MOVE_DOWN_RIGHT 80 FOR GOSTRAIGHT NEXT ;
: MOVE_FLAT_RIGHT 175 FOR GOSTRAIGHT NEXT ;
: MOVE_UP_RIGHT 55 FOR GOSTRAIGHT NEXT ;

( PathRight  PathLeft )
: PathLeft TURN_RIGHT90_CENTER_LEFT MOVE_DOWN_LEFT TURN_LEFT90_CENTER_LEFT MOVE_FLAT_LEFT TURN_LEFT90_CENTER_LEFT MOVE_UP_LEFT TURN_RIGHT90_CENTER_LEFT ; 
: PathRight TURN_LEFT90_CENTER_RIGHT MOVE_DOWN_RIGHT TURN_RIGHT90_CENTER_RIGHT  MOVE_FLAT_RIGHT TURN_RIGHT90_CENTER_RIGHT  MOVE_UP_RIGHT  TURN_LEFT90_CENTER_RIGHT ;
: PATH_LEFT SURFACESENSORMIDDLE 1= IF PathLeft GOSTRAIGHT THEN ;
: PATH_RIGHT SURFACESENSORMIDDLE 1= IF PathRight THEN ;

( application Obstacle Avoider )
 : BYPASS SURFACESENSORMIDDLE 1= IF  TOKEN @ 0= IF  PATH_RIGHT  1 TOKEN ! ELSE  PATH_LEFT 0 TOKEN ! THEN ;  

( application U-turn )
: U-turn  SENSORSIDELEFT 0= IF TURN_PI_RIGHT THEN SENSORSIDERIGHT  0= IF TURN_PI_LEFT THEN ;

( application round-trip )
: round-trip  SURFACESENSORLEFT 1= IF TURN_PI_RIGHT THEN SURFACESENSORRIGHT  1= IF TURN_PI_LEFT THEN ;

( application )
: hippodrome  LEFTSENSOR RIGHTSENSOR BOTH-OFF? IF GOSTRAIGHT THEN LEFTSENSOR TURN RIGHTSENSOR TURN ;

: RUN BEGIN hippodrome U-turn  round-trip BYPASS  AGAIN ;
 : zz RUN ; 

( controle )
: tt LEFTSENSOR  ." LEFTSENSOR" . CR RIGHTSENSOR ." RIGHTSENSOR" . CR ;
: ss ." sensor_surface_middle" SURFACESENSORMIDDLE . CR ." sensor_surface_right" SURFACESENSORRIGHT . CR ." sensor_surface_left" SURFACESENSORLEFT . CR  ;

WORDS CR 

