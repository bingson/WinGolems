#IF
; TOGGLE WINGOLEMS OPTIONS _____________________________________________________

  :X:ta~win::  CC("T_adv","!"), PU("Advanced shortcuts: " GC("T_adv"))          ;Toggle: advanced hotkeys ON|OFF

; CONVENIENCE___________________________________________________________________

  #IF GC("T_adv",0)                                                             ; if T_adv = 1 advanced hotkeys are active, if no value for T_adv, default = 0
  +capslock::            backspace                                              ;Convenience:1 makes capslock key function as a delete key. (old capslock functionality: ctrl + capslock)
  capslock::             del                                                    ;Convenience:1 makes capslock key function as a delete key. (old capslock functionality: ctrl + capslock)
  ^capslock::            Send {blind}{capslock}                                 ;Convenience:1 toggle capslock

; MOUSE FUNCTIONS ______________________________________________________________
  ; mouse functions with keyboard shortcuts  

  *#d::                  SaveMousPos("r",1)                                     ;C: Left click and save mouse position
  *^#d::                 RecallMousePosClick("r")                               ;MF: Move to saved mouse position and left click
  *#i::                  SaveMousPos("i",1)                                     ;MouseFn: Left click and save mouse position
  *^#i::                 RecallMousePosClick("i")                               ;MouseFn: Move to saved mouse position and left click
  #o::                   Click, middle                                          ;MouseFn: mouse middle click
  PrintScreen & sc028::                                                         ;MouseFn: mouse Right click
  #sc028::               Click, Right                                           ;MouseFn: mouse Right click
  ^!Lbutton::            Clicks(2), s("^v")                                     ;MouseFn: click twice, paste clipboard
  +^Lbutton::            Clicks(3), s("^v")                                     ;MouseFn: click thrice, paste clipboard
  $^!j::                 Sendinput ^{sc00D}                                     ;MouseFn: zoom in
  $^!k::                 Sendinput ^{sc00C}                                     ;MouseFn: zoom out
  #j::                   Sendinput {Blind}{WheelDown 2}                         ;MouseFn: scroll wheel down
  #k::                   Sendinput {Blind}{WheelUp 2}                           ;MouseFn: scroll wheel Up
  $#>!h::                Sendinput {Blind}{Wheelleft 6}                         ;MouseFn: scroll wheel left
  $#>!l::                Sendinput {Blind}{WheelRight 6}                        ;MouseFn: scroll wheel right
  ~rctrl & ~lctrl::      CursorJump("TL")                                       ;MouseFn: move mouse cursor to TOP LEFT of active app
  ~lctrl & ~rctrl::      CursorJump("TR")                                       ;MouseFn: move mouse cursor to TOP RIGHT of active app
  ralt & lalt::          CursorJump("BL")                                       ;MouseFn: move mouse cursor to BOTTOM LEFT of active app
  lalt & ralt::          CursorJump("BR")                                       ;MouseFn: move mouse cursor to BOTTOM RIGHT of active app
  $!#k::                 CursorJump("T")                                        ;MouseFn: move mouse cursor to top edge
  $!#j::                 CursorJump("B",,"-20")                                 ;MouseFn: move mouse cursor to bottom edge
  $!#h::                 CursorJump("L","20")                                   ;MouseFn: move mouse cursor to Left edge
  $!#l::                 CursorJump("R","-40")                                  ;MouseFn: move mouse cursor to Right edge

