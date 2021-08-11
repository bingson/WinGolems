
; Context Specific shortcut template. The shortcuts below are valid only if the 
; associated application is active or the key is entered in a matching command box.

#If WinActive("ahk_exe " exe["html"])                                           

    /*  SAMPLE CODE
       #space::     CB("~html", C.pink)                                         ;html: opens command box that runs ~html suffix CB keys
       :X:m~html::  LoadURL("mail.google.com")                                  ;html: create a command key "m" that opens gmail, if entered in a "~html" Command Box
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
        :X:r~doc:: RunMSWordMacro("vba_macro_name")                             ;doc: create a command key "r" that runs an word VBA macro, if entered in a "~doc" Command Box
        ^r::       RunMSWordMacro("vba_macro_name")                             ;doc: create keyboard shorcut ctrl + r that runs a word VBA macro
    */
    
    
#If WinActive("ahk_exe " exe["xls"])

    /*  SAMPLE CODE
        #space::   CB("~xls", C.bgreen, C.lgreen)                               ;xls: opens command box that runs ~xls suffix CB keys
        :X:r~xls:: RunExcelMacro("vba_macro_name")                              ;xls: create a command key "r" that runs an excel VBA macro, if entered in a "~xls" Command Box
        ^r::       RunExcelMacro("vba_macro_name")                              ;xls: create keyboard shorcut ctrl + r that runs an excel VBA macro
        !p::       highlight_cell("40")                                         ;xls: change cell background to pink (color index = "40")
        !y::       highlight_cell("36")                                         ;xls: change cell background to yellow
        !g::       highlight_cell("35")                                         ;xls: change cell background to green

    */    

#If WinActive("ahk_exe " exe["ppt"])
    
    /*  SAMPLE CODE
        #space::  CB("~ppt", C.lorange)                                         ;ppt: opens command box that runs ~ppt suffix CB keys
    */

#If WinActive("ahk_exe " exe["pdf"])

    /*  SAMPLE CODE
        #space::  CB("~pdf", C.lpurple)                                         ;pdf: opens command box that runs ~pdf suffix CB keys
    */

#If