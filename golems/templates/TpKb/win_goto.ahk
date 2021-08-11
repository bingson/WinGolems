AutoExecution~win_goto: ;_______________________________________________________

 ; INITIALIZE USER DICTIONARIES -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  MoveWin_DICT := { "F" : "Maximize"
                  , "a" : "LeftHalf"        
                  , "d" : "RightHalf"       
                  , "dd": "RightHalfsmall"       
                  , "w" : "TopHalf"         
                  , "ww": "TopHalfSmall"
                  , "ss": "BottomHalfSmall"
                  , "s" : "BottomHalf"      
                  , "q" : "TopLeft"         
                  , "e" : "TopRight"        
                  , "z" : "BottomLeft"      
                  , "c" : "BottomRight"     
                  , "qq": "TopLeftSmall"    
                  , "zz": "BottomLeftSmall" 
                  , "ee": "TopRightSmall"   
                  , "cc": "BottomRightSmall" }

  
 
  ; modify *_DICT arrays to modify jump list options and *_DICT arrays to change
  
  File_DICT    := { "v"    : "golems\coding_environments.ahk"
                  , "f"    : "golems\_functions.ahk"                            ; options for edit file jump list
                  , "g"    : "golems\win_goto.ahk"
                  , "c"    : "golems\chrome.ahk"
                  , "t"    : "golems\win_text_navigation.ahk"
                  , "r"    : "golems\win_sys.ahk"
                  , "o"    : "golems\office.ahk"
                  , "j"    : "golems\jupyter.ahk"
                  , "p"    : "golems\Python.ahk"
                  , "v"    : "golems\coding_environments.ahk"
                  , "ms"   : "golems\win_mem_system.ahk"
                  , "gi"   : ".gitignore"
                  , "r"    : "golems\R.ahk"
                  , "m"    : "master.ahk"
                  , "mm"   : UProfile """\Google Drive\secure\mm.ahk"""
                  , "aq"   : UProfile "\Google Drive\1-Jobs\2_Monzo\AQ_1_1.docm"
                  , "i"    : """" config_path """"
                  , "h"    : "golems\Hotkey_Help.ahk" }
  
  Folder_DICT  := { "u"    : "C:\Users\bings\DS\DAG_course\pics"
                ;     "a"    : A_ScriptDir                                      ; options for open folder jump list
                ;   , "g"    : A_ScriptDir "\golems"
                ;   , "pf"   : A_ProgramFiles
                ;   , "pfo"  : PF_x86
                ;   , "gd"   : UProfile "\Google Drive"
                ;   , "pic"  : UProfile """\Google Drive\pics"""                ; UProfile "\Pictures"
                ;   , "wg"   : "C:\Users\bings\WinGolems"
                ;   , "j"    : UProfile "\Downloads"
                ;   , "md"   : UProfile "\Documents"
                ;   , "mem"  : A_ScriptDir "\mem_cache"
                ;   , "s"    : UProfile "\Google Drive\secure"
                ;   , "as"   : A_ScriptDir "\assets"
                  , "g"    : "C:\Users\bings\Google Drive\secure\Bing\Golems"
                  , "j"    : "C:\Users\bings\Google Drive\1-Jobs"
                  , "dag"  : UProfile "\DS\DAG_course"
                  , "tax"  : "C:\Users\bings\Google Drive\Taxes"
                  , "m"    : "C:\Users\bings\Google Drive\1-Jobs\2_Monzo"
                  , "t10"  : "C:\Users\bings\Google Drive\Taxes\2010" }

 return ;_______________________________________________________________________ 

