ReplaceAwithB(A = "", B = "", var = "", paste = True, regex = false) {
    var := (!var ? clip() : var)
    var := RegExReplace(var, "S) +", A_Space)
    if regex
        var := RegExReplace(var, A, B)
    else 
        var := StrReplace(var, A, B)

    if !paste
        return %var%
    clip(var, True)
    return
}