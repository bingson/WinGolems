SetTitleMatchMode, 3
#If (WinActive("ahk_exe Code.exe"))
 
 ^!sc035::            Send % (toggle := !toggle) ? "^k^0" : "^k^j"              ;[base] fold/unfold all code toggle

 +!0::                                                                          ;[base] fold code to level 0
 +!1::                                                                          ;[base] fold code to level 1
 +!2::                                                                          ;[base] fold code to level 2
 +!3::                                                                          ;[base] fold code to level 3
 +!4::                                                                          ;[base] fold code to level 4
   foldCodeLvl() {
      send ^k
      send {ctrl down}
      send % substr(A_ThisHotkey, 0)                                              
      send {ctrl up}
      return
   }


#If (WinActive("ahk_exe Code.exe") and TabCondition(".py"))
 $+^!8::          Clip("""""""" Clip() """""""")                                ;[py] surround selected text with block comment braces

#If (WinActive("ahk_exe Code.exe") and TabCondition(".ahk"))
 $+^!8::          Clip("/*" Clip() "*/")                                        ;[ahk] surround selected text with block comment braces
 
#If (WinActive("ahk_exe Code.exe") and TabCondition(".md"))
 F21 & f::        clip("<a href=""" clip() """>" clip() "</a>")                 ;[md] insert hyperlink
 >+b::            clip("<b>" clip() "</b>")                                     ;[md] bold text

#IfWinActive
