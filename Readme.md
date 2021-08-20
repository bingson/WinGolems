
<p align="center">
  <img src="assets\Screens\WGLc.png" width="300">
</p>


A good computer interface makes it easier to complete frequent tasks and automate redundant processes, saving both time and mental resources. A transformative interface goes beyond automation by giving its user the ability to solve problems that would be impossible to solve otherwise. Because mastering an interface requires internalizing its component objects and operations, interface designers have the ability to introduce new elements of cognition and modes of thought.

WinGolems embodies a collection of AutoHotkey (AHK) modules and templates that I have written or adapted from others over the years to automate and augment how I interact with my computer. Before investing any time into learning AHK, new users can first try out many of WinGolems' features by running the quick start template below using the included executable (no knowledge of AHK or software installation required). 

The initial value provided by this repository will come from users adapting the code from the quick start template to alleviate common workflow frictions. 

#### Example use cases:

- When different applications have different shortcuts for the same operation, users must remember application-specific information that could otherwise be standardized away—e.g., switching tabs with `ctrl + tab` versus `ctrl + PgDn`. 

- When ones hardware setup doesn't play well with default application shortcuts, users should be able to change those defaults—e.g., to actuate ` ctrl + PgDn `  on my laptop's condensed keyboard requires that I move my right hand off of home row. 

- When software developers pre-assign prime keyboard real estate to less used operations, their making decisions that are anathema to user-centered design. Common sense dictates that the most frequently performed operations are the easiest to execute and vice versa. E.g., the ` Win + F ` combination opens the rarely used feedback reporting dialog in Windows.

 Satya Nadella's proclaimed in his [recent remarks on Windows 11](https://www.theverge.com/2021/6/24/22549007/microsoft-windows-11-satya-nadella-remarks-apple), "operating systems and devices should mold to our needs, not the other way around." In this spirit, WinGolems provides a toolbox for re-engineering Windows application interfaces to better suit a users needs (i.e., particular hardware setup and ergonomic preferences).  


## Quick Start Template Overview:

The quick start template has working code examples that illustrate how to create interface layers and connect them to WinGolems' function library. To modify the quick start template, AutoHotkey must be installed. Within the WinGolems folder, code for the creation of interface layers (i.e., interface templates) are kept in separate files from the code used to execute the desired task (i.e., function libraries). To reduce the AHK or programming knowledge to use WinGolems convenience functions, new users will only need to understand how to modify template files which are limited to code that assigns hotstrings and hotkeys (keyboard shortcuts) to function calls (or AHK code that doesn't exceed 1 line). 

```ahk
                                          ; Open or reactivate a web browser by 
    #s::                                  ; (1) pressing "win + s" 
    :X:c~win:: ActivateApp("html_path")   ; (2) typing "c~win" <space> anywhere in windows (hotstring)
                                          ; (3) entering "c" in a CommandBox("~win")
```
One of the key strengths of AHK is it's powerful and parsimonious syntax for creating different interface layers in Windows. The AHK code above illustrates this by showing how easy it is to create three shortcuts for opening/reactivating a web browser window through the WinGolems function ActivateApp(). 

<h3> Quick Start Keyboard Shortcuts: </h3>
<table>
<tr>
    <td>
        <img src="assets\Screens\QuickStartHotkeys.png" width="1000"> 
    </td>
</tr>

Reading through the short section on [Hotkeys & Hotstrings](https://www.autohotkey.com/docs/Tutorial.htm#s2) for the AHK beginner tutorial is all a new user needs to know to begin modifying interface layers in the quick start template. 

<tr>
    <td>
        <details><summary><font color = 'orange'><b>Click to see full List of Quick Start Hotkeys</b></font></summary>
        <p>

```

SC KEY REFERENCE -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 

 sc027 = {;:}    sc028 = {"'}    sc029 = {`~}     sc033 = {,<}      sc02b = {\|}

 sc034 = {.>}    sc035 = {/?}    sc00D = {=+}     sc00C = {-_} 

 sc01a or b = {[} or {]} 

