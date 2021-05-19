;***********************Get PXL to Excel********************************.
;***********************Excel Handles********************************.
;~ XL_Handle(XL,1) ; pointer to Application   XL_Handle(XL,2) Pointer to Workbook
XL_Handle(ByRef PXL,Sel){
ControlGet, hwnd, hwnd, , Excel71, ahk_class XLMAIN ;identify the hwnd for Excel
IfEqual,Sel,1, Return, PXL:= ObjectFromWindow(hwnd,-16).application ;Handle to Excel Application
IfEqual,Sel,2, Return, PXL:= ObjectFromWindow(hwnd,-16).parent ;Handlle to active Workbook
IfEqual,Sel,3, Return, PXL:= ObjectFromWindow(hwnd,-16).activesheet ;Handle to Active Worksheet
}
;***borrowd & tweaked from Acc.ahk Standard Library*** by Sean  Updated by jethrow*****************
ObjectFromWindow(hWnd, idObject = -4){
(if Not h)?h:=DllCall("LoadLibrary","Str","oleacc","Ptr")
    If DllCall("oleacc\AccessibleObjectFromWindow","Ptr",hWnd,"UInt",idObject&=0xFFFFFFFF,"Ptr",-VarSetCapacity(IID,16)+NumPut(idObject==0xFFFFFFF0?0x46000000000000C0:0x719B3800AA000C81,NumPut(idObject==0xFFFFFFF0?0x0000000000020400:0x11CF3C3D618736E0,IID,"Int64"),"Int64"), "Ptr*", pacc)=0
    Return	ComObjEnwrap(9,pacc,1)
}


;~ XL_Handle(XL,1) ;1=Application 2=Workbook 3=Worksheet
;~ XL_Handle(ByRef PXL,Sel){
;~ ControlGet, hwnd, hwnd, , Excel71, ahk_class XLMAIN ;identify the hwnd for Excel
;~ window := Acc_ObjectFromWindow(hwnd, -16) ;Assign hwnd to a pointer
;~ IfEqual,Sel,1, Return, PXL:= window.application ;Handle to Excel Application
;~ IfEqual,Sel,2, Return, PXL:= window.parent ;Handlle to active Workbook
;~ IfEqual,Sel,3, Return, PXL:= window.activesheet ;Handle to Active Worksheet
;~ }

;***********************Show name of object handle is referencing********************************.
;~ XL_Reference(XL) ;will pop up with a message box showing what pointer is referencing
XL_Reference(PXL){
;~ MsgBox, %HWND%
;~ MsgBox, % ComObjType(window)
MsgBox % ComObjType(PXL,"Name")
}
;***********************Screen update toggle********************************.
;~ XL_Screen_Update(XL)
XL_Screen_Update(PXL){
   PXL.Application.ScreenUpdating := ! PXL.Application.ScreenUpdating
}
;***********************First row********************************.
;~ XL_First_Row(XL)
XL_First_Row(PXL){
   Return, PXL.Application.ActiveSheet.UsedRange.Rows(1).Row
}
;***********************Used Rows********************************.
;~ XL_Used_Rows(XL)
XL_Used_rows(PXL){
   Return,PXL.Application.ActiveSheet.UsedRange.Rows.Count
}
;***********************Last Row********************************.
;~ XL_Last_Row(XL)
XL_Last_Row(PXL){
   Return, PXL.Application.ActiveSheet.UsedRange.Rows(PXL.Application.ActiveSheet.UsedRange.Rows.Count).Row
   }
