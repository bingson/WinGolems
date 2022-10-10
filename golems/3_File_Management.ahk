
#IF

; FILE EXPLORER CONVENIENCE ____________________________________________________
    #If WinActive("ahk_exe Explorer.EXE")               
    
    #Del::     FileRecycleEmpty                                                 ;FileExplorer: Empty trash
    !p::       Sendinput ^w                                                     ;FileExplorer: close tab
    !u::       Send !{up}                                                       ;FileExplorer: up one folder level
    <!i::      Send !{left}                                                     ;FileExplorer: prev folder
    <!o::      Send !{right}                                                    ;FileExplorer: forward folder
    !z::       ToggleNavPane()                                                  ;FileExplorer: toggle navigation plane
    ^p::       Send {alt down}p{alt up}                                         ;FileExplorer: toggle preview plane
    !w::       ControlFocus, SysTreeView321, ahk_class CabinetWClass            ;FileExplorer: move focus to navigation pane
    !e::       ControlFocus, DirectUIHWND2, ahk_class CabinetWClass             ;FileExplorer: move focus to current folder pane
    $<!r::     Send {F2}                                                        ;FileExplorer: rename file
    >!SC027::  DetailedView()                                                   ;FileExplorer| detailed file info with resized columnsnmn
    !s::       SelectByRegEx()                                                  ;FileExplorer| select all files matching regex pattern
    ralt & j:: send {down}                                                      ;Navigation| Up
    ralt & k:: send {up}                                                        ;Navigation| Down
    ^j::       SortBy("name")                                                   ;FileExplorer: sort by name
    ^k::       SortBy("date modified")                                          ;FileExplorer: sort by date modified
    ^l::       SortBy("file type")                                              ;FileExplorer: sort by type
    ^h::       SortBy("size")                                                   ;FileExplorer: sort by size
    ^+j::      GroupBy("name")                                                  ;FileExplorer: group by name|remove grouping toggle
    ^+k::      GroupBy("date modified")                                         ;FileExplorer: group by date modified type
    ^+l::      GroupBy("file type")                                             ;FileExplorer: group by file type
    ^+h::      GroupBy("size")                                                  ;FileExplorer: group by size type
    ^+SC027::  GroupBy("none")                                                  ;FileExplorer: group by none type
                                                                                
    #If WinActive("ahk_exe Explorer.EXE") && GetKeyState("shift", "P")
    lalt & c:: clipboard := Explorer_GetSelection()                             ;FileExplorer| store file path(s) of selected file(s) in clipboard
                                                                                
    #If WinActive("ahk_exe Explorer.EXE") && IsCmode()
    i::                                                                         ;FileExplorer: toggle hide/unhide invisible files                                            
    :X:h~fe:: ToggleInvisible()                                                 ;FileExplorer: toggle hide/unhide invisible files                                            
                                                                                
    #IF

; OPEN FILE|FOLDER PATH|FB _____________________________________________________
    ; works on full file paths for all MS office files (xls, doc, ppt, etc.)
    ; functions below are valid anywhere in windows if "T_FM" variable in config.ini = 1
    
    #IF GC("T_FM",0) 
                                                                                ; GC = (G)et (C)onfig.ini("var_name", "value returned if none found") 
    PgUp & esc:: OP("golems\1_Apps_Misc.ahk")                                   ;OpenPath: A_Quick_Start.ahk 
    PgUp & F1::  OP("golems\2_Text_Manipulation.ahk")                           ;OpenPath: B_Text_Manipulation.ahk 
    PgUp & F2::  OP("golems\3_File_Management.ahk")                             ;OpenPath: C_File_Management.ahk 
    PgUp & F3::  OP("golems\_system.ahk")                                       ;OpenPath: _system.ahk                         
    pgup & f4::  OP("golems\_CB.ahk")                                           ;OpenPath: _CB.ahk                         
                                                                                
    


    ; Function Box: opens a window that gives the user a menu of parameter choices for calling a function
    ; #SC034: :      FB((WinActive("ahk_group FileListers") ? "ChangeFolder" : "OpenPath"), Paths(), C.lpurple)  ;FB: Opens Jump Menu for opening saved paths to files, folders, URLs (works in save dialogue windows)