==o====o====o====o====o== 1_TEMPLATE_QUICKSTART ==o====o====o====o====o====o
 Win+A                   ActvateApp: Activate default editor
 Win+E                   ActvateApp: Activate Excel
 Win+B                   ActvateApp: Activate File explorer
 Win+D                   ActvateApp: Activate pdf viewer
 Win+Q                   ActvateApp: Activate Powerpoint
 Win+F                   ActvateApp: Activate previously saved window ID
 Win+Z                   ActvateApp: Activate previously saved window ID
 Win+C                   ActvateApp: Activate previously saved window ID
 Win+X                   ActvateApp: Activate previously saved window ID
 Win+S                   ActvateApp: Activate web browser
 Win+W                   ActvateApp: Activate Word
 Ctrl+Win+C              ActvateApp: Save window ID for subsequent activation
 Ctrl+Win+Z              ActvateApp: Save window ID for subsequent activation
 Ctrl+Win+F              ActvateApp: Save window ID for subsequent activation
 Ctrl+Win+X              ActvateApp: Save window ID for subsequent activation
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
 Alt+Sc027               FileExplorer:1 detailed file info with resized columnsnmn
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
 *Alt+J                  NavigateText: Down
 Win+H                   NavigateText: jump to next word; simulate ctrl+Left
 Win+L                   NavigateText: jump to next word; simulate ctrl+Right (must first disable win+L lock key combo with CB key "lf")
 Alt+H                   NavigateText: Left
 Alt+L                   NavigateText: Right
 *Alt+K                  NavigateText: Up
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

</p>
</details>
</td>
</tr>
</table>

<h3> Command Box (CB)</h3>

Memory System
The command box was initially created as part of a txt file based memory system. 

that started off as an always-on-top text file viewer to 


At some point, you run out of easily accessible keyboard shortcut combinations  

<table>
<tr>
    <td><img src="assets\Screens\Display.png" width="600"> </td>
    <td><img src="assets\Screens\minimal.png" width="600"> </td>
</tr>

<tr>
    <td style="text-align:center">display mode </td>
    <td style="text-align:center">minimal mode </td>
</tr>
</table>


<details><summary><font color = 'orange'><b>Click to see Command Box cheat sheet</b></font></summary>
<p>