;***********************First Column********************************.
;~ XL_First_Col_Nmb(XL)
XL_First_Col_Nmb(PXL){
   Return, PXL.Application.ActiveSheet.UsedRange.Columns(1).Column
}
;***********************First Column Alpha**********************************.
;~ XL_Last_Col_Alpha(XL)
XL_First_Col_Alpha(PXL){
FirstCol:=PXL.Application.ActiveSheet.UsedRange.Columns(1).Column
IfLessOrEqual,LastCol,26, Return, (Chr(64+FirstCol))
	Else IfGreater,LastCol,26, return, Chr((FirstCol-1)/26+64) . Chr(mod((FirstCol- 1),26)+65)
}
;***********************Used Columns********************************.
;~ LC:=XL_Used_Cols_Nmb(XL)
XL_Used_Cols_Nmb(PXL){
Return, PXL.Application.ActiveSheet.UsedRange.Columns.Count
}
;***********************Last Column********************************.
;~ LC:=XL_Last_Col_Nmb(XL)
XL_Last_Col_Nmb(PXL){
Return, PXL.Application.ActiveSheet.UsedRange.Columns(PXL.Application.ActiveSheet.UsedRange.Columns.Count).Column
}
;***********************Last Column Alpha**  Needs Workbook********************************.
;~ XL_Last_Col_Alpha(XL)
XL_Last_Col_Alpha(PXL){
LastCol:=XL_Last_Col_Nmb(PXL)
IfLessOrEqual,LastCol,26, Return, (Chr(64+LastCol))
	Else IfGreater,LastCol,26, return, Chr((LastCol-1)/26+64) . Chr(mod((LastCol- 1),26)+65)
}
;***********************Used Range********************************.
;~ XL_Used_RG(XL,Header:=1) ;Use header to include/skip first row
XL_Used_RG(PXL,Header=1){
IfEqual,Header,0,Return, XL_First_Col_Alpha(PXL) . XL_First_Row(PXL) ":" XL_Last_Col_Alpha(PXL) . XL_Last_Row(PXL)
IfEqual,Header,1,Return, XL_First_Col_Alpha(PXL) . XL_First_Row(PXL)+1 ":" XL_Last_Col_Alpha(PXL) . XL_Last_Row(PXL)
}
;***********************Numeric Column to string********************************.
;~ XL_Col_To_Char(26)
XL_Col_To_Char(index){ ;Converting Columns to Numeric for Excel
	IfLessOrEqual,index,26, Return, (Chr(64+index))
	Else IfGreater,index,26, return, Chr((index-1)/26+64) . Chr(mod((index - 1),26)+65)
}
;***********************alpha to Number********************************.
;~ XL_String_To_Number("ab")
XL_String_To_Number(Column){
    StringUpper, Column, Column
    Index := 0
    Loop, Parse, Column  ;loop for each character
    {ascii := asc(A_LoopField)
    	if (ascii >= 65 && ascii <= 90)
           index := index * 26 + ascii - 65 + 1    ;Base = 26 (26 letters)
        else { return
        } }
        return, index
}
;***********************Freeze Panes********************************.
;~ XL_Freeze(XL,Row:="1",Col:="B") ;Col A will not include cols which is default so leave out if unwanted
;***********************Freeze Panes in Excel********************************.
XL_Freeze(PXL,Row="",Col="A"){
PXL.Application.ActiveWindow.FreezePanes := False ;unfreeze in case already frozen
IfEqual,row,,return ;if no row value passed row;  turn off freeze panes
PXL.Application.ActiveSheet.Range(Col . Row+1).Select ;Helps it work more intuitivly so 1 includes 1 not start at zero
PXL.Application.ActiveWindow.FreezePanes := True
}

;*******************************************************.
;***********************Formatting********************************.
;*******************************************************.
;***********************Alignment********************************.
;~ XL_Format_HAlign(XL,RG:="A1:A10",h:=2) ;1=Left 2=Center 3=Right
XL_Format_HAlign(PXL,RG="",h="1"){ ;defaults are Right bottom
IfEqual,h,1,Return,PXL.Application.ActiveSheet.Range(RG).HorizontalAlignment:=-4131 ;Left
IfEqual,h,2,Return,PXL.Application.ActiveSheet.Range(RG).HorizontalAlignment:=-4108 ;Center
IfEqual,h,3,Return,PXL.Application.ActiveSheet.Range(RG).HorizontalAlignment:=-4152 ;Right
}

;~ XL_Format_VAlign(XL,RG:="A1:A10",v:=4) ;1=Top 2=Center 3=Distrib 4=Bottom
XL_Format_VAlign(PXL,RG="",v="1"){
IfEqual,v,1,Return,PXL.Application.ActiveSheet.Range(RG).VerticalAlignment:=-4160 ;Top
IfEqual,v,2,Return,PXL.Application.ActiveSheet.Range(RG).VerticalAlignment:=-4108 ;Center
IfEqual,v,3,Return,PXL.Application.ActiveSheet.Range(RG).VerticalAlignment:=-4117 ;Distributed
IfEqual,v,4,Return,PXL.Application.ActiveSheet.Range(RG).VerticalAlignment:=-4107 ;Bottom
}
;***********************Wrap text********************************.
;~ XL_Format_Wrap(XL,RG:="A1:B4",Wrap:=0) ;1=Wrap text, 0=no
XL_Format_Wrap(PXL,RG="",Wrap="1"){ ;defaults to Wrapping
PXL.Application.ActiveSheet.Range(RG).WrapText:=Wrap
}

;***********Shrink to fit*******************
;~ XL_Format_Shrink_to_Fit(XL,RG:="A1",Shrink:=0) ;1=Wrap text, 0=no
XL_Format_Shrink_to_Fit(PXL,RG="",Shrink="1"){ ;defaults to Shrink to fit
(Shrink=1)?(PXL.Application.ActiveSheet.Range(RG).WrapText:=0) ;if setting Shrink to fit need to turn-off Wrapping
PXL.Application.ActiveSheet.Range(RG).ShrinkToFit :=Shrink
}


;***********************Merge / Unmerge cells********************************.
;~ XL_Merge_Cells(XL,RG:="A12:B13",Warn:=0,Merge:=1) ;set to true if you want them merged
XL_Merge_Cells(PXL,RG,warn=0,Merge=0){ ;default is unmerge and warn off
PXL.Application.DisplayAlerts := warn ;Warn about unmerge keeping only one cell
PXL.Application.ActiveSheet.Range(RG).MergeCells:=Merge ;set merge for range
(warn=0)?(PXL.Application.DisplayAlerts:=1) ;if warnings were turned off, turn back on
}
;***********************Font size, type, ********************************.
;~ XL_Format_Font(XL,RG:="A1:B1",Font:="Arial Narrow",Size:=25) ;Arial, Arial Narrow, Calibri,Book Antiqua
XL_Format_Font(PXL,RG="",Font="Arial",Size="11"){
PXL.Application.ActiveSheet.Range(RG).Font.Name:=Font
PXL.Application.ActiveSheet.Range(RG).Font.Size:=Size
}

