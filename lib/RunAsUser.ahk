RunAsUser(Target, Arguments, WorkingDirectory)
{
   ; https://autohotkey.com/board/topic/79136-run-as-normal-user-not-as-admin-when-user-is-admin/
   
   static TASK_TRIGGER_REGISTRATION := 7                                        ; trigger on registration.
   static TASK_ACTION_EXEC := 0                                                 ; specifies an executable action.
   static TASK_CREATE := 2
   static TASK_RUNLEVEL_LUA := 0
   static TASK_LOGON_INTERACTIVE_TOKEN := 3
   objService := ComObjCreate("Schedule.Service") 
   objService.Connect() 

   objFolder := objService.GetFolder("") 
   objTaskDefinition := objService.NewTask(0) 

   principal := objTaskDefinition.Principal 
   principal.LogonType := TASK_LOGON_INTERACTIVE_TOKEN                          ; Set the logon type to TASK_LOGON_PASSWORD
   principal.RunLevel := TASK_RUNLEVEL_LUA                                      ; Tasks will be run with the least privileges.

   colTasks := objTaskDefinition.Triggers
   objTrigger := colTasks.Create(TASK_TRIGGER_REGISTRATION) 
   endTime += 1, Minutes                                                        ; end time = 1 minutes from now
   FormatTime,endTime,%endTime%,yyyy-MM-ddTHH`:mm`:ss
   objTrigger.EndBoundary := endTime
   colActions := objTaskDefinition.Actions 
   objAction := colActions.Create(TASK_ACTION_EXEC) 
   objAction.ID := "7plus run" 
   objAction.Path := Target
   objAction.Arguments := Arguments
   objAction.WorkingDirectory := WorkingDirectory ? WorkingDirectory : A_WorkingDir
   objInfo := objTaskDefinition.RegistrationInfo
   objInfo.Author := "7plus" 
   objInfo.Description := "Runs a program as non-elevated user" 
   objSettings := objTaskDefinition.Settings 
   objSettings.Enabled := True 
   objSettings.Hidden := False 
   objSettings.DeleteExpiredTaskAfter := "PT0S"
   objSettings.StartWhenAvailable := True 
   objSettings.ExecutionTimeLimit := "PT0S"
   objSettings.DisallowStartIfOnBatteries := False
   objSettings.StopIfGoingOnBatteries := False
   objFolder.RegisterTaskDefinition("", objTaskDefinition, TASK_CREATE , "", "", TASK_LOGON_INTERACTIVE_TOKEN ) 
}