```
_________________________________________________________________________________________________________________________________________
| CommandBox (CB) Creation:                           | KEY    WINGOLEMS         ([T]oggle, [M]ode change ) | KEY  WINDOWS SELECTION     |
|-----------------------------------------------------|------- ---------------------------------------------|----- ----------------------|
| 1) Create a "win + spacebar" shortcut to open a CB  | ?      load this help cheat sheet                   |  b   Bluetooth             |
|     #space:: CB("~win")                             | tut    AHK Beginner Tutorial                        |  d   Display               |
|                                                     | oc     open memory .txt folder in file explorer     |  n   Notifications         |
| 2) Create a command key "a" to call any function:   | ec     Edit WinGolems config.ini                    |  p   Presentation mode     |
|     :X:a~win:: anyFunction()                        | Ls     see hotkey list ("gl" to update hotkey list) |  v   Sound                 |
|                                                     | wg     WinGolems github repository & documentation  |  i   Windows Settings      |
| The above can be adaped to call scripts written in  | tcf    [T] mouse cursor follows active window       |  ap  Add Remove Programs   |
| other languages such as python, VBA, C++, etc ...   | ta     [T] advanced hotkeys                         |  a   Alarm Clock           |
|                                                     | lt|lf  [M] ON|OFF:  Win + L Locks Computer          |  r   Open Run Dialog Box   |
| CB Keyboard Shortcuts:   ( win: #  alt: !  ctrl: ^ )| ss|qs  [M] ON|OFF:  Data Backup Application         |  x   Start Context Menu    |
|-----------------------------------------------------| ws     Open Window Spy                              |  s   Start Menu            |
| #Space  submit key                      win+spacebar| kh     Open Key History (#KeyHistory > 0 required)  |  e   desktop environments  |
| ^Space  move focus CB input box        ctrl+spacebar| r~     Reload WinGolems                             |  h~  Hybernate computer    |
| !r      reenter last submitted key             alt+r| q~     Quit WinGolems                               |  ce~ Close All Programs    |
| !x      toggle GUI minimal or display mode     alt+x|                                                     |  rs~ Restart computer      |
| !e      move & resize CB window to top left    alt+e|                                                     |  sd~ Shut Down computer    |
|_____________________________________________________|_____________________________________________________|____________________________|
| UPPER-case first letter required to trigger the following commands                                                                     |
|                                                                                                                                        |
|      TEXT MANIPULATION & MEMORY SYSTEM       USAGE EXAMPLE       Notes: "__" used to link commands that can be repeated         Format?|
|      --------------------------------------- ------------------- ----------------------------------------------------------------------|
| 0-9  Load .txt file 0-9 into CB display      0,1,2,3,4,5,6,7,8,9 shortcut alternative to using L1 to load 1.txt                       ?|
|  L   Load .txt file into CB display          L1, Lhelp, Lr\testr Load in display => 1.txt, help.txt, r\testr.txt ("Ll" .txt list)    L?|
|      Load file shorcut keys                  Lc, Ls, Ll, ?       Load in display => config.ini, hotkey list, .txt file names           |
|  V   Paste .txt file to anchored window      V1, Vsck, Vr\testr  Paste contents of 1.txt, sck.txt, r\testr.txt in last active window V?|
|  C   save a copy or save copy under new name C1, C1 new_name     duplicate names resolved with added number suffix: C1 -> 1_1.txt    C?|
|  O   Overwrite file|clipboard(:) contents    O1, O2 help, O:3    replace => 1.txt w/ selected, 2.txt w/ help.txt, clipboard w/ 3.txt O?|
|  E   Edit file in default editor             E1, Etest, Er\testr edit => 1.txt, test.txt, r\testr.txt (subfolder file path)          E?|
| A|P  Append|Prepend selected text to file    A1, Atest, Ar\testr add selected text to bottom of => 1.txt, test.txt, r\testr.txt    A|P?|
|  F   Paste same string repeatedly            F-+,4               paste: -+-+ ; fmt: string, # of characters to fill                F?,?|
|  R   Replace A with B in selected text       R,~+__A~B           usage example: A,C (input) -> A+C -> B+C             R?~?__?~? or R?~?|
| R?:  Change replacement separators (1|2)     R1:%; R2:~>         Changes the above replacement separators to % and ~>              R?:?|
| Rf:  Modify file w/ saved replace't pattern  Rf:1~p n            modify=> 1.txt w/ pattern in p.txt & save result to n.txt     Rf:?~? ?|
|      pattern file fmt: no R at beginning     ,~+__A~B,           all linebreaks will be ignored in patten .txt file            ?~?__?~?|
|                                                                                                                                        |
| KEY  CONVENIENCE                                                                                                                       |
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
|  Q   Query selected text in search engine    Qd, Qt, Qw, Qn, Qf  (d)ictionary,(t)hesaurus,(w)ikipedia,(n)ews,(f)inance,(i)mages      Q?|
| J|j  SELECT|goto or delete! rows below       J3, J, JJ!, j23     select # of rows below => 3, 10, 20 + delete, 23 + no selection     J?|
| K|k  SELECT|goto or delete! rows above       K3, K, KK!, k23     J|K|j|k = 10 if no numbers or other letters are also entered        K?|
|  G   Run any function                        GMoveWin,TopLeft    fmt: fn1_name,fn1_params__fn2name,fn2params          G?,?__?,? or G?,?|
| G?:  Create G function|parameter alias (f|p) Gf:mw~MoveWin       makes Gmw,tl behave same as GMoveWin,TopLeft (dict: "Lalias")   G?:?~?|
|                                              Gp:tl~TopLeft       list of current aliases in the file ALIAS.ini in /mem_cache/ folder   |
|      GUI BEHAVIOR & APPEARANCE                                                                                                         |
|      --------------------------------------- ------------------- ----------------------------------------------------------------------|
|  W   Run a different commandbox key suffix   Ws, Wb, Wtut        default suffix: ~win; "Wb" same as entering b in CB("~win")   M|H|B|W?|
|  W:  Change W command suffix reference       W:~win, W:~pdf      M|H|B behave the same as W to allow access to multiple CBs         W:?|
|  T   Toggle CommandBox UI options            Td, Tm, Tp, Tt, Ts  [M]:(d)isplay,(m)inimal,(p)ersistent;[T]:(t)itle,(s)crollbar,(W)rap T?|
|  Z   Change display window appearance        Z13, Zf:courier, Zd change => font size: 13, font: courier, back to default     Z?:? or Z?|
|                                                                                                                                        |
|________________________________________________________________________________________________________________________________________|

```

