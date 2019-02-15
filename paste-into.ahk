﻿#^c::  ; Insert citation into Discord with Win+Ctrl+c
    prevClipboard := ClipboardAll
    Clipboard =
    Send, ^c
    ClipWait
    if !(ErrorLevel) {
        WinActivate, ahk_exe Discord.exe ahk_class Chrome_WidgetWin_1
        WinWaitActive, ahk_exe Discord.exe ahk_class Chrome_WidgetWin_1
        Send, {Tab}
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
    if !(ErrorLevel) {
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