ReleaseModifiers(timeout := "") {                                              ; timeout in ms
   ; sometimes modifier keys get stuck while switching between programs
   ; this function call can be embedded in a function to fix that.
   static  aModifiers := ["Ctrl", "Alt", "Shift", "LWin", "RWin"
                         , "PrintScreen", "del", "ins", "end", "home"]
   
   startTime := A_Tickcount
   while (isaKeyPhysicallyDown(aModifiers))
   {
       if (timeout && A_Tickcount - startTime >= timeout)
           return 1                                                            ; was taking too long
       sleep, 5
   }
   return
} 