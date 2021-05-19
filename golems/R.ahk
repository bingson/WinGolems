SetTitleMatchMode, 2
#If WinActive("ahk_exe rstudio.exe") 
|| TabCondition(".r") 
|| (WinActive("ahk_exe chrome.exe") 
&& (WinActive("JupyterLab") 
||  WinActive("1_DAG") 
. )) 