; COMMAND & FUNCTION BOXES _____________________________________________________
  #IfWinActive
  
  /* FunctionBox("function" , input_dict): opens GUI menu where each option calls the same function with different parameters
     - function: name of function or function object used to process key value pairs from the input dictionary
     - input dictionary: associative array where each key-value pair corresponds to an user input key and function parameter 
  */
               
  e~win:                                                                        ;[CB] opens edit file jumplist
  +!sc033:: FunctionBox("EditFile", File_dict, C.lgreen)                        ;[CB] opens edit file jumplist
  
  ef~win:                                                                       ;[CB] opens open folder jumplist
  ^!sc033:: FunctionBox("OpenFolder", Folder_dict, C.lblue)                     ;[CB] opens open folder jumplist
                               
  !sc033::  FunctionBox("MoveWin", MoveWin_DICT,C.bwhite,,MoveWin_DICT,0)
          
  printscreen & enter::                                                         ;[CB] opens CB with "~win" suffix priority 
  +#enter::                                                                     ;[CB] opens CB with "~win" suffix priority
  +#space::                                                                     ;[CB] opens CB with "~win" suffix priority
  #space::                                                                      ;[CB] opens CB with "~win" suffix priority
  #enter:: CB("~win")                                                           ;[CB] opens CB with "~win" suffix priority
  ; ~*$#enter:: CB("~win")                                                      ;[CB] opens CB with "~win" suffix priority
  
  printscreen & space::
  $#sc034:: CB(">", onyx, white)                                                ;[CB] opens CB with ">" suffix priority
 
 ; GUI keyboard shortcuts ;-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

  #IF WinActive("ahk_id " ghwnd) or TitleTest("(-_-)")                          ; https://www.autohotkey.com/boards/viewtopic.php?t=520
    
    $!q::  MoveWin("TL")  
    $!e::  MoveWin("TR")  
    $!z::  MoveWin("BL")  
    
    ; $!x::  MoveWin("F")  
    $!x::  ToggleDisplay()

    !c::  MoveWin("BR")  
    !w::  MoveWin("T")
    !s::  MoveWin("B")
    #left::
    !a::  MoveWin("L")  
    #right::
    !d::  MoveWin("R")  
    +!a:: MoveWin("LS")  
    +!d:: MoveWin("RS")  
    +!w:: MoveWin("TS")
    +!s:: MoveWin("BS")
    +!q:: MoveWin("L1") 
    +!e:: MoveWin("R1")
    +!z:: MoveWin("L4")
    +!c:: MoveWin("R4")

    printscreen & q::  ActivateWin("ahk_id " TgtWinID) , MoveWin("TL")
    printscreen & e::  ActivateWin("ahk_id " TgtWinID) , MoveWin("TR")
    printscreen & z::  ActivateWin("ahk_id " TgtWinID) , MoveWin("BL")
    printscreen & x::  ActivateWin("ahk_id " TgtWinID) , MoveWin("F") 
    printscreen & c::  ActivateWin("ahk_id " TgtWinID) , MoveWin("BR")
    printscreen & w::  ActivateWin("ahk_id " TgtWinID) , MoveWin("T") 
    printscreen & s::  ActivateWin("ahk_id " TgtWinID) , MoveWin("B") 
    printscreen & a::  ActivateWin("ahk_id " TgtWinID) , MoveWin("L") 
    printscreen & d::  ActivateWin("ahk_id " TgtWinID) , MoveWin("R") 
    
    $<^space::                                                                  ; move focus to input box of any open Command Box
    $>^space:: GUIFocusInput()                                                  ; move focus to input box of any open Command Box
    
    #space::                                                                    ; submit GUI input 
    printscreen & space::                                                       ; submit GUI input 
    $>!space::                                                                  ; submit GUI input 
    $<!space:: GUISubmit()                                                      ; submit GUI input 
    
    !r::
    ^r::       GUIRecall()
 
  #If WinExist("ahk_id " ghwnd) and !WinActive("ahk_id " ghwnd)                 ; Brings GUI to front if hidden behind other windows
  
  #sc034:: 
  +#enter:: 
  #enter:: 
  #space:: 
  +#space::  ;ActivateWin("ahk_id " ghwnd)  
  $<^space::
  $>^space:: ActivateWin("ahk_id " ghwnd), GUIFocusInput()

  #If
 

