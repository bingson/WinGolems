ObjGetVarName(ByRef oArray)
{
	ListVars
	WinWaitActive, ahk_class AutoHotkey
	vPtr2 := &oArray
	;MsgBox, % Format("0x{:X}", vPtr2)
	Loop
	{
		ControlGetText, vText, Edit1, ahk_class AutoHotkey
		if InStr(vText, ": Object object {address: ")
			break
		Sleep, 100
	}
	WinHide, ahk_class AutoHotkey
	Loop, Parse, vText, `n, `r
	{
		vTemp := A_LoopField
		if (vTemp = "Global Variables (alphabetical)")
			vOutput := ""
		if !vPos := InStr(vTemp, ": Object object {address: ")
			continue
		vPtr := SubStr(vTemp, vPos+26, -1)
		;MsgBox, % "[" vPtr "]"
		if (vPtr = vPtr2)
			vOutput .= vTemp "`r`n"
	}
	;MsgBox, % Clipboard := vOutput
	return SubStr(vOutput, 1, -2)
}
return