; CONVENIENCE/TEXT MANIPULATION ________________________________________________
  
  !Backspace::       delLine()                                                  ;Convenience: delete current line of text
  ^#Backspace::      ReplaceBackspaceWithSpaces()                               ;Convenience| Delete and replace selected text with blank spaces
  !v::               PasteWithoutBreaks()                                       ;Convenience| replace multiple paragraph breaks w/ 1 break in selected text
  +!v::              PasteWithoutBreaks(True)                                   ;Convenience| replace multiple paragraph breaks with space (remove paragraphs breaks)
  ^#v::              PasteOverwrite()                                           ;Convenience| Paste and overwrite the same number of spaces (aka. overtype paste)
  +^u::              w("ls","lc"),ConvertUpper()                                ;Convenience* capitalize selected text
  +!u::              w("ls","la"),ConvertLower()                                ;Convenience* make selected text to lower case
  ^!u::              w("la","lc"),Capitalize1stLetter()                         ;Convenience; First Letter Capitalized
  ^!+u::             w("ls","lc","la"),Capitalize1stLetter(,,0)                 ;Convenience; Every First Letter Capitalized
  !#s::              ReplaceAwithB(" ")                                         ;Convenience! remove all spaces from selected text
  !#enter::          RemoveBlankLines()                                         ;Convenience! remove empty lines starting from selected text
  +!9::              Clip("(" Clip() ")")                                       ;Convenience: enclose selected text with ( )
  $+!SC01A::         Clip("{" Clip() "}")                                       ;Convenience: enclose selected text with { }
  !SC01A::           Clip("[" Clip() "]")                                       ;Convenience: enclose selected text with [ ]
  +^SC028::          Clip("'" Clip() "'")                                       ;Convenience: enclose selected text with ' '
  +!SC028::          Clip("""" Clip() """")                                     ;Convenience: enclose selected text with " "
  <!>+5::                                                                       ;Convenience: enclose selected text with % %
  >!<+5::            Clip("%" Clip() "%")                                       ;Convenience: enclose selected text with % %
  <!>+4::                                                                       ;Convenience: enclose selected text with $ $
  >!<+4::            Clip("$" Clip() "$")                                       ;Convenience: enclose selected text with $ $
  !sc029::           Clip("``" Clip() "``")                                     ;Convenience: enclose selected text with ` `
  +!sc029::          Clip("`````` " Clip() " ``````")                           ;Convenience: enclose selected text with ``` ```
  #backspace::       Send ^{backspace}                                          ;Convenience: ^backspace (delete word from last character)
  #!sc028::          s("{blind}"), ReplaceAwithB("""", "")                      ;Convenience replace "_" with " " Ain selected text
  #!sc00C::          s("{blind}"), ReplaceAwithB("-", " ")                      ;Convenience replace "_" with " " Ain selected text
  ^#sc00C::          s("{blind}"), ReplaceAwithB(" ", "-")                      ;Convenience replace " " with "_" in selected text
  #!SC034::          s("{blind}"), ReplaceAwithB(".", " ")                      ;Convenience replace "." with " " in selected text
  ^#SC034::          s("{blind}"), ReplaceAwithB(" ", ".")                      ;Convenience replace "." with " " in selected text
  ^#SC00D::          s("{blind}"), ReplaceAwithB(" ", "+")                      ;Convenience replace " " with "+" in selected text
  #!sc033::          s("{blind}"), ReplaceAwithB(",", " ")                      ;Convenience replace "_" with " " Ain selected text
  ^#SC033::          s("{blind}"), ReplaceAwithB(" ", ",")                      ;Convenience replace " " with "," in selected text
  #!SC00D::          s("{blind}"), ReplaceAwithB(",", "+")                      ;Convenience replace "," with "+" in selected text


  #IF IsCMODE()
  backspace::        ReplaceAwithB(" ")                                         ; remove all spaces               
  SC00D::            ReplaceAwithB()                                            ; replaces multiple consecutive spaces with character length 1 space 
  #IF  

  #If !WinActive("ahk_exe Code.exe") && GC("T_TM",0)                            ; conditional: ignore this shortcut if vs code active            
  ^!d::              SelectLine(), txt := clip(), s("right"), clip(txt)         ;Convenience: duplicate current line
  #IF GC("T_TM",0)


 
; TEXT NAVIGATION & SELECTION __________________________________________________
  
    $#h::              Sendinput ^{Left}                                        ;Navigation: jump to next word; simulate ctrl+Left
    $#l::              Sendinput ^{Right}                                       ;Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
    $#>!h::            Sendinput ^{Left 4}                                      ;Navigation: jump to next word; simulate ctrl+Left
    $#>!l::            Sendinput ^{Right 4}                                     ;Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
    $#>!j::            Sendinput {down 4}                                       ;Navigation: jump to next word; simulate ctrl+Left
    $#>!k::            Sendinput {up 4}                                         ;Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
    $<^>!h::           Sendinput ^{Left 4}                                      ;Navigation: jump to next word; simulate ctrl+Left
    $<^>!l::           Sendinput ^{Right 4}                                     ;Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
    !h::               Sendinput {Left}                                         ;Navigation| Left
    !l::               Sendinput {Right}                                        ;Navigation| Right
    !j::               Sendinput {down}                                         ;Navigation| Up
    !k::               Sendinput {up}                                           ;Navigation| Down
    ^!h::              Sendinput {home}                                         ;Navigation: Home
    ^!l::              Sendinput {end}                                          ;Navigation: End
    #e::               W("lw"),SI("^{home}")                                    ;Navigation: ^home                        
    +#e up::           W("lw","ls"),SI("^{end}")                                ;Navigation: ^end
    ;>^K::              W("rc"),SI("^{home}")                                    ;Navigation: ^home
    ;>^J::              W("rc"),SI("^{end}")                                     ;Navigation: ^end
    
  #IF GetKeyState("lctrl", "P") && GetKeyState("lalt", "P")
    left::             Sendinput {home}                                         ;Navigation: home
    right::            Sendinput {end}                                          ;Navigation: end

  #IF GC("T_rshift",1) ; 4 char nav -- -- -- -- -- -- -- -- -- -- -- -- -- -- -
    >+l::              Sendinput {Right 4}                                      ;Navigation: extend selection Right 4 character
    >+h::              Sendinput {Left 4}                                       ;Navigation: extend selection Left  4 character
    >+j::              Sendinput {down 4}                                       ;Navigation: extend selection Right 4 character
    >+k::              Sendinput {up 4}                                         ;Navigation: extend selection Left  4 character

  #IF IsCMODE() ; capslock- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    n::                Sendinput {down}                                         ;Navigation| Up
    b::                Sendinput {up}                                           ;Navigation| Down

    rshift & l::       Sendinput {Right 10}                                     ;Navigation: extend selection Right 2 character
    rshift & h::       Sendinput {Left 12}                                      ;Navigation: extend selection Left  2 character
    rshift & j::       Sendinput {down 12}                                      ;Navigation: extend selection Right 2 character
    rshift & k::       Sendinput {up 10}                                        ;Navigation: extend selection Left  2 character
    h::                Sendinput {home}                                         ;Navigation: home
    l::                Sendinput {end}                                          ;Navigation: end
    #IF  

    $<!f::             SelectWord()                                             ;Selection: select word at text cursor position
    $+!f up::          SelectLine()                                             ;Selection: select current line starting from begining of line
    $^!f::             Sendinput {end}+{home}                                   ;Selection: select line starting from end of line
    $^#h::             Sendinput +{Home}                                        ;Selection: select to beginning of line (press win before ctrl)
    $^#l::             Sendinput +{End}                                         ;Selection: select to end of line (press win before ctrl)
    $+^j::             Sendinput +{down}                                        ;Selection: select to next line
    $+^k::             Sendinput +{up}                                          ;Selection: select to line above
    $^#j::             Sendinput +^{end}                                        ;Selection: select all below
    $^#k::             Sendinput +^{home}                                       ;Selection: sejlect all above
    $+^h::             Sendinput +^{Left}                                       ;Selection: extend selection Left  1 words
    $+^l::             Sendinput +^{Right}                                      ;Selection: extend selection Right 1 words
    $+#h::             Sendinput +^{Left}                                       ;Selection: extend selection Left  1 words
    $+#l::             Sendinput +^{Right}                                      ;Selection: extend selection Right 1 words
    $+#>!h::           Sendinput +^{Left 2}                                     ;Selection: extend selection Left  2 words
    $+#>!l::           Sendinput +^{Right 2}                                    ;Selection: extend selection Right 2 words
    $+#>!j::           Sendinput +^{down 4}                                     ;Selection: extend selection Left  2 words
    $+#>!k::           Sendinput +^{up 4}                                       ;Selection: extend selection Right 2 words
    $+<!l::            Sendinput +{Right}                                       ;Selection: extend selection Right 1 characters
    $+<!h::            Sendinput +{Left}                                        ;Selection: extend selection Left  1 characters
    $+#k::                                                                      ;Selection: extend selection up    1 rows
    +!k::              Sendinput +{up}                                          ;Selection: extend selection up    1 rows
    $+#j::                                                                      ;Selection: extend selection down  1 rows
    +!j::              Sendinput +{down}                                        ;Selection: extend selection down  1 rows
    $>+<!l::                                                                    ;Selection: extend selection Right 4 characters 
    $<+>!l::           Sendinput +{Right 4}                                     ;Selection: extend selection Right 4 characters
    $>+<!h::                                                                    ;Selection: extend selection Left 4 characters 
    $<+>!h::           Sendinput +{Left 4}                                      ;Selection: extend selection Left 4 characters
    >+<!k::                                                                     ;Selection: extend selection up    4 rows 
    <+>!k::            Sendinput +{up 4}                                        ;Selection: extend selection up    4 rows
    >+<!j::                                                                     ;Selection: extend selection down  4 rows 
    <+>!j::            Sendinput +{down 4}                                      ;Selection: extend selection down  4 rows
    $<+>+!l::          Sendinput +{Right 10}                                    ;Selection: extend selection Right 10 characters
    $<+>+!h::          Sendinput +{Left 10}                                     ;Selection: extend selection Left  10 characters
    <+>+!k::           Sendinput +{up 8}                                        ;Selection: extend selection up    8 rows
    <+>+!j::           Sendinput +{down 8}                                      ;Selection: extend selection down  8 rows
    <+>+#h::           Sendinput +^{left 4}                                     ;Selection: extend selection up    4 rows
    <+>+#l::           Sendinput +^{right 4}                                    ;Selection: extend selection down  4 rows
    >+!l::             Sendinput +{Right 8}                                     ;Selection: extend selection Right 8 rows
    >+!h::             Sendinput +{Left 8}                                      ;Selection: extend selection Left  8 rows
    <+>+l::            Sendinput +{Right 5}                                     ;Selection: extend selection Right 5 rows
    <+>+h::            Sendinput +{Left 5}                                      ;Selection: extend selection Left  5 rows
    <+>+k::            Sendinput +{up 4}                                        ;Selection: extend selection up    4 rows
    <+>+j::            Sendinput +{down 4}                                      ;Selection: extend selection down  4 rows

  
; MOUSE FUNCTION _______________________________________________________________
    
    *#i::                                                                       ;MouseFn: return to saved mouse position and click (left click if no saved position found)
    *#d::             CursorRecall(substr(A_ThisHotkey,0), 1,,0)                ;MouseFn: return to saved mouse position and click (left click if no saved position found) chng 4th parameter to 1 stay at saved clicked position
    F12 & i::                                                                   ;MouseFn: Left click and save mouse position
    F12 & d::         SaveMousPos(substr(A_ThisHotkey,0),1)                     ;MouseFn: Left click and save mouse position
    :X:+i~win::       SaveMousPos("i",1)                                        ;MouseFn: Left click and save mouse position
    :X:+p~win::       SaveMousPos("p",1)                                        ;MouseFn: Left click and save mouse position
    end & i::                                                                   ;MouseFn: reset saved mouse coordinates 
    end & d::                                                                   ;MouseFn: reset saved mouse coordinates 
                      DC("MPos_" getCurrentDesktop() "_" substr(A_ThisHotkey,0))
                      PU("Click reset")                                         ;MouseFn: erase saved curor position
                      return
    #>^j::            Sendinput {WheelDown 10}                                  ;MouseFn: scroll wheel down 15 clicks
    #>^k::            Sendinput {WheelUp 10}                                    ;MouseFn: scroll wheel Up 15 clicks
    printscreen & j:: Sendinput {WheelDown 4}                                   ;MouseFn: scroll wheel down 15 clicks
    printscreen & k:: Sendinput {WheelUp 4}                                     ;MouseFn: scroll wheel Up 15 clicks

    $#k::             Sendinput {WheelUp 3}                                     ;Navigation: mouse scroll down 6 lines
    $#j::             Sendinput {WheelDown 3}                                   ;Navigation: mouse scroll down 6 lines
    $#>+h::           Sendinput {Wheelleft 1}                                   ;Navigation: mouse scroll left
    $#>+l::           Sendinput {WheelRight 1}                                  ;Navigation: mouse scroll right
    $#n::             CursorJump("C")                                           ;MouseFn: move mouse cursor to center of active application window

    #f::              Clicks(2)                                                 ;MouseFn: 2 Left clicks (select word)
    ^#f::             Clicks(3)                                                 ;MouseFn: 3 Left clicks (select line)
    >+>!j up::        Send ^{sc00D}                                             ;MouseFn: zoom in
    >+>!k up::        Send ^{sc00C}                                             ;MouseFn: zoom out
    #o up::           Click, middle                                             ;MouseFn: mouse middle click
    PrintScreen & sc028::                                                       ;MouseFn: mouse Right click
    #sc028::          Click, Right                                              ;MouseFn: mouse Right click

  #If IsCMODE()                                                                 ; capslocks used as modifier for following functions
            
    sc028::         Click, Right                                                ;MouseFn: mouse Right click
    k::             Sendinput {WheelUp 2}                                       ;MouseFn: mouse scroll down 2 lines
    j::             Sendinput {WheelDown 2}                                     ;MouseFn: mouse sckkroll down 2 lines
    left::          Sendinput {Wheelleft 1}                                     ;MouseFn: mouse scroll left
    right::         Sendinput {WheelRight 1}                                    ;MouseFn: mouse scroll right
    space::         CursorJump()                                                ;MouseFn: center cursor
    w::             CursorJump("T",,100)                                        ;MouseFn: move mouse cursor to top edge
    s::             CursorJump("B",,-70)                                        ;MouseFn: move mouse cursor to bottom edge
    a::             CursorJump("L",70)                                          ;MouseFn: move mouse cursor to Left edge
    d::             CursorJump("R",-70)                                         ;MouseFn: move mouse cursor to Right edge
    u::             CursorJump("TL",150,150)                                    ;MouseFn: move mouse cursor to TOP LEFT of active app
    q::             CursorJump("TL",150,150)                                    ;MouseFn: move mouse cursor to TOP LEFT of active app
    i::             CursorJump("TR",-150,150)                                   ;MouseFn: move mouse cursor to TOP RIGHT of active app
    e::             CursorJump("TR",-150,150)                                   ;MouseFn: move mouse cursor to TOP RIGHT of active app
    lshift::        CursorJump("BL",150,-150)                                   ;MouseFn: move mouse cursowr to BOTTOM LEFT of active app
    z::             CursorJump("BL",150,-150)                                   ;MouseFn: move mouse cursowr to BOTTOM LEFT of active app
    c::             CursorJump("BR",-150,-150)                                  ;MouseFn: move mouse cursor to BOTTOM RIGHT of active app
    #IF
; ACCENTS ______________________________________________________________________
    :C*?:'E::{U+00C9} ; ' followed by E => É
    :C*?:'e::{U+00E9} ; ' followed by e => é

    /*
    Easy accents on a qwerty keyboard including french ç as well as spanish ñ and ¿ 1nd ¡
    
    Note: Obtained the unicode values at: https en.wikipedia.org /wiki/List_of_Unicode_characters  Spaced Link for safety
    
    Basiclly this solution allows to type any vowel preceded by any of [':;^] to obtain the 'accented' version:
    ' before [AEIOUaeiou'NnCc?!] produces [ÁÉÍÓÚáéíóú'ÑñÇç¿¡]
    " before [AEIOUaeiou"]       produces [ÄËÏÖÜäëïöü"]
    ` before [AEIOUaeiou`]       produces [ÀÈÌÒÙàèìòù`]
    ^ before [AEIOUaeiou^]       produces [ÂÊÎÔÛâêîôû^]
    
    The leader character can be produced by typing it twice: '' => ', "" => " et al.
    This is only needed if the leader character is followed by a vowel, n, c, ? or !.
    
    Note that for my personal ease of typing, ñ and Ñ can also pr produced by 'n and 'N.
    
    The available combinations can easily be extended if you need other accented characters.
    
    */
    
    /*
    
        ; ' followed by character
        :C*?:'!::{U+00A1} ; ! followed by ' => ¡
        :C*?:''::{U+0027} ; ' followed by ' => '
        :C*?:'?::{U+00BF} ; ? followed by ' => ¿
        :C*?:'A::{U+00C1} ; ' followed by A => Á
        :C*?:'C::{U+00C7} ; ' followed by C => Ç
        :C*?:'E::{U+00C9} ; ' followed by E => É
        :C*?:'I::{U+00CD} ; ' followed by I => Í
        :C*?:'N::{U+00D1} ; ' followed by N => N
        :C*?:'O::{U+00D3} ; ' followed by O => Ó
        :C*?:'U::{U+00DA} ; ' followed by U => Ú
        :C*?:'a::{U+00E1} ; ' followed by a => á
        :C*?:'c::{U+00E7} ; ' followed by c => ç
        :C*?:'e::{U+00E9} ; ' followed by e => é
        :C*?:'i::{U+00ED} ; ' followed by i => í
        :C*?:'n::{U+00F1} ; ' followed by n => ñ
        :C*?:'o::{U+00F3} ; ' followed by o => ó
        :C*?:'u::{U+00FA} ; ' followed by u => ú
        
        ; " followed by character
        :C*?:""::{U+0022} ; " followed by : => :
        :C*?:"A::{U+00C4} ; " followed by A => Ä
        :C*?:"E::{U+00CB} ; " followed by E => Ë
        :C*?:"I::{U+00CF} ; " followed by I => Ï
        :C*?:"O::{U+00D6} ; " followed by O => Ö
        :C*?:"U::{U+00DC} ; " followed by U => Ü
        :C*?:"a::{U+00E4} ; " followed by a => ä
        :C*?:"e::{U+00EB} ; " followed by é => ë
        :C*?:"i::{U+00EF} ; " followed by i => ï
        :C*?:"o::{U+00F6} ; " followed by o => ö
        :C*?:"u::{U+00FC} ; " followed by u => ü
        
        ; ` followed by character
        :C*?:````::{U+0060} ; ` followed by ` => `
        :C*?:``A::{U+00C0} ; ` followed by A => À
        :C*?:``E::{U+00C8} ; ` followed by E => È
        :C*?:``I::{U+00CC} ; ` followed by I => Ì
        :C*?:``O::{U+00D2} ; ` followed by O => Ò
        :C*?:``U::{U+00D9} ; ` followed by U => Ù
        :C*?:``a::{U+00E0} ; ` followed by a => à
        :C*?:``e::{U+00E8} ; ` followed by e => è
        :C*?:``i::{U+00EC} ; ` followed by i => ì
        :C*?:``o::{U+00F2} ; ` followed by o => ò
        :C*?:``u::{U+00F9} ; ` followed by u => ù
        
        ; ^ followed by character
        :C*?:^^::{U+005E} ; ^ followed by ^ => ^
        :C*?:^A::{U+00C2} ; ^ followed by A => Â
        :C*?:^E::{U+00CA} ; ^ followed by E => Ê
        :C*?:^I::{U+00CE} ; ^ followed by I => Î
        :C*?:^O::{U+00D4} ; ^ followed by O => Ô
        :C*?:^U::{U+00DB} ; ^ followed by U => Û
        :C*?:^a::{U+00E2} ; ^ followed by a => â
        :C*?:^e::{U+00EA} ; ^ followed by e => ê
        :C*?:^i::{U+00EE} ; ^ followed by i => î
        :C*?:^o::{U+00F4} ; ^ followed by o => ô
        :C*?:^u::{U+00FB} ; ^ followed by u => û
        
        ; ~ followed by character
        :C*?:~~::{U+007E} ; ~ followed by ~ => ~
        :C*?:~N::{U+00D1} ; ~ followed by N => N
        :C*?:~n::{U+00F1} ; ~ followed by n => ñ
    */
    
#IF

