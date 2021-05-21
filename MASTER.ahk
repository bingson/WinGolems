; AUTO-EXECUTION SECTION _______________________________________________________
  ; SCRIPT OPTIMIZATION -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
  ; change the below settings if WinGolems isn't running smoothly               https://www.autohotkey.com/boards/viewtopic.php?f=7&t=6413
 
  SetWorkingDir %A_ScriptDir%
  #MaxHotkeysPerInterval 99000000
  SetBatchLines -1
  ListLines Off                                                                 ; ListLines/KeyHistory are used to log keys for debugging
  #KeyHistory 0                                                                 ; higher number for debugging
  #UseHook                                                
  #InstallKeybdHook                                               
  ; #InstallMouseHook                                             
  #Singleinstance Force                                                         ; only one instance of this script can be active
  Process, Priority, , A                                                         
  SetKeyDelay, 10, 10                                             
  SetMouseDelay, 20                                                             ; mouse click commands become less reliable at lower settings
  SetDefaultMouseSpeed, 0                                                    
  SetWinDelay, 10                                                               
  SetControlDelay, 20                                                            
  SendMode Event                                                                ; faster input
  ; SetTimer, Restart, 60000                                                      ; reloads the script once every minute; necessary if multiple ahk scripts running at once, optional otherwise
                                                                                ; are loaded in the system tray simultaneously instead of included into 1 script
  ; INITIALIZE GLOBAL VARIABLES  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

  #NoEnv                                                                        ; prevents empty variables from being looked up as potential environment variables
  EnvGet, hdrive, Homedrive                                                     ; see a list of available Environment variables at the command prompt by typing SET
  EnvGet, hpath, Homepath
  EnvGet, UProfile, UserProfile
  EnvGet, PF_x86, ProgramFiles(x86)
  
  short            := 100                                                       ; set sleep time in milliseconds between actions for specific functions
  med              := 300                                                       
  long             := 900                                                       
 
  gosub, WinTextNav_Autoexecution
  GroupAdd, FileListers, ahk_class CabinetWClass                                ; create reference group for file explorer and save as dialogue boxes
  GroupAdd, FileListers, ahk_class WorkerW
  GroupAdd, FileListers, ahk_class #32770, ShellView
  
  RegWrite, REG_DWORD, HKEY_CURRENT_USER                                        ; disables windows lockscreen key hook
     , Software\Microsoft\Windows\CurrentVersion\Policies\System                ; frees WIN+L key combo for ahk usage.
     , DisableLockWorkstation, 1
  
  ; config_path := A_ScriptDir "\config.ini"
  config_path      := UProfile "\Google Drive\secure\config.ini"
  icon_path   := A_ScriptDir "\assets\Aikawns\W\"                               ; A_ScriptDir = active AHK script directory

  path := RetrieveINI(A_ComputerName, "vscode_path") 
  if (!FileExist(config_path) or path = "ERROR")
     CreateConfigINI()
     
  ; ChangeTrayIcon(icon_path)                                                   ; changes icon color every time script reloads
  set_tray_icon(icon_path "red.ico")                                           ; set static icon color, black, blue, dg (dark green), gold, grey, lg (light green), orange, pink, red, violet


  
; LOAD AHK SCRIPTS _____________________________________________________________

 #Include %A_ScriptDir%           
 #Include golems\_functions.ahk   
 #Include *i golems\windows_sys.ahk
 #Include *i golems\windows_text_navigation.ahk
 #Include *i golems\windows_goto.ahk
 #Include *i golems\VS_code.ahk                                                 ; *i => ignore if script doesn't exist
 #Include *i golems\Python.ahk                                                  
 #Include *i golems\R.ahk                            
 #Include *i ..\AHK\golems\chrome.ahk        
 #Include *i ..\AHK\golems\office.ahk        
 #Include *i ..\Google Drive\secure\bing.ahk
 #Include *i ..\Google Drive\secure\mm.ahk                              
 
/* #INCLUDE MECHANICS **********************************************************

     Start.ahk:
         #include Return.ahk
         MsgBox, this message will not be shown
     
     Return.ahk: 
         Return <- After the return line no more code will execute unless it's 
                   started by a hotkey, gui action, timer, etc. Encountering 
                   a "Return" will end the auto-execute section of any script
 
 
 You can think of #Include as "pasting" the included script's contents at the 
 line where you wrote #Include. If the included script only contains functions 
 or commands that don't end the auto-execute section you're fine. If it contains 
 a hotkey or return or the like, it will stop execution at that point and AHK 
 will never reach the code in your main script. From that point on variables 
 must be instantiated in functions

*******************************************************************************/