;***********************Font bold, normal, italic, Underline********************************.
;~ XL_Format_Format(XL,RG:="A1:B1",Bold:=1,Italic:=0,Underline:=3) ;Underline 1 thru 5
XL_Format_Format(PXL,RG="",Bold=0,Italic=0,Underline=0){
PXL.Application.ActiveSheet.Range(RG).Font.Bold:= bold
PXL.Application.ActiveSheet.Range(RG).Font.Italic:=Italic
(Underline="0")?(PXL.Application.ActiveSheet.Range(RG).Font.Underline:=-4142):(PXL.Application.ActiveSheet.Range(RG).Font.Underline:=Underline+1)
}

;***********Cell Shading*******************
;2=none 3=Red 4=Lt Grn 6=Brt Yel 7=Mag 8=brt blu 15=Grey 17=Lt purp  19=Lt Yell 20=Lt blu 22=Salm 26=Brt Pnk
;~ XL_Format_Cell_Shading(XLs,RG:="A1:H1",Color:=28)
XL_Format_Cell_Shading(PXL,RG="",Color=0){
PXL.Application.ActiveSheet.Range(RG).Interior.ColorIndex :=Color
}

;***********************Cell Number format********************************.
;~ XL_Format_Number(XL,RG:="A1:B4",Format:="#,##0") ;#,##0 ;0,000 ;0,00.0 ;0000 ;000.0 ;.0% ;$0 ;m/dd/yy ;m/dd ;dd/mm/yyyy
XL_Format_Number(PXL,RG="",format="#,##0"){
PXL.Application.ActiveSheet.Range(RG).NumberFormat := Format
}

;***********************Search- find text- Cell shading and Font color********************************.
;~ XL_Color(PXL:=XL,RG:="A1:D50",Value:="Joe",Color:="2",Font:=1) ;change the font color
;~ XL_Color(PXL:=XL,RG:="A1:D50",Value:="Joe",Color:="1") ;change the interior shading
;***********************to do ********************************.
;*this is one or the other-  redo it so it does both***************.
XL_Color(PXL="",RG="",Value="",Color="1",Font="0"){
if  f:=PXL.Application.ActiveSheet.Range[RG].Find[Value]{ ; if the text can be found in the Range
    first :=f.Address  ; save the address of the first found match
 	 Loop
         If (Font=0){
         f.Interior.ColorIndex :=Color, f :=PXL.Application.ActiveSheet.Range[RG].FindNext[f] ;color Interior & move to next found cell
       }Else{
         f.Font.ColorIndex :=Color, f :=PXL.Application.ActiveSheet.Range[RG].FindNext[f] ;color font & move to next found cell
     }Until (f.Address = first) ; stop looking when we're back to the first found cell
}}

;***********************Cell Borders (box)********************************.
;***********Note- some weights and linestyles overwrite each other*******************
;~ XL_Border(XL,RG:="a20:b21",Weight:=2,Line:=2) ;Weight 1=Hairline 2=Thin 3=Med 4=Thick  ***  Line 0=None 1=Solid 2=Dash 4=DashDot 5=DashDotDot
;***********************Cell Borders (box)********************************.
XL_Border(PXL,RG="",Weight="3",Line="1"){
IfEqual,Line,0,SetEnv,Line,-4142 ; Excel constant for no border
Loop, 4{
PXL.Application.ActiveSheet.Range(RG).Borders(A_Index+6).Weight := Weight
PXL.Application.ActiveSheet.Range(RG).Borders(A_Index+6).LineStyle := Line
}}

;***********************Row Height********************************.
;~ XL_Row_Height(XL,RG:="1:4=-1|10:13=50|21=15") ;rows first then height -1 is auto
XL_Row_Height(PXL,RG=""){
for k, v in StrSplit(rg,"|") ;Iterate over array
   (StrSplit(v,"=").2="-1")?(PXL.Application.ActiveSheet.rows(StrSplit(v,"=").1).AutoFit):(PXL.Application.ActiveSheet.rows(StrSplit(v,"=").1).RowHeight:=StrSplit(v,"=").2)
}

;***********************Column Widths********************************.
;~ XL_Col_Width_Set(XL,RG:="A:B=-1|D:F=-1|H=15|K=3") ;-1 is auto
XL_Col_Width_Set(PXL,RG=""){
for k, v in StrSplit(rg,"|") ;Iterate over array
   (StrSplit(v,"=").2="-1")?(PXL.Application.ActiveSheet.Columns(StrSplit(v,"=").1).AutoFit):(PXL.Application.ActiveSheet.Columns(StrSplit(v,"=").1).ColumnWidth:=StrSplit(v,"=").2)
}

;***********************Column Insert********************************.
XL_Col_Insert(PXL,RG="",WD:="5"){ ;Default width is 5
PXL.Application.ActiveSheet.Columns(RG).Insert(-4161).Select
PXL.Application.ActiveSheet.Columns(RG).ColumnWidth:=WD
}

