 ; MOUSE FUNCTIONS ______________________________________________________________
 ; simulate mouse functions with keyboard shortcuts -- -- -- -- -- -- -- -- --

 PrintScreen & j::                                                              ;[MF] scroll wheel down
 #j:: Click, WheelDown 4                                                        ;[MF] scroll wheel down
 PrintScreen & k::                                                              ;[MF] scroll wheel up
 #k:: Click, WheelUp 4                                                          ;[MF] scroll wheel up 
 PrintScreen & i::                                                              ;[MF] 1 Left click
 *#i:: click                                                                    ;[MF] 1 Left click 

 #f::                                                                           ;[MF] 2 Left clicks
    DoubleClick() {
      Click
      sleep, short
      Click
      return
   }
 
 ^#f::                                                                          ;[MF] 3 Left clicks
    Click
    sleep, short
    Click
    sleep, short
    Click
    return

 PrintScreen & o::                                                              ;[MF] mouse middle click
 #o::                            Click, middle                                  ;[MF] mouse middle click 
 
 PrintScreen & sc028::                                                          ;[MF] mouse Right click
 #sc028::                        Click, Right                                   ;[MF] mouse Right click
 
 #u::                                                                           ;[MF] move mouse cursor to top edge
 !#k::                           JumpTopEdge()                                  ;[MF] move mouse cursor to top edge
 
 !#j::                                                                          ;[MF] move mouse cursor to bottom edge 
 #If GetKeyState("shift", "P")
 PrintScreen & j::               JumpBottomEdge()                               ;[MF] move mouse cursor to bottom edge
 #IF
 
 !#h::                                                                          ;[MF] move mouse cursor to Left edge
 #If GetKeyState("alt", "P")
 PrintScreen & h::               JumpLeftEdge()                                 ;[MF] move mouse cursor to Left edge
 #IF 
 !#l::                                                                          ;[MF] move mouse cursor to Right edge
 #If GetKeyState("alt", "P")
 PrintScreen & l::               JumpRightEdge()                                ;[MF] move mouse cursor to Right edge
 #IF
 
 lwin & rshift::                                                                ;[MF] move mouse cursor to middle
 PrintScreen & rctrl::           JumpMiddle()                                   ;[MF] move mouse cursor to middle
 