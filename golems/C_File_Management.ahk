#IF
; FILE EXPLORER AND LISTVIEW WINDOWS ___________________________________________
  ; ChangeFolder() shortcuts are valid in file explorer and other listview type windows (e.g., save as diaglogue boxes)

  SetTitleMatchMode, 2
  #If WinActive("ahk_group FileListers") and GC("T_FM",0) ; -- -- -- -- -- -- -- below only applies to ListView windows like file explorer and save as dialogue boxes if T_FM = 1
  
  >+sc029::     CF(A_ScriptDir)                                                 ;ChangeFolder: WinGolems folder
  >+m::         CF(A_ScriptDir "\mem_cache")                                    ;ChangeFolder: mem_cache
  >+u::         CF(UProfile)                                                    ;ChangeFolder: %UserProfile%
  >+j::         CF(UProfile "\Downloads")                                       ;ChangeFolder: Downloads
  >+o::         CF(A_ProgramFiles)                                              ;ChangeFolder: C:\Program Files
  >+!o::        CF(PF_x86)                                                      ;ChangeFolder: C:\Program Files(x86)
  >+p::         CF(UProfile "\Pictures")                                        ;ChangeFolder: Pictures
  >+d::         CF(UProfile "\Documents")                                       ;ChangeFolder: Documents
  >+c::         CF(hdrive)                                                      ;ChangeFolder: %Homedrive% (C:)
  >+r::         CF("`:`:{645FF040-5081-101B-9F08-00AA002F954E}"), CFW()         ;ChangeFolder: Recycle bin (doesn't work for save as diag)
  >+t::         CF("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}"), CFW()         ;ChangeFolder: This PC / My Computer
                                                                                ; https://www.autohotkey.com/docs/misc/CLSID-List.htm 
  !u::          send !{up}                                                      ;FileExplorer: up one folder level  
  !i::          send !{left}                                                    ;FileExplorer: prev folder
  !o::          send !{right}                                                   ;FileExplorer: forward folder
  !z::          ToggleNavPane("alt")
  ^p::          Send {alt down}p{alt up}                                        ;FileExplorer: toggle preview plane
  !w::          ControlFocus, SysTreeView321, ahk_class CabinetWClass           ;FileExplorer: move focus to navigation pane
  !e::          ControlFocus, DirectUIHWND2, ahk_class CabinetWClass            ;FileExplorer: move focus to current folder pane
  ^u::          ToggleOpt("ctrl","vg{up 4}")                                         ;FileExplorer: group by name|remove grouping toggle
  ^o::          ToggleOpt("ctrl","vg{down 2}")                                    ;FileExplorer: group by file type
  ^i::          ToggleOpt("ctrl","vg{down 1}")                                    ;FileExplorer: group by date modified
  ^y::          ToggleOpt("ctrl","vg{down 4}")                                  ;FileExplorer: group by date created
  $!r::         Send {F2}                                                       ;FileExplorer: rename file
  <^j::         SortByName()                                                    ;FileExplorer: sort by name
  <^k::         SortByDate()                                                    ;FileExplorer: sort by date modified
  >^j::         SortByType()                                                    ;FileExplorer: sort by type
  >^k::         SortBySize()                                                    ;FileExplorer: sort by size
  !SC027::      DetailedView()                                                  ;FileExplorer| detailed file info with resized columnsnmn       
  $+!c::        clipboard := Explorer_GetSelection()                            ;FileExplorer| store file path(s) of selected file(s) in clipboard
  !s::          SelectByRegEx()                                                 ;FileExplorer| select all files matching regex pattern 
  +^esc::       savePath("cESC_path")                                           ;FileExplorer; save file|folder path for ^esc
  +^F1::        savePath("cF1_path")                                            ;FileExplorer; save file|folder path for ^F1                                   
  +^F2::        savePath("cF2_path")                                            ;FileExplorer; save file|folder path for ^F2                                   
  +^F3::        savePath("cF3_path")                                            ;FileExplorer; save file|folder path for ^F3                                   
  +^F4::        savePath("cF4_path")                                            ;FileExplorer; save file|folder path for ^F4
  +^F5::        savePath("cF5_path")                                            ;FileExplorer; save file|folder path for ^F5
  +^F6::        savePath("cF6_path")                                            ;FileExplorer; save file|folder path for ^F6
  +^F7::        savePath("cF7_path")                                            ;FileExplorer; save file|folder path for ^F7
  +^F8::        savePath("cF8_path")                                            ;FileExplorer; save file|folder path for ^F8
  ^!h::         send {home}                                                     ;Navigation: Home
  ^!l::         send {end}                                                      ;Navigation: End
  !j::          send {down}                                                     ;Navigation| Up 
  !k::          send {up}                                                       ;Navigation| Down  
                                                                                ; file explorer needs a different key send mode 

; OPEN FILE|FOLDER PATH ________________________________________________________
  ; works on full file paths for all MS office files (xls, doc, ppt, etc.)

  #IF GC("T_FM",0) ; -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --;lines below are valid anywhere in windows if "T_FM" variable in config.ini = 1
  
                                                                                ; GC = (G)et (C)onfig.ini("var_name", "value returned if none found") 
  ^esc::       OpenPath(GC("cesc_path", "golems\A_Quick_Start.ahk"))            ;OpenPath: open saved file|folder path from +^esc    
  ^F1::        OpenPath(GC("cF1_path" , "golems\B_Text_Manipulation.ahk"))      ;OpenPath: open saved file|folder path from +^F1    
  ^F2::        OpenPath(GC("cF2_path" , "golems\C_File_Management.ahk"))        ;OpenPath: open saved file|folder path from +^F2    
  ^F3::        OpenPath(GC("cF3_path" , "golems\D_App_Examples.ahk"))           ;OpenPath: open saved file|folder path from +^F3    
  ^F4::        OpenPath(GC("cF4_path" , "mem_cache"))                           ;OpenPath: open saved file|folder path from +^F4   
  ^F5::        OpenPath(GC("cF5_path" , A_ScriptDir))                           ;OpenPath: open saved file|folder path from +^F5   
  ^F6::        OpenPath(GC("cF6_path" , "golems"))                              ;OpenPath: open saved file|folder path from +^F6   
  ^F7::        OpenPath(GC("cF7_path" , UProfile "\Documents"))                 ;OpenPath: open saved file|folder path from +^F7    
  ^F8::        OpenPath(GC("cF8_path" , UProfile "\Downloads"))                 ;OpenPath: open saved file|folder path from +^F8   

; FUNCTION BOX _________________________________________________________________
  ; Purpose: opens a window that gives the user a menu of parameter choices for calling a function
  ; Note: A line that begins with a comma (or any other operator) is automatically appended to the line above it.                              
  ; The comma operator is usually faster than writing separate expressions https://www.autohotkey.com/docs/Variables.htm#comma


   #SC033::                                                                     ;FB: Menu for cESC-cF8 saved paths
    send {blind}
    t := { "esc": GC("cESC_path", "golems\A_Quick_Start.ahk")      
          ,"f1" : GC("cF1_path" , "golems\B_Text_Manipulation.ahk")
          ,"f2" : GC("cF2_path" , "golems\C_File_Management.ahk")  
          ,"f3" : GC("cF3_path" , "golems\D_App_Examples.ahk")     
          ,"f4" : GC("cF4_path" , "mem_cache")                     
          ,"f5" : GC("cF5_path" , A_ScriptDir)                     
          ,"f6" : GC("cF6_path" , "golems")                        
          ,"f7" : GC("cF7_path" , UProfile "\Documents")
          ,"f8" : GC("cF8_path" , UProfile "\Downloads")}
    FB("OpenPath", t)
    return

  #IF WinExist("ahk_id " FB_hwnd)                                               ;Function Box must exist for the below two lines to be valid
    $<^space::                                                                  ;FB: activate already open Function Box and move focus to inputbox
    $>^space::         ActivateWin("ahk_id " FB_hwnd)                           ;FB: activate already open Function Box and move focus to inputbox
    
#IF