;***********************Row Insert********************************.
;~ XL_Row_Insert(XL,RG:="1:5",HT:=16)  ;~ XL_Row_Insert(XL,RG:="1")
XL_Row_Insert(PXL,RG="",HT:="15"){ ;default height is 15
PXL.Application.ActiveSheet.Rows(RG).Insert(-4161).Select
PXL.Application.ActiveSheet.Rows(RG).RowHeight:=HT
}

;***********************Column Delete********************************.
XL_Col_Delete(PXL,RG=""){
   for j,k in StrSplit(rg,"|")
	(instr(k,":")=1)?list.=k ",":(list.=k ":" k ",") ;need to make for two if only 1 col
PXL.Application.ActiveSheet.Range(SubStr(list,1,(StrLen(list)-1))).Delete ;use list but remove final comma
}

;***********************Row Delete********************************.
;~ XL_Row_Delete(XL,RG:="4:5|9|67|9|10") ;range or single but cannot overlap
XL_Row_Delete(PXL,RG=""){
for j,k in StrSplit(rg,"|")
    (instr(k,":")=1)?list.=k ",":(list.=k ":" k ",") ;need to make for two if only 1 Row
    PXL.Application.ActiveSheet.Range(SubStr(list,1,(StrLen(list)-1))).Delete ;use list but remove final comma
}

;***********************Delete Column Based on Value********************************.
;~ XL_Delete_Col_Based_on_Value(XL,RG:="A1:H1",Val:="Joe")
XL_Delete_Col_Based_on_Value(PXL,RG="",Val=""){
For C in PXL.Application.ActiveSheet.Range(RG)
     If (c.Value=Val){
     PXL.Application.ActiveSheet.Range(c.Address).EntireColumn.Clearcontents
Try PXL.Application.ActiveSheet.Range(RG).SpecialCells(4).EntireColumn.Delete Shift:=-4159     ;Left
}}

;***********************Row delete based on Column value********************************.
;~ XL_Delete_Row_Based_on_Value(XL,RG:="B1:B20",Val:="Joe")
XL_Delete_Row_Based_on_Value(PXL,RG="",Val=""){
For C in PXL.Application.ActiveSheet.Range(RG)
    If (c.Value=Val)
     PXL.Application.ActiveSheet.Range(c.Address).EntireRow.Clearcontents
TRY PXL.Application.ActiveSheet.Range(RG).SpecialCells(4).EntireRow.Delete ,Shift:=-4162 ;Up ;xlToLeft = -4159
}

;***********looping over cells*******************
For Cell in xl.range(XL.Selection.Address) {
Current_Cell:=Cell.Address(0,0) ;get absolue reference; change to 1 if want releative
MsgBox % cell.value
}


;*******************************************************.
;***********************Clipboard actions********************************.
;*******************************************************.
;***********************Copy to a delimited String Variable********************************.
;~ XL_Copy_to_Var(XL,RG:="A1:A5",Delim:=",")
XL_Copy_to_Var(PXL,RG="",Delim="|"){ ;pipe is defualt
PXL.Application.ActiveSheet.range(RG).copy ;copy to clipboard
Clipboard := RegExReplace(Clipboard , "\v+", Delim)
StringTrimRight, Clipboard, Clipboard, 1 ;trim last delimiter
}

