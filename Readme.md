<h1> WinGolems </h1>

A good computer interface makes it easier to complete frequent tasks and automate redundant processes, saving both time and mental resources. A truly transformative interface is one that goes beyond automation by making it possible to solve problems that would be impossible to tackle otherwise. Because mastering an interface requires internalizing its component objects and operations, interface designers have the ability to introduce new elements of cognition and modes of thought.

WinGolems embodies a collection of AutoHotkey (AHK) modules and templates that I have written or adapted from others over the years to automate and augment how I interact with my computer. After going through a short tutorial below, new users will be able to start building their own interface layers by modifying sample code in the quick start template  (no prior Autohotkey knowledge is assumed).

One of the key strengths of AHK is it's powerful and parsimonious syntax for creating different interface layers in Windows. The AHK code below illustrates this by showing how easy it is to create 3 shortcuts for opening/reactivating a web browser using WinGolems convenience functions. 

```ahk
                                    ; Open web browser by 
    :X:c~win::                      ; 1. typing "c~win" <space>
    #s:: ActivateApp("html_path")   ; 2. pressing "win + s" 
                                    ; 3. submitting "c" in a "~win" command box
                                
```

## Quick Start Template

Within this repository the code for the creation of interface elements (i.e., interface templates) is kept separate from the code that executes the desired task (i.e., function libraries). The user only needs to know the correct calling convention to use WinGolems convenience functions like ActivateApp(). Note: The quickstart template only highlights a subset of WinGolems' convenience functions. For a more comprehensive reference template, please see the files in \Golems\TpKb which was written for Lenovo Trackpoint-based keyboards. 

The initial value provided by this repository will come from leveraging various 'golems' to alleviate workflow frictions. For example, when different applications have different shortcuts for the same function (e.g., switching tabs with ctrl+tab vs ctrl+PgDn), users are forced to remember extra information to interact with their machine that could be standardized away. A more common problem arises when software developers assign prime keyboard real-estate to less used operations (e.g., Windows key + F is a shortcut for opening a feedback dialog in Windows OS). Since common sense dictates that the most frequently performed operations should be the easiest to execute, the Windows key + F keyboard combination should be reassigned to a more useful task. WinGolems gives users the power to reengineer application design decisions to suit their hardware and particular preferences. As Satya Nadella says, "Operating systems and devices should mold to our needs, not the other way around."—[Satya Nadella](https://www.theverge.com/2021/6/24/22549007/microsoft-windows-11-satya-nadella-remarks-apple)





 to remember which software uses Or worse yet, when software developpers assign less used functions to prominent key combinations that could be put to better use (e.g., #i,#g,#f). WinGolem's provides examples of how to reengineer how one 


<center>
<img src="assets\Screens\QuickStartHotkeys.png" width="1000">

<br>

The command box was initially conceived as an always on top .txt file viewer for the 0-9 memory keys. However, that it's use 

<br>
<img src="assets\Screens\CB.png" width="600">

## <details><summary><font color = 'orange'><b>Click to see Command Box cheat sheet</b></font></summary>
<p>

```


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
 
## Help

* Open <a href="https://github.com/bingson/WinGolems/blob/master/HotKey_List.txt" title="title">HotKey_List.txt</a> for a list of hotkeys 

* [AHK Beginner Tutorial](https://www.autohotkey.com/docs/Tutorial.htm) 
 


