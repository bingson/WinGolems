
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

 /*
 */

; SEARCH _______________________________________________________________________

 PrintScreen & SC035::                                                          ;[S] search Google for selected text
 #SC035::  Run % "http://www.google.com/search?q=" . clip()                     ;[S] search Google for selected text
 ^#SC035::  Run % "https://www.google.com/search?tbm=isch&q=" . clip()          ;[S] search Google images for selected text
 !#SC035:: Run % "http://en.wikipedia.org/w/index.php?search=" . clip()         ;[S] search Wikipedia for selected text  
 ; #F11::  Run % "http://www.investopedia.com/search/default.aspx?q=" . clip()  

; EDIT FILE ____________________________________________________________________
 ; edit file from anywhere in windows

 ^#g::                                                                          ;<EF> test.ahk
 :*:t~~::                                                                       ;<EF> test.ahk 
 EditFile("lab\test.ahk")
 return
 
 PrintScreen & g::                                                              ;<EF> windows_goto.ahk
 Home & g::                                                                     ;<EF> windows_goto.ahk
 :*:g~~::                                                                       ;<EF> windows_goto.ahk
 EditFile("golems\windows_goto.ahk")
 return
 
 PrintScreen & t::                                                              ;<EF> windows_text_navigation.ahk
 Home & t::                                                                     ;<EF> windows_text_navigation.ahk
 :*:wt~~::                                                                      ;<EF> windows_text_navigation.ahk
 EditFile("golems\windows_text_navigation.ahk")
 return
 
 PrintScreen & w::                                                              ;<EF> windows_sys.ahk
 Home & w::                                                                     ;<EF> windows_sys.ahk
 :*:w~~::                                                                       ;<EF> windows_sys.ahk
 EditFile("golems\windows_sys.ahk")                                    
 return

 PrintScreen & f::                                                              ;<EF> _functions.ahk
 Home & f::                                                                     ;<EF> _functions.ahk
 :*:f~~::                                                                       ;<EF> _functions.ahk
 EditFile("golems\_functions.ahk")
 return
 
 PrintScreen & v::                                                              ;<EF> VS_code.ahk
 Home & v::                                                                     ;<EF> VS_code.ahk
 :*:v~~::                                                                       ;<EF> VS_code.ahk
 EditFile("golems\VS_code.ahk")
 return
 
 Home & m::                                                                     ;<EF> MASTER.ahk
 :*:m~~::                                                                       ;<EF> MASTER.ahk
 EditFile("MASTER.ahk")
 return
 
 Home & p::                                                                     ;<EF> Python.ahk
 :*:p~~::                                                                       ;<EF> Python.ahk
 EditFile("golems\Python.ahk")
 return
 
 Home & r::                                                                     ;<EF> R.ahk
 :*:r~~::                                                                       ;<EF> R.ahk
 EditFile("golems\R.ahk")      
 return
 
 :*:hh~~::                                                                      ;<EF> Hotkey_Help.ahk
 EditFile("golems\Hotkey_Help.ahk")
 return
 
 :*:ini~~::                                                                     ;<EF> config.ini
 EditFile("""" config_path """")
 return
 
 :*:gi~~::                                                                      ;<EF> .gitignore 
 EditFile(".gitignore")
 return
 
; CHANGE FOLDER ________________________________________________________________
 ; change folders in file explorer and save as dialogue boxes

 SetTitleMatchMode, 2
 #IfWinActive ahk_group FileListers
 
 >+sc029::  ChangeFolder(A_ScriptDir)                                           ;<F> AHK folder
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

 printscreen & m:: ActivateApp("explorer.exe",A_ScriptDir "\mem_cache\",True)   ;<F> open mem_cache folder from anywhere in windows (new explorer instance)



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
 #b::       ActivateApp("explorer.exe", "buffer_path")                          ;<A> File explorer open at buffer_path defined in config.ini (defaults to My Documents if none found)
 ^#!m::     ActivateMail()                                                      ;<A> Mail
 +#c::      ActivateCalc()                                                      ;<A> Calculator
 