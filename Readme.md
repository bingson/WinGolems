# WinGolems

A collection of Windows 10 automation and enhancement scripts (golems) written in Autohotkey. 

----

## CONTENTS 

* [Getting Started](##Getting-Started)

----

## GETTING STARTED

### 1. &nbsp; Install Dependencies
 <ul>
   <li>
     <p>  <b>Required:</b> </p>
     <p>  – &nbsp; Install Windows 10 (tested on Home Version 20H2 OS build 19042.985)
     <br> – &nbsp; Install <a href="https://www.autohotkey.com/">Autohotkey</a> version 1.1.33.09.
   </li>
   <li>
     <p>  <b>Recommended:</b> </p>
     <p>  – &nbsp; Install <a href="https://code.visualstudio.com/">Visual Studio Code</a> Editor with the following extension IDs 
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
     <p> Download WinGolems as a zip file from the following web address and <a href="https://www.7-zip.org/">unzip</a> to the same drive Windows 10 and program files are installed.

``` 
https://github.com/bingson/WinGolems/archive/refs/heads/master.zip
```

   </li>
   <li>
     <p><b> Option 2: GIT </b></p>
     <p>    This option requires the installation of <a href="https://git-scm.com/book/en/v2/Getting-Started-Installing-Git">Git</a> and is recommended if you want to make contributions 
            to the project and easily update your local repo with new versions via git pull. To download this project through git, run command

``` 
git clone https://github.com/bingson/WinGolems.git 
```

   </li>
 </ul>



### 3. &nbsp; Run and configure WinGolems


 <ul>
   <li>
     <p><b> Run MASTER.ahk as administrator </b></p>
     <p> After you have installed Autohotkey and unzipped the WinGolems project folder, navigate to the WinGolems folder using file explorer and run MASTER.ahk as administrator through the right-click context menu. 
     <p><img src="assets\Screens\run_master.png" alt="run_master.png" title="run_master.png" /></p>
   </li>
   <li>
     <p><b> Configure WinGolems </b></p>
     <p> If WinGolems MASTER.ahk doesn't detect a settings file (<code>config.ini</code>) in the same folder, a new settings file will be created. WinGolems will search through Program Files (x86) and Program Files folders for application paths used to activate application specific windows and open associated file types. To modify these settings, please open <code>config.ini</code> in any text editor and modify the file path values for the following variables. 

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

## Usage




## Help

* For an introduction to AutoHotkey please visit [AHK Beginner Tutorial](https://www.autohotkey.com/docs/Tutorial.htm) 


To run this project, install it locally using npm:

```
$ cd ../lorem
$ npm install
$ npm start   
```

<hr>
<hr>
<hr>

# Project Title

Simple overview of use/purpose.

## Description

An in-depth paragraph about your project and overview of use.


## Help

Any advise for common problems or issues.
```
command to run if program contains helper info
```

## Authors

Contributors names and contact info

ex. Dominique Pizzie  
ex. [@DomPizzie](https://twitter.com/dompizzie)

## Version History

* 0.2
    * Various bug fixes and optimizations
    * See [commit change]() or See [release history]()
* 0.1
    * Initial Release

## License

This project is licensed under the [NAME HERE] License - see the LICENSE.md file for details

## Acknowledgments

Inspiration, code snippets, etc.
* [awesome-readme](https://github.com/matiassingers/awesome-readme)
* [PurpleBooth](https://gist.github.com/PurpleBooth/109311bb0361f32d87a2)
* [dbader](https://github.com/dbader/readme-template)
* [zenorocha](https://gist.github.com/zenorocha/4526327)
* [fvcproductions](https://gist.github.com/fvcproductions/1bfc2d4aecb01a834b46)