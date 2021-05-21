SetTitleMatchMode, 3
#If (WinActive("ahk_exe Code.exe"))
 
 !o::                 send !0                                                   ;[base] open last editor in group
 +!Right::            send ^!{sc028}                                            ;[base] move to group 1
 +!Left::             send +!1                                                  ;[base] move to group 2
 ^m::                 send ^m                                                   ;[base] toggle tab moves focus
 +^!o::               send +^u                                                  ;[base] toggle output window
 !d::                 send +^k                                                  ;[base] delete line
 ^!d::                send +!{down}                                             ;[base] duplicate line
 +^d::                send +^l                                                  ;[base] Select all occurrences of current selection
 ^!sc01a::            Send % (toggle := !toggle) ? "^k^9" : "^k^8"              ;[base] fold/unfold all regions toggle
 del & f::            Send +^h                                                  ;[base] search/replace all files in directory
 +^!f::               Send +^h                                                  ;[base] search/replace all files in directory
 ^!sc035::            Send % (toggle := !toggle) ? "^k^0" : "^k^j"              ;[base] fold/unfold all code toggle
 ^q::                 Send ^{sc035}                                             ;[base] toggle comment
 ^sc035::             send +^{[}                                                ;[base] fold current code level
 !sc035::             send +^{]}                                                ;[base] unfold current code level
 +^sc035::            send ^k^[                                                 ;[base] fold recursively 
 +!sc035::            send ^k^]                                                 ;[base] unfold recursively
 >+^enter::           send ^kz                                                  ;[base] zen mode
 !p::                 send ^w                                                   ;[base] close tab
 !g::                 send +!{Right}                                            ;[base] select all text in between brackets
 del & k::            send +^!p                                                 ;[base] clear all bookmarks            
 del & g::                                                                      ;[base] source control
    ReleaseModifiers()
    send +^g
    return

 +!0::                                                                          ;[base] fold code to level 0
 +!1::                                                                          ;[base] fold code to level 1
 +!2::                                                                          ;[base] fold code to level 2
 +!3::                                                                          ;[base] fold code to level 3
 +!4::                                                                          ;[base] fold code to level 4
    send ^k
    send {ctrl down}
    send % substr(A_ThisHotkey, 0)                                              
    send {ctrl up}
    return

#If (WinActive("ahk_exe Code.exe") and TabCondition(".notes"))
 ins & sc034::    send #l                                                       ;[notes] add checkbox to current line

#If (WinActive("ahk_exe Code.exe") and TabCondition(".py"))
 $+^!8::          Clip("""""""" Clip() """""""")                                ;[py] surround selected text with block comment braces
 ^enter::         send +^!r                                                     ;[py] run selected code

#If (WinActive("ahk_exe Code.exe") and TabCondition(".ahk"))
 $+^!8::          Clip("/*" Clip() "*/")                                        ;[ahk] surround selected text with block comment braces
 
#If (WinActive("ahk_exe Code.exe") and TabCondition(".md"))
 
 ins & f::        clip("<a href=""" clip() """>" clip() "</a>")                 ;[md] insert hyperlink
 +^b::            clip("<b>" clip() "</b>")                 ;[md] bold text
 ; ^tab::           Send % (toggle := !toggle) ? "^1" : "^2"                      ;[md] toggle editor group 1 and 2
#IfWinActive
