#IF

  ; Context Specific shortcut template: The shortcuts below are valid only if the 
  ; WinActive condition is met.

  /*  SAMPLE CODE: (mode switch) create interface layer active only if there's a Command Box open, but not active 
      #If WinActive("ahk_exe " exe["editor"]) and WinExist("ahk_id " CB_hwnd) and !WinActive("ahk_id " CB_hwnd)
      #If WinActive("ahk_exe " exe["editor"]) and WinExist("ahk_id " CB_hwnd) and !WinActive("ahk_id " CB_hwnd) and (GC("CB_sfx") == "~markdown")
  */
  
  /*  SAMPLE CODE: DESKTOP FUNCTIONS 
    >+>!o::                % (t := !t) ? WinToDesktop("2") : WinToDesktop("1")  ;SC: Move Window to other desktop (between desktops 1 and 2)
    >!sc028::                                                                   ;SC: Switch between desktop 1 and 2
    <!sc027::              % (t := !t) ? GotoDesktop("2") : GotoDesktop("1")    ;SC: Switch between desktop 1 and 2



  */

#If WinActive("ahk_exe " exe["html"])                                           
    
    ; The Vimium extension is highly recommended for Firefox, Edge, Vivaldi, Chrome browsers

    /*  SAMPLE CODE
       lwin & space::     CB("~html", C.pink)                                         ;html: opens command box that runs ~html suffix CB keys
       :X:gm~html::  LURL("mail.google.com")                                 ;html: create a command key "m" that opens gmail, if entered in a "~html" Command Box
    */

#If WinActive("ahk_exe " exe["editor"])    

    /*  SAMPLE CODE
        
        lwin & enter::   RunCmd(,"~editor")
        rshift & enter:: RunCmd(,"~win")
        lalt & space::   RunCmd("Veditor\") 
        ralt & space::   RunCmd("V") 
        lwin & space::   CB("~editor", C.lgreen)                                       ;editor: create command box that runs ~editor suffix CB keys
        ^!sc01a:: Send % (toggle := !toggle) ? "^k^9" : "^k^8"                  ;editor: fold/unfold all regions toggle
        printscreen & tab::      AddSpaceBeforeComment(wdt)                     ;[FC] Add Space Before Comment (default)
        printscreen & capslock:: AddSpaceBeforeComment(wdt), s("down")          ;[FC] Add Space Before Comment and move down 1 line (default)
        
        
        #If (WinActive("ahk_exe Code.exe") and TitleTest(".md"))                ; >+b hotkey active if markdown file extension contained in editor window title
        >+b:: Clip(send "**" Clip() "**")                                       ;md: bold text

    */


#If WinActive("ahk_exe " exe["editor"]) and TitleTest(".ahk")
    /*  SAMPLE CODE

        $^s:: SaveReloadAHK()                                                   ;editor: reloads WinGolems.ahk every time you save with ^s                                                         
    */
      
#If WinActive("ahk_exe " exe["doc"])


    /*  SAMPLE CODE
        lwin & space::   CB("~doc", C.rblue, C.lblue)                                 ;doc: opens command box that runs ~doc suffix CB keys
    */
    
#If WinActive("ahk_exe " exe["xls"])

    /*  SAMPLE CODE
        lwin & space::   CB("~xls", C.bgreen, C.lgreen)                               ;xls: opens command box that runs ~xls suffix CB keys
    */    

#If WinActive("ahk_exe " exe["ppt"])
    
    /*  SAMPLE CODE
        lwin & space::  CB("~ppt", C.lorange)                                         ;ppt: opens command box that runs ~ppt suffix CB keys
    */

#If WinActive("ahk_exe " exe["pdf"])

    /*  SAMPLE CODE
        lwin & space::  CB("~pdf", C.lpurple)                                         ;pdf: opens command box that runs ~pdf suffix CB keys

        lalt & Space::
        { 
            send {Blind}
            send ^{tab}
            return
        }
        
        Ralt & b::                                                              ;pdf: 
        !b:: send ^+{tab}
        
        
        
        #If GetKeyState("alt", "P")
        ctrl & space::                  WinMaximize, A 
        #If
    */
#IF
