LoadURL(URL) {
    ; Browser path used to load urls dependent on computer
    global config_path, PF_x86
    winget, Pname, ProcessName, A 
    Switch Pname
    {
        case "vivaldi.exe": output := GC("vivaldi_path", GC("html_path"))
        case "chrome.exe" : output := GC("chrome_path", GC("html_path"))
        case "msedge.exe" : output := GC("edge_path", GC("html_path"))
        ; case "firefox.exe": output := GC("firefox_path", GC("html_path"))     ; look into firefox url syntax
        default: output := GC("html_path")
    }
    output := !output ? GC("html_path") : output
    Run, %output% %URL%
    return
}