;***********************Paste ********************************.
;~ XL_Paste(XL,Source_RG:="C1",Dest_RG:="F1:F10",Paste:=1)
XL_Paste(PXL,Source_RG="",Dest_RG="",Paste=""){       ;1=All 2=Values 3=Comments 4=Formats 5=Formulas 6=Validation 7=All Except Borders
IfEqual,Paste,1,SetEnv,Paste,-4104 ;xlPasteAll        ;8=Col Widths 11=Formulas and Number formats 12=Values and Number formats
IfEqual,Paste,2,SetEnv,Paste,-4163 ;xlPasteValues
IfEqual,Paste,3,SetEnv,Paste,-4144 ;xlPasteComments
IfEqual,Paste,4,SetEnv,Paste,-4122 ;xlPasteFormats
IfEqual,Paste,5,SetEnv,Paste,-4123 ;xlPasteFormulas
PXL.Application.ActiveSheet.Range(Source_RG).Copy
PXL.Application.ActiveSheet.Range(Dest_RG).PasteSpecial(Paste)
}
;***********************deselect cells ********************************.
XL_UnSelect(XL) ;Unselects highlighted cells
XL_UnSelect(PXL){
PXL.Application.ActiveSheet.CutCopyMode := False
}
;***********************Set cell values / Formulas********************************.
;~ XL_Set_Value(XL,RG:="A1=First|A3=Next|a4=line`nbreak|B1=1|B2=2|B3=3|B4==sum(b1:b3)|B5=B6 is a formula")
XL_Set_Value(PXL,RG=""){
Loop, Parse, RG, |
{
;~ RegExMatch(A_LoopField,"(\S+)=(.*)",Vars) ;separate range from values
RegExMatch(A_LoopField,"([a-zA-Z]+\d+)=(=?\w.*)",Vars) ;separate range from values
PXL.Application.ActiveSheet.Range(Vars1).Value:=Vars2
}}
;***********************Set range********************************.
;***********************Insert Comment********************************.
;~ XL_Add_Comment(XL,RG:="b3",Comment:="Hello there`n`rMr monk`n`rWhatup",Vis:=1,Size:=11,Font:="Book Antique",ForeClr:=5)
XL_Add_Comment(PXL,RG="",Comment="",Vis=0,Size=11,Font="Arial",ForeClr=5){
If (PXL.Application.ActiveSheet.Range(RG).comment.text) <> ""
   PXL.Application.ActiveSheet.Range(RG).Comment.Delete
PXL.Application.ActiveSheet.Range(RG).Addcomment(Comment)
PXL.Application.ActiveSheet.Range(RG).Comment.Visible := Vis
PXL.Application.ActiveSheet.Range(RG).Comment.Shape.Fill.ForeColor.SchemeColor:=ForeClr
PXL.Application.ActiveSheet.Range(RG).Comment.Shape.TextFrame.Characters.Font.size:=Size
PXL.Application.ActiveSheet.Range(RG).Comment.Shape.TextFrame.Characters.Font.Name:=Font
}
;***********NEEDO TO FIX this: ToDO  Use tripple quotes like this: XL.Application.ActiveSheet.Range("D3").Value:= "=Hyperlink(""" NARRPR_Link . """,""" Add_Street """)"
;***********************Insert Hyperlink********************************.
;url needs to be in format https://www.google.com
;~ XL_Insert_URL(XL,URL:="B1",Display:="C1",RG:="B8")
XL_Insert_URL(PXL,URL="",Display="",RG=""){
      PXL.Application.ActiveSheet.Range(RG).Value:="=Hyperlink(" . URL . "," . Display . ")"
}
;***********************Insert Hyperlink via OFFSET in Columns (data is in rows)******************.
;~ XL_Hyperlink_Offset_Col(XL,RG:="E1:E8",URL:="-3",Freindly:="-2") ;Neg values are col to Left / Pos are col to Right
XL_Hyperlink_Offset_Col(PXL,RG="",URL="",Freindly=""){
For Cell in PXL.Application.ActiveSheet.Range(RG){
  Cell.Value:="=Hyperlink(""" . Cell.offset(0,URL).value . """,""" . Cell.Offset(0,Freindly).Value . """)"
  }}
;***********************Insert Hyperlink via OFFSET in Rows (data is in Columns)******************.
;~ XL_Hyperlink_Offset_Row(XL,RG:="B18:C18",URL:="-2",Freindly:="-1") ;Neg values are rows Above/ Pos are Rows below
XL_Hyperlink_Offset_Row(PXL,RG="",URL="",Freindly=""){
For Cell in PXL.Application.ActiveSheet.Range(RG){
  Cell.Value:="=Hyperlink(""" . Cell.offset(URL,0).value . """,""" . Cell.Offset(Freindly,0).Value . """)"
  }}

;***********************Remove Hyperlink********************************.
;~ XL_Clear_URL(XLs,RG="B1:B" . LR){
XL_Clear_URL(PXL,RG=""){
   For C in RG
      c.Hyperlinks.Delete
}

;***********************insert email link********************************.
;~  XL_Insert_Email(XL,email:="A3",Disp:="B3",Subj:="C3",Body:="D3",Dest:="E3")

XL_Insert_Email(PXL,email="",Disp="",Subj="",Body="",Dest=""){
PXL.Application.ActiveSheet.Range(Dest).Value:="=Hyperlink(""Mailto:"
 . PXL.Application.ActiveSheet.range(email).value
 . "?Subject=" . PXL.Application.ActiveSheet.Range(Subj).Value
 . "&Body="    . PXL.Application.ActiveSheet.Range(Body).Value
 . ""","""     . PXL.Application.ActiveSheet.Range(Disp).Value . """)"
}

;***********************Insert email OFFSET in Columns (data in rows)********************************.
;~ XL_email_Offset_Col(XL,RG:="E1:E8",URL:="-3",Freindly:="-2",Subj:="-1") ;Neg values are col to Left / Pos are col to Right
XL_email_Offset_Col(PXL,RG="",URL="",Freindly="",Subj=""){
For Cell in PXL.Application.ActiveSheet.Range(RG){
  Cell.Value:="=Hyperlink(""mailto:" . Cell.offset(0,URL).value . "?Subject=" . Cell.offset(0,Subj).Value . """,""" . Cell.Offset(0,Freindly).Value . """)"
  }}
;***********************Insert email OFFSET in Rows (data in Columns)********************************.
;~ XL_email_Offset_Row(XL,RG:="B24:D24",URL:="-3",Freindly:="-2",Subj:="-1") ;Neg values are Rows Above / Pos are Rows below
XL_email_Offset_Row(PXL,RG="",URL="",Freindly="",Subj=""){
For Cell in PXL.Application.ActiveSheet.Range(RG){
  Cell.Value:="=Hyperlink(""mailto:" . Cell.offset(URL,0).value . "?Subject=" . Cell.offset(Subj,0).Value . """,""" . Cell.Offset(Freindly,0).Value . """)"
  }}