; FILE EXPLORER AND LISTVIEW WINDOWS ___________________________________________
  ; ChangeFolder() shortcuts are valid in file explorer and other listview type windows (e.g., save as diaglogue boxes)
  ; below only applies to ListView windows like file explorer and save as dialogue boxes if T_FM = 1

  SetTitleMatchMode, 2
  #If WinActive("ahk_group FileListers") and GC("T_FM",0) 
  !u::       Send {blind}!{up}                                                  ;FileExplorer: up one folder level 
  <!i::      Send {blind}!{left}                                                ;FileExplorer: prev folder         
  <!o::      Send {blind}!{right}                                               ;FileExplorer: forward folder      
  !d::       Send {blind}!d                                                     ;FileExplorer: select path bar     
  >+u::      CF(UProfile)                                                       ;ChangeFolder: %UserProfile%
  >+o::      CF(A_ProgramFiles)                                                 ;ChangeFolder: C:\Program Files
  >+>!o::    CF(PF_x86)                                                         ;ChangeFolder: C:\Program Files(x86)
  >+p::      CF(UProfile "\Pictures")                                           ;ChangeFolder: Pictures
  PgUp & j:: CF(UProfile "\Downloads")                                          ;ChangeFolder: Downloads
  PgUp & d:: CF(UProfile "\Documents")                                          ;ChangeFolder: My Documents
  PgUp & c:: CF(hdrive)                                                         ;ChangeFolder: %Homedrive% (C:)
  PgUp & m:: CF(A_ScriptDir "\mem_cache")                                       ;ChangeFolder: mem_cache
  PgUp & r:: CF("`:`:{645FF040-5081-101B-9F08-00AA002F954E}"), CFW()            ;ChangeFolder: Recycle bin (doesn't work for save as diag)
  PgUp & t:: CF("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}"), CFW()            ;ChangeFolder: This PC / My Computer
                                                                                
; CHORD COMMAND ________________________________________________________________
    #If WinActive("ahk_exe Explorer.EXE")
    #SC033::     
    ^SC033::     
    ChordFileExplorer(options := "L1 M T10", escape := "{esc}{ralt}",PUmenu:="zb\ChordFileMenu") {
        global reChordMenuPattern, C
        
        ;pop up website menu
        menu := rtrim(AccessCache(PUmenu,,0),"`n")
        PU(menu,C.Eyellow,,,,90000,13,,"Lucida Sans Typewriter",1)              ;pop up website menu
        
        keysPressed :=  KeyWaitHook("L1 M T10",escape)
        input := (Instr(keysPressed,"<+") ? clipboard : (Instr(keysPressed,">+") ? clip() : ""))
        Gui, PopUp: cancel
        Switch % keysPressed
        {
            Case "j":         SortBy("name")                                                   ;FileExplorer: sort by name
            Case "k":         SortBy("date modified")                                          ;FileExplorer: sort by date modified
            Case "c":         SortBy("date created")                                           ;FileExplorer: sort by date created
            Case "l":         SortBy("file type")                                              ;FileExplorer: sort by type
            Case "h":         SortBy("size")                                                   ;FileExplorer: sort by size
            Case "<+j",">+j": GroupBy("name")                                                  ;FileExplorer: group by name|remove grouping toggle
            Case "<+k",">+k": GroupBy("date modified")                                         ;FileExplorer: group by date modified
            Case "<+c",">+c": GroupBy("date created")                                          ;FileExplorer: group by date created
            Case "<+l",">+l": GroupBy("file type")                                             ;FileExplorer: group by file type
            Case "<+h",">+h": GroupBy("size")                                                  ;FileExplorer: group by size
            Case ";":         GroupBy("none")                                                  ;FileExplorer: group by none
            Case "i":         ToggleInvisible()                                                ;FileExplorer: toggle hide/unhide invisible files            
            Case ">+?":       OP(A_ScriptDir "\mem_cache\" PUmenu ".txt")           
            default:
                ; msgbox % "Nothing assigned to " keysPressed " which was pressed"
                sleep,0
        }
        return 
    }
                                                                                   ; https://www.autohotkey.com/docs/misc/CLSID-List.htm 
#IF
