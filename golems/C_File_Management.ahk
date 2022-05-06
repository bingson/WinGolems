
#IF
; STARTING SAVED PATHS TO FILES AND FOLDERS ____________________________________
  ; Users can overwrite these paths through (1) hotkey or (2) command box;
  ; (1) HOTKEY PATH SAVE: press right ctrl + shift + F1 while a file or folder in File Explorer is selected
  ; (2) CB PATH SAVE: select file or folder in Windows File Explorer, then open CB("~win") and enter sF1 
  ; the above also works with selected text that is a URL  
  ;                           
  ; A_ScriptDir = WinGolems folder path 
  ; UProfile    = currently logged in windows user folder path

  Paths(help=0) {
    AutoTrim, Off
    msg                  := "How to overwrite a open file|folder|URL path shortcut: `n`n`t"
                          . "1) <SELECT> a file|folder in file explorer or highlight a url `n`t"
                          . "including the ""http"" portion;`n`n`t" 
                          . "2) <ENTER> ""+Key"" associated with the path you want to overwrite in `n`t" 
                          . "the input box below (also works in a Command Box). `n`n`t"
                          . "E.g.,`tSelect example.doc in file explorer, open a Function Box or `n`t" 
                          . "`tCommand Box and enter ""+f1"" in the input field to overwrite`n`t" 
                          . "`tthe default F1 shortcut for B_Text_Manipulation.ahk.`n`n"
                        ;   . "`t`tSAMPLE VALID PATH TYPES:`n`n"
                        ;   . "`t`tEdit AHK files        `t`tE,F1,F2`n"
                        ;   . "`t`tOpen Folder           `t`tF3,F4,F5`n"
                        ;   . "`t`tOpen URL              `t`tF6`n" 
                        ;   . "`t`tEdit Office Documents `tF7,F8,F9`n"
                        ;   . "`t`tNote: also works with video files (mp4, webm, avi, mkv)`n"
    msg := help ? msg : " "

    global UProfile
    global p := { "e"  : GC("esc_path" , A_ScriptDir "\golems\A_Quick_Start.ahk")      
                , "f1" : GC("F1_path"  , A_ScriptDir "\golems\B_Text_Manipulation.ahk")
                , "f2" : GC("F2_path"  , A_ScriptDir "\golems\C_File_Management.ahk")  
                , "f3" : GC("F3_path"  , A_ScriptDir)                     
                , "f4" : GC("F4_path"  , A_ScriptDir "\mem_cache")                     
                , "f5" : GC("F5_path"  , A_ScriptDir "\golems")               
                , "f6" : GC("F6_path"  , "https://www.autohotkey.com/docs/Tutorial.htm")  
                , "f7" : GC("F7_path"  , A_ScriptDir "\assets\tutorial\example.xlsx")
                , "f8" : GC("F8_path"  , A_ScriptDir "\assets\tutorial\example.pptx")
                , "f9" : GC("F9_path"  , A_ScriptDir "\assets\tutorial\example.docx")
                , " ": msg }
    return % p
  }

; OPEN|SAVE PATHS HOTKEYS ______________________________________________________
  ; golems\_paths.ahk contains 
  
  ; hotkey    
  +>^esc::      SP("E_path")                                                   ;FileExplorer; file|folder save E_path 
  +>^F1::                                                                      ;FileExplorer; file|folder save F1_path                                 
  +>^F2::                                                                      ;FileExplorer; file|folder save F2_path                                 
  +>^F3::                                                                      ;FileExplorer; file|folder save F3_path                                 
  +>^F4::                                                                      ;FileExplorer; file|folder save F4_path 
  +>^F5::                                                                      ;FileExplorer; file|folder save F5_path 
  +>^F6::                                                                      ;FileExplorer; file|folder save F6_path 
  +>^F7::                                                                      ;FileExplorer; file|folder save F7_path 
  +>^F8::                                                                      ;FileExplorer; file|folder save F8_path 
  +>^F9::       SP(ltrim(A_ThisHotkey, "+>^") . "_path")                       ;FileExplorer; file|folder save F9_path 

