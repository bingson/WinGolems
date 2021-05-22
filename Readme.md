# WinGolems

A collection of Windows 10 automation and enhancement scripts (golems) written in Autohotkey. 

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
     <br> – &nbsp; <a href="https://www.autohotkey.com/">Autohotkey</a> version 1.1.33.09.
   </li>
   <li>
     <p>  <b>Recommended:</b> </p>
     <p>  – &nbsp; <a href="https://code.visualstudio.com/">Visual Studio Code</a> Editor with the following extension IDs 
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; slevesque.vscode-autohotkey
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; helsmy.ahk-simple-ls
     <br> &nbsp;&nbsp;&nbsp;&nbsp; + &nbsp; johnnywong.vscode-ts-whitespace-converter
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
     <p><b> Run MASTER.ahk as administrator </b></p>
     <p> After you have installed Autohotkey and unzipped the WinGolems project folder, navigate to the WinGolems folder using file explorer and run MASTER.ahk as administrator through the right-click context menu. 
     <p><img src="assets\Screens\run_master.png" alt="run_master.png" title="run_master.png" /></p>
   </li>
   <li>
     <p><b> Configure WinGolems </b></p>
     <p> Upon first run, a new settings file will be created. WinGolems will search through 32 bit and 64 bit Program File directories for executable paths used to launch specific apps and modify associated file types. To change these settings, please open <code>config.ini</code> in any text editor and update the file path values for the following variables.  

``` 
vscode_path
chrome_path
word_path
excel_path
ppt_path
pdf_path
```

   </li>
 </ul>
<br>

## Help

* Open HotKey_List.txt for a list of hotkeys
* [AHK Beginner Tutorial](https://www.autohotkey.com/docs/Tutorial.htm) 
