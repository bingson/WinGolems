
<p align="center"><img src="assets\Screens\WGLc.png" width="300"></p>

WinGolems embodies a collection of AutoHotkey (AHK) modules and templates that I have written or adapted from the AHK community over the years to create different interface layers to automate and augment how I use Windows. Before investing any time into learning AHK, prospective users can try out a premade keyboard shortcut interface layer by [by running the included executable]() included with the source code (no software installation or knowledge of AHK required). 



>Operating systems and devices should mold to our needs, not the other way around. - [Satya Nadella](https://www.theverge.com/2021/6/24/22549007/microsoft-windows-11-satya-nadella-remarks-apple) 

As an aspiration 

In the spirit of the above quote, WinGolems gives users tools to reengineer how they interact with Windows computers. The initial value provided by this repository will come from new users adapting code examples from the tutorial template to alleviate common workflow frictions with minimal AHK knowledge. The frequently performed operations should be the easiest to execute and vice versa

convenient keyboard shortcuts to less useful operations, WinGolems shows users how to reprogram those shortcuts. 



As they become more familiar with AHK, users will be able to leverage more of WinGolems'function library to build new capabilities and features into the windows application they use, creating cognitive artifacts to reduce the effort it takes to transform ideas into output. 


 [Satya Nadella said during his recent Windows 11 presentation]"operating systems and devices should mold to our needs, not the other way around." In this spirit, WinGolems offers tools to reengineer the windows man machine interface 
reshaping

WinGolems was 
reifies this idea by giving users tools for re-engineering  

how they translate thought into actions.

**Example workflow frictions solved by AHK or WinGolems:** 

- 

WinGolems templates show users how to standardize these shortcuts among programs, minimizing application-specific information a user has to remember.
- When ones keyboard layout makes it awkward to actuate default application shortcuts, it should be easy to reassign those shortcuts
- When  developers assign desirable keyboard shortcuts to less useful operations, you should be able to reassign those shortcuts: e.g., the ` Win + F ` combination opens the rarely used feedback reporting dialog in Windows. 
- When    

Common sense dictates that the most frequently performed operations should be the easiest to execute and vice versa. The quick start template shows how to reprogram the above shortcuts as well as create new ones. Beyond changing application shortcuts, WinGolems also has Windows enhancement features such as the Command Box (CB) and integrated memory system commands. The CB is a keyboard-driven GUI with it's own command-line interface that can be used to manipulate application windows and call scripts written in other programming languages. The integrated memory system describes a collection of functions and commands used to modify clipboard contents and text files located in the ``` \mem_cache ``` folder. Please see [Quick Start Template Overview](#quick-start-template-overview) for a more comprehensive overview.


  
----
## Contents

1. [Getting Started](#getting-started)
    1. [Install Dependencies](#dependencies)
    2. [Download WinGolems](#download)
    3. [Run WinGolems](#run)
    4. [Configure WinGolems](#cfg)
2. [Quick Start Template Overview](#quick-start-template-overview)
    1. [Keyboard Shortcuts](#ks)
    2. [Command Box](#cb)
3. [AHK resources](#ahk)
4. [Roadmap](#roadmap)
See the open issues for a list of proposed features (and known issues).


----

## 1. Getting Started <a name="getting-started"></a>

### i. &nbsp; Install Dependencies <a name="dependencies"></a>
 <ul>
   <li>
     <p>  <b>Required:</b> </p>
     <p>  – &nbsp; Windows 10/11
     <br> – &nbsp; <a href="https://www.AutoHotkey.com/docs/Tutorial.htm#s11">AutoHotkey</a> version 1.1.33.09.
   </li>
   <li>
     <p>  <b>Recommended Editor:</b> </p>
     <p>  Any code editor that supports indentation-based code folding and AutoHotkey syntax highlighting.
     <p>  – &nbsp; <a href="https://code.visualstudio.com/">Visual Studio Code</a> editor with the following extension IDs 
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; slevesque.vscode-AutoHotkey
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; helsmy.ahk-simple-ls
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; johnnywong.vscode-ts-whitespace-converter
     
   </li>
 </ul>
 
 <br>


### ii. &nbsp; Download WinGolems <a name="download"></a>

 <ul>
   <li>
     <p><b> Option 1: download zip file</b></p>
     <p> Download WinGolems as a zip file from the following url and <a href="https://www.7-zip.org/">unzip</a> in a location of your choosing (e.g., windows user folder). 

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


### iii. &nbsp; Run WinGolems <a name="run"></a>

<p> After downloading and unzipping the WinGolems project folder, navigate to that folder in file explorer, then

 <ul>
    <li>
     <p><b> Option 1: run WinGolems.exe as administrator </b></p>
     This option lets users try out the Quick Start Template without having to install AHK. The executable must be recompiled to reflect any template changes, which requires AHK installation.
     <p><img src="assets\Screens\wingolems_exe.png" width="400"></p>
     <br>
   </li>

   <li>
     <p><b> Option 2: run WinGolems.ahk as administrator </b></p>
     This option lets users make changes to the script and see changes reflected immediately by reloading the script. No executable necessary.
     <p><img src="assets\Screens\run_master.png" width="400" alt="run_master.png" title="run_master.png" /></p>
   </li>
 </ul>
<br>

Note: By default, UAC protects "elevated" programs (that is, programs which are running as admin) from being automated by non-elevated programs, since that would allow them to bypass security restrictions. Running as administrator is required for AHK to work on certain Microsoft application windows (e.g, MS office apps, task manager window). If the user does not have the rights to run programs as administrator, please visit this link for some [workarounds](https://www.autohotkey.com/docs/FAQ.htm#uac).

### iv. &nbsp; Configure WinGolems <a name="cfg"></a>
<ul>
   <li>
     <p><b> Configure WinGolems </b></p>
     
   If WinGolems does not detect any configuration settings for the current computer, it will prompt the user  
   <p><img src="assets\Screens\cfg.png" width="500" alt="run_master.png" title="run_master.png" /></p>

     WinGolems will search through both 32 bit and 64 bit program file folders for executable paths used to launch specific apps and modify associated file types. To change these app references, open <code>config.ini</code> in a text editor and update the file path values for the following variables.  

``` 
html_path
doc_path
xls_path
ppt_path
pdf_path
```

</li>
<ul>

## 2. Quick Start Template Overview: <a name="quick-start-template-overview"></a> 

A good computer interface makes it easier to complete frequent tasks and automate redundant processes, saving both time and mental resources. A transformative interface goes beyond automation by giving its user the ability to solve problems that would be impossible to solve otherwise. Because mastering an interface requires internalizing its component objects and operations, interface designers have the ability to introduce new elements of cognition and modes of thought.

The quick start template is a collection of code examples that show how to create interface layers: i.e., assigning hotstrings/hotkeys to particular WinGolems functions. Within the `\Golems` folder, code for the creation of interface layers (i.e., interface templates) are kept in separate files from the code used to carry out the desired task (i.e., function library files). To modify the quick start template, AutoHotkey installation is required.

To reduce the AHK or programming knowledge necessary to use WinGolems, new users will only need to understand how to modify template files, which can be learned by reading through Section 2 [Hotkeys & Hotstrings](https://www.AutoHotkey.com/docs/Tutorial.htm#s2) of the AHK beginner tutorial (~10 min).  

```ahk
                                      ; Open or reactivate a web browser by 
#s::                                  ; 1) pressing "win + s"                                  <- hotkey
:X:c~win:: ActivateApp("html_path")   ; 2) typing "c~win" <space> anywhere in windows          <- hotstring
                                      ; 3) entering "c" in a Command Box with a "~win" suffix              
```
One of the key strengths of AHK is it's powerful and parsimonious syntax for creating application-specific and system-wide hotstrings and hotkeys. The sample code above illustrates how to create three shortcuts for opening/reactivating a web browser by calling the function ActivateApp(). 

### Keyboard Shortcuts: <a name="ks"></a>

<details><summary>&nbsp;ℹ️&nbsp;<b>Click here to see a list of all quick start template Hotkeys</b></summary>
<p>

```

SC KEY REFERENCE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

 sc027 = {;:}    sc028 = {"'}    sc029 = {`~}     sc033 = {,<}      sc02b = {\|}

 sc034 = {.>}    sc035 = {/?}    sc00D = {=+}     sc00C = {-_} 
      
 sc01a or b = {[} or {]} 

==o====o====o====o====o== 1_TEMPLATE_QUICKSTART ==o====o====o====o====o====o
 Win+X                   ActvateApp: Activate previously saved window ID
 Win+C                   ActvateApp: Activate previously saved window ID
 Win+F                   ActvateApp: Activate previously saved window ID
 Win+Z                   ActvateApp: Activate previously saved window ID
 Ctrl+Win+C              ActvateApp: Save window ID for subsequent activation
 Ctrl+Win+Z              ActvateApp: Save window ID for subsequent activation
 Ctrl+Win+X              ActvateApp: Save window ID for subsequent activation
 Ctrl+Win+F              ActvateApp: Save window ID for subsequent activation
 Win+A                   ActvateApp:1 Activate default editor
 Win+E                   ActvateApp:1 Activate Excel
 Win+B                   ActvateApp:1 Activate File explorer
 Win+D                   ActvateApp:1 Activate pdf viewer
 Win+Q                   ActvateApp:1 Activate PowerPoint
 Win+S                   ActvateApp:1 Activate web browser
 Win+W                   ActvateApp:1 Activate Word
 Rightctrl+Space         CommandBox: activate CB if exists and move focus to inputbox
 Leftctrl+Space          CommandBox: activate CB if exists and move focus to inputbox
 Alt+S                   CommandBox: move CB window to bottom half
 Alt+Z                   CommandBox: move CB window to bottom left
 Alt+C                   CommandBox: move CB window to bottom right
 Win+Left                CommandBox: move CB window to left half
 Alt+A                   CommandBox: move CB window to left half
 Alt+D                   CommandBox: move CB window to right half
 Win+Right               CommandBox: move CB window to right half
 Alt+W                   CommandBox: move CB window to top half
 Alt+Q                   CommandBox: move CB window to top left
 Alt+E                   CommandBox: move CB window to top right
 Alt+R                   CommandBox: reenter last command
 Win+Space               CommandBox: submit GUI input
 Alt+X                   CommandBox: toggle Command Box display|minimalist mode
 Ctrl+Win+W              Convenience: close active window
 Ctrl+Win+Q              Convenience: close all instances of the active program
 Alt+Backspace           Convenience: Delete current line of text
 Win+Sc035               Convenience: google search selected text
 Win+Sc028               Convenience: maximize window
 Ctrl+Alt+Space          Convenience: maximize window
 Win+Sc027               Convenience: minimize window
 Alt+Sc034               Convenience: move window btn monitors
 Win+Space               Convenience: opens command box that runs ~win suffix CB keys; "?" for cheat sheet
 Rshift & Lshift         Convenience: reload WinGolems
 Lshift & Rshift         Convenience: reload WinGolems (update running script for changes, fixes sticky keys)
 Shift+Alt+Capslock      Convenience: rotate through application instances starting from newest
 Win+Capslock            Convenience: rotate through application instances starting from newest
 Shift+Win+Capslock      Convenience: rotate through application instances starting from oldest
 Alt+Capslock            Convenience: rotate through application instances starting from oldest
 Ctrl+Sc027              Convenience: simulate appkey
 Alt+Sc027               Convenience: simulate esc key (alt + semicolon)
 Win+Ins                 Convenience: Window always on top: OFF
 Win+Del                 Convenience: Window always on top: ON
 Ctrl+Alt+J              Convenience: zoom in (simulate: ctrl + plus)
 Ctrl+Alt+K              Convenience: zoom out (simulate: ctrl + minus)
 *Lwin                   Convenience:1 makes windows key inert so it can act as a modifier key
 Lwin Up                 Convenience:1 makes windows key inert so it can act as a modifier key
 Ctrl+Win+Enter          Convenience:1 open start menu (alt: Ctrl+Esc)
 Win+Lbutton             Convenience:1 open start menu (alt: Ctrl+Esc)
 Alt+Win+B               Convenience:2 bluetooth settings (reassign less used windows sys shortcuts)
 Alt+Win+D               Convenience:2 display settings
 Alt+Win+N               Convenience:2 notification window
 Alt+Win+P               Convenience:2 presentation display mode
 Alt+Win+R               Convenience:2 run program
 Alt+Win+I               Convenience:2 windows settings
 Ctrl+Win+0              Memory: add selected text to the bottom of 0.txt
 Ctrl+Win+1              Memory: add selected text to the bottom of 1.txt
 Ctrl+Win+2              Memory: add selected text to the bottom of 2.txt
 Ctrl+Win+3              Memory: add selected text to the bottom of 3.txt
 Ctrl+Win+4              Memory: add selected text to the bottom of 4.txt
 Ctrl+Win+5              Memory: add selected text to the bottom of 5.txt
 Ctrl+Win+6              Memory: add selected text to the bottom of 6.txt
 Ctrl+Win+7              Memory: add selected text to the bottom of 7.txt
 Ctrl+Win+8              Memory: add selected text to the bottom of 8.txt
 Ctrl+Win+9              Memory: add selected text to the bottom of 9.txt
 Shift+Win+0             Memory: overwrite 0.txt with selected text
 Shift+Win+1             Memory: overwrite 1.txt with selected text
 Shift+Win+2             Memory: overwrite 2.txt with selected text
 Shift+Win+3             Memory: overwrite 3.txt with selected text
 Shift+Win+4             Memory: overwrite 4.txt with selected text
 Shift+Win+5             Memory: overwrite 5.txt with selected text
 Shift+Win+6             Memory: overwrite 6.txt with selected text
 Shift+Win+7             Memory: overwrite 7.txt with selected text
 Shift+Win+8             Memory: overwrite 8.txt with selected text
 Shift+Win+9             Memory: overwrite 9.txt with selected text
 Win+0                   Memory: paste contents of 0.txt
 Win+1                   Memory: paste contents of 1.txt
 Win+2                   Memory: paste contents of 2.txt
 Win+3                   Memory: paste contents of 3.txt
 Win+4                   Memory: paste contents of 4.txt
 Win+5                   Memory: paste contents of 5.txt
 Win+6                   Memory: paste contents of 6.txt
 Win+7                   Memory: paste contents of 7.txt
 Win+8                   Memory: paste contents of 8.txt
 Win+9                   Memory: paste contents of 9.txt
 Ctrl+Win+Lbutton        Memory:| double click and paste contents of 1.txt at cursor position
 Win+Alt+Lbutton         Memory:| paste contents of single digit .txt file entered at prompt
 Win+P                   Navigation: Ctrl + end
 Win+O                   Navigation: Ctrl + Home
 Ctrl+Alt+L              Navigation: End
 Ctrl+Alt+H              Navigation: Home
 Win+J                   Navigation: scroll wheel down
 Win+Rightalt+H          Navigation: scroll wheel left
 Win+Rightalt+L          Navigation: scroll wheel right
 Win+K                   Navigation: scroll wheel Up
 Alt+B                   Navigation: universal navigate to left tab
 Alt+Space               Navigation: universal navigate to right tab

==o====o====o====o====o== 2_TEMPLATE_ADVANCED ==o====o====o====o====o====o==
Advanced shortcuts below must be turned on by typing "ta" in CB(~win).

 Rightshift+C            ChgFolder: %Homedrive% (C:)
 Rightshift+U            ChgFolder: %UserProfile%
 Rightshift+Sc029        ChgFolder: AHK folder
 Rightshift+O            ChgFolder: C:\Program Files
 Rightshift+Alt+O        ChgFolder: C:\Program Files(x86)
 Rightshift+D            ChgFolder: Documents
 Rightshift+J            ChgFolder: Downloads
 Rightshift+M            ChgFolder: mem_cache
 Rightshift+P            ChgFolder: Pictures
 Rightshift+T            ChgFolder: This PC / My Computer (file explorer only)
 Shift+Alt+S             CommandBox: move CB window to bottom half small
 Shift+Alt+Z             CommandBox: move CB window to bottom left small
 Shift+Alt+C             CommandBox: move CB window to bottom right small
 Shift+Alt+A             CommandBox: move CB window to left side small
 Shift+Alt+D             CommandBox: move CB window to right side small
 Shift+Alt+W             CommandBox: move CB window to top half small
 Shift+Alt+Q             CommandBox: move CB window to top left small
 Shift+Alt+E             CommandBox: move CB window to top right small
 Ctrl+Win+Backspace      Convenience: Delete and replace selected text with blank spaces
 Alt+Sc033               Convenience: Move window to preset locations
 <HS>  date*             Convenience: output current date
 Ctrl+Win+V              Convenience: Paste and overwrite the same number of spaces (aka. overtype paste)
 Alt+Win+Space           Convenience: remove all spaces from selected text
 Alt+Win+Enter           Convenience: remove empty lines starting from selected text
 Ctrl+Win+Space          Convenience: replace multiple consecutive spaces w/ one space in selected text
 Ctrl+Win+Sc027          Convenience: show desktop
 Capslock                Convenience:1 makes capslock key function as a delete key. (old capslock functionality: ctrl + capslock)
 Ctrl+Capslock           Convenience:1 toggle capslock
 Shift+Ctrl+U            Convenience:2 capitalize selected text
 Shift+Alt+U             Convenience:2 convert selected text to lower case
 Ctrl+Alt+Shift+U        Convenience:2 Every First Letter Capitalized
 Ctrl+Alt+U              Convenience:2 First letter capitalized
 Ctrl+I                  FileExplorer: group by date
 Ctrl+O                  FileExplorer: group by file type
 Rightalt+Space          FileExplorer: move focus to current folder pane
 Leftalt+Space           FileExplorer: move focus to navigation pane
 Leftctrl+K              FileExplorer: sort by date modified
 Leftctrl+J              FileExplorer: sort by name
 Rightctrl+K             FileExplorer: sort by size
 Rightctrl+J             FileExplorer: sort by type
 Alt+Z                   FileExplorer: toggle navigation pane
 Ctrl+P                  FileExplorer: toggle preview plane
 Alt+Sc027               FileExplorer:1 detailed file info with resized columns
 Ctrl+S                  FileExplorer:1 select files by regex
 Shift+Alt+C             FileExplorer:1 store file path(s) of selected file(s) in clipboard
 Ctrl+H                  FileExplorer:1 toggle hide/unhide invisible files
 Shift+Ctrl+Lbutton      MouseFn: click thrice, paste clipboard
 Ctrl+Alt+Lbutton        MouseFn: click twice, paste clipboard
 *Win+I                  MouseFn: Left click and save mouse position
 Alt+I                   MouseFn: mouse middle click
 Printscreen & Sc028     MouseFn: mouse Right click
 Win+Sc028               MouseFn: mouse Right click
 Alt+Win+J               MouseFn: move mouse cursor to bottom edge
 Ralt & Lalt             MouseFn: move mouse cursor to BOTTOM LEFT of active app
 Lalt & Ralt             MouseFn: move mouse cursor to BOTTOM RIGHT of active app
 Alt+Win+H               MouseFn: move mouse cursor to Left edge
 Alt+Win+L               MouseFn: move mouse cursor to Right edge
 Alt+Win+K               MouseFn: move mouse cursor to top edge
 *Ctrl+Win+I             MouseFn: Move to saved mouse position and left click
 Win+J                   MouseFn: scroll wheel down
 Win+Rightalt+H          MouseFn: scroll wheel left
 Win+Rightalt+L          MouseFn: scroll wheel right
 Win+K                   MouseFn: scroll wheel Up
 Ctrl+Alt+J              MouseFn: zoom in
 Ctrl+Alt+K              MouseFn: zoom out
 Win+H                   NavigateText: jump to next word; simulate ctrl+Left
 Win+L                   NavigateText: jump to next word; simulate ctrl+Right (disable win+L lock w/ "lf")
 *Alt+J                  NavigateText:| Down
 Alt+H                   NavigateText:| Left
 Alt+L                   NavigateText:| Right
 *Alt+K                  NavigateText:| Up
 Shift+Alt+J             SelectText: extend selection down  1 row
 Shift+Win+J             SelectText: extend selection down  1 row
 Shift+Alt+H             SelectText: extend selection Left  1 character
 Shift+Win+H             SelectText: extend selection Left  1 word
 Shift+Alt+L             SelectText: extend selection Right 1 character
 Shift+Win+L             SelectText: extend selection Right 1 word
 Shift+Alt+K             SelectText: extend selection up    1 row
 Shift+Win+K             SelectText: extend selection up    1 row
 Ctrl+Win+K              SelectText: select all above
 Ctrl+Win+J              SelectText: select all below
 Shift+Alt+F             SelectText: select current line starting from begining of line
 Ctrl+Alt+F              SelectText: select line starting from end of line
 Ctrl+Win+H              SelectText: select to beginning of line
 Ctrl+Win+L              SelectText: select to end of line
 Shift+Ctrl+K            SelectText: select to line above
 Shift+Ctrl+J            SelectText: select to next line
 Alt+F                   SelectText: select word at text cursor position

```

</p></details>





<img src="assets\Screens\QuickStartHotkeys.png" width = "1000"> 



### Command Box: <a name="cb"></a>

<details>
    <summary>&nbsp;ℹ️&nbsp;<b>Click here to see the default Command Box cheat sheet</b></summary>
    <p>

```
 _________________________________________________________________________________________________________________________________________
| CommandBox (CB) Creation:                           | KEY    WINGOLEMS         ([T]oggle, [M]ode change ) | KEY  WINDOWS SELECTION     |
|-----------------------------------------------------|------- ---------------------------------------------|----- ----------------------|
| 1) Create a "win + spacebar" shortcut to open a CB  | ?      load this help cheat sheet                   |  b   Bluetooth             |
|     #space:: CB("~win")                             | tut    AHK Beginner Tutorial                        |  d   Display               |
|                                                     | oc     open memory .txt folder in file explorer     |  n   Notifications         |
| 2) Create a command key "a" to call any function:   | ec     Edit WinGolems config.ini                    |  p   Presentation mode     |
|     :X:a~win:: anyFunction()                        | Ls     see hotkey list (update hotkey list "gl")    |  v   Sound                 |
|                                                     | wg     WinGolems github repository & documentation  |  i   Windows Settings      |
| The above can be adaped to call scripts written in  | tcf    [T] mouse cursor follows active window       |  ap  Add Remove Programs   |
| other languages such as python, VBA, C++, etc ...   | tt     [T] enhanced text nav/selection hotkeys      |  a   Alarm Clock           |
|                                                     | tc     [T] replace capslock w/ delete key           |  r   Open Run Dialog Box   |
| CB Keyboard Shortcuts:   ( win: #  alt: !  ctrl: ^ )| lt|lf  [M] ON|OFF:  Win + L Locks Computer          |  x   Start Context Menu    |
|-----------------------------------------------------| ss|qs  [M] ON|OFF:  Data Backup Application         |  s   Start Menu            |
| #Space  submit key                      win+spacebar| ws     Open Window Spy                              |  e   desktop environments  |
| ^Space  move focus CB input box        ctrl+spacebar| kh     Open Key History (#KeyHistory > 0 required)  |  h~  Hybernate computer    |
| !r      reenter last submitted key             alt+r| r~     Reload WinGolems                             |  ce~ Close All Programs    |
| !x      toggle GUI minimal or display mode     alt+x| q~     Quit WinGolems                               |  rs~ Restart computer      |
| !e      move & resize CB window to top left    alt+e|                                                     |  sd~ Shut Down computer    |
|_____________________________________________________|_____________________________________________________|____________________________|
| UPPERcase first letter required to trigger the following commands                                                                      |
|                                                                                                                                        |
| KEY  TEXT MANIPULATION & MEMORY SYSTEM       USAGE EXAMPLE       Notes: "__" used to link commands that can be repeated         Format?|
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
| 0-9  Load .txt file 0-9 into CB display      0,1,2,3,4,5,6,7,8,9 shortcut alternative to using L1 to load 1.txt                     0-9|
|  L   Load .txt file into CB display          L1, Lhelp, Lr\testr Load in display => 1.txt, help.txt, r\testr.txt ("Ll" .txt list)    L?|
|      Load file shorcut keys                  Lc, Ls, Ll, ?       Load in display => config.ini, hotkey list, .txt file names           |
|  V   Paste .txt file to anchored window      V1, Vsck, Vr\testr  Paste contents of 1.txt, sck.txt, r\testr.txt in last active window V?|
|  C   save a copy or save copy under new name C1, C1 new_name     duplicate names resolved with added number suffix: C1 -> 1_1.txt    C?|
|  O   Overwrite file|clipboard(:) contents    O1, O2 help, O:3    replace => 1.txt w/ selected, 2.txt w/ help.txt, clipboard w/ 3.txt O?|
|  E   Edit file in default editor             E1, Etest, Er\testr edit => 1.txt, test.txt, r\testr.txt (subfolder file path)          E?|
| A|P  Append|Prepend selected text to file    A1, Atest, Ar\testr add selected text to bottom of => 1.txt, test.txt, r\testr.txt    A|P?|
|  F   Paste same string repeatedly            F-+,4               paste: -+-+ ; fmt: string, # of characters to fill                F?,?|
|  D   Delete file                             D1, D1.txt, D1.ini  file extension optional for .txt files                              D?|
|  R   Replace A with B in selected text       R,~+__A~B           usage example: A,C (input) -> A+C -> B+C             R?~?__?~? or R?~?|
| R?:  Change replacement separators (1|2)     R1:%; R2:~>         Changes the above replacement separators to % and ~>              R?:?|
| Rf:  Modify file w/ saved replace't pattern  Rf:1~p n            modify=> 1.txt w/ pattern in p.txt & save result to n.txt     Rf:?~? ?|
|      pattern file fmt: no R at beginning     ,~+__A~B,           all linebreaks will be ignored in patten .txt file            ?~?__?~?|
|                                                                                                                                        |
| KEY  CONVENIENCE                                                                                                                       |
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
|  Q   Query selected text in search engine    Qd, Qt, Qw, Qn, Qf  (d)ictionary,(t)hesaurus,(w)ikipedia,(n)ews,(f)inance,(i)mages      Q?|
|  Q:  Query submitted text                    Qd:facetious        (so)stack overflow,(a)hk documentation,(y)outube,(twt)twitter     Q?:?|
| J|j  SELECT|goto or delete! rows below       J3, J, JJ!, j23     select # of rows below => 3, 10, 20 + delete, 23 + no selection     J?|
| K|k  SELECT|goto or delete! rows above       K3, K, KK!, k23     J|K|j|k = 10 if no numbers or other letters are also entered        K?|
|  G   Run any function                        GMoveWin,TopLeft    fmt: fn1_name,fn1_params__fn2name,fn2params          G?,?__?,? or G?,?|
| G?:  Create G function|parameter alias (f|p) Gf:mw~MoveWin       creates 2 alias => Gmw,tl will behave same as GMoveWin,TopLeft  G?:?~?|
|                                              Gp:tl~TopLeft       list of current aliases in the file ALIAS.ini (see: "Lalias")         |
| KEY  GUI BEHAVIOR & APPEARANCE                                                                                                         |
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
|  W   Run a different commandbox key suffix   Ws, Wb, Wtut        default suffix: ~win; "Wb" same as entering b in CB("~win")   M|H|B|W?|
|  W:  Change W command suffix reference       W:~win, W:~pdf      M|H|B behave the same as W to allow access to multiple CBs         W:?|
|  T   Toggle CommandBox UI options            Td, Tm, Tp, Tt, Ts  [M]:(d)isplay,(m)inimal,(p)ersistent;[T]:(t)itle,(s)crollbar,(W)rap T?|
|  Z   Change display window appearance        Z13, Zf:courier, Zd change => font size: 13, font: courier, back to default     Z?:? or Z?|
|                                                                                                                                        |
|________________________________________________________________________________________________________________________________________|


```

</p>
</details>

| DISPLAY MODE | MINIMALIST MODE |
| :-: | :-: |
| <img src="assets\Screens\Display.png" width="500"> | <img src="assets\Screens\minimal.png" width="500"> |
<p align="center">
Press ALT + X to switch between modes
</p>

The CB is an entirely keyboard-driven graphical user interface (GUI) designed to augment the windows experience by adding new functionality to existing applications. 

Key Features:
+ see the contents of any .txt file in an always-on-top display window;
+ create additional keyboard shortcut layers valid only when a particular CB is open;
+ access a variety of convenience and augmentation functions ("?" for cheat sheet) 
+ AHK users can also swap in their own command box input processing module to create their own command-line syntax for parametizing and calling functions 

```ahk 

; "ProcessCommand" is an example user input processing module that can be swapped with other ones . 
; open lib\ProcessCommand.ahk
CB("~win", C.lblue, C.dblue , "ProcessCommand")   
```
<br>

Use Cases:




## 3. AHK Resources <a name="ahk"></a>
https://www.autohotkey.com/docs/KeyList.htm
https://www.autohotkey.com/boards/viewtopic.php?f=5&t=1411 ; comma 
https://www.autohotkey.com/boards/viewtopic.php?f=7&t=6413 ; How to optimize the speed of a script as much as possible.

* Open <a href="https://github.com/bingson/WinGolems/blob/master/HotKey_List.txt" title="title">HotKey_List.txt</a> for a list of hotkeys 

* [AHK Beginner Tutorial](https://www.AutoHotkey.com/docs/Tutorial.htm) 
 
<center><img src="assets\Screens\wingolems_exe.png" width="400"></center>
modify code samples in quick start interface template  https://www.AutoHotkey.com/docs/Tutorial.htm#s2

## 4. Roadmap <a name="roadmap"></a>
See the open issues for a list of proposed features (and known issues).


1. Sometimes the CB window will show up as just a title bar in the top left corner. 
    * Temporary fix: ` alt + x ` 

2. Sometimes the CB text display window doesn't fill out the window. 