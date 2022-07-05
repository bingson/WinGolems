# WinGolems

WinGolems, aka Windows Golems, encompasses a collection of AutoHotkey (AHK) functions and interface templates that I have written to automate and augment my Windows 10 environment. The initial value provided by this repository will come from new users modifying code examples from the tutorial templates to alleviate common workflow frictions. WinGolems helps users re-engineer their computer interface to better fit their hardware and ergonomic preferences so that the most frequently performed operations are the easiest to execute. As they gain more experience working with AHK, users will be able to bring to bear more of WinGolems' function library to build new capabilities into existing windows applications, creating cognitive artifacts that reduce the effort it takes to transform thought into output. 
<br>

Before investing any time into learning AHK, prospective users can try out the tutorial interface layers by [running the precompiled binary](#download)  `WinGolems.exe` included with the source code (no software installation or knowledge of AHK is required). The important keyboard shortcuts from the base (quick start) interface layer are shown below, with additional layers and UI options that can be turned on and off as users familiarize themselves with the features of each new interface layer. 
<br><br>

<p align="center"><img src="assets\Screens\QuickStartHotkeys.png" width = "800">  </p>

<br> 

Beyond adding new keyboard shortcuts, WinGolems also gives users access to the Command Box (CB), a keyboard-driven GUI that can execute any script or manipulate any windows application through user-defined functions.

| DISPLAY MODE | MINIMALIST MODE |
| :-: | :-: |
| <img src="assets\Screens\Display.png" width="500"> | <img src="assets\Screens\minimal.png" width="500"> |
<p align="center">
Press ALT + X to switch between modes
</p>

<br>

See [Tutorial Templates](#tutorial-overview) for a more complete list of template shortcuts and Command Box features.

WinGolems is under constant development. I created this repository to give back to the AHK community, as much of WinGolems' code base comes from code adapted from AHK forums, reddit, and stack overflow. It is my hope that others might find this repository useful enough to want to invest some time into improving WinGolems by pushing contributions back through git.  
  
----
## Contents

1. [Getting Started](#getting-started) <br>
    1. [Install Dependencies](#dependencies) <br>
    2. [Download WinGolems](#download) <br>
    3. [Run WinGolems](#run) <br>
    4. [Configure WinGolems](#cfg) <br>
2. [Tutorial Templates](#tutorial-overview) <br>
    1. [Instructions](#instructions) <br>
    2. [Keyboard Shortcuts](#ks) <br>
    3. [Command Box](#cb) <br>
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
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; mark-wiemer.vscode-autohotkey-plus-plus
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
<p> After downloading and unzipping the WinGolems project folder, navigate to that folder in file explorer and run one of two options
<ul>
    
   <li>
    <p><b> WinGolems.exe</b></p>
     This option lets users try out the tutorial templates without having to install AHK. If any changes are made to a WinGolems AHK file, the executable must be recompiled, which requires AHK installation.

   </li>

   <li>
     <p><b> WinGolems.ahk </b></p>
     This option requires AHK installation and lets users make changes and run/reload AHK scripts without needing to compile an executable. 
   
   </li> 
   <br>

</ul>
<p> Note: By default, UAC protects "elevated" programs (that is, programs which are running as admin) from being automated by non-elevated programs, since that would allow them to bypass security restrictions. The ability to run programs with administrator rights is required for WinGolems to work on Microsoft application windows (e.g, MS office apps, task manager window). If the user does not have the rights to run programs as administrator, please visit <a href="https://www.autohotkey.com/docs/FAQ.htm#uac"> this link </a> for some workarounds.

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

### I. Instructions <a name="instructions"></a>

To help ease new users into the different interface layers, only the `Quick Start Template` and Command Box interface layers will be active on first run. Additional templates are placed in the `golems` folder. These sample templates can be added as additional interface layers or be used as a reference for modifying the Quick Start Template.

To see a list of keyboard shortcuts in the `Quick Start Template` open a CommandBox with `win + spacebar` and type `L$` followed by `enter`. 

Note: When text is selected, opening a CB and submitting `Qa` will query and load the corresponding webpage in the [AHK documentation](https://www.autohotkey.com/docs/AutoHotkey.htm). A search string can also be manually entered into the CB with the colon operator: e.g., `Qa:blind`, `Qa:sendinput`, etc. 

<br>

<details><summary>&nbsp;📕&nbsp;<b> Recommended reading </b></summary><p>
1.  [Hotkeys & Hotstrings](https://www.autohotkey.com/docs/Tutorial.htm#s2)
    * [Keys and their mysterious symbols](https://www.autohotkey.com/docs/Tutorial.htm#s21)
    * [Window specific hotkeys/hotstrings](https://www.autohotkey.com/docs/Tutorial.htm#s22)
    * [Multiple hotkeys/hotstrings per file](https://www.autohotkey.com/docs/Tutorial.htm#s23)
    * [Examples](https://www.autohotkey.com/docs/Tutorial.htm#s24)
2.  [Sending Keystrokes](https://www.autohotkey.com/docs/Tutorial.htm#s3)
3.  [Commands vs. Functions()](https://www.autohotkey.com/docs/Tutorial.htm#s5)
    * [Code blocks](https://www.autohotkey.com/docs/Tutorial.htm#s51)
    * [GoSub command](https://www.autohotkey.com/docs/commands/Gosub.htm)
    * [Libraries of Functions: Standard Library and User Library](https://www.autohotkey.com/docs/Functions.htm#lib)
4.  [Variables](https://www.autohotkey.com/docs/Tutorial.htm#s6)
    * [When to use percents](https://www.autohotkey.com/docs/Tutorial.htm#s61)
    * [Examples](https://www.autohotkey.com/docs/Tutorial.htm#s63)
5.  [Objects](https://www.autohotkey.com/docs/Tutorial.htm#s7)
    * [Creating Objects](https://www.autohotkey.com/docs/Tutorial.htm#s71)
    * [Using Objects](https://www.autohotkey.com/docs/Tutorial.htm#s72)
6.  Interface Design
    * [User Interface: A Personal View — Alan Kay (1989)](https://numinous.productions/ttft/assets/Kay1989.pdf)
    * [How can we develop transformative tools for thought? — Matuschak & Nielsen](https://numinous.productions/ttft/) 
    * [Thought as a Technology — Nielsen](http://cognitivemedium.com/tat/index.html)
7.  Misc.
    * [backup windows registry before editing](https://support.microsoft.com/en-us/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692)
    * [disable all built-in Windows hotkeys except Win+L and Win+U](https://www.autohotkey.com/docs/misc/Override.htm) 
    * [disable native MS office shortcut](https://superuser.com/questions/1457073/how-do-i-disable-specific-windows-10-office-keyboard-shortcut-ctrlshiftwinal) 
    * [Send commands](https://www.autohotkey.com/docs/commands/Send.htm)
    * [Optimizing the speed of a script](https://www.autohotkey.com/boards/viewtopic.php?f=7&t=6413&sid=a3fa467747d78cedad4ca780b4e08dbb)
    * [Square Brackets Notation (documentation)](https://www.autohotkey.com/docs/Tutorial.htm#s81)
    * [Code Indentation](https://www.autohotkey.com/docs/Tutorial.htm#s84)
    * [Combining Multiple Scripts (#Include)](https://www.autohotkey.com/docs/commands/_Include.htm) 
    * [List of Keys](https://www.autohotkey.com/docs/KeyList.htm)
    * [Send and Retrieve Text using the Clipboard](https://www.autohotkey.com/boards/viewtopic.php?f=6&t=62156)
    * [Comma character and its context, command, sub-expressions](https://www.autohotkey.com/boards/viewtopic.php?f=5&t=1411)
    * [Jeeswg's RegEx tutorial (RegExMatch, RegExReplace)](https://www.autohotkey.com/boards/viewtopic.php?f=7&t=28031)

<br></p></details>

<details><summary>&nbsp;📕&nbsp;<b> Adding interface layers </b></summary><p><a name="addlayer"></a>

`WinGolems.ahk` is the master script that calls/manages other AHK scripts. To change which scripts get loaded by WinGolems, modify the following section. You can think of `#Include` as "pasting" the included script's contents at the line where you wrote `#Include`. Although it's possible to run multiple AHK scripts concurrently, its better to combine multiple scripts together with include statements for improved stability and reliability. 

[See: Combining Multiple Scripts (#Include)](https://www.autohotkey.com/docs/commands/_Include.htm)

``` ahk

; LOAD AHK SCRIPTS (GOLEMS) __________________________________________

#Include %A_ScriptDir%\golems\             
#Include _functions.ahk                    ; system files 
#Include _system.ahk                       ; modify with caution
#Include _CB.ahk                           ; command box

                                           ; TUTORIAL TEMPLATES
#Include *i Quick_Start.ahk                ; base template
#Include *i 1_Apps_Misc.ahk                ; advanced base template
#Include *i 2_Text_Manipulation.ahk        ; text manipulation template
#Include *i 3_File_Management.ahk          ; file management template
#Include *i 4_App_Examples.ahk             ; context (app) dependent code examples
```
<br></p></details>

<details><summary>&nbsp;📕&nbsp;<b> File structure </b></summary><p>

A core component of good code is readability. For this reason, the code for the creation of interface layers is separated (i.e., interface template files) from the code that executes the underlying task (function library files). To build their own interfaces, users will only need to know how to modify the tutorial template files, which consist mainly of single-line assignment statements that connect hotkeys to WinGolems functions or native AHK commands/functions. 
<br> 

```ahk

; MODIFIER SYMBOL LEGEND
; # = Windows Key
; ! = Alt Key
; ^ = Ctrl Key

#s::      ActivateApp("C:\browser_path")  ; open or reactivate a web browser window with 'win + s' 
^!space:: WinMaximize,A                   ; maximize active window with 'ctrl + alt + spacebar'    

```

- All tutorial template files are located in the `WinGolems\golems` folder. 
- Functions are located in the `WinGolems\lib` folder as well as the `_functions.ahk` file. 
- Memory system files are located in the `WinGolems\mem_cache` folder

<br>

```
WinGolems
  ├── WinGolems.ahk
  ├── WinGolems.exe               
  ├── config.ini                    ; computer specific settings
  ├── HotKey_List.txt               ; last generated list of hotkeys
  ├── Readme.md
  |
  ├──golems 
  |   ├── _functions.ahk            ; function library
  |   ├── _CB.ahk                   ; command box interface)
  |   ├── _system.ahk               ; system related CB keys)
  |   ├── A_Quick_Start.ahk         ┐                                                              
  |   ├── B_Text_Manipulation.ahk   ├─ tutorial template files
  |   ├── C_File_Management.ahk     |  and sample code                                            
  |   └── D_App_Examples.ahk        ┘                                            
  |
  ├──lib                            ; function library
  |   ├── CommandBox.ahk            ; command box GUI code
  |   ├── ProcessCommand.ahk        ; example command processing module 
  |   └── large WinGolems functions 
  |       and third party functions
  |
  ├──mem_cache
  |   └── all text files related to memory system (including 0.txt to 9.txt)
  |
  └──assets
      └── all non ahk files         ;icons, tutorial screenshots, etc.
```

<br></p></details>

<details><summary>&nbsp;📕&nbsp;<b> Creating CB keys and special commands </b></summary><p>

```ahk 
; CB keys are hotstrings or labels with a unique suffix appended e.g., "~win", "~coding", etc.
; 'X' option lets a hotstring execute a command/expression instead of sending text


:X:wg~win::   LURL("https://github.com/bingson/wingolems")   ; Load WinGolems GitHub Page
:X:tut~win::  LURL("autohotkey.com/docs/Tutorial.htm")       ; Load AHK beginner tutorial
:X:oc~win::   OpenFolder("mem_cache\")                       ; open mem_cache folder
:X:kh~win::   KeyHistory                                     ; open key history
:X:ws~win::   WindowSpy()                                    ; open windows spy
:X:ec~win::   EditFile(config_path)                          ; edit config.ini file
:X:tcf~win::  TC("T_CF", "Cursor follows active window: ")   ; toggle cursor follows window
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
Note: that the base ~win label suffix will be checked if no valid `GoSub` label found with a user-defined CB suffix.

<br></p></details>

<br>


### II. &nbsp; Sample Keyboard Shortcuts <a name="ks"></a>

Below is a snap shot (as of 30 Sept 2021) of WinGolems keyboard shortcuts and command box features. As the tutorial templates are a component of my own Windows setup, changes are constantly being made. Once WinGolems is installed, enter `L$$` in a command box to generate an updated list of hotkeys.

Note: under WinGolems, the `win` key functions as a modifier key and will not bring up the start menu when pressed. The start menu can be accessed with `ctrl + esc` or `win + left click`.

To toggle all hotkeys off and on: `esc + delete` (only hotkey active in off mode).

<details><summary>&nbsp;ℹ️&nbsp;<b> Quick Start </b></summary><p>

```
==o====o====o====o====o====o== A_QUICK_START ==o====o====o====o====o====o===
 Win+F1                  Apps: Activate saved F1 window
 Win+F2                  Apps: Activate saved F2 window
 Win+F3                  Apps: Activate saved F3 window
 Win+F4                  Apps: Activate saved F4 window
 Win+F5                  Apps: Activate saved F5 window
 Win+F6                  Apps: Activate saved F6 window
 Win+F7                  Apps: Activate saved F7 window
 Win+F8                  Apps: Activate saved F8 window
 Ctrl+Alt+F1             Apps: Save window for win+F1 activation
 Ctrl+Alt+F2             Apps: Save window for win+F2 activation
 Ctrl+Alt+F3             Apps: Save window for win+F3 activation
 Ctrl+Alt+F4             Apps: Save window for win+F4 activation
 Ctrl+Alt+F5             Apps: Save window for win+F5 activation
 Ctrl+Alt+F6             Apps: Save window for win+F6 activation
 Ctrl+Alt+F7             Apps: Save window for win+F7 activation
 Ctrl+Alt+F8             Apps: Save window for win+F8 activation
 Win+C                   Apps| Activate Calculator
 Win+T                   Apps| Activate Command window
 Win+Z                   Apps| Activate default editor
 Win+Q                   Apps| Activate Excel
 Win+B                   Apps| Activate File Explorer
 Win+A                   Apps| Activate pdf viewer
 Win+X                   Apps| Activate PowerPoint
 Win+S                   Apps| Activate web browser
 Win+W                   Apps| Activate Word
 Alt+Backspace           Convenience: delete current line of text
 Win+Sc035               Convenience: google search selected text
 Shift+Win+0             Mem: add selected text to the bottom of 0.txt
 Ctrl+Win+0              Mem: add selected text to the bottom of 0.txt with breaks removed
 Alt+Win+0               Mem: add selected text to the bottom of 0.txt with leading spaces removed
 Shift+Win+1             Mem: add selected text to the bottom of 1.txt
 Ctrl+Win+1              Mem: add selected text to the bottom of 1.txt with breaks removed
 Alt+Win+1               Mem: add selected text to the bottom of 1.txt with leading spaces removed
 Shift+Win+2             Mem: add selected text to the bottom of 2.txt
 Ctrl+Win+2              Mem: add selected text to the bottom of 2.txt with breaks removed
 Alt+Win+2               Mem: add selected text to the bottom of 2.txt with leading spaces removed
 Shift+Win+3             Mem: add selected text to the bottom of 3.txt
 Ctrl+Win+3              Mem: add selected text to the bottom of 3.txt with breaks removed
 Alt+Win+3               Mem: add selected text to the bottom of 3.txt with leading spaces removed
 Shift+Win+4             Mem: add selected text to the bottom of 4.txt
 Ctrl+Win+4              Mem: add selected text to the bottom of 4.txt with breaks removed
 Alt+Win+4               Mem: add selected text to the bottom of 4.txt with leading spaces removed
 Shift+Win+5             Mem: add selected text to the bottom of 5.txt
 Ctrl+Win+5              Mem: add selected text to the bottom of 5.txt with breaks removed
 Alt+Win+5               Mem: add selected text to the bottom of 5.txt with leading spaces removed
 Shift+Win+6             Mem: add selected text to the bottom of 6.txt
 Ctrl+Win+6              Mem: add selected text to the bottom of 6.txt with breaks removed
 Alt+Win+6               Mem: add selected text to the bottom of 6.txt with leading spaces removed
 Shift+Win+7             Mem: add selected text to the bottom of 7.txt
 Ctrl+Win+7              Mem: add selected text to the bottom of 7.txt with breaks removed
 Alt+Win+7               Mem: add selected text to the bottom of 7.txt with leading spaces removed
 Shift+Win+8             Mem: add selected text to the bottom of 8.txt
 Ctrl+Win+8              Mem: add selected text to the bottom of 8.txt with breaks removed
 Alt+Win+8               Mem: add selected text to the bottom of 8.txt with leading spaces removed
 Shift+Win+9             Mem: add selected text to the bottom of 9.txt
 Ctrl+Win+9              Mem: add selected text to the bottom of 9.txt with breaks removed
 Alt+Win+9               Mem: add selected text to the bottom of 9.txt with leading spaces removed
 Leftctrl+Mbutton        Mem: double click and paste contents of 0.txt at cursor position
 Shift+Leftctrl+Mbutton  Mem: double click and paste contents of number entered at prompt
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
 Ctrl+Alt+L              Navigation: End
 Ctrl+Alt+H              Navigation: Home
 Win+K                   Navigation: mouse scroll down 2 lines
 Win+J                   Navigation: mouse scroll down 2 lines
 Rightalt+Win+J          Navigation: mouse scroll down 6 lines
 Rightalt+Win+K          Navigation: mouse scroll down 6 lines
 Win+Rightalt+H          Navigation: mouse scroll left
 Win+Rightalt+L          Navigation: mouse scroll right
 Rightctrl+B             Navigation: navigate to left tab
 Alt+B                   Navigation: navigate to left tab
 Alt+Space               Navigation: navigate to right tab
 Rightctrl+Space         Navigation: navigate to right tab
 Rightshift+Rightalt+O   VirtualDesktop: Move active Window to other desktop (between desktops 1 and 2)
 Rightalt+Enter          VirtualDesktop: Switch between desktop 1 and 2
 Rightalt+Sc028          VirtualDesktop: Switch to desktop 1
 Ctrl+Win+Q              WindowMgmt: close active window
 Shift+Win+Q             WindowMgmt: close active window
 Alt+Win+Q               WindowMgmt: close all instances of the active program
 Win+Sc028               WindowMgmt: maximize window
 Ctrl+Alt+Space          WindowMgmt: maximize window
 Win+Sc027               WindowMgmt: minimize window
 Ralt & Sc034            WindowMgmt: move window btn monitors, cursor follows active windows
 Shift+Win+Capslock      WindowMgmt: rotate through app instances from most recent
 Win+Capslock            WindowMgmt: rotate through app instances from oldest (no thumbnail previews)
 Ctrl+Win+Sc027          WindowMgmt: show desktop
 Win+Ins                 WindowMgmt: Window always on top: OFF
 Win+Del                 WindowMgmt: Window always on top: ON
 Win+Esc                 WinGolems: reload WinGolems
 Esc & Del               WinGolems: toggle all hotkeys ON|OFF except for this one
 Ctrl+Win+Enter          WinOS: open start menu
 Win+Lbutton             WinOS: open start menu (alt: Ctrl+Esc)
 Ctrl+Sc027              WinOS: simulate appkey
 Alt+Sc027               WinOS: simulate esc key (alt + semicolon)
 Alt+Win+B               WinSetting: bluetooth settings (reassign less used windows sys shortcuts)
 Alt+Win+D               WinSetting: display settings
 Alt+Win+N               WinSetting: notification window
 Alt+Win+P               WinSetting: presentation display mode
 Alt+Win+R               WinSetting: run program
 Alt+Win+I               WinSetting: windows settings
```

</p></details>

<details><summary>&nbsp;ℹ️&nbsp;<b> Text Manipulation </b></summary><p>

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
 Leftalt+Rightshift+4    Convenience: enclose selected text with $ $
 Rightalt+Leftshift+4    Convenience: enclose selected text with $ $
 Leftalt+Rightshift+5    Convenience: enclose selected text with % %
 Rightalt+Leftshift+5    Convenience: enclose selected text with % %
 Shift+Ctrl+Sc028        Convenience: enclose selected text with ' '
 Shift+Alt+9             Convenience: enclose selected text with ( )
 Alt+Sc029               Convenience: enclose selected text with ` `
 Shift+Alt+Sc029         Convenience: enclose selected text with ``` ```
 Ctrl+Alt+Sc027          Convenience: left bracket
 Ctrl+Alt+Sc028          Convenience: right bracket
 Ctrl+Capslock           Convenience: toggle capslock
 Ctrl+Alt+Shift+U        Convenience; Every First Letter Capitalized
 Ctrl+Alt+U              Convenience; First letter capitalized
 Ctrl+Win+Backspace      Convenience| Delete and replace selected text with blank spaces
 Ctrl+Win+V              Convenience| Paste and overwrite the same number of spaces (aka. overtype paste)
 Alt+V                   Convenience| replace multiple paragraph breaks w/ 1 break in selected text
 Shift+Alt+V             Convenience| replace multiple paragraph breaks with space (remove paragraphs breaks)
 Win+F                   MouseFn: 2 Left clicks (select word)
 Ctrl+Win+F              MouseFn: 3 Left clicks (select line)
 Shift+Leftalt+Mbutton   MouseFn: click thrice, paste clipboard
 Leftalt+Mbutton         MouseFn: click twice, paste clipboard
 Alt+Win+D               MouseFn: erase saved curor position
 Alt+Win+I               MouseFn: erase saved curor position
 Ctrl+Win+I              MouseFn: Left click and save mouse position
 Alt+Win+J               MouseFn: move mouse cursor to bottom edge
 Alt+Win+H               MouseFn: move mouse cursor to Left edge
 Alt+Win+L               MouseFn: move mouse cursor to Right edge
 Alt+Win+K               MouseFn: move mouse cursor to top edge
 Win+D                   MouseFn: return to saved mouse position and click (left click if no saved position found)
 Win+I                   MouseFn: return to saved mouse position and click (left click if no saved position found)
 Ctrl+Alt+J              MouseFn: zoom in
 Ctrl+Alt+K              MouseFn: zoom out
 Ctrl+Win+D              MouseFn:f Left click and save mouse position
 Win+Shift+E             Navigation: ^end
 Win+E                   Navigation: ^home
 Win+H                   Navigation: jump to next word; simulate ctrl+Left
 Win+L                   Navigation: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
 Alt+K                   Navigation| Down
 Alt+H                   Navigation| Left
 Alt+L                   Navigation| Right
 Alt+J                   Navigation| Up
 Shift+Alt+J             Selection: extend selection down  1 row
 Shift+Win+J             Selection: extend selection down  1 row
 Shift+Alt+H             Selection: extend selection Left  1 character
 Shift+Win+H             Selection: extend selection Left  1 word
 Shift+Ctrl+H            Selection: extend selection Left  1 word
 Shift+Win+Alt+H         Selection: extend selection Left  2 words
 Shift+Ctrl+Win+H        Selection: extend selection Left  3 words
 Shift+Alt+L             Selection: extend selection Right 1 character
 Shift+Ctrl+L            Selection: extend selection Right 1 word
 Shift+Win+L             Selection: extend selection Right 1 word
 Shift+Win+Alt+L         Selection: extend selection Right 2 words
 Shift+Ctrl+Win+L        Selection: extend selection Right 3 words
 Shift+Alt+K             Selection: extend selection up    1 row
 Shift+Win+K             Selection: extend selection up    1 row
 Ctrl+Win+K              Selection: select all above
 Ctrl+Win+J              Selection: select all below
 Shift+Alt+F             Selection: select current line starting from begining of line
 Ctrl+Alt+F              Selection: select line starting from end of line
 Ctrl+Win+H              Selection: select to beginning of line (press win before ctrl)
 Ctrl+Win+L              Selection: select to end of line (press win before ctrl)
 Shift+Ctrl+K            Selection: select to line above
 Shift+Ctrl+J            Selection: select to next line
 Leftalt+F               Selection: select word at text cursor position
```

</p></details>

<details><summary>&nbsp;ℹ️&nbsp;<b> File Management </b></summary><p>

```
==o====o====o====o====o== C_FILE_MANAGEMENT ==o====o====o====o====o====o====
 Rightshift+C            ChangeFolder: %Homedrive% (C:)
 Rightshift+U            ChangeFolder: %UserProfile%
 Rightshift+O            ChangeFolder: C:\Program Files
 Rightalt+O              ChangeFolder: C:\Program Files(x86)
 Rightshift+D            ChangeFolder: Documents
 Rightshift+J            ChangeFolder: Downloads
 Rightshift+M            ChangeFolder: mem_cache
 Rightshift+P            ChangeFolder: Pictures
 Rightshift+R            ChangeFolder: Recycle bin (doesn't work for save as diag)
 Rightshift+T            ChangeFolder: This PC / My Computer
 Rightshift+Sc029        ChangeFolder: WinGolems folder
 Win+Sc034               FB: Opens Jump Menu for opening saved paths to files, folders, URLs (works in save dialogue windows)
 Alt+O                   FileExplorer: forward folder
 Ctrl+Y                  FileExplorer: group by date created
 Ctrl+I                  FileExplorer: group by date modified
 Ctrl+O                  FileExplorer: group by file type
 Ctrl+U                  FileExplorer: group by name|remove grouping toggle
 Alt+E                   FileExplorer: move focus to current folder pane
 Alt+W                   FileExplorer: move focus to navigation pane
 Alt+I                   FileExplorer: prev folder
 Alt+R                   FileExplorer: rename file
 Ctrl+K                  FileExplorer: sort by date modified
 Ctrl+J                  FileExplorer: sort by name
 Ctrl+H                  FileExplorer: sort by size
 Ctrl+L                  FileExplorer: sort by type
 Alt+Z                   FileExplorer: toggle navigation plane
 Ctrl+P                  FileExplorer: toggle preview plane
 Alt+U                   FileExplorer: up one folder level
 Shift+Rightctrl+Esc     FileExplorer; file|folder save E_path
 Shift+Rightctrl+F1      FileExplorer; file|folder save F1_path
 Shift+Rightctrl+F2      FileExplorer; file|folder save F2_path
 Shift+Rightctrl+F3      FileExplorer; file|folder save F3_path
 Shift+Rightctrl+F4      FileExplorer; file|folder save F4_path
 Shift+Rightctrl+F5      FileExplorer; file|folder save F5_path
 Shift+Rightctrl+F6      FileExplorer; file|folder save F6_path
 Shift+Rightctrl+F7      FileExplorer; file|folder save F7_path
 Shift+Rightctrl+F8      FileExplorer; file|folder save F8_path
 Shift+Rightctrl+F9      FileExplorer; file|folder save F9_path
 Alt+Sc027               FileExplorer| detailed file info with resized columnsnmn
 Alt+S                   FileExplorer| select all files matching regex pattern
 Shift+Alt+C             FileExplorer| store file path(s) of selected file(s) in clipboard
 Ctrl+Alt+L              Navigation: End
 Ctrl+Alt+H              Navigation: Home
 Alt+K                   Navigation| Down
 Alt+J                   Navigation| Up
 Rightctrl+Esc           OpenPath: open saved file|folder path from +^esc
 Rightctrl+F1            OpenPath: open saved file|folder path from +^F1
 Rightctrl+F2            OpenPath: open saved file|folder path from +^F2
 Rightctrl+F3            OpenPath: open saved file|folder path from +^F3
 Rightctrl+F4            OpenPath: open saved file|folder path from +^F4
 Rightctrl+F5            OpenPath: open saved file|folder path from +^F5
 Rightctrl+F6            OpenPath: open saved file|folder path from +^F6
 Rightctrl+F7            OpenPath: open saved file|folder path from +^F7
 Rightctrl+F8            OpenPath: open saved file|folder path from +^F8
 Rightctrl+F9            OpenPath: open saved file|folder path from +^F9
```

</p></details>

<details><summary>&nbsp;ℹ️&nbsp;<b> Command Box </b></summary><p>

```
==o====o====o====o====o====o====o== _CB ==o====o====o====o====o====o====o===
 Lwin & Enter            CB. (V command) selects word at cursor position and replaces it with \mem_cache .txt file with the same name (e.g., 1 = 1.txt).
 Win+Space               CB. opens command box that runs ~win suffix CB keys; enter "?" for help
 Lshift & Enter          CB. selects word at text cursor position and run as CB "~win" key
 Ctrl+Alt+K              CB: Font size decrease
 Ctrl+Alt+J              CB: Font size increase
 Alt+N                   CB: highlight next match of text in the CB display window with text entered in the input box
 Shift+Alt+N             CB: highlight previous match of text in the CB display window with text entered in the input box
 Alt+S                   CB: move CB window to bottom half
 Shift+Alt+S             CB: move CB window to bottom half small
 Alt+Z                   CB: move CB window to bottom left
 Rightshift+Alt+Z        CB: move CB window to bottom left small (landscape)
 Shift+Rightalt+Z        CB: move CB window to bottom left small (landscape)
 Shift+Alt+Z             CB: move CB window to bottom left small (portrait)
 Alt+C                   CB: move CB window to bottom right
 Shift+Rightalt+C        CB: move CB window to bottom right small (landscape)
 Rightshift+Alt+C        CB: move CB window to bottom right small (landscape)
 Shift+Alt+C             CB: move CB window to bottom right small (portrait)
 Alt+A                   CB: move CB window to left half
 Win+Left                CB: move CB window to left half
 Shift+Alt+A             CB: move CB window to left side small
 Alt+D                   CB: move CB window to right half
 Win+Right               CB: move CB window to right half
 Shift+Alt+D             CB: move CB window to right side small
 Alt+W                   CB: move CB window to top half
 Shift+Alt+W             CB: move CB window to top half small
 Alt+Q                   CB: move CB window to top left
 Shift+Rightalt+Q        CB: move CB window to top left small (landscape)
 Rightshift+Alt+Q        CB: move CB window to top left small (landscape)
 Shift+Alt+Q             CB: move CB window to top left small (portrait)
 Alt+E                   CB: move CB window to top right
 Rightshift+Alt+E        CB: move CB window to top right small (landscape)
 Shift+Rightalt+E        CB: move CB window to top right small (landscape)
 Shift+Alt+E             CB: move CB window to top right small (portrait)
 Leftctrl+Space          CB| activate already open Command Box and move focus to inputbox
 Rightctrl+Space         CB| activate already open Command Box and move focus to inputbox
 Rightalt+Space          CB| Capitalize first letter of user input and submit GUI
 Alt+R                   CB| reenter last command
 Leftalt+Space           CB| submit GUI input
 Win+Space               CB| submit GUI input
 Alt+X                   CB| toggle Command Box display|minimalist mode
 Alt+B                   CB| toggle Command Box display|minimalist mode
 Leftctrl+Space          FB: activate already open Function Box and move focus to inputbox
 Rightctrl+Space         FB: activate already open Function Box and move focus to inputbox
```

</p></details>

<details><summary>&nbsp;ℹ️&nbsp;<b> SC key & Symbol Reference </b></summary><p>

```
 _______________________________________________________________________________
| SC KEYS                            | SYMBOLS                                  |
| -----------------------------------|------------------------------------------|
| SC029 ` ~   SC00D = +   SC00C - _  | # win        <# lwin        ># rwin      |
| SC01A [ {   SC01b ] }   SC02b \ |  | ! alt        <! lalt        >! ralt      |
| SC027 ; :   SC028 " '              | ^ ctrl       <^ lctrl       >^ rctrl     |
| SC033 , <   SC034 . >   SC035 / ?  | + shift      <+ lshift      >+ rshift    |
| ___________________________________|__________________________________________|

An ampersand (&) between two keys or mouse buttons combines them to create a custom hotkey.
```

</p></details>

<br>

### III. &nbsp; Command Box </b><a name="cb"></a>
The Command Box (CB) is a GUI that can execute any script. Where applicable, the CB operates on the last active application window (target application.exe).

<p align="center"><img src="assets\Screens\CB_header.png" width="600"></p>

<b>The Command Box (CB) was conceived to alleviate the following problems:</b>

<br>

 > A lack of keyboard real-estate and mental bandwidth for assigning and remembering less frequently used operations.
    
 With the CB users can

- create meaningful keywords to execute commands, freeing them from having to rely on increasingly obscure and hard to remember hotkey combinations.
    
- create interface layers active only when a particular CB is open.

- execute commands in any text field of any windows application without needing to call the GUI (i.e., pseudo command-line interface).

<br>
 
> Having to go back and forth repeatedly between two application windows to copy and paste sections of text in a particular order.

With the CB users can

- use WinGolems text manipulation and file saving functions that allow users to prepend or append text to the clipboard through txt file functions and hotkeys.

- view, modify, and paste contents of .txt files (e.g., code snippets, regex patterns, frequently typed text) into any windows application through named txt files (aka., memory slots).

<br>
 
> A limited ability to dynamically pass parameters to a called function using keyboard shortcuts alone.

With the CB users can

- swap in their own command-line processor module to create their own specialized syntax for dynamically parameterizing called functions written in any language.

- create parameter text files that can be passed to user-defined functions.

<br>

<details><summary>&nbsp;ℹ️&nbsp;<b>Command Keys</b></summary><p>

``` 
_________________________________________________________________________________________________________________________________________
| CommandBox (CB) CREATION:                           | KEY    WinGolems COMMAND ([T]oggle, [M]ode change ) | KEY  WINDOWS COMMAND       |
|-----------------------------------------------------|------- ---------------------------------------------|----- ----------------------|
| 1) Create a "win + spacebar" shortcut to open a CB  | ?      load this help cheat sheet                   |  b   Bluetooth             |
|     lwin & space:: CB("~win")                       | tut    AHK Beginner Tutorial                        |  d   Display               |
|                                                     | oc     open memory .txt folder in file explorer     |  n   Notifications         |
| 2) Create a command key "a" to call any function:   | ec     Edit WinGolems config.ini                    |  p   Presentation mode     |
|     :X:a~win:: anyFunction()                        | LK     see keyboard shortcut list; update list "gl" |  v   Sound                 |
|                                                     | wg     WinGolems github repository & documentation  |  i   Windows Settings      |
| The above can be adaped to call scripts written in  | ws     Open Window Spy                              |  ap  Add Remove Programs   |
| other languages such as python, VBA, C++, etc ...   | kh     Open Key History (#KeyHistory > 0 required)  |  a   Alarm Clock           |
|                                                     | r~     Reload WinGolems                             |  r   Open Run Dialog Box   |
| CB Keyboard Shortcuts:   ( win: #  alt: !  ctrl: ^ )| q~     Quit WinGolems                               |  x   Start Context Menu    |
|-----------------------------------------------------|                                                     |  s   Start Menu            |
| #Space      open command box or submit key          | KEY    UI OPTIONS: [T]oggle ON|Off                  |  t   System tray           |
| <!Space     submit key (left alt: <! right alt: >!) | ------ -------------------------------------------- |  tm  Sask manager          |
| >!Space     capitalize 1st letter and submit key    | tcf    [T] mouse cursor follows active window       |  h~  Hibernate computer    |
| ^Space      move to CB input box from another app   | lt|lf  Turn ON|OFF:  Win + L Locks Computer         |  ce~ Close All Programs    |
| !r          reenter last submitted CB key           | ts     [T] auto-selection after win+enter commands  |  rs~ Restart computer      |
| !b          toggle GUI minimal or display mode      |                                                     |  sd~ Shut Down computer    |
| !q !e !a !d move & resize CB window to 4 quadrants  |                                                     |                            |
| !n          find text in CB display (+!n: prev)     |                                                     |                            |
|_____________________________________________________|_____________________________________________________|____________________________|
```

</p></details>

<details><summary>&nbsp;ℹ️&nbsp;<b>Uppercase 1st letter initiated functions</b></summary><p>

```
__________________________________________________________________________________________________________________________________________
| Uppercase 1st letters trigger the following functions            >  = windows clipboard contents                                       |
| remaining characters are case insensitive                        ,  = separate usage examples (except for G examples)                  |
|                                                                  __ = chains commands that can be repeated                    reference|
| KEY  CONVENIENCE                             USAGE EXAMPLE                                                                      Format?|
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
|  R   Replace A with B in selected text       R,~+__A~B           usage example: A,C (input) -> A+C -> B+C             R?~?__?~? or R?~?|
| R?:  Change replacement separators (1|2)     R1~:%; R2~:~:       Changes replacement separators to % and ~: from ~ and __         R?~:?|
| S?   Query selected text in search engine    Sd, St, Sw, Sn, Sf  (d)ictionary,(t)hesaurus,(w)ikipedia,(n)ews,(f)inance,(i)mages      S?|
| S?:  Query submitted text                    Sd:facetious        (so)stack overflow,(a)hk documentation,(y)outube,(twt)twitter     S?:?|
| J|j  SELECT|goto or delete! rows below       J3, J, JJ!, j23     select # of rows below => 3, 10, 20 + delete, 23 + no selection     J?|
| K|k  SELECT|goto or delete! rows above       K3, K, KK!, k23     J|K|j|k = 10 if no numbers or other letters are also entered        K?|
|  G   Run any function                        GMoveWin,TopLeft    format: fnName1,fnParams1__fnName2,fnParams2         G?,?__?,? or G?,?|
| G?:  Create G function|parameter alias (f|p) Gf:mw~MoveWin       creates 2 alias => Gmw,tl will behave same as GMoveWin,TopLeft  G?:?~?|
|                                              Gp:tl~TopLeft       list of current aliases in the file ALIAS.ini (see: "Lalias")         |
|________________________________________________________________________________________________________________________________________|

__________________________________________________________________________________________________________________________________________
| KEY  CLIPBOARD TEXT MANAGER & MEMORY SYSTEM                      note: if multiple files in a command, output file is last in order    |
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
|  L   Load .txt file into CB display          L1, Lr\testr, L>    Load: 1.txt, r\testr.txt ("Ll" .txt list), clipboard                L?|
|      L?: shortcuts for useful information    LC, LK, LL, L#      Load: (C)onfig.ini, Hot(K)ey list, (L)ist of mem folder files         |
|      L#? or LI?: 1st lines of a-z or #.txt   L#4, LI, LI2        (#) 1st line of #.txt files (#4: 1st 4 lines), (I) #.txt + A-Z.txt    |
| 0-9  Load .txt file 0-9 into CB display      0,1,2,3,4,5,6,7,8,9 shortcut alternative to using L1 to load 1.txt                     0-9|
|  V   Paste .txt file to anchored window      V1, Vsck, V         Paste contents of 1.txt, sck.txt, current file in CB display        V?|
|  C   save a copy or save copy under new name C1, C1 new_name     duplicate names resolved with number suffix: C1 -> 1_1.txt          C?|
|  O   Overwrite file options                  O1, Ohelp 2         Overwrite => 1.txt w/ selected, 2.txt w/ help.txt                   O?|
|      Overwrite Clipboard options             O3>, O>3            Overwrite => Clipboard with 3.txt (3.txt with clipboard)       O?.|O.?|
|  E   Edit file in default editor             E1, Er\test, E      edit => 1.txt, r\test.txt (r\ subfolder file path), (L)loaded file  E?|
| A|P  Append|Prepend selected text to file    A1, Ar\test 1       add selected text to bottom of => 1.txt, r\test.txt to 1.txt     A?|P?|
|      A|P manually entered text               P1:title, A2:end    add => "title" to top of 1.txt, "end" to bottom of 2.txt     A?:?|P?:?|
|      A|P clipboard(>) variations             A>, P1>, A>:sample  A|P to clipboard=> selected text, 1.txt, the word "sample"            |
|  F   Paste same string repeatedly            F-+~4               paste => -+-+ ; format: (string) ~ (# of characters) to fill      F?~?|
|  D   Delete file                             D1, Da.ini, DD      Delete =>1.txt (".txt" is optional), a.ini, (L)loaded file          D?|
| Rf~: Modify file w/ saved replace't pattern  R~f:1~p n           modify => 1.txt w/ pattern in p.txt & save result to n.txt    Rf:?~? ?|
|      pattern file fmt: (no R at beginning)   ,~+__A~B,           all linebreaks will be ignored in pattern .txt file           ?~?__?~?|
|________________________________________________________________________________________________________________________________________|

__________________________________________________________________________________________________________________________________________
| KEY  GUI BEHAVIOR & APPEARANCE                                                                                                         |
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
|  W   Run a different commandbox key suffix   Ws, Wb, Wtut        default suffix: ~win; "Wb" same as entering b in CB("~win")   M|H|B|W?|
|  W:  Change W command suffix reference       W:~win, W:~pdf      M|H|B behave the same as W to allow access to multiple CBs         W:?|
|  T   CommandBox UI options; also see CB      Td, Tm, Tp          (d)isplay mode, (m)inimalist mode, (p)ersistent CB, (f)ont          T?|
|      keyboard shortcuts with "LK"            Ta, Tt, Ts, Tw      (a)app stays active, (t)itlebar, (s)crollbar, (w)Text Wrap            |
|                                              Tr, Tf:arial        (r)eenter last userinput, (f)ont change to arial                      |
|________________________________________________________________________________________________________________________________________|
```

</p></details>

<details><summary>&nbsp;ℹ️&nbsp;<b>Pseudo command-line interface</b></summary><p>

Using hotkeys, users can access Command Box functions without calling the GUI. 

In any windows application text field pressing

- `lwin` + `enter` will consume the last typed word and treat it as a CB key submission (default suffix: "~win");

    > E.g., typing "oc", then hitting `lwin` + `enter` will open the `mem_cache` folder in windows file explorer.

<br>

- `lalt` + `spacebar` will consume the last typed word and replace it with the contents of the corresponding memory file—equivalent to uppercase-initiated V (paste) function

    > E.g., typing "1", then hitting `lalt` + `spacebar` will replace "1" with the contents of 1.txt in the `mem_cache` folder.

</p></details>
<br>
</ol>

<br>

----
## 3. Roadmap & Known Issues <a name="roadmap"></a>

Future development priorities:

1. save/recall CB GUI profiles by command suffix.
2. show images in CB display window.
    * https://autohotkey.com/board/topic/97643-load-and-display-images-in-gui-window-using-gdi/


----