</p>
</details>
</center>

After creating different interfaces elements, the next step is to connect that interface to functions that do something useful. 

Before writing any new functions, I suggest searching the following AHK community forums to find relevant discussions and pre-maid scripts that can be adapted to suit your needs. Over a third of \' function library was modified from AHK community scripts.

- https://www.autohotkey.com/boards/
- https://www.reddit.com/r/AutoHotkey/

Moving beyond automation and quality of life features, WinGolems can be used as a toolkit for building building layers of abstraction. 


#F https://superuser.com/questions/1251384/how-to-disable-windows-10-feedback-hub



By abstraction we simply mean the removal of unnecessary detail when trying to accomplish tasks. One useful way of doing this with autohotkey is the clip().
```ahk
function() {
    var := clip()
    
}
```

The larger the customer base the more complex the business process, whether it's software, hardware, financial services, or cars. Growing complexity is a major source of engineering cost and errors. With the wrong engineering approach, every team member can end up needing to understand every other team member's work, which means the total effort requires to build a system of size n is proportional to n2! The solution to complexity is abstraction, also known as information hiding. Abstraction is simply the removal of unnecessary detail. The idea is that to design a part of a complex system, you must identify what about that part others must know in order to design their parts, and what details you can hide. The part others must know is the abstraction.


In other words, create  

The bigger idea is to strip away focus on ideas of greater

process of removing physical, spatial, or temporal details or attributes in the study of objects or systems to focus attention on details of greater importance;[3] it is similar in nature to the process of generalization;