; TEXT FUNCTIONS _______________________________________________________________

  ; MANIPULATE TEXT-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  +!sc00C::              Send, {ASC 0150}                                       ;ManipulateText: en dash (–)
  !sc00C::               Send, {ASC 0151}                                       ;ManipulateText: em dash (—)
  ^#Backspace::          ReplaceBackspaceWithSpaces()                           ;ManipulateText:1 Delete and replace selected text with blank spaces 
  !v::                   PasteWithoutBreaks()                                   ;ManipulateText:1 replace multiple paragraph breaks w/ 1 break in selected text
  +!v::                  PasteWithoutBreaks(True)                               ;ManipulateText:1 replace multiple paragraph breaks with space (remove paragraphs breaks)
  ^#v::                  PasteOverwrite()                                       ;ManipulateText:1 Paste and overwrite the same number of spaces (aka. overtype paste)
  +^u::                  ConvertUpper()                                         ;ManipulateText:2 capitalize selected text
  +!u::                  ConvertLower()                                         ;ManipulateText:2 convert selected text to lower case
  ^!u::                  Capitalize1stLetter()                                  ;ManipulateText:2 First letter capitalized
  ^!+u::                 Capitalize1stLetter(,,0)                               ;ManipulateText:2 Every First Letter Capitalized
  !#space::              s("{blind}"), ReplaceAwithB(" ")                       ;ManipulateText: remove all spaces from selected text
  ^#space::              s("{blind}"), ReplaceAwithB()                          ;ManipulateText: replace multiple consecutive spaces w/ one space in selected text
  !#enter::              s("{blind}"), RemoveBlankLines()                       ;ManipulateText: remove empty lines starting from selected text
  ^#sc027::              Send {lwin down}d{lwin up}                             ;ManipulateText: show desktop
  +!9::                  Clip("(" Clip() ")")                                   ;ManipulateText: enclose selected text with ( )
  $+!SC01A::             Clip("{" Clip() "}")                                   ;ManipulateText: enclose selected text with { }
  !SC01A::               Clip("[" Clip() "]")                                   ;ManipulateText: enclose selected text with [ ]
  ^SC028::               Clip("'" Clip() "'")                                   ;ManipulateText: enclose selected text with ' '
  +!SC028::              Clip("""" Clip() """")                                 ;ManipulateText: enclose selected text with " "
  >!n::                  Clip("%" Clip() "%")                                   ;ManipulateText: enclose selected text with % %
  >!m::                  Clip("$" Clip() "$")                                   ;ManipulateText: enclose selected text with $ $
  !sc029::               Clip("`` " Clip() " ``")                               ;ManipulateText: enclose selected text with ` `
  +!sc029::              Clip("`````` " Clip() " ``````")                       ;ManipulateText: enclose selected text with ``` ```
  #backspace::           send ^{backspace}

  
  #IF GC("T_adv",0) and !WinActive("ahk_exe " exe["editor"])                    ; exclude when using editor app (replace with native app duplicate line function)
  ^!d::  SelectLine(), s("^c"), s("right"), s("enter"), s("^v")                 ;textManipulate: duplicate line
  
  #IF GC("T_adv",0)                                                             ; if T_adv = 1 advanced hotkeys are active, if no value for T_adv, default = 0

  ; SELECT TEXT-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
  $!f::                  SelectWord()                                           ;SelectText: select word at text cursor position
  $+!f::                 SelectLine()                                           ;SelectText: select current line starting from begining of line
  $^!f::                 Sendinput {end}+{home}                                 ;SelectText: select line starting from end of line
  $^#h::                 sendinput +{Home}                                      ;SelectText: select to beginning of line
  $^#l::                 sendinput +{End}                                       ;SelectText: select to end of line
  $+^j::                 Sendinput +{down}                                      ;SelectText: select to next line
  $+^k::                 Sendinput +{up}                                        ;SelectText: select to line above
  $^#j::                 sendinput ^+{end}                                      ;SelectText: select all below
  $^#k::                 sendinput ^+{home}                                     ;SelectText: select all above
  $+#h::                 Sendinput +^{Left}                                     ;SelectText: extend selection Left  1 word
  $+#l::                 Sendinput +^{Right}                                    ;SelectText: extend selection Right 1 word
  $+#!h::                Sendinput +^{Left 2}                                   ;SelectText: extend selection Left  2 words
  $+#!l::                Sendinput +^{Right 2}                                  ;SelectText: extend selection Right 2 words
  $+^#h::                Sendinput +^{Left 3}                                   ;SelectText: extend selection Left  3 words
  $+^#l::                Sendinput +^{Right 3}                                  ;SelectText: extend selection Right 3 words
  $+!l::                 Sendinput +{Right}                                     ;SelectText: extend selection Right 1 character
  $+!h::                 Sendinput +{Left}                                      ;SelectText: extend selection Left  1 character
  $+#k::                                                                        ;SelectText: extend selection up    1 row
  +!k::                  sendinput +{up}                                        ;SelectText: extend selection up    1 row
  $+#j::                                                                        ;SelectText: extend selection down  1 row
  +!j::                  sendinput +{down}                                      ;SelectText: extend selection down  1 row
  
  ; NAVIGATE TEXT-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  
  $#h::                  sendinput ^{Left}                                      ;NavigateText: jump to next word; simulate ctrl+Left
  $#l::                  sendinput ^{Right}                                     ;NavigateText: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
  $!h::                  sendinput {Left}                                       ;NavigateText:| Left
  $!l::                  sendinput {Right}                                      ;NavigateText:| Right
  *$!k::                 sendinput {Up}                                         ;NavigateText:| Up
  *$!j::                 sendinput {Down}                                       ;NavigateText:| Down

; FILE EXPLORER AND LISTVIEW WINDOWS ___________________________________________
  ; ChangeFolder() shortcuts are active for all listview type windows (e.g., save as diaglogue boxes)
  
  SetTitleMatchMode, 2
  #If WinActive("ahk_group FileListers") and GC("T_adv",0)                      ; applies to ListView windows like file explorer and save as dialogue boxes
  
  >+sc029::     ChangeFolder(A_ScriptDir)                                       ;ChgFolder: AHK folder
  >+m::         ChangeFolder(A_ScriptDir "\mem_cache\")                         ;ChgFolder: mem_cache
  >+u::         ChangeFolder(UProfile)                                          ;ChgFolder: %UserProfile%
  >+j::         ChangeFolder(UProfile "\Downloads")                             ;ChgFolder: Downloads
  >+o::         ChangeFolder(A_ProgramFiles)                                    ;ChgFolder: C:\Program Files
  >+!o::        ChangeFolder(PF_x86)                                            ;ChgFolder: C:\Program Files(x86)
  >+p::         ChangeFolder(UProfile "\Pictures\")                             ;ChgFolder: Pictures
  >+d::         ChangeFolder(UProfile "\Documents")                             ;ChgFolder: Documents
  >+c::         ChangeFolder(hdrive)                                            ;ChgFolder: %Homedrive% (C:)
  >+r::         ChangeFolder("`:`:{645FF040-5081-101B-9F08-00AA002F954E}"), CFW()   ;CF: Recycle bin (doesn't work for save as diag)
  >+t::         ChangeFolder("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}"), CFW()   ;CF: This PC / My Computer
 
  ;   >+t::         ChangeFolder("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}")      ;ChgFolder: This PC / My Computer (file explorer only)
  ;   >+r::         ChangeFolder("`:`:{645ff040-5081-101b-9f08-00aa002f954e}")      ;ChgFolder: Recycle Bin (file explorer only)
  
  !i::          send !{up}                                                      ;FileExplorer: up one directory level
  !u::          send !{left}                                                    ;FileExplorer: prev folder
  !o::          send !{right}                                                   ;FileExplorer: forward folder
  !z::          Send !vn{enter}                                                 ;FileExplorer: toggle navigation pane
  ^p::          Send {alt down}p{alt up}                                        ;FileExplorer: toggle preview plane
  <!space::     ControlFocus, SysTreeView321, ahk_class CabinetWClass           ;FileExplorer: move focus to navigation pane
  >!space::     ControlFocus, DirectUIHWND2, ahk_class CabinetWClass            ;FileExplorer: move focus to current folder pane
  ^o::          Send !vg{down 2}{enter}                                         ;FileExplorer: group by file type
  ^i::          Send !vg{down 1}{enter}                                         ;FileExplorer: group by date
  $!r::         Send {F2}                                                       ;FileExplorer: rename file
  <^j::         SortByName()                                                    ;FileExplorer: sort by name
  <^k::         SortByDate()                                                    ;FileExplorer: sort by date modified
  >^j::         SortByType()                                                    ;FileExplorer: sort by type
  >^k::         SortBySize()                                                    ;FileExplorer: sort by size
  !SC027::      DetailedView()                                                  ;FileExplorer:1 detailed file info with resized columnsnmn       
  ^h::          ToggleInvisible()                                               ;FileExplorer:1 toggle hide/unhide invisible files
  $+!c::        clipboard := Explorer_GetSelection()                            ;FileExplorer:1 store file path(s) of selected file(s) in clipboard
  ^s::          SelectByRegEx()                                                 ;FileExplorer:1 select files by regex


; FUNCTION BOX _________________________________________________________________
  ; Purpose: opens a window that gives the user a menu of parameter choices for calling a single function
  ;
  ; Note: A line that begins with a comma (or any other operator) is automatically appended to the line above it.                              
  ; The comma operator is usually faster than writing separate expressions https://www.autohotkey.com/docs/Variables.htm#comma

  #IF GC("T_adv",0)

  e~win:                                                                        
  +#b:: Files   := { "f" : A_ScriptDir "\golems\_functions.ahk"                 ;FunctionBox: edit file
                   , "s" : A_ScriptDir "\golems\_system.ahk"                    ; for the construction of the GUI menu
                   , "a" : A_ScriptDir "\golems\1_Template_QuickStart.ahk"      ; all before the before the last "\" is ignored
                   , "b" : A_ScriptDir "\golems\2_Template_Advanced.ahk"        ; only destination file or folder is shown in the GUI menu
                   , "c" : A_ScriptDir "\golems\3_Template_ApplicationSpecific.ahk"  
                   , "w" : A_ScriptDir "\WinGolems.ahk"  
                   , "t" : A_ScriptDir "\golems\test.ahk"  
                   , "x" : A_ScriptDir "\assets\tutorial\example.xlsx"
                   , "d" : A_ScriptDir "\assets\tutorial\example.docx"
                   , "p" : A_ScriptDir "\assets\tutorial\example.pptx"
                   , "i" : """" config_path """" }, FB("EditFile", Files, C.lblue) 

  ef~win:                                                                       
  ^#b:: Folders := { "m"  : A_ScriptDir "\mem_cache"                            ;FunctionBox: open folder
                   , "j"  : UProfile "\Downloads"
                   , "d"  : UProfile "\Documents"
                   , "dt" : UProfile "\Documents"
                   , "p"  : UProfile "\Pictures"
                   , "t"  : "`:`:{20d04fe0-3aea-1069-a2d8-08002b30309d}"        ; https://www.autohotkey.com/docs/misc/CLSID-List.htm
                   , "r"  : "`:`:{645ff040-5081-101b-9f08-00aa002f954e}"
                   , "w"  : A_ScriptDir } 
      , AltText := { "m"  : "WG mem_cache (text memory files)"                  ;FunctionBox: open folder
                   , "j"  : "My Downloads"
                   , "d"  : "My Documents"
                   , "p"  : "Pictures"
                   , "t"  : "This PC"
                   , "r"  : "Recycle Bin"
                   , "w"  : "WinGolems" }, FB("OpenFolder", Folders, C.lbrown,,,, AltText)
    
  !sc033:: dest := { "f" : "0Maximize"                                          ;FunctionBox: resize & move window
                   , "q" : "1TopLeft"         
                   , "e" : "1TopRight"        
                   , "z" : "2BottomLeft"      
                   , "c" : "2BottomRight"     
                   , "a" : "3LeftHalf"     
                   , "d" : "3RightHalf"       
                   , "w" : "4TopHalf"         
                   , "s" : "4BottomHalf"      
                   , "dd": "5RightHalfSmall"       
                   , "aa": "5LeftHalfSmall"       
                   , "ww": "6TopHalfSmall"
                   , "ss": "6BottomHalfSmall"
                   , "qq": "L1TopLeftSmall"    
                   , "qa": "L2TopMidLeftSmall"    
                   , "za": "L3BottomMidLeftSmall"    
                   , "zz": "L4BottomLeftSmall" 
                   , "ee": "R1TopRightSmall"   
                   , "ed": "R2TopMidRightSmall"    
                   , "cd": "R3BottomMidRightSmall"    
                   , "cc": "R4BottomRightSmall" }, FB("MoveWin", dest, C.bwhite,, "s")  ; "s" optn adds a space between case changes for GUI menu
                
; COMMAND BOX __________________________________________________________________
  #IF WinActive("ahk_id " CB_hwnd) and GC("T_adv",0)                        ; If command Box active
  +!a::            MoveWin("LS")                                                ;CommandBox: move CB window to left side small
  +!d::            MoveWin("RS")                                                ;CommandBox: move CB window to right side small
  +!w::            MoveWin("TS")                                                ;CommandBox: move CB window to top half small
  +!s::            MoveWin("BS")                                                ;CommandBox: move CB window to bottom half small
  +!q::            MoveWin("L1")                                                ;CommandBox: move CB window to top left small
  +!e::            MoveWin("R1")                                                ;CommandBox: move CB window to top right small
  +!z::            MoveWin("L4")                                                ;CommandBox: move CB window to bottom left small
  +!c::            MoveWin("R4")                                                ;CommandBox: move CB window to bottom right small

#IF
