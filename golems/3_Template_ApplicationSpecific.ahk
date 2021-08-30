#IF

  ; Context Specific shortcut template: The shortcuts below are valid only if the 
  ; WinActive condition is met.

  /*  SAMPLE CODE: (mode switch) create interface layer active only if there's a Command Box open, but not active 
      #If WinActive("ahk_exe " exe["editor"]) and WinExist("ahk_id " CB_hwnd) and !WinActive("ahk_id " CB_hwnd)
      #If WinActive("ahk_exe " exe["editor"]) and WinExist("ahk_id " CB_hwnd) and !WinActive("ahk_id " CB_hwnd) and (GC("CB_sfx") == "~markdown")
  */


#If WinActive("ahk_exe " exe["html"])                                           

    /*  SAMPLE CODE
       #space::     CB("~html", C.pink)                                         ;html: opens command box that runs ~html suffix CB keys
       :X:gm~html::  LoadURL("mail.google.com")                                 ;html: create a command key "m" that opens gmail, if entered in a "~html" Command Box
    */

#If WinActive("ahk_exe " exe["editor"])     

    /*  SAMPLE CODE
        #space::  CB("~editor", C.lgreen)                                       ;editor: create command box that runs ~editor suffix CB keys
        ^!sc01a:: Send % (toggle := !toggle) ? "^k^9" : "^k^8"                  ;editor: fold/unfold all regions toggle
        printscreen & tab::      AddSpaceBeforeComment(wdt)                     ;[FC] Add Space Before Comment (default)
        printscreen & capslock:: AddSpaceBeforeComment(wdt), s("down")          ;[FC] Add Space Before Comment and move down 1 line (default)

    */

#If WinActive("ahk_exe " exe["doc"])


    /*  SAMPLE CODE
        #space::   CB("~doc", C.rblue, C.lblue)                                 ;doc: opens command box that runs ~doc suffix CB keys
    */
    
#If WinActive("ahk_exe " exe["xls"])

    /*  SAMPLE CODE
        #space::   CB("~xls", C.bgreen, C.lgreen)                               ;xls: opens command box that runs ~xls suffix CB keys
    */    

#If WinActive("ahk_exe " exe["ppt"])
    
    /*  SAMPLE CODE
        #space::  CB("~ppt", C.lorange)                                         ;ppt: opens command box that runs ~ppt suffix CB keys
    */

#If WinActive("ahk_exe " exe["pdf"])

    /*  SAMPLE CODE
        #space::  CB("~pdf", C.lpurple)                                         ;pdf: opens command box that runs ~pdf suffix CB keys
    */
#IF
