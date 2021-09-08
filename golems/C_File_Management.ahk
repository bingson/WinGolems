#IF
; FILE EXPLORER AND LISTVIEW WINDOWS ___________________________________________
  ; ChangeFolder() shortcuts are valid in file explorer and other listview type windows (e.g., save as diaglogue boxes)

  SetTitleMatchMode, 2
  #If WinActive("ahk_group FileListers") and GC("T_FM",0)                       ; below only applies to ListView windows like file explorer and save as dialogue boxes if T_FM = 1
  
  >+sc029::     CF(A_ScriptDir)                                                 ;ChangeFolder: WinGolems folder
  >+m::         CF(A_ScriptDir "\mem_cache\")                                   ;ChangeFolder: mem_cache
  >+u::         CF(UProfile)                                                    ;ChangeFolder: %UserProfile%
  >+j::         CF(UProfile "\Downloads")                                       ;ChangeFolder: Downloads
  >+o::         CF(A_ProgramFiles)                                              ;ChangeFolder: C:\Program Files
  >+!o::        CF(PF_x86)                                                      ;ChangeFolder: C:\Program Files(x86)
  >+p::         CF(UProfile "\Pictures\")                                       ;ChangeFolder: Pictures
  >+d::         CF(UProfile "\Documents")                                       ;ChangeFolder: Documents
  >+c::         CF(hdrive)                                                      ;ChangeFolder: %Homedrive% (C:)
  >+r::         CF("`:`:{645FF040-5081-101B-9F08-00AA002F954E}"), CFW()         ;ChangeFolder: Recycle bin (doesn't work for save as diag)
  >+t::         CF("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}"), CFW()         ;ChangeFolder: This PC / My Computer
                                                                                ; https://www.autohotkey.com/docs/misc/CLSID-List.htm 
  !u::          send !{up}                                                      ;FileExplorer: up one folder level  
  !i::          send !{left}                                                    ;FileExplorer: prev folder
  !o::          send !{right}                                                   ;FileExplorer: forward folder
  !z::          Send !vn{enter}                                                 ;FileExplorer: toggle navigation pane
  ^p::          Send {alt down}p{alt up}                                        ;FileExplorer: toggle preview plane
  !b::          ControlFocus, SysTreeView321, ahk_class CabinetWClass           ;FileExplorer: move focus to navigation pane
  !space::      ControlFocus, DirectUIHWND2, ahk_class CabinetWClass            ;FileExplorer: move focus to current folder pane
  ^u::          send !vg{up   4}{enter}                                         ;FileExplorer: group by name|remove grouping toggle
  ^o::          Send !vg{down 2}{enter}                                         ;FileExplorer: group by file type
  ^i::          Send !vg{down 1}{enter}                                         ;FileExplorer: group by date
  $!r::         Send {F2}                                                       ;FileExplorer: rename file
  <^j::         SortByName()                                                    ;FileExplorer: sort by name
  <^k::         SortByDate()                                                    ;FileExplorer: sort by date modified
  >^j::         SortByType()                                                    ;FileExplorer: sort by type
  >^k::         SortBySize()                                                    ;FileExplorer: sort by size
  !SC027::      DetailedView()                                                  ;FileExplorer| detailed file info with resized columnsnmn       
  ^h::          ToggleInvisible()                                               ;FileExplorer| toggle hide/unhide invisible files
  $+!c::        clipboard := Explorer_GetSelection()                            ;FileExplorer| store file path(s) of selected file(s) in clipboard
  ^s::          SelectByRegEx()                                                 ;FileExplorer| select all files matching regex pattern 

; EDIT FILE ____________________________________________________________________
  ; works on full file paths to all MS office files (xls, doc, ppt, etc.)

  #IF GC("T_FM",0)                                                              ;lines below are valid anywhere in windows if "T_FM" variable in config.ini = 1
  >^esc::       EditFile("golems\A_Quick_Start.ahk")                            ;EditFile: A_QuickStart.ahk
  >^F1::        EditFile("golems\B_Text_Manipulation.ahk")                      ;EditFile: B_Text_Navigation.ahk
  >^F2::        EditFile("golems\C_File_Management.ahk")                        ;EditFile: C_File_Navigation.ahk
  >^F3::        EditFile("golems\D_App_Examples.ahk")                           ;EditFile: D_App_Dependent.ahk

  ;>^F4:`:      EditFile("assets\tutorial\example.xlsx")                        ;EditFile: example.xlsx
  ;>^F5:`:      EditFile("assets\tutorial\example.docx")                        ;EditFile: example.docx
  ;>^F6:`:      EditFile("assets\tutorial\example.pptx")                        ;EditFile: example.pptx

; OPEN FOLDER __________________________________________________________________
  ; accepts full file paths as well as config.ini stored entries using get configuration function GC("file_path")

  >!esc::       OpenFolder("mem_cache")                                         ;OpenFolder: mem_cache (.txt memory folder)
  >!F1::        OpenFolder(A_ScriptDir)                                         ;OpenFolder: WinGolems (.txt memory folder)
  >!F2::        OpenFolder("golems")                                            ;OpenFolder: WinGolems (.txt memory folder)

; FUNCTION BOX _________________________________________________________________
  ; Purpose: opens a window that gives the user a menu of parameter choices for calling a function
  ; Note: A line that begins with a comma (or any other operator) is automatically appended to the line above it.                              
  ; The comma operator is usually faster than writing separate expressions https://www.autohotkey.com/docs/Variables.htm#comma

  e~win: 
  +#b:: Files   := { "f"  : A_ScriptDir "\golems\_functions.ahk"                ;FunctionBox: edit file
                   , "s"  : A_ScriptDir "\golems\_system.ahk"                   ; for the construction of the GUI menu
                   , "a"  : A_ScriptDir "\golems\A_Quick_Start.ahk"             ; all text before the before the last "\" is ignored
                   , "b"  : A_ScriptDir "\golems\B_Text_Manipulation.ahk"       ; only destination file or folder is shown in the GUI menu as an option
                   , "c"  : A_ScriptDir "\golems\C_File_Management.ahk"
                   , "d"  : A_ScriptDir "\golems\D_App_Examples.ahk"
                   , "w"  : A_ScriptDir "\WinGolems.ahk"
                   , "t"  : A_ScriptDir "\golems\test.ahk"
                   , "xe" : A_ScriptDir "\assets\tutorial\example.xlsx"
                   , "we" : A_ScriptDir "\assets\tutorial\example.docx"
                   , "pe" : A_ScriptDir "\assets\tutorial\example.pptx"
                   , "i"  : """" config_path """" }, FB("EditFile", Files, C.lblue)

  ef~win: 
  ^#b:: Folders := { "m"  : A_ScriptDir "\mem_cache"                            ;FunctionBox: open folder
                   , "j"  : UProfile "\Downloads"
                   , "d"  : UProfile "\Documents"
                   , "dt" : UProfile "\Documents"
                   , "p"  : UProfile "\Pictures"
                   , "t"  : "`:`:{20d04fe0-3aea-1069-a2d8-08002b30309d}" 
                   , "r"  : "`:`:{645ff040-5081-101b-9f08-00aa002f954e}"
                   , "w"  : A_ScriptDir } 
      , AltText := { "m"  : "WG mem_cache (text memory files)"                  ;alternate dictionary to replace TOC text auto-generated from parameter inputs
                   , "j"  : "My Downloads"
                   , "d"  : "My Documents"
                   , "p"  : "Pictures"
                   , "t"  : "This PC"
                   , "r"  : "Recycle Bin"
                   , "w"  : "WinGolems" }, FB("OpenFolder", Folders, C.lbrown,,,, AltText)

#IF