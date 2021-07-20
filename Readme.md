<h1> WinGolems </h1>

> Operating systems and devices should mold to our needs, not the other way around. — Satya Nadella

Borrowing ideas from Michael Nielsen's [writings on Tools for Thought](https://michaelnielsen.org/), a transformative computer interface does more than make it easier to complete common tasks and automate redundant processes, to be considered transformative the interface must give users the ability to discover and leverage insights that would be much harder or impossible to do otherwise. Because mastering an interface requires internalizing its component objects and operations, interface designers have the power to introduce new elements of cognition and modes of thought. 

WinGolems embodies a collection of AutoHotkey (AHK) modules and templates that I have written or adapted from others over the years to automate and augment how I interact with my computer. After going through a short tutorial below, new users will be able to start building their own interface layers (no prior Autohotkey knowledge is assumed).

One of the key strengths of AHK is it's powerful and parsimonious syntax for creating different interface layers in Windows.  

```ahk
    ; the AHK code below illustrates how easy it is to create 3 shortcuts 
    ; for opening/activating a web browser using WinGolems convenience functions

    :X:c~win::                      ; 1. typing "c~win" <space>
    #s:: ActivateApp("html_path")   ; 2. pressing "win + s" together 
                                    ; 3. entering "c" in a ~win suffix command box
                                
```

## Quick Start Template

Within WinGolems the AHK code for the creation of interface elements (i.e., interface templates) is kept in separate files from the code for the algorithms carrying out the underlying operations. The user only needs to know the correct calling convention to use WinGolems convenience functions such as ActivateApp(). Note: The quickstart template highlights only a small sample of WinGolems' convenience functions. For a more advanced reference template, please see \Golems\TrackPointKB. 

<img src="assets\Screens\simple.png">
<img src="assets\Screens\CB.png">

Command Box: Multi-function keyboard driven GUI (Graphical User Interface) 

FAQ
free up windows keys
#F https://superuser.com/questions/1251384/how-to-disable-windows-10-feedback-hub
```
 _________________________________________________________________________________________________________________________________________
| CommandBox (CB) Creation:     # win  ! alt  ^ ctrl  | KEY    WINGOLEMS UTILITIES, HELP, CONFIGURATION     | KEY  WINDOWS SELECTION     |
| ---------------------------                         |------ ----------------------------------------------|----- ----------------------|
| 1) Create a "win + spacebar" shortcut to open a CB  | ?      load this help cheat sheet                   |  b   Bluetooth             |
|     #space:: CB("~win")                             | lt|lf  Switch ON|OFF:  Win + L Locks Computer       |  d   Display               |
|                                                     | ss|qs  Switch ON|OFF:  Cloud Sync                   |  n   Notifications         |
| 2) Create a command key "a" to call any function:   | cf     Toggle ON|OFF:  Cursor follows active window |  p   Presentation mode     |
|     :X:a~win:: Function()                           | tut    AHK Beginner Tutorial                        |  k   Quick Connect         |
|                                                     | ci     Edit WinGolems config.ini                    |  v   Sound                 |
| The above can be adaped to call scripts written in  | kh     Open Key History (#KeyHistory > 0 required)  |  i   Windows Settings      |
| other languages such as python, VBA, etc ...        | gl     Generate shortcut list from running scripts  |  ap  Add Remove Programs   |
|                                                     | ls     Open last generated list of shortcuts        |  a   Alarm Clock           |
| CB Keyboard Shortcuts:                              | hs     Open log of user created hotstrings          |  r   Open Run Dialog Box   |
| --------------------------                          | ws     Open Window Spy                              |  x   Start Context Menu    |
| #Space  submit command key        (win  + spacebar) | rw     Reload WinGolems (Ctrl+Win+R)                |  s   Start Menu            |
| ^Space  move focus to input box   (ctrl + spacebar) | qw~    Quit WinGolems                               |  ce~ Close All Programs    |
| !r      enter last command        (alt  + r)        | ec~    open cache folder in file explorer           |  sd~ Shut Down             |
|_____________________________________________________|_____________________________________________________|____________________________|
| FIRST CHARACTER INITIATED COMMANDS (Case-sensitive)                                                                                    |
| KEY  UTILITIES                               USAGE                                                                       separator (?) |
|----- --------------------------------------- ------------------------------------------------------------------------------------------|
| J|j  SELECT|goto or delete! rows below       J3, J, JJ!, j23     select # of rows below => 3, 10, 20 + delete, 23 + no selection       |
| K|k  SELECT|goto or delete! rows above       K3, K, KK!, k23     J or K = 10 if no numbers used, KK = 20 rows selected above           |
|  G   Run any WinGolems Library function      GLoadURL,gmail.com  fmt: function name, paramaters                                    (,) |
|  F   Paste same string repeatedly            F-+,4               paste: -+-+ ; fmt: string, # of characters to fill                (,) |
|  R   Replace A with B in selected text       R,~+__A~B           Changes A,C -> B+C  ; replacement (~), btn multiple replacements (__) |
| R?~  Change separator characters             R1~%, R2~~>         Changes separators to replacement (%), btn multiple replacements (~>) | 
|                                                                                                                                        |
| KEY  MEM_CACHE COMMANDS ( .txt files only )  USAGE                                                                                     |
|----- --------------------------------------- ------------------------------------------------------------------------------------------|
| 0-9  Load .txt file 0-9 into CB display      0, 1, 2, ...         alternative to using L1 to load 1.txt                                |
|  L   Load .txt file into CB display          L1, Lhelp, Lr\testr  Load in display: 1.txt, help.txt, r\testr.txt                        |
|  V   Paste .txt file contents                V1, Vsck, Vr\testr   Paste contents of 1.txt, sck.txt, r\testr.txt into prior window      |
|  C   1) make copy 2) make & rename copy      C1, Chelp new_name   duplicate names resolved with added number suffix                    |
|  O   Overwrite file|clipboard(:) contents    O1, O2 help, O:3     overwrite: 1.txt <= selection, 2.txt <= help.txt, clipboard <= 3.txt |
|  E   Edit file in default editor             E1, Etest, Er\testr  entering E or EF will open file or folder jumplist menus             |
| A|P  Append|Prepend selected text to file    A1, Atest, Ar\testr  add selected text to bottom|top of: 1.txt, test.txt, r\testr.txt     |
| Rf~  Modify file w/ pattern in another file  Rf~1~p n             Modify 1.txt w/ replacement pattern in p.txt, save chg as n.txt   (~)|
|      pattern file fmt: no R at beginning     ,~+__A~B,            linebreaks btn _ _ will be ignored. E.g.,  _,~+_ *line break* _A~B_  |
|________________________________________________________________________________________________________________________________________|
After creating different interfaces elements, the next step is to connect that interface to functions that do something useful. 

Before writing any new functions, I suggest searching the following AHK community forums to find relevant discussions and pre-maid scripts that can be adapted to suit your needs. Over a third of \' function library was modified from AHK community scripts.

- https://www.autohotkey.com/boards/
- https://www.reddit.com/r/AutoHotkey/

Moving beyond automation and quality of life features, WinGolems can be used as a toolkit for building building layers of abstraction. 






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

```
. . . [the] aim is to develop a new medium for thought. A medium such as, say, Adobe Illustrator is essentially different from any of the individual tools Illustrator contains. Such a medium creates a powerful immersive context, a context in which the user can have new kinds of thought, thoughts that were formerly impossible for them. Speaking loosely, the range of expressive thoughts possible in such a medium is an emergent property of the elementary objects and actions in that medium. If those are well chosen, the medium expands the possible range of human thought.
```

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
 


