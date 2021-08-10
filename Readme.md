<h1> WinGolems </h1>

A great computer interface makes it easier to complete frequent tasks and automate redundant processes, saving both time and mental resources. A tranformative interface is one that lets you solve problems that would be impossible to solve without. Because mastering an interface requires internalizing its component objects and operations, interfaces can introduce new elements of cognition and modes of thought. 

WinGolems embodies a collection of AutoHotkey (AHK) modules and templates that I have written or adapted from others over the years to automate and augment how I interact with my computer. After going through a short tutorial below, new users can start building their own interface layers (no prior Autohotkey knowledge is assumed) using premade convenience functions that control various aspects of Windows OS.

One of the key strengths of AHK is it's powerful and parsimonious syntax for creating different interface layers in Windows.  

```ahk
    ; the AHK code below illustrates how easy it is to create 3 shortcuts 
    ; for opening/activating a web browser using WinGolems convenience functions

    :X:c~win::                      ; 1. typing "c~win" <space>
    #s:: ActivateApp("html_path")   ; 2. pressing "win + s" 
                                    ; 3. submitting "c" in a "~win" command box
                                
```

## Quick Start Template

Within this repository the AHK code for the creation of interface elements (i.e., interface templates) is kept separate from the code for the algorithms that carry out the desired task. The user only needs to know the correct calling convention to use WinGolems convenience functions such as ActivateApp(). Note: The quickstart template highlights only a small sample of WinGolems' convenience functions. For a more advanced reference template, please see the template files in \Golems\TpKb which was designed around Lenovo Trackpoint keyboards (my current setup). 

