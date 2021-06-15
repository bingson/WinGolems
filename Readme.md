# WinGolems

A collection of Windows 10 automation and enhancement scripts (aka. golems) written in Autohotkey.  

<h2>Sample template:</h2> One 
<p><img src="assets\Screens\WinGolemnsQuickReferenc.png" alt="run_master.png" title="run_master.png" width="2000" /></p>

<ol>
<li>

<p> WinGolems consists of a repository of functions and templates used to enha

create more convenient keyboard/mouse shortcuts for the most frequently performed Windows 10 actions. 

WinGolem templates show how to create shortcuts to </p>

* switch between, launch, and reactivate specific application windows
* open a file in any particular program from anywhere in windows
* change folders in file explorer and save as dialogue boxes
* select and navigate through text using homerow keys
* execute different text manipulation macros 
* and much more
</li>
<li>



<p> Another feature of WinGolems is a text file based memory system that combines with metaprogramming functions to create dynamic hotstrings  </p>

For example 

```
DF, X, Y <g.pt 
```




</li>
<br>

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
     <br> – &nbsp; <a href="https://www.autohotkey.com/docs/Tutorial.htm#s11">Autohotkey</a> version 1.1.33.09.
   </li>
   <li>
     <p>  <b>Recommended:</b> </p>
     <p> Any code editor which supports indentation-based code folding and autohotkey syntax support. 
     <p>  – &nbsp; <a href="https://code.visualstudio.com/">Visual Studio Code</a> Editor with the following extension IDs 
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
 


