  RepeatString(_string, _count) {
    ; Fast way to create a string of a repeated character
    local result
    VarSetCapacity(result, StrLen(_string) * _count)
    AutoTrim Off
    Loop %_count%
        result = %result%%_string%
    return result
  }
 