; SAVE & REACTIVATE WINDOWS BY ID ______________________________________________
 ; hotkey to activate window with match string anywhere in the title

 #IF GetKeyState("alt", "P")

 printscreen & q::       SaveWinID("Q")                                         ;[SAW] (+ Alt) Save window ID for later activation w/ printscreen & q
 printscreen & w::       SaveWinID("W")                                         ;[SAW] (+ Alt) Save window ID for later activation w/ printscreen & q
 printscreen & a::       SaveWinID("A")                                         ;[SAW] (+ Alt) Save window ID for later activation w/ printscreen & a
 printscreen & s::       SaveWinID("S")                                         ;[SAW] (+ Alt) Save window ID for later activation w/ printscreen & s
 printscreen & z::       SaveWinID("Z")                                         ;[SAW] (+ Alt) Save window ID for later activation w/ printscreen & z
 printscreen & x::       SaveWinID("X")                                         ;[SAW] (+ Alt) Save window ID for later activation w/ printscreen & x
 printscreen & lctrl::   SaveWinID("Lctrl")                                     ;[SAW] (+ Alt) Save window ID for later activation 
 printscreen & rctrl::   SaveWinID("Rctrl")                                     ;[SAW] (+ Alt) Save window ID for later activation 
 
 printscreen & ESC::     SaveWinID("ESC")                                       ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F1::      SaveWinID("F1")                                        ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F2::      SaveWinID("F2")                                        ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F3::      SaveWinID("F3")                                        ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F4::      SaveWinID("F4")                                        ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F5::      SaveWinID("F5")                                        ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F6::      SaveWinID("F6")                                        ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F7::      SaveWinID("F7")                                        ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F8::      SaveWinID("F8")                                        ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F9::      SaveWinID("F9")                                        ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F10::     SaveWinID("F10")                                       ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F11::     SaveWinID("F11")                                       ;[SAW] (+ Alt) Save window ID for later activation  
 printscreen & F12::     SaveWinID("F12")                                       ;[SAW] (+ Alt) Save window ID for later activation  
 #IF
           
 printscreen & q::       ActivateWinID("Q")                                     ;[SAW] activate saved Window ID
 printscreen & w::       ActivateWinID("W")                                     ;[SAW] activate saved Window ID
 printscreen & a::       ActivateWinID("A")                                     ;[SAW] activate saved Window ID
 printscreen & s::       ActivateWinID("S")                                     ;[SAW] activate saved Window ID
 printscreen & z::       ActivateWinID("Z")                                     ;[SAW] activate saved Window ID
 printscreen & x::       ActivateWinID("X")                                     ;[SAW] activate saved Window ID
 
 printscreen & lctrl::                                                          ;[SAW] activate saved Window ID
 printscreen & ralt::    ActivateWinID("Lctrl")                                 ;[SAW] activate saved Window ID
 lwin & rctrl::                                                                 ;[SAW] activate saved Window ID
 printscreen & rctrl::   ActivateWinID("Rctrl")                                 ;[SAW] activate saved Window ID
 
 printscreen & ESC::     ActivateWinID("ESC")                                   ;[SAW] activate saved Window ID
 printscreen & F1::      ActivateWinID("F1")                                    ;[SAW] activate saved Window ID
 printscreen & F2::      ActivateWinID("F2")                                    ;[SAW] activate saved Window ID
 printscreen & F3::      ActivateWinID("F3")                                    ;[SAW] activate saved Window ID
 printscreen & F4::      ActivateWinID("F4")                                    ;[SAW] activate saved Window ID
 printscreen & F5::      ActivateWinID("F5")                                    ;[SAW] activate saved Window ID
 printscreen & F6::      ActivateWinID("F6")                                    ;[SAW] activate saved Window ID
 printscreen & F7::      ActivateWinID("F7")                                    ;[SAW] activate saved Window ID
 printscreen & F8::      ActivateWinID("F8")                                    ;[SAW] activate saved Window ID
 printscreen & F9::      ActivateWinID("F9")                                    ;[SAW] activate saved Window ID
 printscreen & F10::     ActivateWinID("F10")                                   ;[SAW] activate saved Window ID
 printscreen & F11::     ActivateWinID("F11")                                   ;[SAW] activate saved Window ID
 printscreen & F12::     ActivateWinID("F12")                                   ;[SAW] activate saved Window ID

