
#IF

; FILE EXPLORER CONVENIENCE ____________________________________________________

  #If WinActive("ahk_exe Explorer.EXE") and GC("T_FM",0) ; -- -- -- -- -- -- -- below shortcuts active in file explorer if "T_FM" variable in config.ini = 1
    !u::          Send !{up}                                                    ;FileExplorer: up one folder level 
    <!i::         Send !{left}                                                  ;FileExplorer: prev folder         
    <!o::         Send !{right}                                                 ;FileExplorer: forward folder      
    !z::          ToggleNavPane()                                               ;FileExplorer: toggle navigation plane 
    ^p::          Send {alt down}p{alt up}                                      ;FileExplorer: toggle preview plane
    !w::          ControlFocus, SysTreeView321, ahk_class CabinetWClass         ;FileExplorer: move focus to navigation pane
    !e::          ControlFocus, DirectUIHWND2, ahk_class CabinetWClass          ;FileExplorer: move focus to current folder pane
    $<!r::        Send {F2}                                                     ;FileExplorer: rename file
    ^u::          ToggleOpt("vg{up 4}")                                         ;FileExplorer: group by name|remove grouping toggle
    ^o::          ToggleOpt("vg{down 2}")                                       ;FileExplorer: group by file type
    ^i::          ToggleOpt("vg{down 1}")                                       ;FileExplorer: group by date modified
    ^j::          ToggleOpt("vo")                                               ;FileExplorer: sort by name
    ^k::          ToggleOpt("vo{down}")                                         ;FileExplorer: sort by date modified
    ^l::          ToggleOpt("vo{down 2}")                                       ;FileExplorer: sort by type
    ^h::          ToggleOpt("vo{down 3}")                                       ;FileExplorer: sort by size
    >!SC027::     DetailedView()                                                ;FileExplorer| detailed file info with resized columnsnmn
    $+!c::        clipboard := Explorer_GetSelection()                          ;FileExplorer| store file path(s) of selected file(s) in clipboard
    !s::          SelectByRegEx()                                               ;FileExplorer| select all files matching regex pattern
    ralt & j::    send {down}                                                   ;Navigation| Up 
    ralt & k::    send {up}                                                     ;Navigation| Down  


; OPEN FILE|FOLDER PATH|FB _____________________________________________________
    ; works on full file paths for all MS office files (xls, doc, ppt, etc.)
    ; functions below are valid anywhere in windows if "T_FM" variable in config.ini = 1
    
    #IF GC("T_FM",0) 
                                                                                ; GC = (G)et (C)onfig.ini("var_name", "value returned if none found") 
    >+F4::        OP("golems\_system.ahk")                                      ;OpenPath: _system.ahk                         
    >+F1::        OP("golems\1_Apps_Misc.ahk")                                  ;OpenPath: A_Quick_Start.ahk 
    >+F2::        OP("golems\2_Text_Manipulation.ahk")                          ;OpenPath: B_Text_Manipulation.ahk 
    >+F3::        OP("golems\3_File_Management.ahk")                            ;OpenPath: C_File_Management.ahk 


    ; Function Box: opens a window that gives the user a menu of parameter choices for calling a function
    ; #SC034: :      FB((WinActive("ahk_group FileListers") ? "ChangeFolder" : "OpenPath"), Paths(), C.lpurple)  ;FB: Opens Jump Menu for opening saved paths to files, folders, URLs (works in save dialogue windows)

; FILE EXPLORER AND LISTVIEW WINDOWS ___________________________________________
  ; ChangeFolder() shortcuts are valid in file explorer and other listview type windows (e.g., save as diaglogue boxes)
  ; below only applies to ListView windows like file explorer and save as dialogue boxes if T_FM = 1

  SetTitleMatchMode, 2
  #If WinActive("ahk_group FileListers") and GC("T_FM",0) 
  !u::            Send {blind}!{up}                                             ;FileExplorer: up one folder level 
  <!i::           Send {blind}!{left}                                           ;FileExplorer: prev folder         
  <!o::           Send {blind}!{right}                                          ;FileExplorer: forward folder      
  !d::            Send {blind}!d                                                ;FileExplorer: select path bar     
  >+sc029::       CF(A_ScriptDir)                                               ;ChangeFolder: WinGolems folder    
  >+m::           CF(A_ScriptDir "\mem_cache")                                  ;ChangeFolder: mem_cache
  >+u::           CF(UProfile)                                                  ;ChangeFolder: %UserProfile%
  >+j::           CF(UProfile "\Downloads")                                     ;ChangeFolder: Downloads
  >+o::           CF(A_ProgramFiles)                                            ;ChangeFolder: C:\Program Files
  >+>!o::         CF(PF_x86)                                                    ;ChangeFolder: C:\Program Files(x86)
  >+p::           CF(UProfile "\Pictures")                                      ;ChangeFolder: Pictures
  >+d::           CF(UProfile "\Documents")                                     ;ChangeFolder: My Documents
  >+c::           CF(hdrive)                                                    ;ChangeFolder: %Homedrive% (C:)
  >+r::           CF("`:`:{645FF040-5081-101B-9F08-00AA002F954E}"), CFW()       ;ChangeFolder: Recycle bin (doesn't work for save as diag)
  F1 & h::        CF("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}"), CFW()       ;ChangeFolder: This PC / My Computer
                                                                                ; https://www.autohotkey.com/docs/misc/CLSID-List.htm 
#IF
