StringWidth(String, Font:="", FontSize:=10)
{
	Gui StringWidth:Font, s%FontSize%, %Font%
	Gui StringWidth:Add, Text, R1, %String%
	GuiControlGet T, StringWidth:Pos, Static1
	Gui StringWidth:Destroy
	return TW+1
	;~ return TW+1 ;this solve the problem
}