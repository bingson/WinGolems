 LoadURL(URL) {
    ; Browser path used to load urls dependent on computer
    global config_path
    IniRead, output, %config_path%, %A_ComputerName%, chrome_path
    Run, %output% %URL%
    return
 }
 