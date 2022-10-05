#SingleInstance, Force
SetTitleMatchMode, 2

F10::
	MsgBox, % GetURL("Google Chrome")
	return

GetURL(wTitle*) {
	ErrorLevel := 0
	if !(wId := WinExist(wTitle*)) {
		ErrorLevel := 1
		return
	}
	IUIAutomation := ComObjCreate(CLSID_CUIAutomation := "{ff48dba4-60ef-4201-aa87-54103eef594e}", IID_IUIAutomation := "{30cbe57d-d9d0-452a-ab13-7ac5ac4825ee}")
	DllCall(NumGet(NumGet(IUIAutomation+0)+6*A_PtrSize), "ptr", IUIAutomation, "ptr", wId, "ptr*", elementMain)   ; IUIAutomation::ElementFromHandle
	NumPut(addressbarStrPtr := DllCall("oleaut32\SysAllocString", "wstr", "Address and search bar", "ptr"),(VarSetCapacity(addressbar,8+2*A_PtrSize)+NumPut(8,addressbar,0,"short"))*0+&addressbar,8,"ptr")
	DllCall("oleaut32\SysFreeString", "ptr", addressbarStrPtr)
	if (A_PtrSize = 4) {
		DllCall(NumGet(NumGet(IUIAutomation+0)+23*A_PtrSize), "ptr", IUIAutomation, "int", 30005, "int64", NumGet(addressbar, 0, "int64"), "int64", NumGet(addressbar, 8, "int64"), "ptr*", addressbarCondition)   ; IUIAutomation::CreatePropertyCondition
	} else {
		DllCall(NumGet(NumGet(IUIAutomation+0)+23*A_PtrSize), "ptr", IUIAutomation, "int", 30005, "ptr", &addressbar, "ptr*", addressbarCondition)   ; IUIAutomation::CreatePropertyCondition
	}
	DllCall(NumGet(NumGet(elementMain+0)+5*A_PtrSize), "ptr", elementMain, "int", TreeScope_Descendants := 0x4, "ptr", addressbarCondition, "ptr*", currentURLElement) ; IUIAutomationElement::FindFirst
	DllCall(NumGet(NumGet(currentURLElement+0)+10*A_PtrSize),"ptr",currentURLElement,"uint",30045,"ptr",(VarSetCapacity(currentURL,8+2*A_PtrSize)+NumPut(0,currentURL,0,"short")+NumPut(0,currentURL,8,"ptr"))*0+&currentURL) ;IUIAutomationElement::GetCurrentPropertyValue
	ObjRelease(currentURLElement)
	ObjRelease(elementMain)
	ObjRelease(IUIAutomation)
	return StrGet(NumGet(currentURL,8,"ptr"),"utf-16")
}