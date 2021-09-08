
<p align="center"><img src="assets\Screens\WGLc.png" width="300"></p>

WinGolems comprises a collection of AutoHotkey (AHK) functions and interface templates that I have developed over the years to automate and augment my Windows 10 environment. The initial value provided by this repository will come from new users modifying code examples from tutorial templates to alleviate common workflow frictions. WinGolems helps users re-engineer their computer interface so that the most frequently performed operations are the easiest to execute. As they gain more experience working with AHK, users will be able to leverage more of WinGolems' function library to build new capabilities into existing windows applications, creating cognitive artifacts that reduce the effort it takes to transform thought into output. 
<br><br>

Before investing any time into learning AHK, prospective users can try out the tutorial interface layers by [running the precompiled binary](#download)  `WinGolems.exe` included with the source code (no software installation or knowledge of AHK is required). The important keyboard shortcuts from the base (quick start) interface layer are shown below, with additional layers and UI options that can be turned on and off as users familiarize themselves with the new features of each template. 
<br><br>

<p align="center"><img src="assets\Screens\QuickStartHotkeys.png" width = "800">  </p>

<br> 

For convenience, the code for the creation of interface layers is abstracted away (i.e., interface template files) from the code that does most of the heavy lifting (function library files). To modify tutorial interface shortcuts, users will only need to know how to modify template files, which consist mostly of single-line assignment statements that connect hotkeys (i.e., keyboard shortcuts) to WinGolems convenience functions or native AHK commands/functions. 

<br> 

```ahk

; MODIFIER SYMBOL LEGEND
; # = Windows Key
; ! = Alt Key
; ^ = Ctrl Key

#s::       ActivateApp("C:\browser_path")    ; open or reactivate a web browser window with 'win + s' 
^!space::  WinMaximize,A                     ; maximize active window with 'ctrl + alt + spacebar'    

```

<br> 

Beyond adding new keyboard shortcuts, WinGolems also gives users access to the Command Box (CB), a keyboard-driven text-based user interface that was originally conceived to alleviate the following issues:

 * a lack of keyboard real-estate/mental bandwidth for assigning/remembering less frequently used operations (daily vs hourly);
    
    - The CB lets users create meaningful keywords to execute commands, freeing them from having to rely on increasingly obscure and hard to remember keyboard shortcuts.
    
    - The CB can also be used to create interface layers active only when a particular CB is open, letting the user recycle convenient keyboard shortcuts.
 
 * having to repeatedly go back and forth between two application windows to copy and paste multiple sections of text in a specific order;

    - The CB provides text manipulation and file saving functions that allow users to append and prepend text to the clipboard in any order, reducing the need to switch back and forth between windows.
 
 * a limited ability to dynamically pass parameters to a called function using keyboard shortcuts alone.

    - Users can swap in their own command-line processor module to create their own specialized syntax for dynamically parameterizing and calling functions.

<br>

| DISPLAY MODE | MINIMALIST MODE |
| :-: | :-: |
| <img src="assets\Screens\Display.png" width="500"> | <img src="assets\Screens\minimal.png" width="500"> |
<p align="center">
Press ALT + X to switch between modes
</p>

<br>

See [Tutorial Templates](#tutorial-overview) for a more complete list of template shortcuts and Command Box features.

WinGolems is under constant development. I created this repository to give back to the AHK community, as over a 1/3 of WinGolems' code base comes from code adapted from AHK forums and stack overflow posts. It is my hope that others might find this repository useful enough to want to invest some time into improving WinGolems by pushing contributions back through git.  
  
----
## Contents

1. [Getting Started](#getting-started) <br>
    1. [Install Dependencies](#dependencies) <br>
    2. [Download WinGolems](#download) <br>
    3. [Run WinGolems](#run) <br>
    4. [Configure WinGolems](#cfg) <br>
2. [Tutorial Templates](#tutorial-overview) <br>
    1. [Keyboard Shortcuts](#ks) <br>
    2. [Command Box](#cb) <br>
3. [Roadmap](#roadmap)

----

## 1. Getting Started <a name="getting-started"></a>

### I. &nbsp; Install Dependencies <a name="dependencies"></a>
 <ul>
   <li>
     <p>  <b>Required:</b> </p>
     <p>  – &nbsp; Windows 10/11
     <br> – &nbsp; <a href="https://www.AutoHotkey.com/docs/Tutorial.htm#s11">AutoHotkey</a> version 1.1.33.09.
   </li>
   <li>
     <p>  <b>Recommended Editor:</b> </p>
     <p>  A code editor that supports indentation-based code folding and AutoHotkey syntax highlighting.
     <p>  – &nbsp; <a href="https://code.visualstudio.com/">Visual Studio Code</a> editor with the following extension IDs 
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; slevesque.vscode-AutoHotkey
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; helsmy.ahk-simple-ls
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; johnnywong.vscode-ts-whitespace-converter
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; janjoerke.align-by-regex
   </li>
 </ul>
 
 <br>


### II. &nbsp; Download WinGolems <a name="download"></a>

<ul>
   <li>
     <p><b> Option 1: download zip file</b></p>
     <p> Download WinGolems as a zip file from the following url and <a href="https://www.7-zip.org/">unzip</a> to a location of your choosing (e.g., windows user folder). 

```
https://github.com/bingson/WinGolems/archive/refs/heads/master.zip
```

   </li>
   <li>
     <p><b> Option 2: run GIT command </b></p>
     <p>    This option requires the installation of <a href="https://git-scm.com/book/en/v2/Getting-Started-Installing-Git">Git</a> and is recommended if you want to push contributions to the project as well as periodically update your local repo with new versions via git pull. To download this project through git, run the command

``` 
git clone https://github.com/bingson/WinGolems.git 
```

   </li>
</ul>

<br>


### III. &nbsp; Run WinGolems <a name="run"></a>

<ul>
    <p> After downloading and unzipping the WinGolems project folder, navigate to that folder in file explorer and choose one of two options using the right-click context menu.
    <li><b> Option 1: run WinGolems.exe as administrator </b></p>
     This option lets users try out the Quick Start Template without having to install AHK. If any changes are made to the ahk file, the executable must be recompiled, which requires AHK installation.
     <p><img src="assets\Screens\wingolems_exe.png" width="400"></p>

   </li>

   <li>
     <p><b> Option 2: run WinGolems.ahk as administrator </b></p>
     This option requires AHK installation and lets users make changes and run the script immediately without needing to create a compiled executable. 
     <p><img src="assets\Screens\run_master.png" width="400" alt="run_master.png" title="run_master.png" /></p>
   
   </li> 
    <p> Note: By default, UAC protects "elevated" programs (that is, programs which are running as admin) from being automated by non-elevated programs, since that would allow them to bypass security restrictions. Running as    administrator is required for AHK to work on Microsoft application windows (e.g, MS office apps, task manager window). If the user does not have the rights to run programs as administrator, please visit <a href="https://www.autohotkey.com/docs/FAQ.htm#uac"> this link </a> for some workarounds.

</ul>

<br>

### IV. &nbsp; Configure WinGolems <a name="cfg"></a>
<ul>
   If WinGolems does not detect any configuration settings for the current computer, it will prompt the user to create a new system profile. <br><br>
   <p align="center"><img src="assets\Screens\cfg.png" width="500" alt="run_master.png" title="run_master.png" /></p>

   The following applications have been tested with WinGolems:

File type|Application |
|:--|:--|
|Office&nbsp;files | MS Office 2013, 2016, and 2019 (exe filenames don't change)|
|PDF files| Adobe Acrobat Reader DC (**acrord32.exe**), PDF-XChange Editor (**PDFXEdit.exe**)|
|HTML files| MS Edge (**msedge.exe**), Vivaldi (**vivaldi.exe**), Chrome (**chrome.exe**), Firefox (**firefox.exe**)|
|Editor| VS Code (**code.exe**), Notepad++ (**notepad++.exe**), Notepad (**notepad.exe**)|

<br>

To fix/change WinGolems application associations, go to the WinGolems folder and open the <code>config.ini</code> file in a text editor and update the file path values for the following variables.  

<img src="assets\Screens\cfg_manual.png" width="740" alt="cfg_manual.png" title="cfg_manual.png" />
   
</ul>

<br><br>

----
## 2. Tutorial Templates <a name="tutorial-overview"></a> 

<OL>

To help ease new users into the different interface layers, only the Quick Start Template and Command Box interface layers will be active on first run. 

To turn on UI options and other tutorial interface layers, open a CommandBox with `win + enter` or `win + spacebar` and submit one of the following keys. 

|KEY   |WinGolems Option|           
|:-----|:----------------------------------------------------------------------------------------------------|
|<code>tcf</code>   |Toggle mouse cursor follows active window when switching applications                   |     
|<code>tt </code>   |Toggle text manipulation interface layers                                               |     
|<code>tf </code>   |Toggle file management interface layers                                                 |     
|<code>td </code>   |Toggle developer mode (+ trackpoint interface, extra shortcuts)                         |
|<code>lt</code> &#124; <code>lf</code>  |Turn ON&#124;OFF  `Win + L` locks Computer <br>(conflicts with B_text_manipulation.ahk template)|
| | |     

<details><summary>&nbsp;📕&nbsp;<b> Recommended reading </b></summary><p>

Note: If text is highlighted in the default editor app, entering `Qa` in a CB will query and load the corresponding webpage in the AHK documentation, if a match is returned. A search string can also be manually entered into the CB with the colon operator: e.g., `Qa:blind`, `Qa:sendinput`, etc. 

1.  [Hotkeys & Hotstrings](https://www.autohotkey.com/docs/Tutorial.htm#s2)
    * [Keys and their mysterious symbols](https://www.autohotkey.com/docs/Tutorial.htm#s21)
    * [Window specific hotkeys/hotstrings](https://www.autohotkey.com/docs/Tutorial.htm#s22)
    * [Multiple hotkeys/hotstrings per file](https://www.autohotkey.com/docs/Tutorial.htm#s23)
    * [Examples](https://www.autohotkey.com/docs/Tutorial.htm#s24)
2.  [Sending Keystrokes](https://www.autohotkey.com/docs/Tutorial.htm#s3)
3.  [Commands vs. Functions()](https://www.autohotkey.com/docs/Tutorial.htm#s5)
    * [Code blocks](https://www.autohotkey.com/docs/Tutorial.htm#s51)
4.  [Variables](https://www.autohotkey.com/docs/Tutorial.htm#s6)
    * [When to use percents](https://www.autohotkey.com/docs/Tutorial.htm#s61)
    * [Examples](https://www.autohotkey.com/docs/Tutorial.htm#s63)
5.  [Objects](https://www.autohotkey.com/docs/Tutorial.htm#s7)
    * [Creating Objects](https://www.autohotkey.com/docs/Tutorial.htm#s71)
    * [Using Objects](https://www.autohotkey.com/docs/Tutorial.htm#s72)
6.  Misc.
    * [Send commands](https://www.autohotkey.com/docs/commands/Send.htm)
    * [Optimizing the speed of a script](https://www.autohotkey.com/boards/viewtopic.php?f=7&t=6413&sid=a3fa467747d78cedad4ca780b4e08dbb)
    * [Square Brackets Notation (documentation)](https://www.autohotkey.com/docs/Tutorial.htm#s81)
    * [Code Indentation](https://www.autohotkey.com/docs/Tutorial.htm#s84)
    * [Combining Multiple Scripts (#Include)](https://www.autohotkey.com/docs/commands/_Include.htm) 
    * [List of Keys](https://www.autohotkey.com/docs/KeyList.htm)
    * [Send and Retrieve Text using the Clipboard](https://www.autohotkey.com/boards/viewtopic.php?f=6&t=62156)
    * [Comma character and its context, command, sub-expressions](https://www.autohotkey.com/boards/viewtopic.php?f=5&t=1411)
    * [Jeeswg's RegEx tutorial (RegExMatch, RegExReplace)](https://www.autohotkey.com/boards/viewtopic.php?f=7&t=28031)
    * [Libraries of Functions: Standard Library and User Library](https://www.autohotkey.com/docs/Functions.htm#lib)
    * [GoSub command](https://www.autohotkey.com/docs/commands/Gosub.htm)


</p></details>

<details><summary>&nbsp;📕&nbsp;<b> Loading ahk scripts and file structure </b></summary><p>

`WinGolems.ahk` is the master script that controls all others. To change which scripts get loaded by WinGolems modify the following section in `WinGolems.ahk`. You can think of `#Include` as "pasting" the included script's contents at the line where you wrote `#Include`. 

All Tutorial Templates files are located in the `WinGolems\golems` folder. WinGolems function code in located in the `WinGolems\lib` folder as well as the `_functions.ahk` file (in the golems folder).
Although it's possible to run multiple AHK scripts concurrently, it is always better to combine multiple scripts together with include statements and run one script. 

[See: Combining Multiple Scripts (#Include)](https://www.autohotkey.com/docs/commands/_Include.htm)

``` ahk

; LOAD AHK SCRIPTS (GOLEMS) __________________________________________

#Include %A_ScriptDir%\golems\             
#Include _functions.ahk                    ; system files don't modify
#Include _system.ahk                       ;
#Include _CB.ahk                           ;

                                           ; TUTORIAL TEMPLATES
#Include *i A_Quick_Start.ahk              ; base template
#Include *i B_Text_Manipulation.ahk        ; text manipulation template
#Include *i C_File_Management.ahk          ; file management template
#Include *i D_App_Examples.ahk             ; application dependent code examples
#Include *i Test.ahk                       ; test code here

```
</p></details>

<details><summary>&nbsp;📕&nbsp;<b> Creating Command Box keys and Special Commands </b></summary><p>

```ahk 
; CB keys are hotstrings or labels with a unique suffix appended e.g., "~win", "~coding", etc.
; the 'X' option lets a hotstring execute a command/expression instead of sending replacement text   


:X:wg~win::   LoadURL("https://github.com/bingson/wingolems")    ; Load WinGolems GitHub Page
:X:oc~win::   OpenFolder("mem_cache\")                           ; open mem folder in file explorer
:X:kh~win::   KeyHistory                                         ; open key history
:X:ws~win::   WindowSpy()                                        ; open windows spy
:X:ec~win::   EditFile("""" config_path """")                    ; edit config.ini file
:X:tut~win::  loadURL("autohotkey.com/docs/Tutorial.htm")        ; AHK beginner tutorial
:X:tcf~win::  TglCFG("T_CF", "Cursor follows active window: ")   ; toggle cursor follows window
```

```ahk 
; Command keys are just labels executed with a GoSub 
 
RunLabel(UserInput="", suffix = "", tgt_winID ="") {
    suffix := suffix ? suffix : GC("CB_sfx")
    Switch 
    {
        Case IsLabel(        UserInput . suffix): UserInput :=         UserInput . suffix
        Case IsLabel(":X:" . UserInput . suffix): UserInput := ":X:" . UserInput . suffix
        Case IsLabel(":*:" . UserInput . suffix): UserInput := ":*:" . UserInput . suffix
        Case IsLabel(        UserInput . "~win"): UserInput :=         UserInput . "~win"
        Case IsLabel(":X:" . UserInput . "~win"): UserInput := ":X:" . UserInput . "~win"
        Case IsLabel(":*:" . UserInput . "~win"): UserInput := ":*:" . UserInput . "~win"
        Default:
            Gui, 2: destroy
            return
    }     
    ActivateWin("ahk_id " tgt_winID)
    Gosub, %UserInput% 
    Gui, 2: +LastFound
    Gui, 2: destroy
}

```

```ahk 

; Calling Convention: CB( command_suffix, window_color, text_color, ProcessorModule) 
; "ProcessCommand" is a sample command-line processor module that can be replaced 
; with a user created one. See WinGolems\lib\ProcessCommand.ahk for sample code

#enter:: CB("~win",  C.lblue, C.dblue , "ProcessCommand")                   

```

</p></details>

<details><summary>&nbsp;📕&nbsp;<b> Developer mode </b></summary><p>

The developer mode is a hidden interface template found in the _system.ahk file that contains features designed for Lenovo Trackpoint keyboards. In short, the developer mode adds additional shortcuts by transforming  PrintScreen into a modifier key and introduces mouse click functions designed to work with TrackPoint pointing devices.

The developer interface does not make sense for non-TrackPoint keyboard users, leaving free keys that should be reassigned. 

``` ahk
Developer mode keys: #u, #y, #d, ^#d, #i, ^#i, #o, #n, #f, ^#f
```

</p></details>

<br>

### I. &nbsp; Keyboard Shortcuts <a name="ks"></a>

Note: Under WinGolems, the `win` key functions as a modifier key and will not bring up the start menu when pressed alone. The start menu can be accessed with `ctrl + esc`, `win + left click`, or `ctrl + win + enter`



<details><summary>&nbsp;ℹ️&nbsp;<b> (A) Quick Start </b></summary><p>

```
==o====o====o====o====o====o== A_QUICK_START ==o====o====o====o====o====o===
 Win+F2                  Apps: Activate saved window ID
 Win+F4                  Apps: Activate saved window ID
 Win+F5                  Apps: Activate saved window ID
 Win+F6                  Apps: Activate saved window ID
 Win+F7                  Apps: Activate saved window ID
 Win+F1                  Apps: Activate saved window ID
 Win+F8                  Apps: Activate saved window ID
 Win+F3                  Apps: Activate saved window ID
 Ctrl+Alt+F6             Apps: Save window ID
 Ctrl+Alt+F5             Apps: Save window ID
 Ctrl+Alt+F4             Apps: Save window ID
 Ctrl+Alt+F3             Apps: Save window ID
 Ctrl+Alt+F2             Apps: Save window ID
 Ctrl+Alt+F8             Apps: Save window ID
 Ctrl+Alt+F7             Apps: Save window ID
 Ctrl+Alt+F1             Apps: Save window ID
 Win+C                   Apps| Activate Calculator
 Win+T                   Apps| Activate Command window
 Win+Z                   Apps| Activate default editor
 Win+Q                   Apps| Activate Excel
 Win+B                   Apps| Activate File Explorer
 Win+A                   Apps| Activate pdf viewer
 Win+X                   Apps| Activate PowerPoint
 Win+S                   Apps| Activate web browser
 Win+W                   Apps| Activate Word
 Win+Space               CB: opens command box that runs ~win suffix CB keys; enter "?" for help
 Win+Enter               CB: opens command box that runs ~win suffix CB keys; enter "?" for help
 Alt+Backspace           Convenience: delete current line of text
 Win+Sc035               Convenience: google search selected text
 Ctrl+Win+Enter          Convenience: open start menu
 Win+Lbutton             Convenience: open start menu (alt: Ctrl+Esc)
 Rshift & Lshift         Convenience: reload WinGolems
 Lshift & Rshift         Convenience: reload WinGolems (update running script for changes, fixes sticky keys)
 Ctrl+Sc027              Convenience: simulate appkey
 Alt+Sc027               Convenience: simulate esc key (alt + semicolon)
 Win+Esc                 Convenience: toggle all hotkeys ON|OFF except for this one
 Shift+Win+0             Mem: add selected text to the bottom of 0.txt
 Shift+Win+1             Mem: add selected text to the bottom of 1.txt
 Shift+Win+2             Mem: add selected text to the bottom of 2.txt
 Shift+Win+3             Mem: add selected text to the bottom of 3.txt
 Shift+Win+4             Mem: add selected text to the bottom of 4.txt
 Shift+Win+5             Mem: add selected text to the bottom of 5.txt
 Shift+Win+6             Mem: add selected text to the bottom of 6.txt
 Shift+Win+7             Mem: add selected text to the bottom of 7.txt
 Shift+Win+8             Mem: add selected text to the bottom of 8.txt
 Shift+Win+9             Mem: add selected text to the bottom of 9.txt
 Ctrl+Win+Lbutton        Mem: double click and paste contents of 1.txt at cursor position
 Win+Alt+Lbutton         Mem: double click and paste contents of number entered at prompt
 Ctrl+Alt+0              Mem: overwrite 0.txt with selected text
 Ctrl+Alt+1              Mem: overwrite 1.txt with selected text
 Ctrl+Alt+2              Mem: overwrite 2.txt with selected text
 Ctrl+Alt+3              Mem: overwrite 3.txt with selected text
 Ctrl+Alt+4              Mem: overwrite 4.txt with selected text
 Ctrl+Alt+5              Mem: overwrite 5.txt with selected text
 Ctrl+Alt+6              Mem: overwrite 6.txt with selected text
 Ctrl+Alt+7              Mem: overwrite 7.txt with selected text
 Ctrl+Alt+8              Mem: overwrite 8.txt with selected text
 Ctrl+Alt+9              Mem: overwrite 9.txt with selected text
 Win+0                   Mem: paste contents of 0.txt
 Win+1                   Mem: paste contents of 1.txt
 Win+2                   Mem: paste contents of 2.txt
 Win+3                   Mem: paste contents of 3.txt
 Win+4                   Mem: paste contents of 4.txt
 Win+5                   Mem: paste contents of 5.txt
 Win+6                   Mem: paste contents of 6.txt
 Win+7                   Mem: paste contents of 7.txt
 Win+8                   Mem: paste contents of 8.txt
 Win+9                   Mem: paste contents of 9.txt
 Win+Y                   Navigation: Ctrl + end
 Win+U                   Navigation: Ctrl + Home
 Ctrl+Alt+L              Navigation: End
 Ctrl+Alt+H              Navigation: Home
 Win+J                   Navigation: mouse scroll down 2 lines
 Win+K                   Navigation: mouse scroll down 2 lines
 Rightalt+Win+K          Navigation: mouse scroll down 6 lines
 Rightalt+Win+J          Navigation: mouse scroll down 6 lines
 Win+Rightalt+H          Navigation: mouse scroll left
 Win+Rightalt+L          Navigation: mouse scroll right
 Alt+B                   Navigation: navigate to left tab
 Alt+Space               Navigation: navigate to right tab
 Shift+Win+Q             WindowMgmt: close active window
 Alt+Win+Q               WindowMgmt: close all instances of the active program
 Ctrl+Alt+Space          WindowMgmt: maximize window
 Win+Sc028               WindowMgmt: maximize window
 Win+Sc027               WindowMgmt: minimize window
 Alt+Sc034               WindowMgmt: move window btn monitors, cursor follows active windows
 Shift+Win+Capslock      WindowMgmt: rotate through app instances from most recent
 Win+Capslock            WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
 *Alt+Capslock           WindowMgmt: rotate through app instances with thumbnails(+!capslock for other direction)
 Win+Ins                 WindowMgmt: Window always on top: OFF
 Win+Del                 WindowMgmt: Window always on top: ON
 Alt+Win+B               WinSetting: bluetooth settings (reassign less used windows sys shortcuts)
 Alt+Win+D               WinSetting: display settings
 Alt+Win+N               WinSetting: notification window
 Alt+Win+P               WinSetting: presentation display mode
 Alt+Win+R               WinSetting: run program
 Alt+Win+I               WinSetting: windows settings

```

</p></details>


<details><summary>&nbsp;ℹ️&nbsp;<b> (B) Text Manipulation </b></summary><p>

```
==o====o====o====o====o== B_TEXT_MANIPULATION ==o====o====o====o====o====o==

 Alt+Win+Space           Convenience! remove all spaces from selected text
 Alt+Win+Enter           Convenience! remove empty lines starting from selected text
 Ctrl+Win+Space          Convenience! replace multiple consecutive spaces w/ one space in selected text
 Shift+Ctrl+U            Convenience* capitalize selected text
 Shift+Alt+U             Convenience* make selected text to lower case
 Win+Backspace           Convenience: ^backspace (delete word from last character)
 Shift+Capslock          Convenience: backspace (toggle capslock: ctrl + capslock)
 Capslock                Convenience: delete (toggle capslock: ctrl + capslock)
 Ctrl+Alt+D              Convenience: duplicate current line
 Shift+Alt+Sc028         Convenience: enclose selected text with " "
 Rightalt+M              Convenience: enclose selected text with  
 Rightalt+N              Convenience: enclose selected text with % %
 Ctrl+Sc028              Convenience: enclose selected text with ' '
 Shift+Alt+9             Convenience: enclose selected text with ( )
 Alt+Sc029               Convenience: enclose selected text with ` `
 Shift+Alt+Sc029         Convenience: enclose selected text with ``` ```
 Ctrl+Alt+Sc027          Convenience: left bracket
 Ctrl+Alt+Sc028          Convenience: right bracket
 Ctrl+Win+Sc027          Convenience: show desktop
 Ctrl+Capslock           Convenience: toggle capslock
 Ctrl+Alt+Shift+U        Convenience; Every First Letter Capitalized
 Ctrl+Alt+U              Convenience; First letter capitalized
 Ctrl+Win+Backspace      Convenience| Delete and replace selected text with blank spaces
 Ctrl+Win+V              Convenience| Paste and overwrite the same number of spaces (aka. overtype paste)
 Alt+V                   Convenience| replace multiple paragraph breaks w/ 1 break in selected text
 Shift+Alt+V             Convenience| replace multiple paragraph breaks with space (remove paragraphs breaks)
 Alt+Win+J               MouseFn: move mouse cursor to bottom edge
 Ralt & Lalt             MouseFn: move mouse cursor to BOTTOM LEFT of active app
 Lalt & Ralt             MouseFn: move mouse cursor to BOTTOM RIGHT of active app
 Alt+Win+H               MouseFn: move mouse cursor to Left edge
 Alt+Win+L               MouseFn: move mouse cursor to Right edge
 Alt+Win+K               MouseFn: move mouse cursor to top edge
 Ctrl+Alt+J              MouseFn: zoom in
 Ctrl+Alt+K              MouseFn: zoom out
 Win+H                   Navigation: jump to next word; simulate ctrl+Left
 Win+L                   Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
 *Alt+J                  Navigation| Down
 Alt+H                   Navigation| Left
 Alt+L                   Navigation| Right
 *Alt+K                  Navigation| Up
 Shift+Alt+J             Selection: extend selection down  1 row
 Shift+Win+J             Selection: extend selection down  1 row
 Shift+Alt+H             Selection: extend selection Left  1 character
 Shift+Win+H             Selection: extend selection Left  1 word
 Shift+Win+Alt+H         Selection: extend selection Left  2 words
 Shift+Ctrl+Win+H        Selection: extend selection Left  3 words
 Shift+Alt+L             Selection: extend selection Right 1 character
 Shift+Win+L             Selection: extend selection Right 1 word
 Shift+Win+Alt+L         Selection: extend selection Right 2 words
 Shift+Ctrl+Win+L        Selection: extend selection Right 3 words
 Shift+Win+K             Selection: extend selection up    1 row
 Shift+Alt+K             Selection: extend selection up    1 row
 Ctrl+Win+K              Selection: select all above
 Ctrl+Win+J              Selection: select all below
 Shift+Alt+F             Selection: select current line starting from begining of line
 Ctrl+Alt+F              Selection: select line starting from end of line
 Ctrl+Win+H              Selection: select to beginning of line
 Ctrl+Win+L              Selection: select to end of line
 Shift+Ctrl+K            Selection: select to line above
 Shift+Ctrl+J            Selection: select to next line
 Alt+F                   Selection: select word at text cursor position

```

</p></details>

<details><summary>&nbsp;ℹ️&nbsp;<b> (C) File Management </b></summary><p>

```
==o====o====o====o====o== C_FILE_MANAGEMENT ==o====o====o====o====o====o====
 Rightshift+C            ChangeFolder: %Homedrive% (C:)
 Rightshift+U            ChangeFolder: %UserProfile%
 Rightshift+O            ChangeFolder: C:\Program Files
 Rightshift+Alt+O        ChangeFolder: C:\Program Files(x86)
 Rightshift+D            ChangeFolder: Documents
 Rightshift+J            ChangeFolder: Downloads
 Rightshift+M            ChangeFolder: mem_cache
 Rightshift+P            ChangeFolder: Pictures
 Rightshift+R            ChangeFolder: Recycle bin (doesn't work for save as diag)
 Rightshift+T            ChangeFolder: This PC / My Computer
 Rightshift+Sc029        ChangeFolder: WinGolems folder
 Rightctrl+Esc           EditFile: A_QuickStart.ahk
 Rightctrl+F1            EditFile: B_Text_Navigation.ahk
 Rightctrl+F2            EditFile: C_File_Navigation.ahk
 Rightctrl+F3            EditFile: D_App_Dependent.ahk
 Alt+O                   FileExplorer: forward folder
 Ctrl+I                  FileExplorer: group by date
 Ctrl+O                  FileExplorer: group by file type
 Ctrl+U                  FileExplorer: group by name|remove grouping toggle
 Alt+Space               FileExplorer: move focus to current folder pane
 Alt+B                   FileExplorer: move focus to navigation pane
 Alt+I                   FileExplorer: prev folder
 Alt+R                   FileExplorer: rename file
 Leftctrl+K              FileExplorer: sort by date modified
 Leftctrl+J              FileExplorer: sort by name
 Rightctrl+K             FileExplorer: sort by size
 Rightctrl+J             FileExplorer: sort by type
 Alt+Z                   FileExplorer: toggle navigation pane
 Ctrl+P                  FileExplorer: toggle preview plane
 Alt+U                   FileExplorer: up one folder level
 Alt+Sc027               FileExplorer| detailed file info with resized columnsnmn
 Ctrl+S                  FileExplorer| select all files matching regex pattern
 Shift+Alt+C             FileExplorer| store file path(s) of selected file(s) in clipboard
 Ctrl+H                  FileExplorer| toggle hide/unhide invisible files
 Shift+Win+B             FunctionBox: edit file
 Ctrl+Win+B              FunctionBox: open folder
 Rightalt+Esc            OpenFolder: mem_cache (.txt memory folder)
 Rightalt+F2             OpenFolder: WinGolems (.txt memory folder)
 Rightalt+F1             OpenFolder: WinGolems (.txt memory folder)

```

</p></details>

<details><summary>&nbsp;ℹ️&nbsp;<b> Command Box </b></summary><p>

``` 
==o====o====o====o====o====o====o== _CB ==o====o====o====o====o====o====o===
 Alt+S                   CB: move CB window to bottom half
 Shift+Alt+S             CB: move CB window to bottom half small
 Alt+Z                   CB: move CB window to bottom left
 Shift+Alt+Z             CB: move CB window to bottom left small
 Alt+C                   CB: move CB window to bottom right
 Shift+Alt+C             CB: move CB window to bottom right small
 Win+Left                CB: move CB window to left half
 Alt+A                   CB: move CB window to left half
 Shift+Alt+A             CB: move CB window to left side small
 Alt+D                   CB: move CB window to right half
 Win+Right               CB: move CB window to right half
 Shift+Alt+D             CB: move CB window to right side small
 Alt+W                   CB: move CB window to top half
 Shift+Alt+W             CB: move CB window to top half small
 Alt+Q                   CB: move CB window to top left
 Shift+Alt+Q             CB: move CB window to top left small
 Alt+E                   CB: move CB window to top right
 Shift+Alt+E             CB: move CB window to top right small
 Leftctrl+Space          CB| activate already open CB and move focus to inputbox
 Rightctrl+Space         CB| activate already open CB and move focus to inputbox
 Alt+R                   CB| reenter last command
 Alt+Space               CB| submit GUI input
 Win+Space               CB| submit GUI input
 Alt+X                   CB| toggle Command Box display|minimalist mode

```

</p></details>

<details><summary>&nbsp;ℹ️&nbsp;<b> SC Key Reference </b></summary><p>

```
 _______________________________________________________________________________
| SC KEY REFERENCE                                                              |
| ------------------------------------------------------------------------------|
| SC029 ` ~     SC00D = +      SC00C - _                                        |
| SC01A [ {     SC01b ] }      SC02b \ |                                        |
| SC027 ; :     SC028 " '                                                       |
| SC033 , <     SC034 . >      SC035 / ?                                        |
| ______________________________________________________________________________|
```

</p></details>

<br>

### II. &nbsp; Command Box </b><a name="cb"></a>


<details><summary>&nbsp;ℹ️&nbsp;<b>System Commands </b></summary><p>

``` 
 _________________________________________________________________________________________________________________________________________
| CommandBox (CB) CREATION:                           | KEY    WinGolems COMMAND                            | KEY  WINDOWS COMMAND       |
|-----------------------------------------------------|------- ---------------------------------------------|----- ----------------------|
| 1) Create a "win + spacebar" shortcut to open a CB  | ?      load this help cheat sheet                   |  b   Bluetooth             |
|     #space:: CB("~win")                             | tut    AHK Beginner Tutorial                        |  d   Display               |
|                                                     | oc     open memory .txt folder in file explorer     |  n   Notifications         |
| 2) Create a command key "a" to call anyFunction():  | ec     Edit WinGolems config.ini                    |  p   Presentation mode     |
|     :X:a~win:: anyFunction()                        | Ls     see hotkey list (update hotkey list "gl")    |  v   Sound                 |
|                                                     | wg     WinGolems github repository & documentation  |  i   Windows Settings      |
| The above can be adaped to call scripts written in  | ws     Open Window Spy                              |  ap  Add Remove Programs   |
| other languages such as python, VBA, C++, etc ...   | kh     Open Key History (#KeyHistory > 0 required)  |  a   Alarm Clock           |
|                                                     | r~     Reload WinGolems                             |  r   Open Run Dialog Box   |
| CB Keyboard Shortcuts:   ( win: #  alt: !  ctrl: ^ )| q~     Quit WinGolems                               |  x   Start Context Menu    |
|-----------------------------------------------------|                                                     |  s   Start Menu            |
| #Space  open command box or submit key              | KEY    UI OPTIONS: [T]oggle ON|Off                  |  e   desktop environments  |
| !Space  submit key                                  | ------ -------------------------------------------- |  h~  Hybernate computer    |
| ^Space  move focus CB input box                     | tcf    [T] mouse cursor follows active window       |  ce~ Close All Programs    |
| !r      reenter last submitted key                  | tt     [T] text manipulation interface layers       |  rs~ Restart computer      |
| !x      toggle GUI minimal or display mode          | tf     [T] file management interface layers         |  sd~ Shut Down computer    |
| !e      move & resize CB window to top left corner  | td     [T] trackpoint interface layers              |                            |
|                                                     | lt|lf  Turn ON|OFF:  Win + L Locks Computer         |                            |
|_____________________________________________________|_____________________________________________________|____________________________|

```
</p></details>

<details><summary>&nbsp;ℹ️&nbsp;<b>Uppercase first letter initiated commands</b></summary><p>

```
_________________________________________________________________________________________________________________________________________
| KEY  TEXT MANIPULATION & MEMORY SYSTEM       USAGE EXAMPLE       Notes: "__" used to link commands that can be repeated         Format?|
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
| 0-9  Load .txt file 0-9 into CB display      0,1,2,3,4,5,6,7,8,9 shortcut alternative to using L1 to load 1.txt                     0-9|
|  L   Load .txt file into CB display          L1, Lr\testr        Load in display => 1.txt, r\testr.txt ("Ll" .txt list)              L?|
|      Load file shorcut keys                  Lc, Ls, Ll, ?       Load in display => config.ini, hotkey list, .txt file names           |
|  V   Paste .txt file to anchored window      V1, Vsck, Vr\testr  Paste contents of 1.txt, sck.txt, r\testr.txt in last active window V?|
|  C   save a copy or save copy under new name C1, C1 new_name     duplicate names resolved with added number suffix: C1 -> 1_1.txt    C?|
|  O   Overwrite file|clipboard(:) contents    O1, O2 help, O:3    replace => 1.txt w/ selected, 2.txt w/ help.txt, clipboard w/ 3.txt O?|
|  E   Edit file in default editor             E1, Er\testr        edit => 1.txt, test.txt, r\testr.txt (subfolder file path)          E?|
| A|P  Append|Prepend selected text to file    A1, Ar\testr        add selected text to bottom of => 1.txt, r\testr.txt           A or P?|
|  F   Paste same string repeatedly            F-+,4               paste: -+-+ ; fmt: string, # of characters to fill                F?,?|
|  D   Delete file                             D1, D1.txt, D1.ini  file extension optional for .txt files                              D?|
|  R   Replace A with B in selected text       R,~+__A~B           usage example: A,C (input) -> A+C -> B+C             R?~?__?~? or R?~?|
| R?:  Change replacement separators (1|2)     R1:%; R2:~>         Changes the above replacement separators to % and ~>              R?:?|
| Rf:  Modify file w/ saved replace't pattern  Rf:1~p n            modify=> 1.txt w/ pattern in p.txt & save result to n.txt     Rf:?~? ?|
|      pattern file fmt: (no R at beginning)   ,~+__A~B,           all linebreaks will be ignored in patten .txt file            ?~?__?~?|
|________________________________________________________________________________________________________________________________________|
_________________________________________________________________________________________________________________________________________
| KEY  CONVENIENCE                             USAGE EXAMPLE                                                                             |
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
|  Q?   Query selected text in search engine   Qd, Qt, Qw, Qn, Qf  (d)ictionary,(t)hesaurus,(w)ikipedia,(n)ews,(f)inance,(i)mages      Q?|
|  Q?:  Query submitted text                   Qd:facetious        (so)stack overflow,(a)hk documentation,(y)outube,(twt)twitter     Q?:?|
| J|j  SELECT|goto or delete! rows below       J3, J, JJ!, j23     select # of rows below => 3, 10, 20 + delete, 23 + no selection     J?|
| K|k  SELECT|goto or delete! rows above       K3, K, KK!, k23     J|K|j|k = 10 if no numbers or other letters are also entered        K?|
|  G   Run any function                        GMoveWin,TopLeft    fmt: fnName1,fnParams1__fnName2,fnParams2            G?,?__?,? or G?,?|
| G?:  Create G function|parameter alias (f|p) Gf:mw~MoveWin       creates 2 alias => Gmw,tl will behave same as GMoveWin,TopLeft  G?:?~?|
|                                              Gp:tl~TopLeft       list of current aliases in the file ALIAS.ini (see: "Lalias")         |
|________________________________________________________________________________________________________________________________________|
_________________________________________________________________________________________________________________________________________
| KEY  GUI BEHAVIOR & APPEARANCE                                                                                                         |
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
|  W   Run a different CB key suffix           Ws, Wb, Wtut        default suffix: ~win; "Wb" same as entering b in CB("~win")   M|H|B|W?|
|  W:  Change W command suffix reference       W:~win, W:~pdf      M|H|B behave the same as W to allow access to multiple CBs         W:?|
|  T   CommandBox window options               Td, Tm, Tp,         (d)isplay mode, (m)inimalist mode, (p)ersistent: CB stays open,     T?|
|                                              Ta, Tt, Ts, Tw      (a)app stays active, (t)itlebar, (s)crollbar, (w)Text Wrap            |
|  Z   Change text display options             Z11, Zf:courier, Zd change => font size: 11, font: courier, reset to default    Z?:? or Z?|
|________________________________________________________________________________________________________________________________________|

```

</p></details>


</ol>

<br>

----
## 3. Roadmap <a name="roadmap"></a>

Current development priorities:

1. add search box for finding text/highlighting text in the CB display window.
2. save/recall CB GUI profiles by command suffix.
3. show images in CB display window.
----