;**********************Dictionary Search / REplace - multiple in range*********************************
;~ {"ACC":"Account Spec.":"RMK":"Rel Mark":"RM":"Rel Mark":"UNI":"University":"NIV":"University":"RFI":"RFID":"HVA":"HVAL":"PWR":"Power":"COR":"Corporate":"WBU":"Wireless":"":"Not-Coded"}
;~ Dict_Replacer(XL,rg:=RG_Hay, {"ACC":"Account Spec.":"RMK":"Rel Mark":"RM":"Rel Mark":"UNI":"University":"NIV":"University":"RFI":"RFID":"HVA":"HVAL":"PWR":"Power":"COR":"Corporate":"WBU":"Wireless":"":"Not-Coded"})
Dict_Replacer(PXL,rg="",Terms=""){
For Cell in PXL.Range[RG]
	for key, val in Terms ;Terms is Object passed in form of dictionary
      if Cell.Value=(key)  ;look for key
         Cell.Value:=Val   ;if found, change to corresponding value
}

;**********************replace null*********************************
;~  XL_Replace_Null(PXL,RG)
;***********replace Null*******************
XL_Replace_Null(PXL,RG:=""){
if (! RG)
    RG:=XL_Used_RG(PXL,0)
PXL.Range(RG).Replace("#NULL!","")  ;
}

;***********************Search / Replace********************************.
;~ XL_Replace(XL,RG:="A1:A39",Sch:="Text",Rep:="New Text",MC:="True",CellCont:=1) ;CC=1 Exact, 2=Any
XL_Replace(PXL,RG="",Sch="",Rep="",MC="",CellCont=""){
For c in PXL.Application.ActiveSheet.Range[RG]
	If C.Find[Sch]
c.Replace(What:=Sch,Replacement:=Rep,LookAt:=CellCont,SearchOrder:=1,MatchCase:=MC,MatchByte:=True, ComObjParameter(0xB, -1) , ComObjParameter(0xB, -1))
}

;********************search***Find columns based on header********************************.
;~  loc:=XL_Find_Headers_in_Cols(XL,["email","country","Age"]) ;pass search terms as an array
;~  MsgBox % "email: "  loc["email"]   .  "`nCountry: " loc["country"]   .  "`nAge: " loc["Age"]
XL_Find_Headers_in_Cols(PXL,Values){
Headers:={} ;need to create the object for storing Key-value pairs of search term and Location
for k, Search_Term in Values{
	Loop, % XL_Last_Col_Nmb(PXL){ ;loop over all used columns
		if (PXL.Application.ActiveSheet.cells(1,A_Index).Value=Search_Term) ;if cell in row 1, column A_index = search term
			Headers[Search_Term]:=XL_Col_To_Char(A_Index) . "1" ;set column to value in Hearders object
		}} return Headers ;return the key-value pairs Object
}

;~  XL_Clear(XL,RG:="A1:A8",All:=0,Format:=0,Content:=0,Hyperlink:=1,Notes:=0,Outline:=0,Comments:=1) ;0 clears contents but leaves formatting 1 clears both
;***********************Clear********************************.
XL_Clear(PXL,RG="",All=0,Format=0,Content=0,Hyperlink=0,Notes=0,Outline=0,Comments=0){
	; https://analysistabs.com/excel-vba/clear-cells-data-range-worksheet/  ;https://msdn.microsoft.com/en-us/vba/excel-vba/articles/range-clearcontents-method-excel
      (All=1)?(PXL.Application.ActiveSheet.Range(RG).Clear)           ;clear the range of cells including Formats
   (Format=1)?(PXL.Application.ActiveSheet.Range(RG).ClearFormats)    ;clear Formats but leave data
  (Content=1)?(PXL.Application.ActiveSheet.Range(RG).ClearContents)   ;clear Data but leave Formats
(Hyperlink=1)?(PXL.Application.ActiveSheet.Range(RG).ClearHyperlinks) ;clear Hyperlinks but leave formatting & Data
    (Notes=1)?(PXL.Application.ActiveSheet.Range(RG).ClearNotes)      ;clear Notes
  (Outline=1)?(PXL.Application.ActiveSheet.Range(RG).ClearOutline)    ;clear Outline
 (Comments=1)?(PXL.Application.ActiveSheet.Range(RG).ClearComments)   ;clear Comments
}


;***********************Delete blank columns********************************.
;Jetrhow wrote this http://www.autohotkey.com/board/topic/69033-basic-ahk-l-com-tutorial-for-excel/?p=557697
;~ XL_Delete_Blank_Col(XL)
XL_Delete_Blank_Col(PXL){
for column in PXL.Application.ActiveSheet.UsedRange.Columns
	if Not PXL.Application.WorkSheetFunction.count(column)
		delete_range .= column.entireColumn.address(0,0) ","
Try PXL.Application.Range(Trim(delete_range,",")).delete()
Catch
MsgBox,,Missing Columns, no missing COLUMNS, 1
}
;***********************Delete blank Rows********************************.
;~ XL_Delete_Blank_Row(XL)
XL_Delete_Blank_Row(PXL){
for Row in PXL.Application.ActiveSheet.UsedRange.Rows
	if Not PXL.Application.WorkSheetFunction.counta(Row)
		delete_range .= Row.entireRow.address(0,0) ","
Try PXL.Application.Range(Trim(delete_range,",")).delete()
Catch
MsgBox,,Missing Rows, no missing ROWS, 1
}
;***********************Row delete based on value in 1 column********************************.
; need to build it
;***********************Delete Column based on Header********************************.
;~ XL_DropColumns_Per_Header(XL,Values:="One|Two|more")
XL_DropColumns_Per_Header(PXL,Values=""){
LoopCount:=XL_Last_Col_Nmb(PXL)
Loop, %LoopCount% {
Col:=loopCount-(A_index-1)
Header:=PXL.Application.ActiveSheet.cells(1,Col).Value
    Loop, parse, Values, |
        If (Header=A_LoopField)
            PXL.Application.ActiveSheet.Columns(Col).Delete
}}

