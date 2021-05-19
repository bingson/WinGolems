
; TITLE MATCH __________________________________________________________________
 ;hotkey to activate window with match string anywhere in the window title
 
 SetTitleMatchMode, 2
 
 <^space::                                                                      ;<TM> activate udemy window, (note: VLC windows can't distinguish between lctrl vs rctrl)
    ReleaseModifiers()
    ActivateWindow("Udemy")                                                    
    return

 >^space::                                                                      ;<TM> jupyter notebook windows (will stop after the first successful activation)
    ReleaseModifiers()
    ActivateWindow("Ho me Page - Select or create a notebook - Google Chrome")      
    ActivateWindow("1_DAG")
    ActivateWindow("Jupyter Notebook")
    return

 #y:: ActivateWindow("VLC media player")                                        ;<TM> VLC
 
 

; EDIT FILE ____________________________________________________________________
 
 ^#g::                                                                          ;<EF> test.ahk
 :*:t~~::                                                                       ;<EF> test.ahk 
 EditFile("test.ahk", "vscode_path")
 return
 
 PrintScreen & g::                                                              ;<EF> windows_goto.ahk
 Home & g::                                                                     ;<EF> windows_goto.ahk
 :*:g~~::                                                                       ;<EF> windows_goto.ahk
 EditFile("golems\windows_goto.ahk", "vscode_path")
 return
 
 PrintScreen & t::                                                              ;<EF> windows_text_navigation.ahk
 Home & t::                                                                     ;<EF> windows_text_navigation.ahk
 :*:wt~~::                                                                      ;<EF> windows_text_navigation.ahk
 EditFile("golems\windows_text_navigation.ahk", "vscode_path")
 return
 
 PrintScreen & w::                                                              ;<EF> windows_sys.ahk
 Home & w::                                                                     ;<EF> windows_sys.ahk
 :*:w~~::                                                                       ;<EF> windows_sys.ahk
 EditFile("golems\windows_sys.ahk", "vscode_path")                                    
 return

 PrintScreen & f::                                                              ;<EF> _functions.ahk
 Home & f::                                                                     ;<EF> _functions.ahk
 :*:f~~::                                                                       ;<EF> _functions.ahk
 EditFile("golems\_functions.ahk", "vscode_path")
 return
 
 Home & v::                                                                     ;<EF> VS_code.ahk
 :*:v~~::                                                                       ;<EF> VS_code.ahk
 EditFile("golems\VS_code.ahk", "vscode_path")
 return
 
 Home & m::                                                                     ;<EF> MASTER.ahk
 :*:m~~::                                                                       ;<EF> MASTER.ahk
 EditFile("MASTER.ahk", "vscode_path")
 return
 
 Home & p::                                                                     ;<EF> Python.ahk
 :*:p~~::                                                                       ;<EF> Python.ahk
 EditFile("golems\Python.ahk", "vscode_path")
 return
 
 Home & r::                                                                     ;<EF> R.ahk
 :*:r~~::                                                                       ;<EF> R.ahk
 EditFile("golems\R.ahk", "vscode_path")      
 return
 
 :*:hh~~::                                                                      ;<EF> Hotkey_Help.ahk
 EditFile("golems\Hotkey_Help.ahk", "vscode_path")
 return
 
 :*:ini~~::                                                                     ;<EF> config.ini
 EditFile("""" config_path """", "vscode_path")
 return
 
 :*:gi~~::                                                                      ;<EF> .gitignore 
 EditFile(".gitignore", "vscode_path")
 return
 
; CHANGE FOLDER ________________________________________________________________

 ; change folders in file explorer and save as dialogue boxes

 SetTitleMatchMode, 2
 ;  #if WinActive("ahk_class #32770") 
 ;  or (WinActive("ahk_exe explorer.exe") and WinActive("ahk_class CabinetWClass")) 

 #IfWinActive ahk_group FileListers
 
 >+sc029::  ChangeFolder(A_ScriptDir)                                           ;<F> AHK folder
 >+1::      ChangeFolder(A_ScriptDir "\golems\")                                ;<F> AHK golems folder
 >+2::      ChangeFolder(A_ScriptDir "\lib\")                                   ;<F> AHK libs folder    
 >+c::      ChangeFolder(hdrive)                                                ;<F> %Homedrive% (C:)
 >+o::      ChangeFolder(A_ProgramFiles)                                        ;<F> C:\Program Files
 >+u::      ChangeFolder(UProfile)                                              ;<F> %UserProfile% 
 >+p::      ChangeFolder(UProfile "\Pictures\")                                 ;<F> Pictures
 >+g::      ChangeFolder(UProfile "\Google Drive")                              ;<F> Pictures
 >+j::      ChangeFolder(UProfile "\Downloads")                                 ;<F> Downloads
 >+d::      ChangeFolder(UProfile "\Documents")                                 ;<F> Documents
 >+r::      ChangeFolder("`:`:{645FF040-5081-101B-9F08-00AA002F954E}")          ;<F> Recycle bin (doesn't work for save as diag)
 >+t::      ChangeFolder("`:`:{20D04FE0-3AEA-1069-A2D8-08002B30309D}")          ;<F> This PC / My Computer
                                                                                ;    https://www.autohotkey.com/docs/misc/CLSID-List.htm
 #IfWinActive

; APPS _________________________________________________________________________

 ;shorcuts to launch/reactivate specific apps with the same key
 PrintScreen & n::                                                              ;<A> VS Code
 #n::                                                                           ;<A> VS Code
 #r::   ActivateApp("ahk_exe Code.exe",             "vscode_path")              ;<A> VS Code
 #s::   ActivateApp("ahk_exe chrome.exe",           "chrome_path")              ;<A> Chrome
 #w::   ActivateApp("ahk_exe winword.exe",          "word_path")                ;<A> Word
 +#q::  ActivateApp("ahk_exe powerpnt.exe",         "ppt_path")                 ;<A> Powerpoint
 #q::   ActivateApp("ahk_exe excel.exe",            "excel_path")               ;<A> Excel
 #t::   ActivateApp("ahk_class ConsoleWindowClass", "cmd.exe")                  ;<A> Command Window
 ^#!m:: ActivateMail()                                                          ;<A> Mail
 +#c::  ActivateCalc()                                                          ;<A> Calculator

 PrintScreen & b::                                                              ;<A> File Explorer
 #b::                                                                           ;<A> File Explorer
    IniRead, b_path, %config_path%, %A_ComputerName%, buffer_path, %A_Space%   ;     retrieve system dependent folder path to load into file explorer
    ActivateApp("ahk_exe explorer.exe ahk_class CabinetWClass"                  ;    if none exists, will default to my documents 
        ,"explorer.exe", b_path)
    return



