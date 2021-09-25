
#IF
; STARTING SAVED PATHS TO FILES AND FOLDERS ____________________________________
  ; Users can overwrite these paths through (1) hotkey or (2) command box;
  ; (1) HOTKEY PATH SAVE: press right ctrl + shift + F1 while a file or folder in File Explorer is selected
  ; (2) CB PATH SAVE: select file or folder in Windows File Explorer, then open CB("~win") and enter sF1 
  ; the above also works with selected text that is a URL  
  ;                           
  ; A_ScriptDir = WinGolems folder path 
  ; UProfile    = currently logged in windows user folder path

  Paths() {
    global UProfile
    global p := { "e"  : GC("cE_path"   , A_ScriptDir "\golems\A_Quick_Start.ahk")      
                , "f1" : GC("cF1_path"  , A_ScriptDir "\golems\B_Text_Manipulation.ahk")
                , "f2" : GC("cF2_path"  , A_ScriptDir "\golems\C_File_Management.ahk")  
                , "f2=--" : "------------------OPEN FOLDER--------------------"
                , "f3" : GC("cF3_path"  , A_ScriptDir)                     
                , "f4" : GC("cF4_path"  , A_ScriptDir "\mem_cache")                     
                , "f5" : GC("cF5_path"  , A_ScriptDir "\golems")               
                , "f5=--" : "-----------OPEN URL | OFFICE DOCUMENT------------"         
                , "f6" : GC("cF6_path"  , "https://www.autohotkey.com/docs/Tutorial.htm")  
                , "f7" : GC("cF7_path"  , A_ScriptDir "\assets\tutorial\example.xlsx")
                , "f8" : GC("cF8_path"  , A_ScriptDir "\assets\tutorial\example.pptx")
                , "f9" : GC("cF9_path"  , A_ScriptDir "\assets\tutorial\example.docx")}
    return % p
  }

; SAVE PATHS ___________________________________________________________________
  
  ; command box
  :X:se~win::   SP("cE_path")                                                   ;FileExplorer; file|folder save path for >^esc
  :X:sF1~win::  SP("cF1_path")                                                  ;FileExplorer; file|folder save path for >^F1                                   
  :X:sF2~win::  SP("cF2_path")                                                  ;FileExplorer; file|folder save path for >^F2                                   
  :X:sF3~win::  SP("cF3_path")                                                  ;FileExplorer; file|folder save path for >^F3                                   
  :X:sF4~win::  SP("cF4_path")                                                  ;FileExplorer; file|folder save path for >^F4
  :X:sF5~win::  SP("cF5_path")                                                  ;FileExplorer; file|folder save path for >^F5
  :X:sF6~win::  SP("cF6_path")                                                  ;FileExplorer; file|folder save path for >^F6
  :X:sF7~win::  SP("cF7_path")                                                  ;FileExplorer; file|folder save path for >^F7
  :X:sF8~win::  SP("cF8_path")                                                  ;FileExplorer; file|folder save path for >^F8
  :X:sF9~win::  SP("cF9_path")                                                  ;FileExplorer; file|folder save path for >^F8
  
  ; hotkey    
  +>^esc::      SP("cE_path")                                                   ;FileExplorer; file|folder save path for >^esc
  +>^F1::       SP("cF1_path")                                                  ;FileExplorer; file|folder save path for >^F1                                   
  +>^F2::       SP("cF2_path")                                                  ;FileExplorer; file|folder save path for >^F2                                   
  +>^F3::       SP("cF3_path")                                                  ;FileExplorer; file|folder save path for >^F3                                   
  +>^F4::       SP("cF4_path")                                                  ;FileExplorer; file|folder save path for >^F4
  +>^F5::       SP("cF5_path")                                                  ;FileExplorer; file|folder save path for >^F5
  +>^F6::       SP("cF6_path")                                                  ;FileExplorer; file|folder save path for >^F6
  +>^F7::       SP("cF7_path")                                                  ;FileExplorer; file|folder save path for >^F7
  +>^F8::       SP("cF8_path")                                                  ;FileExplorer; file|folder save path for >^F8
  +>^F9::       SP("cF9_path")                                                  ;FileExplorer; file|folder save path for >^F8