;***********************Remove Duplicates / Dedupe********************************.
;~ XL_Remove_Dup_Used_Range(XL)
;~ XL_Remove_Dup_Used_Range(XL)
XL_Remove_Dup_Used_Range(PXL,Header=""){
Dedupe_CL:=PXL.Application.Activesheet.Rows(XL_First_Row(PXL)).Find(Header).column
PXL.Application.ActiveSheet.Range(XL_Used_RG(PXL)).RemoveDuplicates(Columns:=Dedupe_CL).Header:=1 ;added header
}
;***********************Sort by Column ********************************.
;~ XL_Sort_UsedRange(XL,Head:=1,Sort_Col:="A",Ord:="d") ;Sort used range w/without header
XL_Sort_UsedRange(PXL,Head="1",Sort_Col="",Ord="A"){
Range:=XL_Used_RG(PXL,Header:=Head)
StringUpper,Ord,Ord
Sort_Col:=XL_String_To_Number(Sort_Col)+0 ; w/o the +0 will not work even though it is integer???
IfEqual,Ord,A,Return,PXL.Application.ActiveSheet.Range(Range).Sort(PXL.Application.ActiveSheet.Columns(Sort_Col),1) ;Ascending
IfEqual,Ord,D,Return,PXL.Application.ActiveSheet.Range(Range).Sort(PXL.Application.ActiveSheet.Columns(Sort_Col),2) ;Descending
}
;***********************Sort Two Columns********************************.
;~ XL_Sort_TwoCols_UsedRange(XL,Sort_1:="a",Ord_1:="D",Sort_2:="b",Ord_2:="d")
XL_Sort_TwoCols_UsedRange(PXL,Sort_1="b",Ord_1="a",Sort_2="c",Ord_2="a"){
StringUpper, Ord_1, Ord_1, StringUpper, Ord_2, Ord_2
IfEqual, Ord_1,A,SetEnv,Ord_1,1
IfEqual, Ord_1,D,SetEnv,Ord_1,2
IfEqual, Ord_2,A,SetEnv,Ord_2,1
IfEqual, Ord_2,D,SetEnv,Ord_2,2
PXL.Application.ActiveSheet.Range(XL_Used_RG(PXL,Header:=1)).Sort(PXL.Application.ActiveSheet.Columns(XL_String_To_Number(Sort_2)+0),Ord_2),PXL.Application.ActiveSheet.Range(XL_Used_RG(PXL,Header:=1)).Sort(PXL.Application.ActiveSheet.Columns(XL_String_To_Number(Sort_1)+0),Ord_1)
}

;***********************Auto filter********************************.
;***********************Clear Auto filter********************************.
XL_Filter_Clear(PXL){
PXL.Application.ActiveSheet.Range(XL_Used_RG(PXL,Header:=0)).AutoFilter ;Clear autofilter
}

;***********Add filters*******************
XL_Add_Filters(PXL){
PXL.Application.ActiveSheet.Range("A:G").AutoFilter ;Clear autofilter
}

;***********************Filter Used Range********************************.
;~ XL_Filter_Used_Range(XL,Filt_Col:="a",FilterA:="joe",FilterB:="king")
XL_Filter_Used_Range(PXL,Filt_Col="",FilterA="",FilterB=""){
PXL.Application.ActiveSheet.Range(XL_Used_RG(PXL,Header:=0)).AutoFilter ;Clear autofilter
PXL.Application.ActiveSheet.Range(XL_Used_RG(PXL,Header:=0)).AutoFilter(XL_String_To_Number(Filt_Col),FilterA,2,FilterB)
}

