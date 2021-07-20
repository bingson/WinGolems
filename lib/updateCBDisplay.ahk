updateCBDisplay(txt_file) {
    txt  := AccessCache(txt_file,, False)
    rows := countrows(txt)
    rows := (rows < 1) ? 1 : (rows > 30) ? 30 : rows
    Width := StringWidth(txt, fnt, fsz)
    Width := (Width < 200) ? 200 : (Width > 800) ? 800 : Width
    Gui, 2: Margin, 10, 10
    Gui, 2: Add, Edit, section x5 w%Width% R%rows% HScroll VScroll ReadOnly vCB_Display         ; https://www.autohotkey.com/boards/viewtopic.php?f=5&t=16964
    Guicontrol, ,CB_Display, %txt%
    IniRead, gui_position, %config_path%, %A_ComputerName%, gui_position, Center
    wdth := StrSplit(gui_position, " ")[3]
    GuiControl, Move, CB_Display, %wdth%                                            ; set the width to the edit box to value stored in ini file
    ; Gui, 2: show, hide AutoSize
    ; Gui, 2: show, %gui_position%
}