; FILE EXPLORER CONVENIENCE ____________________________________________________

  #If WinActive("ahk_exe Explorer.EXE") and GC("T_FM",0) ; -- -- -- -- -- -- -- below shortcuts active in file explorer if "T_FM" variable in config.ini = 1

  !u::          send !{up}                                                      ;FileExplorer: up one folder level  
  !i::          send !{left}                                                    ;FileExplorer: prev folder
  !o::          send !{right}                                                   ;FileExplorer: forward folder
  !z::          ToggleNavPane("alt")                                            ;FileExplorer: toggle navigation plane 
  ^p::          Send {alt down}p{alt up}                                        ;FileExplorer: toggle preview plane
  !w::          ControlFocus, SysTreeView321, ahk_class CabinetWClass           ;FileExplorer: move focus to navigation pane
  !e::          ControlFocus, DirectUIHWND2, ahk_class CabinetWClass            ;FileExplorer: move focus to current folder pane
  $!r::         Send {F2}                                                       ;FileExplorer: rename file
  ^u::          ToggleOpt("ctrl","vg{up 4}")                                    ;FileExplorer: group by name|remove grouping toggle
  ^o::          ToggleOpt("ctrl","vg{down 2}")                                  ;FileExplorer: group by file type
  ^i::          ToggleOpt("ctrl","vg{down 1}")                                  ;FileExplorer: group by date modified
  ^y::          ToggleOpt("ctrl","vg{down 4}")                                  ;FileExplorer: group by date created
  ^j::          ToggleOpt("ctrl","vo")                                          ;FileExplorer: sort by name
  ^k::          ToggleOpt("ctrl","vo{down}")                                    ;FileExplorer: sort by date modified
  ^l::          ToggleOpt("ctrl","vo{down 2}")                                  ;FileExplorer: sort by type
  ^h::          ToggleOpt("ctrl","vo{down 3}")                                  ;FileExplorer: sort by size
  !SC027::      DetailedView()                                                  ;FileExplorer| detailed file info with resized columnsnmn
  $+!c::        clipboard := Explorer_GetSelection()                            ;FileExplorer| store file path(s) of selected file(s) in clipboard
  !s::          SelectByRegEx()                                                 ;FileExplorer| select all files matching regex pattern
  ^!h::         send {home}                                                     ;Navigation: Home
  ^!l::         send {end}                                                      ;Navigation: End
  !j::          send {down}                                                     ;Navigation| Up 
  !k::          send {up}                                                       ;Navigation| Down  

; OPEN FILE|FOLDER PATH ________________________________________________________
  ; works on full file paths for all MS office files (xls, doc, ppt, etc.)
  ; functions below are valid anywhere in windows if "T_FM" variable in config.ini = 1
  
  #IF GC("T_FM",0) 
                                                                                ; GC = (G)et (C)onfig.ini("var_name", "value returned if none found") 
  ^esc::         OP(Paths()["e"])                                               ;OpenPath: open saved file|folder path from +^esc                                       
  ^F1::          OP(Paths()["f1"])                                              ;OpenPath: open saved file|folder path from +^F1
  ^F2::          OP(Paths()["f2"])                                              ;OpenPath: open saved file|folder path from +^F2
  ^F3::          OP(Paths()["f3"])                                              ;OpenPath: open saved file|folder path from +^F3
  ^F4::          OP(Paths()["f4"])                                              ;OpenPath: open saved file|folder path from +^F4
  ^F5::          OP(Paths()["f5"])                                              ;OpenPath: open saved file|folder path from +^F5
  ^F6::          OP(Paths()["f6"])                                              ;OpenPath: open saved file|folder path from +^F6
  ^F7::          OP(Paths()["f7"])                                              ;OpenPath: open saved file|folder path from +^F7
  ^F8::          OP(Paths()["f8"])                                              ;OpenPath: open saved file|folder path from +^F8
  ^F9::          OP(Paths()["f9"])                                              ;OpenPath: open saved file|folder path from +^F9

  ; Function Box: opens a window that gives the user a menu of parameter choices for calling a function
  #SC033::       FB((WinActive("ahk_group FileListers") ? "ChangeFolder" : "OpenPath"), Paths())  ;FB: Opens Jump Menu for saved paths (works everwhere inclulding save dialogue windows)

; FILE EXPLORER AND LISTVIEW WINDOWS ___________________________________________
  ; ChangeFolder() shortcuts are valid in file explorer and other listview type windows (e.g., save as diaglogue boxes)
  ; below only applies to ListView windows like file explorer and save as dialogue boxes if T_FM = 1

  SetTitleMatchMode, 2
  #If WinActive("ahk_group FileListers") and GC("T_FM",0) 
  
  >+sc029::     CF(A_ScriptDir)                                                 ;ChangeFolder: WinGolems folder
  >+m::         CF(A_ScriptDir "\mem_cache")                                    ;ChangeFolder: mem_cache
  >+u::         CF(UProfile)                                                    ;ChangeFolder: %UserProfile%
  >+j::         CF(UProfile "\Downloads")                                       ;ChangeFolder: Downloads
  >+o::         CF(A_ProgramFiles)                                              ;ChangeFolder: C:\Program Files
  >!o::         CF(PF_x86)                                                      ;ChangeFolder: C:\Program Files(x86)
  >+p::         CF(UProfile "\Pictures")                                        ;ChangeFolder: Pictures
  >+d::         CF(UProfile "\Documents")                                       ;ChangeFolder: Documents
  >+c::         CF(hdrive)                                                      ;ChangeFolder: %Homedrive% (C:)
  >+r::         CF("`:`:{645FF040-5081-101B-9F08-00AA002F954E}"), CFW()         ;ChangeFolder: Recycle bin (doesn't work for save as diag)
  >+t::         CF("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}"), CFW()         ;ChangeFolder: This PC / My Computer
                                                                                ; https://www.autohotkey.com/docs/misc/CLSID-List.htm 
#IF