;***********************to do********************************.
; Rename worksheet
; reorder worksheet
; Identify Column (see ZOHO API
; get selected range
; get selected rows
; get selected columns
; Identify Row
;  *******************************************************
;**************************File********************************
;  *******************************************************.
;~ XL_Start_Get(XL,1) ;store pointer to Excel Application in XL
;~ XL_Start_Get(XL,0) ;store pointer to Excel- start off hidden
XL_Start_Get(ByRef PXL,Vis=1){
Try {
PXL := ComObjActive("Excel.Application") ;handle
PXL.Visible := Vis
}
Catch{
PXL := ComObjCreate("Excel.Application") ;handle
PXL.Visible := Vis ; 1=Visible/Default 0=hidden
}
Return,PXL
}
;***********************Open********************************.
;***********************open excel********************************.
;~ XL_Open(XL,Vis:=1,Try:=1,Path:="B:\Americas.xlsx") ;XL is pointer to workbook, Vis=0 for hidden Try=0 for new Excel
XL_Open(ByRef PXL,vis=1,Try=1,Path=""){
If (Try=1){
Try PXL := ComObjActive("Excel.Application") ;handle
Catch
PXL := ComObjCreate("Excel.Application") ;handle
PXL.Visible := vis ;1=Visible/Default 0=hidden
}Else{
PXL := ComObjCreate("Excel.Application") ;handle
PXL.Visible := vis ;1=Visible/Default 0=hidden
}
PXL:=PXL.Workbooks.Open(path) ;wrb =handle to specific workbook
Return,PXL
}
;***********Detect and opens Tab & Comma delimited, HTML, XML and Excel 2003/2007 with pre-set defaults********************************.
;~ XL_Multi_Opener(XL,FullFileName:="C:\Diet.txt")
;~ XL_Multi_Opener(XL,FullFileName:="C:\Diet.csV")
;~ XL_Multi_Opener(XL,FullFileName:="B:\Custom\My Docs\Files\Joe.htm")
;~ XL_Multi_Opener(XL,FullFileName:="B:\Progs\AutoHotkey_L\TI\Engage\API\Mailings Feb 01, 2013.xlsx")
;~ XL_Multi_Opener(XL,FullFileName:="B:\Progs\AutoHotkey_L\TI\Engage\API\mailing.xml")
XL_Multi_Opener(PXL,FullFileName=""){
Ext := RegExReplace(FullFileName,"(.*)\.(\w{3,4})", "$L2") ;grab Extension and Lowercase it
If (EXT="txt") or (EXT="txt") or (Ext="csv") or (Ext="tab"){
TabD:="False", csvD:="False"
IfEqual,ext,txt, SetEnv, tabD, True ;Sets tabD to 1 if extension is txt
IfEqual,ext,tsv, SetEnv, tabD, True ;Sets tabD to 1 if extension is txt
IfEqual,ext,csv, SetEnv, csvD, True ;Sets csvD to 1 if extension is csv
PXL.Application.Workbooks.OpenText(FullFileName), origin:=65001, StartRow:=1, DataType:=1, TextQualifier:=1, ConsecutiveDelimiter:=False, Tab:=tabD, Semicolon:=False, Comma:=csvD, Space:=False, Other:=False, FieldInfo:=Array(Array(1, 1), Array(2, 1)), TrailingMinusNumbers:=True
} Else if (Ext="xml"){
 PXL.Application.Workbooks.OpenXML(FullFileName, 1, 2) ;.LoadOption.2 ;import xml file
 } Else If (Ext contains xls,htm) {
 PXL.Application.Workbooks.Open(FullFileName) ;Opens Excel 2003,2007 and html
}}
;***********************Save as********************************.
;~ XL_Save(Wrb,File:="C:\try",Format:="2007",WarnOverWrite:=0) ;2007
;~ XL_Save(Wrb,File:="C:\try",Format:="2007",WarnOverWrite:=0) ;2007 format no warn on overwrite
;~ XL_Save(Wrb,File:="C:\try",Format:="CSV",WarnOverWrite:=1) ;CSV format warn on overwrite
;~ XL_Save(Wrb,File:="C:\try",Format:="TAB",WarnOverWrite:=0) ;Tab delimited no warn on overwrite
XL_Save(PXL,File="",Format="2007",WarnOverWrite=0){
PXL.Application.DisplayAlerts := WarnOverWrite ;doesn't ask if I care about overwriting the file
IfEqual,Format,TAB,SetEnv,Format,-4158 ;Tab
IfEqual,Format,CSV,SetEnv,Format,6 ;CSV
IfEqual,Format,2003,SetEnv,Format,56 ;2003 format
IfEqual,Format,2007,SetEnv,Format,51 ;2007 format
PXL.Application.ActiveWorkbook.Saveas(File, Format) ;save it
PXL.Application.DisplayAlerts := true ;Turn back on warnings
}

;***********************Quit********************************.
XL_Quit(ByRef PXL){
PXL.Application.Quit
PXL:=""
}

;***********************MRU*********************************.
;~ XL_Handle(XL,1) ;1=Application 2=Workbook 3=Worksheet
;~ MRU(FileName:="")
XL_MRU(FileName=""){
XL_Handle(XL,1)
XL.RecentFiles.Add(FileName) ;adds file to recently accessed file list
mruList := []
For file in ComObj("Excel.Application").RecentFiles
   if  (A_Index <> 1)
       mruList.Insert(file.name)
mruList.Insert(RegExReplace(Filename,"^[A-Z]:")) ;adds to MRU list
}


;***********only show if hidden*******************
;~ If ! cell.Entirerow.Hidden ;
    ;~ MsgBox % cell.value " is not hidden @ " cell.address(0,0) ;0,0 tells it not to be relative
;~ return

;***********Find autofiltered row*******************
;~ xl.activesheet.autofilter.Range.row

;***********close active workbook*******************
XL_Close_Active_Workbook(){
;~XL.Workbook.Close(1) ;close need pointer to workbook
XL.ActiveWorkbook.Close
}