; OPEN FILE/FOLDER HOTKEYS _____________________________________________________
 ; edit file from anywhere in windows; if already open but not active, hotkey will activate file window
 ; recognizes pdf, html, ppt,doc,xls and related file extensions. If all other apps fail, will open with default editor.

 ^#g::              EditFile("golems\test.ahk")                                 ;<EF> test.ahk
 printscreen & g::  EditFile("golems\win_goto.ahk")                             ;<EF> win_goto.ahk
 printscreen & f::  EditFile("golems\_functions.ahk")                           ;<EF> _functions.ahk
 printscreen & t::  EditFile("golems\win_text_navigation.ahk")                  ;<EF> win_text_navigation.ahk
 printscreen & r::  EditFile("golems\win_sys.ahk")                              ;<EF> win_sys.ahk

 :X:ec~win::        OpenFolder("mem_cache\")
 
; CHANGE FOLDER IN FILELISTERS _________________________________________________
 SetTitleMatchMode, 2
 #IfWinActive ahk_group FileListers                                             ;    ChangeFolders works in file explorer and open file + save as dialogue boxes

 >+sc029::  ChangeFolder(A_ScriptDir)                                           ;<F> AHK folder
 >+1::      ChangeFolder(A_ScriptDir "\golems\")                                ;<F> AHK golems folder
 >+2::      ChangeFolder(A_ScriptDir "\lib\")                                   ;<F> AHK libs folder
 >+m::      ChangeFolder(A_ScriptDir "\mem_cache\")                             ;<F> mem_cache
 >+a::      ChangeFolder(A_ScriptDir "\assets\")                                ;<F> mem_cache
 >+c::      ChangeFolder(hdrive)                                                ;<F> %Homedrive% (C:)
 >+o::      ChangeFolder(A_ProgramFiles)                                        ;<F> C:\Program Files
 >+!o::     ChangeFolder(PF_x86)                                                ;<F> C:\Program Files(x86)
 >+u::      ChangeFolder(UProfile)                                              ;<F> %UserProfile%
 >+p::      ChangeFolder(UProfile "\Pictures\")                                 ;<F> Pictures
 >+g::      ChangeFolder(UProfile "\Google Drive")                              ;<F> google drive
 >+j::      ChangeFolder(UProfile "\Downloads")                                 ;<F> Downloads
 >+d::      ChangeFolder(UProfile "\Documents")                                 ;<F> Documents
 >+r::      ChangeFolder("`:`:{645FF040-5081-101B-9F08-00AA002F954E}")          ;<F> Recycle bin (doesn't work for save as diag)
 >+t::      ChangeFolder("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}")          ;<F> This PC / My Computer
                                                                                ;    https://www.autohotkey.com/docs/misc/CLSID-List.htm
; ACTIVATE APP SHORCUTS ________________________________________________________
  ;shorcuts to launch/reactivate applications with the same key                  
  #IfWinActive
 
  printscreen & n::
  #n::       ActivateApp("editor_path")                                         ;<A> VS Code
  #r::       ActivateApp(UProfile "\AppData\Local\Obsidian\Obsidian.exe")       ;<A> Obsidian
 
  +Pgdn::
  #s::       ActivateApp("html_path")                                           ;<A> Chrome
  +#q::      ActivateApp("ppt_path")                                            ;<A> Powerpoint
  #q::       ActivateApp("xls_path")                                            ;<A> Excel
  #w::       ActivateApp("doc_path")                                            ;<A> Word
  #t::       ActivateApp("cmd.exe")                                             ;<A> Command Window
  printscreen & b::
  #b::       ActivateApp("explorer.exe", "buffer_path", True)                   ;<A> File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
  ^#!m::     ActivateMail()                                                     ;<A> Mail
  +#c::      ActivateCalc()                                                     ;<A> Calculator
  :X:es~win:: ActivateApp(UProfile "\Downloads\Programs\Everything\Everything.exe")
  +#m::      ActivateApp("C:\Users\bings\Downloads\Programs\KeePassXC-2.6.6-Win64\KeePassXC.exe")
  :x:a~win:: ActivateApp(A_ProgramFiles "\Anki\anki.exe")                       ;<A> Anki
  
  #a::       ActivateApp("pdf_path")                                            ;<A> pdf-xchange
  +#a::      ActivateApp(PF_x86 """\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe""")  ;<A> adobe