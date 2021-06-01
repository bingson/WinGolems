
Goto_AutoExecution:
 
 ; options for edit file jump list
 File_Dict := { "f"  : "golem\_functions.ahk"
              , "wg" : "WinGolems.ahk"
              , "i"  : """" config_path """"
              , "t"  : "golems\test.ahk"
              , "p"  : "golems\Python.ahk"
              , "r"  : "golems\R.ahk"
              , "t"  : "golems\win_text_navigation.ahk"
              , "g"  : "golems\win_goto.ahk"
              , "w"  : "golems\win_sys.ahk"
              , "ms" : "golems\win_mem_system.ahk"
              , "mf" : "golems\win_mouse_functions.ahk"
              , "h"  : "golems\Hotkey_Help.ahk" }
 
 ; options for open folder jump list
 Folder_Dict := { "m"   : A_ScriptDir
                , "g"   : A_ScriptDir "\golems"
                , "c"   : hdrive
                , "p"   : A_ProgramFiles
                , "o"   : PF_x86
                , "u"   : UProfile
                , "pic" : UProfile "\Pictures"
                , "d"   : UProfile "\Google Drive"
                , "j"   : UProfile "\Downloads"
                , "md"  : UProfile "\Documents"
                , "mem" : A_ScriptDir "\mem_cache"
                , "a"   : A_ScriptDir "\assets"
                , "b"   : "buffer_path" }

 ActivateExplorer := Func("ActivateApp").Bind("explorer.exe")                   ; create bound function to 

return 

; TITLE MATCH __________________________________________________________________
 ; hotkey to activate window with match string anywhere in the title
 
 SetTitleMatchMode, 2
 
 <^space::                                                                      ;<TM> activate udemy window, 
    ReleaseModifiers()                                                          ;     note: VLC windows can't distinguish between lctrl vs rctrl
    ActivateWindow("Udemy")                                                               
    return

 >^space::                                                                      ;<TM> Jupyter window
    ReleaseModifiers()                                                          ;     window search will stop after the first successful activation
    ActivateWindow("Home Page - Select or create a notebook - Google Chrome")      
    ActivateWindow("1_DAG")
    ActivateWindow("Jupyter Notebook")
    return


 #y:: ActivateWindow("VLC media player")                                        ;<TM> VLC

; EDIT FILE ____________________________________________________________________
 ; edit file from anywhere in windows; if already open but not active, hotkey will activate file window

 :*:>d::                                                                        ;<EF> opens edit file jump list
 #sc034:: RunInputCommand("EditFile", File_Dict, "EDIT FILE")                   ;<EF> opens edit file jump list


 ^#g::              EditFile("golems\test.ahk")                                 ;<EF> test.ahk
 PrintScreen & g::  EditFile("golems\win_goto.ahk")                             ;<EF> win_goto.ahk
 PrintScreen & t::  EditFile("golems\win_text_navigation.ahk")                  ;<EF> win_text_navigation.ahk
 PrintScreen & w::  EditFile("golems\win_sys.ahk")                              ;<EF> win_sys.ahk
 PrintScreen & f::  EditFile("golems\_functions.ahk")                           ;<EF> _functions.ahk


 
; GOTO FOLDER ________________________________________________________________
 
 :*:>f::                                                                        ;<F> opens goto folder jump list from anywhere in windows
 #sc033:: RunInputCommand(ActivateExplorer, Folder_Dict, "OPEN FOLDER")         ;<F> opens goto folder jump list from anywhere in windows

 #m::                                                                           ;<F> open mem_cache folder from anywhere in windows (new explorer instance)
 printscreen & m:: ActivateApp("explorer.exe", A_ScriptDir "\mem_cache")        ;<F> open mem_cache folder from anywhere in windows (new explorer instance)
 
 
 
 SetTitleMatchMode, 2
 #IfWinActive ahk_group FileListers                                             
 ; ChangeFolders works in file explorer and open file + save as dialogue boxes
                
 >+sc029::  ChangeFolder(A_ScriptDir)                                           ;<F> AHK folder
 :*:golems>::                                                                   ;<F> AHK golems folder
 >+1::      ChangeFolder(A_ScriptDir "\golems\")                                ;<F> AHK golems folder
 >+2::      ChangeFolder(A_ScriptDir "\lib\")                                   ;<F> AHK libs folder    
 >+m::      ChangeFolder(A_ScriptDir "\mem_cache\")                             ;<F> mem_cache
 >+c::      ChangeFolder(hdrive)                                                ;<F> %Homedrive% (C:)
 >+o::      ChangeFolder(A_ProgramFiles)                                        ;<F> C:\Program Files
 >!o::      ChangeFolder(PF_x86)                                                ;<F> C:\Program Files(x86)
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
 ;shorcuts to launch/reactivate applications with the same key
 
 PrintScreen & n::                                                              ;<A> VS Code 
 #n::       ActivateApp("editor_path")                                          ;<A> VS Code
 #s::       ActivateApp("html_path")                                            ;<A> Chrome
 #w::       ActivateApp("doc_path")                                             ;<A> Word
 #a::       ActivateApp("xls_path")                                             ;<A> Excel
 #q::       ActivateApp("ppt_path")                                             ;<A> Powerpoint
 #r::       ActivateApp("pdf_path")                                             ;<A> pdf-xchange
 #t::       ActivateApp("cmd.exe")                                              ;<A> Command Window
 PrintScreen & b::                                                              ;<A> File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
 #b::       ActivateApp("explorer.exe", "buffer_path", True)                    ;<A> File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
 ^#!m::     ActivateMail()                                                      ;<A> Mail
 +#c::      ActivateCalc()                                                      ;<A> Calculator
 