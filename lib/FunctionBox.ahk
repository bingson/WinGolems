FunctionBox(func="", input_dict="", w_color = "CEDFBF", t_color = "000000", title="", name_dict = "") {
 
    ; opens an input box offering choices based on input_dict
    ; dictionary, name_dict(optional) will replace labels Programmatically generated
    ; from input_dict.
    ;
    ; func: calls a function that accepts values from the input array
    
    ; the value of input_dict will be treated as a parameter to that function. 

    global UserInput, med
    sleep ,med                                                                  ; short wait to delete hotstring
    TOC := (name_dict) ? BuildTOC(name_dict, true) : BuildTOC(input_dict)
    default_title := "  (-_-)   " 
    default_title .= (!title) ? AddSpaceBtnCaseChange(func, 0) : title
    
    ; title := (!title) ? "  (-_-)   " . AddSpaceBtnCaseChange(func, 0) : title
    FunctionBoxGUI(TOC, default_title, w_color, t_color) 
    if (func and input_dict[UserInput]) {
        %func%(input_dict[UserInput])
    } else if (!func and input_dict[UserInput]) {
        try 
        {
            command := input_dict[UserInput]
            %command%.call()
        }
    } else if UserInput                                                         
        FunctionBox(func,input_dict, w_color, t_color, title, name_dict)
    else
    return
}