The initial value provided by this repository comes from helping others reduce every day workflow frictions. For instance, when different applications have different shortcuts for the same function. E.g, switching tabs with ctrl+tab vs ctrl+PgUp. Or worse yet, when application developpers assign rarely used functions to prominent key combinations that could be put to better use (e.g., #i,#g,#f). WinGolem's provides examples of how to alleviate these issues and 

> "Operating systems and devices should mold to our needs, not the other way around."—[Satya Nadella](https://www.theverge.com/2021/6/24/22549007/microsoft-windows-11-satya-nadella-remarks-apple)


<center>
<img src="assets\Screens\QuickStartHotkeys.png" width="1000">

<br>
At some point, 
<br>
<img src="assets\Screens\CB.png" width="600">

<details><summary><font color = 'orange'><b>Click to see Command Box cheat sheet</b></font></summary>
<p>

```
_________________________________________________________________________________________________________________________________________
| CommandBox (CB) Creation:                           | KEY    WINGOLEMS UTILITIES, HELP, CONFIGURATION     | KEY  WINDOWS SELECTION     |
|-----------------------------------------------------|------- ---------------------------------------------|----- ----------------------|
| 1) Create a "win + spacebar" shortcut to open a CB  | ?      load this help cheat sheet                   |  b   Bluetooth             |
|     #space:: CB("~win")                             | lt|lf  Switch ON|OFF:  Win + L Locks Computer       |  d   Display               |
|                                                     | ss|qs  Switch ON|OFF:  Cloud Sync                   |  n   Notifications         |
| 2) Create a command key "a" to call any function:   | cf     [Toggle] mouse cursor follows active window  |  p   Presentation mode     |
|     :X:a~win:: anyFunction()                        | tut    AHK Beginner Tutorial                        |  v   Sound                 |
|                                                     | ci     Edit WinGolems config.ini                    |  i   Windows Settings      |
| The above can be adaped to call scripts written in  | kh     Open Key History (#KeyHistory > 0 required)  |  ap  Add Remove Programs   |
| other languages such as python, VBA, C++, etc ...   | gl     Generate shortcut list from running scripts  |  a   Alarm Clock           |
|                                                     | ls     Open last generated list of shortcuts        |  r   Open Run Dialog Box   |
| CB Keyboard Shortcuts:   ( win: #  alt: !  ctrl: ^ )| hs     Open log of user created hotstrings          |  x   Start Context Menu    |
|-----------------------------------------------------| ws     Open Window Spy                              |  s   Start Menu            |
| #Space  submit key                      win+spacebar| r~     Reload WinGolems                             |  e   desktop environments  |
| ^Space  move focus CB input box        ctrl+spacebar| q~     Quit WinGolems                               |  h~  Hybernate computer    |
| !r      reenter last submitted key             alt+r| ec     open cache folder in file explorer           |  ce~ Close All Programs    |
| !x      toggle GUI minimal or display mode     alt+x| Ll     Load cache contents in GUI display           |  rs~ Restart computer      |
| !e      move & resize CB window to top left    alt+e| tt     toggle text navigation and selection hotkeys |  sd~ Shut Down computer    |
|_____________________________________________________|_____________________________________________________|____________________________|
| FIRST CHARACTER INITIATED COMMAND: (upper-case first letter required to trigger execution)                                             |
| KEY  DESCRIPTION                             USAGE               Notes: "__" used to chain link commands that can be repeated   Format?|
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
|  Q   Query selected text in search engine    Qd, Qt, Qw, Qn, Qf  (d)ictionary,(t)hesaurus,(w)ikipedia,(n)ews,(f)finance,(i)mages     Q?|
|  T   Toggle CommandBox UI options            Td, Tm, Tt, Ts, Tw  mode:(d)isplay,(m)inimal; toggle:t)itlebar,(s)crollbar,(w)ord wrap  T?|
|  W   Run a different commandbox key suffix   Ws, Wb, Wtut        default suffix: ~win; "Wb" equivalent to entering b in CB("~win")   W?|
|  W~  Change W command suffix reference       W~win, W~pdf        M|H|B behave the same as W to allow access to multiple CBs         W~?|
| J|j  SELECT|goto or delete! rows below       J3, J, JJ!, j23     select # of rows below => 3, 10, 20 + delete, 23 + no selection     J?|
| K|k  SELECT|goto or delete! rows above       K3, K, KK!, k23     J|K|j|k = 10 if no numbers or other letters are also entered        K?|
|  F   Paste same string repeatedly            F-+,4               paste: -+-+ ; fmt: string, # of characters to fill                F?,?|
|  R   Replace A with B in selected text       R,~+__A~B           usage example: A,C (input) -> A+C -> B+C              (R?~?__?~?) R?~?|
| R?~  Change replacement separators (1|2)     R1~%; R2~~>         Changes the above replacement separators to % and ~>              R?~?|
|  G   Run any function                        GMoveWin,TopLeft    fmt: fn1_name,fn1_params__fn2name,fn2params           (G?,?__?,?) G?,?|
| G?~  Create G function|parameter alias (f|p) Gf~mw~MoveWin       makes Gmw,tl behave identically to GMoveWin,TopLeft             G?~?~?|
|                                              Gp~tl~TopLeft       list of current aliases in the file ALIAS.ini in /mem_cache/ folder   |
|                                                                                                                                        |
| KEY  MEM_CACHE COMMANDS ( .txt files only )  USAGE               Notes:                                                         Format?|
|----- --------------------------------------- ------------------- ----------------------------------------------------------------------|
| 0-9  Load .txt file 0-9 into CB display      0,1,2,3,4,5,6,7,8,9 shortcut alternative to using L1 to load 1.txt                       ?|
|  L   Load .txt file into CB display          L1, Lhelp, Lr\testr [Load in display] 1.txt, help.txt, r\testr.txt ("Ll" for file list) L?|
|  V   Paste .txt file to anchored window      V1, Vsck, Vr\testr  Paste contents of 1.txt, sck.txt, r\testr.txt in last active window V?|
|  C   save a copy or save copy under new name C1, C1 new_name     duplicate names resolved with added number suffix: C1 -> 1_1.txt    C?|
|  O   Overwrite file|clipboard(:) contents    O1, O2 help, O:3    replace => 1.txt w/ selected, 2.txt w/ help.txt, clipboard w/ 3.txt O?|
|  E   Edit file in default editor             E1, Etest, Er\testr edit => 1.txt, test.txt, r\testr.txt (subfolder file path)          E?|
| A|P  Append|Prepend selected text to file    A1, Atest, Ar\testr add selected text to bottom of => 1.txt, test.txt, r\testr.txt    A|P?|
| Rf~  Modify file w/ saved replace't pattern  Rf~1~p n            modify=> 1.txt w/ pattern in p.txt & save result to n.txt     Rf~?~? ?|
|      pattern file fmt: no R at beginning     ,~+__A~B,           all linebreaks will be ignored in patten .txt file            ?~?__?~?|
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

Engineers have to work together in teams to build complex systems, whether software, hardware, cars, planes, or bridges. This complexity is a major source of engineering cost and errors. With the wrong engineering approach, every team member can end up needing to understand every other team member's work, which means the total effort requires to build a system of size n is proportional to n2! The solution to complexity is abstraction, also known as information hiding. Abstraction is simply the removal of unnecessary detail. The idea is that to design a part of a complex system, you must identify what about that part others must know in order to design their parts, and what details you can hide. The part others must know is the abstraction.


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
 
## Help

* Open <a href="https://github.com/bingson/WinGolems/blob/master/HotKey_List.txt" title="title">HotKey_List.txt</a> for a list of hotkeys 

* [AHK Beginner Tutorial](https://www.autohotkey.com/docs/Tutorial.htm) 
 


