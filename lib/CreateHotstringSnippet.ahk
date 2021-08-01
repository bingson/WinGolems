
 CreateHotstringSnippet(tgt = "win_sys", suffix ="", width = "80") {
    /*
      CreateHotstringSnippet() will create a .txt copy of selected text
      in the mem_cache folder that can be retrieved through dynamically created
      hotstring (i.e., hotstring can be used immediately after creation).
   
      — Python and R hotstring snippets are kept in separate directories. So the same
         hotstring name can be applied to corresponding layers of abstraction.
         For example, "PlotScatter" can be used in both python and R to output
         language/api specific syntax for the same idea.
   
      — To see an index of hotstrings created through CreateHotstringSnippet() open
         mem_cache/hotstring_creation_log.csv
   
      — FORMAT:
   
         1) First line of text will be transformed into the hotstring trigger string
            with a ">" character appended to the end.
         2) Second line will be transformed into a comment in the target .ahk file
         3) Third line should be the target text to store
   
      — EXAMPLE:
   
         hotstring_label
         comment/description of hotstring for hotkey_help.ahk indexing>
         text to store
   
       select above 3 lines and press insert & w to create a hotstring.
       Afterwards, typing "hotstring_label>" will output "text to store"
    */
     global long, bgreen, lgreen, red, pink
     suffix      := (!suffix) ? "~"tgt : suffix
     dest        := !(tgt = "win_sys") ? tgt "\" : ""
     dest_folder := A_ScriptDir "\mem_cache\" dest
     dest_file   := A_ScriptDir "\golems\" tgt ".ahk"
     
     input := trim(clip(), "`r`n`t")
     key := trim(SubStr(input,1,InStr(input,"`r")-1)) 
     if !key
         return
     desc := trim(SubStr(input,InStr(input,"`r") + 2
             , InStr(input,"`r",,,2) - StrLen(key) - 2))
     body := trim(SubStr(input,InStr(input,"`r",,,2)+2))
     
     if !InStr(FileExist(dest_folder), "D") {                                      
         msg := "WinGolems can't find a mem_cache folder for " tgt ".ahk`nWould you like to create one?"
         MsgBox,4100,Create Hotstring,%msg% 
         IfMsgBox Yes
             FileCreateDir, %dest_folder%
         else 
             return
     }
 
     WriteToCache(key, False, dest, body)
     new_hotstring := "`r :*:" key suffix "::"
     num_char      := width - StrLen(new_hotstring) + 1
     string_char   := RepeatString(" ", num_char)
     new_hotstring := new_hotstring string_char ";" desc "`n"                    ; create hotstring instantiation code
                    . " AccessCache(" """" dest key """" ")`n"
                    . " return`n"
 
     head    = %key% `, %suffix% `, %A_YYYY% `, %A_MMM% `, %A_DD% `,
     tail    = %A_Hour% `, %A_Min% `, %tgt% `, %desc% 
     log_txt = %head%%tail%

     FileAppend, %log_txt%, *%A_ScriptDir%\mem_cache\hotstring_creation_log.csv  ; update hotstring creation log
     FileAppend, %new_hotstring%, %dest_file%                                    ; add hotstring code to relevant ahk file ()
     AccessCache(key, dest)
     
     ShowPopup("new hotstring created",C.lgreen, C.bgreen, "300", "75", "-1000", "16", "610")
     sleep, long
     reload
     return
 }
