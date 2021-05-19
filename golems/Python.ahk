; PYTHON   
SetTitleMatchMode, 2
#If TabCondition(".py") 
or (WinActive("ahk_exe chrome.exe") && (WinActive("pymc") 
||  WinActive("0_programming")))
