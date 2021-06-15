; FILE EXPLORER ________________________________________________________________
 #IfWinActive ahk_group FileListers

 $+!c::     clipboard := Explorer_GetSelection()                                ;[FE] store file path(s) of selected file(s) in clipboard
 ^s::       SelectByRegEx()                                                     ;[FE] select files by regex
 !r::       Send {F2}                                                           ;[FE] rename file
 ^!c::      SendInput !dcmd{Enter}                                              ;[FE] Open Command Prompt Here
 !b::       send !{left}                                                        ;[FE] prev folder
 !n::       send !{right}                                                       ;[FE] forward folder
 ^!k::                                                                          ;[FE] up one directory level
 !u::       send !{up}                                                          ;[FE] up one directory level
 !p::       Send ^w                                                             ;[FE] close file explorer window
 
 !SC027::   DetailedView()                                                      ;[FE] view: detailed file info with resized columns
 ^h::       ToggleInvisible()                                                   ;[FE] view: toggle hide/unhide invisible files
 <^j::      SortByName()                                                        ;[FE] view: sort by name
 <^k::      SortByDate()                                                        ;[FE] view: sort by date modified
 >^j::      SortByType()                                                        ;[FE] view: sort by type
 >^k::      SortBySize()                                                        ;[FE] view: sort by size
 
 ^u::       send !vg{up   4}{enter}                                             ;[FE] groups: toggle groupby name/remove grouping
 ^o::       Send !vg{down 2}{enter}                                             ;[FE] groups: group by file type
 ^i::       Send !vg{down 1}{enter}                                             ;[FE] groups: group by date
 !sc035::                                                                       ;[FE] groups: group folding: Expand all 
 ^sc035::   ExpandCollapseAllGroups()                                           ;[FE] groups: group folding: Collapse all
 
 !z::       Send !vn{enter}                                                     ;[FE] panes: toggle navigation pane
 ^p::       Send {alt down}p{alt up}                                            ;[FE] panes: toggle preview plane
 <+Space::  ControlFocus, SysTreeView321, ahk_class CabinetWClass               ;[FE] panes: move focus to navigation pane
 >+Space::  ControlFocus, DirectUIHWND2, ahk_class CabinetWClass                ;[FE] panes: move focus to current folder pane 

 #IfWinActive    
