; SCRIPT OPTIMIZATION SETTINGS (start of auto-execution section) _______________
  ; Info: https://www.autohotkey.com/boards/viewtopic.php?f=7&t=6413
 
  SetWorkingDir %A_ScriptDir%
  #MaxHotkeysPerInterval 99000000
  SetBatchLines -1
  ListLines Off                                                                 ; ListLines/KeyHistory are used to log keys for debugging
  #KeyHistory                                                                   ; higher number for debugging
  #UseHook                                                
  #InstallKeybdHook                                                             ; The keyboard hook monitors keystrokes for the purpose of activating hotstrings and any keyboard hotkeys
  ; #InstallMouseHook                                                           ; The mouse hook monitors mouse clicks for the purpose of activating mouse hotkeys and facilitating hotstrings.
  #Singleinstance Force                                                         ; only one instance of this script can be active
  Process, Priority, , A                                                         
  SetKeyDelay, 10, 10                                             
  SetMouseDelay, 20                                                             ; mouse click commands become less reliable at lower settings
  SetDefaultMouseSpeed, 0                                                    
  SetWinDelay, 10                                                               
  SetControlDelay, 20                                                            
  SendMode Event                                                                
  ; SetTimer, Reload, 60000                                                     ; reloads the script once every minute; makes the script reliable when running multiple ahk scripts on older hardware
                                                                                ; or when multiple scripts (not recommended) are loaded in the system tray simultaneously instead of included into 1 script 
; INITIALIZE GLOBAL VARIABLES __________________________________________________

  #NoEnv                                                                        ; prevents empty variables from being looked up as potential environment variables
  EnvGet, hdrive, Homedrive                                                     ; see a list of available Environment variables at the command prompt by typing SET
  EnvGet, hpath, Homepath
  EnvGet, UProfile, UserProfile
  EnvGet, PF_x86, ProgramFiles(x86)
  
  short            := 100                                                       ; set sleep time in milliseconds between actions for specific functions
  med              := 300                                                       
  long             := 900                                                       
 
  gosub, WinTextNav_Autoexecution
  gosub, Test_AutoExecution
  gosub, JumpList_AutoExecution

  GroupAdd, FileListers, ahk_class CabinetWClass                                ; create reference group for file explorer and save as dialogue boxes
  GroupAdd, FileListers, ahk_class WorkerW
  GroupAdd, FileListers, ahk_class #32770, ShellView
  
  config_path := A_ScriptDir "\config.ini"
  icon_path   := A_ScriptDir "\assets\Aikawns\W\"                               ; A_ScriptDir = active AHK script directory
  set_tray_icon(icon_path "lg.ico")                                             ; set static icon color, black, blue, dg (dark green), gold, grey, lg (light green), orange, pink, red, violet
  
  ; uncomment to disable WIN+L key for locking screen upon WinGolems startup    ; requires registry write premission, end & L hotkey toggles this as well
  ; WinLLock(False, True)                                                       ; False = disables windows lockscreen key hook; frees WIN+L key combo for ahk usage.
                                                                                ; True = enables windows lockscreen key hook (WIN+L); Second True disables pop up window confirmation 
; FIRST TIME SETUP (only executed if no config.ini detected)____________________

  path := RetrieveINI(A_ComputerName, "editor_path") 
  if (!FileExist(config_path) or path = "ERROR") {

    ; please confirm/modify the below application defaults WinGolems will associate with 
    ; particular files types or system functions 
    apps := [ "winword.exe"           ; docm,doc,docx,dotx,dotm -> Word           
            , "excel.exe"             ; xlsx,xlsm,xltx,xltm     -> Excel                                  
	          , "powerpnt.exe"          ; ppt,pptx,pptm           -> PowerPoint     
	          , "AcroRd32.exe"          ; pdf                     -> adobe acrobat                         
	          , "chrome.exe"            ; html, urls, ipynb       -> chrome                                   
	          , "googledrivesync.exe"]  ; cloud backup            -> google cloud                     
     
    CreateConfigINI(apps*)
  }

; LOAD AHK SCRIPTS (end of auto-execution section)______________________________
 #Include %A_ScriptDir%\golems                                                  ; folder reference changes subsequent includes to look from that location
 #Include _functions.ahk   
 #Include *i win_text_navigation.ahk            
 #Include *i win_sys.ahk   
 #Include *i win_goto.ahk   
 #Include *i win_mem_system.ahk   
 #Include *i R.ahk                               
 #Include *i Python.ahk                          
 #Include *i test.ahk   
     
 #Include *i ..\Google Drive\secure\bing.ahk
 #Include *i ..\Google Drive\secure\mm.ahk                     
 

/* #INCLUDE MECHANICS ********************************************************** 
 Start.ahk:
     #include Return.ahk
     MsgBox, this message will not be shown
 
 Return.ahk: 
     Return <- After the return line no more code will execute unless it's 
               started by a hotkey, gui action, timer, etc. Encountering 
               a "Return" will end the auto-execute section of any script.
               
               Note: Encountering a return from a Gosub block where only variables are 
               initialized will not end the autoexecute, providing a way of declaring 
               variables in other ahk files with multiple gosubs to variable 
               intialization blocks.  

 You can think of #Include as "pasting" the included script's contents at the 
 line where you wrote #Include. 
 
 If the included script only contains functions or commands that don't end the 
 auto-execute section you're fine. If it contains a hotkey or return or the like, 
 it will stop execution at that point and AHK will never reach the code in your 
 main script. From that point on variables must be instantiated in functions

*******************************************************************************/