; FILE EXPLORER CONVENIENCE ____________________________________________________

  #If WinActive("ahk_exe Explorer.EXE") and GC("T_FM",0) ; -- -- -- -- -- -- -- below shortcuts active in file explorer if "T_FM" variable in config.ini = 1

  !u::          send !{up}                                                      ;FileExplorer: up one folder level  
  !i::          send !{left}                                                    ;FileExplorer: prev folder
  !o::          send !{right}                                                   ;FileExplorer: forward folder
  !z::          ToggleNavPane()                                                 ;FileExplorer: toggle navigation plane 
  
  ^p::          Send {alt down}p{alt up}                                        ;FileExplorer: toggle preview plane
  !w::          ControlFocus, SysTreeView321, ahk_class CabinetWClass           ;FileExplorer: move focus to navigation pane
  !e::          ControlFocus, DirectUIHWND2, ahk_class CabinetWClass            ;FileExplorer: move focus to current folder pane
  $!r::         Send {F2}                                                       ;FileExplorer: rename file
  ^u::          ToggleOpt("vg{up 4}")                                           ;FileExplorer: group by name|remove grouping toggle
  ^o::          ToggleOpt("vg{down 2}")                                         ;FileExplorer: group by file type
  ^i::          ToggleOpt("vg{down 1}")                                         ;FileExplorer: group by date modified
  ^j::          ToggleOpt("vo")                                                 ;FileExplorer: sort by name
  ^k::          ToggleOpt("vo{down}")                                           ;FileExplorer: sort by date modified
  ^l::          ToggleOpt("vo{down 2}")                                         ;FileExplorer: sort by type
  ^h::          ToggleOpt("vo{down 3}")                                         ;FileExplorer: sort by size
  >!SC027::     DetailedView()                                                  ;FileExplorer| detailed file info with resized columnsnmn
  $+!c::        clipboard := Explorer_GetSelection()                            ;FileExplorer| store file path(s) of selected file(s) in clipboard
  !s::          SelectByRegEx()                                                 ;FileExplorer| select all files matching regex pattern
  !j::          send {down}                                                     ;Navigation| Up 
  !k::          send {up}                                                       ;Navigation| Down  

; OPEN FILE|FOLDER PATH|FB _____________________________________________________
  ; works on full file paths for all MS office files (xls, doc, ppt, etc.)
  ; functions below are valid anywhere in windows if "T_FM" variable in config.ini = 1
  
  #IF GC("T_FM",0) 
                                                                                ; GC = (G)et (C)onfig.ini("var_name", "value returned if none found") 
  >^esc::       OP(Paths()["e"])                                             ;OpenPath: open saved file|folder path from +^esc                                       
  >^F1::        OP(Paths()["f1"])                                            ;OpenPath: open saved file|folder path from +^F1
  >^F2::        OP(Paths()["f2"])                                            ;OpenPath: open saved file|folder path from +^F2
  >^F3::        OP(Paths()["f3"])                                            ;OpenPath: open saved file|folder path from +^F3
  >^F4::        OP(Paths()["f4"])                                            ;OpenPath: open saved file|folder path from +^F4
  >^F5::        OP(Paths()["f5"])                                            ;OpenPath: open saved file|folder path from +^F5
  >^F6::        OP(Paths()["f6"])                                            ;OpenPath: open saved file|folder path from +^F6
  >^F7::        OP(Paths()["f7"])                                            ;OpenPath: open saved file|folder path from +^F7
  >^F8::        OP(Paths()["f8"])                                            ;OpenPath: open saved file|folder path from +^F8
  >^F9::        OP(Paths()["f9"])                                            ;OpenPath: open saved file|folder path from +^F9

  ; Function Box: opens a window that gives the user a menu of parameter choices for calling a function
  ; #SC034: :      FB((WinActive("ahk_group FileListers") ? "ChangeFolder" : "OpenPath"), Paths(), C.lpurple)  ;FB: Opens Jump Menu for opening saved paths to files, folders, URLs (works in save dialogue windows)

; FILE EXPLORER AND LISTVIEW WINDOWS ___________________________________________
  ; ChangeFolder() shortcuts are valid in file explorer and other listview type windows (e.g., save as diaglogue boxes)
  ; below only applies to ListView windows like file explorer and save as dialogue boxes if T_FM = 1

  SetTitleMatchMode, 2
  #If WinActive("ahk_group FileListers") and GC("T_FM",0) 
  !u::          send !{up}                                                      ;FileExplorer: up one folder level  
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
