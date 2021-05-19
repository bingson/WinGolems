
MoveUpWorkingDir(n = 1) { 
   ; returns a path string to the n-higher folder level
   loop %n%
       dirup%A_Index% := RegExReplace(A_ScriptDir, "(\\[^\\]+) {" A_Index "}$")
   return % dirup%n% 
}
 