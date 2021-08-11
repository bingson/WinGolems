
; FILE EXPLORER ________________________________________________________________

 #IfWinActive ahk_group FileListers
 
 $#enter::
 $#space::  CB("~FileExplorer", C.lyellow)
 
 :X:es~FileExplorer::
    send !d
    var := clip()
    ActivateApp(UProfile "\Downloads\Programs\Everything\Everything.exe")
    clip(var)
    return
 
 $+!c::     clipboard := Explorer_GetSelection()                                 ;[FE] store file path(s) of selected file(s) in clipboard
 ^s::       SelectByRegEx()                                                      ;[FE] select files by regex
 
 !r::       Send {F2}                                                           ;[FE] rename file
 ^!c::      SendInput !dcmd{Enter}                                              ;[FE] Open Command Prompt Here
 ^!k::                                                                          ;[FE] up one directory level
 !b::       send !{left}                                                        ;[FE] prev folder
 !n::       send !{right}                                                       ;[FE] forward folder
 !u::       send !{up}                                                          ;[FE] up one directory level
 !p::       Send ^w                                                             ;[FE] close file explorer window
 
 !SC027::   DetailedView()                                                      ;[FE] view: detailed file info with resized columnsnmn       
 ^h::       ToggleInvisible()                                                   ;[FE] view: toggle hide/unhide invisible files
 <^j::      SortByName()                                                        ;[FE] view: sort by name
 <^k::      SortByDate()                                                        ;[FE] view: sort by date modified
 >^j::      SortByType()                                                        ;[FE] view: sort by type
 >^k::      SortBySize()                                                        ;[FE] view: sort by size
 
 ^u::      send !vg{up   4}{enter}                                              ;[FE] groups: toggle groupby name/remove grouping
 ^o::      Send !vg{down 2}{enter}                                              ;[FE] groups: group by file type
 ^i::      Send !vg{down 1}{enter}                                              ;[FE] groups: group by date
 
 ^!sc035:: SaveMousPos("FE_cg", "0") 
 
 !sc035::                                                                       ;[FE] groups: group folding: Expand all 
 ^sc035::  ExpandCollapseAllGroups()                                            ;[FE] groups: group folding: Collapse all
 
 !z::      Send !vn{enter}                                                      ;[FE] panes: toggle navigation pane
 ^p::      Send {alt down}p{alt up}                                             ;[FE] panes: toggle preview plane
 !i:: ControlFocus, SysTreeView321, ahk_class CabinetWClass                     ;[FE] panes: move focus to navigation pane
 !o:: ControlFocus, DirectUIHWND2, ahk_class CabinetWClass                       ;[FE] panes: move focus to current folder pane 
 
 !h:: SendEvent {Left} ;[NT] Left
 !l:: SendEvent {Right} ;[NT] Right
 #k:: 
 !k:: SendEvent {Up} ;[NT] Up
 #j:: 
 !j:: SendEvent {Down} ;[NT] Down
 
 $<^<!j::                        sendevent {WheelDown 2}                        ;[MF] scroll wheel down
 $<^<!k::                        sendevent {WheelUp 2}                          ;[MF] scroll wheel Up
 
  $>^>!j::                        sendevent {WheelDown 4}                        ;[MF] scroll wheel down
  $>^>!k::                        sendevent {WheelUp 4}                          ;[MF] scroll wheel Up
   
 printscreen & j::               sendevent {WheelDown 5}                        ;[MF] scroll wheel down                                               
 printscreen & k::               sendevent {WheelUp 5}                          ;[MF] scroll wheel Up                                               
 
 $<^>!h::                        sendevent {Wheelleft 6}                        ;[MF] scroll wheel down
 $<^>!j::                        sendevent {WheelDown 6}                        ;[MF] scroll wheel down
 $<^>!k::                        sendevent {WheelUp 6}                          ;[MF] scroll wheel up
 $<^>!l::                        sendevent {WheelRight 6}                       ;[MF] scroll wheel up
 
 $#>!j::                         sendevent {WheelDown 8}                        ;[MF] scroll wheel down
 $#>!k::                         sendevent {WheelUp 8}                          ;[MF] scroll wheel up
 
 $#>!h::                         sendevent {WheelLeft 4}                        ;[MF] scroll wheel left
 $#>!l::                         sendevent {WheelRight 4}                       ;[MF] scroll wheel right
 
 #IfWinActive    