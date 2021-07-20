 
 SelectByRegEx(input = "") {
    ; Select files in file explorer by regex                                    ; https://sharats.me/posts/the-magic-of-autohotkey-2/
    static selectionPattern := ""
    selectionPattern := input ? input : ""
    WinGetPos, wx, wy
    ControlGetPos, cx, cy, cw, , DirectUIHWND3
    x := wx + cx + cw/2 - 200
    y := wy + cy
    InputBox, selectionPattern, Select by regex
        , Enter regex pattern to select files (empty to select all)
        , , 400, 125, %x%, %y%, , , %selectionPattern% 
    Gui, +LastFound +Resize +OwnDialogs +AlwaysOnTop
    hwnd  := WinExist()
        
    if ErrorLevel
        Return
    ; sleep 2000
    
    for window in ComObjCreate("Shell.Application").Windows
        if WinActive("ahk_id " . window.hwnd) {
            pattern := "Si)" . selectionPattern
            items := window.document.Folder.Items
            total := items.Count()
            i := 0
            showProgress := total > 160
            if (showProgress)
                Progress, b w200, , Matching...
            for item in items {
                match := RegExMatch(item.Name, pattern) ? 17 : 0
                window.document.SelectItem(item, match)
                if (showProgress) {
                    i := i + 100
                    Progress, % i / total
                }
            }
            Break
        }
    Progress, Off
 }

 1SelectByRegEx(fsz = "15", fnt = "Consolas", w_color = "F6F7F1", t_color = "000000") {
    static selectionPattern := "Si)"
    global long, med, short, lgreen, config_path, CB_Display := "", UserInput := ""
    Gui, re: Destroy
    title_text := Select by regex
    Gui, re: New, ,%title%
    Gui, re: +LastFound -dpiscale +Resize +OwnDialogs +AlwaysOnTop +MinSize200x80 
    hwnd := WinExist()
    Gui, font ,s%fsz% ,%fnt%
    msg := Enter regex pattern to select files (empty to select all)
    Gui, re: Add, Text, c%ctn% xm ym-1 Center, %msg%
    Gui, 2: Color, %w_color%
    Gui, re: show

 }