('(~_(^_^(-_-)o_o)_*)")

doing this is by using the Clip() 
<!-- with WinGolems is through progromatically accessing  -->
One of the primary use cases I use WinGolems, is as a 
I often create WinGolems scripts 
The command box was conceived out of a desire to augment my memory and 



But beyond creating more convenient Windows shortcuts, WinGolem's also contains modules to facilitate the cognitive outsourcing of complex tasks by 

The WinGolems also contains functions that allow the user to access and modify the Window's clipboard.  
- 

For example, the creation of .txt file copies of clipboard contents that can be retrieved through 




walk new users through modifying the above interface

, including how to use the WinGolem's memory system and execute user-created function through the command input box. 

for programatically  accessing and modifying 

use functions to facilitate the cognitive outsourcing of complex tasks. 


The command WinGolems also includes a variety of modules to facilitate the cognitive outsourcing of tasks. For example, 




(no prior AHK knowledge assumed) 

New users are encouraged to modify this template to better suit their needs. 



[[readme_snippet]]
but only represents a small preview of the capabilities of the WinGolems function library.  



In terms of  sdf


Within this readme, I will walk through the assignment of shortcuts in the quick start template below to illusjtrate how to adapt WinGolems to your own needs.   




features such as the assignment of keyboard shortcuts and hotstrings in the usage section below.  
the quick start template shown below in the usage section. 


In the usage section I will walk through the quick start template below to show how 



The creation of interface features such as the assignment of keyboard shortcuts and hotstrings is separated from the function libraries that execute the desired task (aka. cognitive outsourcing model).  

As the optimal 

The code for the quick start interface template below is provided.
**text**
>>text<<
%text%



  
----
## CONTENTS 

* [Getting Started](##Getting-Started)
* [Help](##Help)
----

## GETTING STARTED

### 1. &nbsp; Install Dependencies
 <ul>
   <li>
     <p>  <b>Required:</b> </p>
     <p>  – &nbsp; Windows 10 (tested on Home Version 20H2 OS build 19042.985)
     <p>  - &nbsp; Windows 10 (tested on Home Version 20H2 OS build 19042.985)
     <br> – &nbsp; <a href="https://www.autohotkey.com/docs/Tutorial.htm#s11">Autohotkey</a> version 1.1.33.09.
   </li>
   <li>
     <p>  <b>Recommended:</b> </p>
     <p> Any code editor that supports indentation-based code folding and autohotkey syntax highlighting. 
     <p>  – &nbsp; <a href="https://code.visualstudio.com/">Visual Studio Code</a> editor with the following extension IDs 
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; slevesque.vscode-autohotkey
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; helsmy.ahk-simple-ls
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; johnnywong.vscode-ts-whitespace-converter
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; bladnman.auto-align
   </li>
 </ul>
 
 <br>


### 2. &nbsp; Install WinGolems 

 <ul>
   <li>
     <p><b> Option 1: Download zip file</b></p>
     <p> Download WinGolems as a zip file from the following url and <a href="https://www.7-zip.org/">unzip</a> to the same drive Windows 10 and program files are installed.

``` 
https://github.com/bingson/WinGolems/archive/refs/heads/master.zip
```

   </li>
   <li>
     <p><b> Option 2: GIT </b></p>
     <p>    This option requires the installation of <a href="https://git-scm.com/book/en/v2/Getting-Started-Installing-Git">Git</a> and is recommended if you want to make contributions to the project as well as periodically update your local repo with new versions via git pull. To download this project through git, run command

``` 
git clone https://github.com/bingson/WinGolems.git 
```

   </li>
 </ul>

<br>


### 3. &nbsp; Run and configure WinGolems


 <ul>
   <li>
     <p><b> Run WinGolems.ahk as administrator </b></p>
     <p> After you have installed Autohotkey and unzipped the WinGolems project folder, open the WinGolems project folder using file explorer and run WinGolems.ahk as administrator using the right-click context menu. 
     <p><img src="assets\Screens\run_master.png" alt="run_master.png" title="run_master.png" /></p>
   </li>
   <li>
     <p><b> Configure WinGolems </b></p>
     <p> Upon first run, a new settings file will be created. WinGolems will search through both 32 bit and 64 bit program file folders for executable paths used to launch specific apps and modify associated file types. To change these app references, open <code>config.ini</code> in a text editor and update the file path values for the following variables.  

``` 
html_path
doc_path
xls_path
ppt_path
pdf_path
```

   </li>
 </ul>
<br>



## Usage

The overarching goal of this project was reduce 
## Tutorial Section



## Help

* Open <a href="https://github.com/bingson/WinGolems/blob/master/HotKey_List.txt" title="title">HotKey_List.txt</a> for a list of hotkeys 

* [AHK Beginner Tutorial](https://www.autohotkey.com/docs/Tutorial.htm) 
 


<center><img src="assets\Screens\wingolems_exe.png" width="400"></center>
modify code samples in quick start interface template  https://www.autohotkey.com/docs/Tutorial.htm#s2