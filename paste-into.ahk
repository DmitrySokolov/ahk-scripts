;
;  paste-into.ahk
;


#^c::  ; Insert citation into Discord with Win+Ctrl+c
    prevClipboard := ClipboardAll
    ; Put selected text into clipboard
    Clipboard =
    Send, ^c
    ClipWait
    KeyWait Control
    KeyWait LWin
    KeyWait RWin
    KeyWait c
    if (!ErrorLevel) {
        ; Activate Discord app
        WinActivate, ahk_exe Discord.exe ahk_class Chrome_WidgetWin_1
        WinWaitActive, ahk_exe Discord.exe ahk_class Chrome_WidgetWin_1
        ; Move focus to input control
        Send, a
        Send, {Backspace}
        ; Paste text
        lines := StrSplit(Clipboard, "`r`n", , 2)
        if (lines.Length() > 1) {
            pos := InStr(lines[1], "Сегодня в")
            if (pos < 1) {
                pos := InStr(lines[1], "Today at")
            }
            if (pos > 0) {
                Clipboard := "@" . SubStr(lines[1], 1, pos-1) . "`n"
                Send, ^v
                Sleep, 100
                Clipboard := lines[2]
            }
        }
        Clipboard := "```````n" . Clipboard . "`n```````n"
        Send, ^v
        Sleep, 100
        Clipboard := prevClipboard
    }
return


#^e::  ; Insert @everyone into Discord with Win+Ctrl+e
    prevClipboard := ClipboardAll
    WinActivate, ahk_exe Discord.exe ahk_class Chrome_WidgetWin_1
    WinWaitActive, ahk_exe Discord.exe ahk_class Chrome_WidgetWin_1
    Clipboard := "@everyone "
    Send, ^v
    Sleep, 100
    Clipboard := prevClipboard
return


#^+c::  ; Insert code into Skype with Win+Ctrl+Shift+c
    prevClipboard := ClipboardAll
    Clipboard =
    Send, ^c
    ClipWait
    KeyWait Control
    KeyWait LWin
    KeyWait RWin
    KeyWait Shift
    KeyWait c
    if (!ErrorLevel) {
        WinActivate, ahk_exe Skype.exe ahk_class tSkMainForm
        WinWaitActive, ahk_exe Skype.exe ahk_class tSkMainForm
        ControlFocus, ClassNN, TChatRichEdit1
        lines := StrSplit(Clipboard, "`r`n", , 2)
        Clipboard := "{code}`n" . Clipboard . "`n{code}`n"
        Send, ^v
        Sleep, 100
        Clipboard := prevClipboard
    }
return


#`::  ; Win+`  Replace selected text with `text`
    prevClipboard := ClipboardAll
    Clipboard =
    Send, ^x
    ClipWait, 0.1
    if (!ErrorLevel && StrLen(Clipboard) > 0) {
        Clipboard := "``" . Clipboard . "``"
    } else {
        Clipboard := "``"
    }
    Send, ^v
    Sleep, 100
    Clipboard := prevClipboard
return
