;
;  switch-lang.ahk
;


SwitchLang(str, n:=1) {
    static map1 := { 0x51: "Й", 0x57: "Ц", 0x45: "У", 0x52: "К", 0x54: "Е", 0x59: "Н", 0x55: "Г", 0x49: "Ш", 0x4f: "Щ", 0x50: "З", 0x7b: "Х", 0x7d: "Ъ", 0x41: "Ф", 0x53: "Ы", 0x44: "В", 0x46: "А", 0x47: "П", 0x48: "Р", 0x4a: "О", 0x4b: "Л", 0x4c: "Д", 0x3a: "Ж", 0x22: "Э", 0x5a: "Я", 0x58: "Ч", 0x43: "С", 0x56: "М", 0x42: "И", 0x4e: "Т", 0x4d: "Ь", 0x3c: "Б", 0x3e: "Ю", 0x7e: "Ё", 0x71: "й", 0x77: "ц", 0x65: "у", 0x72: "к", 0x74: "е", 0x79: "н", 0x75: "г", 0x69: "ш", 0x6f: "щ", 0x70: "з", 0x5b: "х", 0x5d: "ъ", 0x61: "ф", 0x73: "ы", 0x64: "в", 0x66: "а", 0x67: "п", 0x68: "р", 0x6a: "о", 0x6b: "л", 0x6c: "д", 0x3b: "ж", 0x27: "э", 0x7a: "я", 0x78: "ч", 0x63: "с", 0x76: "м", 0x62: "и", 0x6e: "т", 0x6d: "ь", 0x2c: "б", 0x2e: "ю", 0x60: "ё" }
    static map2 := { 0x419: "Q", 0x426: "W", 0x423: "E", 0x41a: "R", 0x415: "T", 0x41d: "Y", 0x413: "U", 0x428: "I", 0x429: "O", 0x417: "P", 0x424: "A", 0x42b: "S", 0x412: "D", 0x410: "F", 0x41f: "G", 0x420: "H", 0x41e: "J", 0x41b: "K", 0x414: "L", 0x42f: "Z", 0x427: "X", 0x421: "C", 0x41c: "V", 0x418: "B", 0x422: "N", 0x42c: "M", 0x439: "q", 0x446: "w", 0x443: "e", 0x43a: "r", 0x435: "t", 0x43d: "y", 0x433: "u", 0x448: "i", 0x449: "o", 0x437: "p", 0x444: "a", 0x44b: "s", 0x432: "d", 0x430: "f", 0x43f: "g", 0x440: "h", 0x43e: "j", 0x43b: "k", 0x434: "l", 0x44f: "z", 0x447: "x", 0x441: "c", 0x43c: "v", 0x438: "b", 0x442: "n", 0x44c: "m", 0x451: "``", 0x401: "~", 0x416: ":", 0x436: ";", 0x42d: """", 0x44d: "'", 0x425: "{", 0x445: "[", 0x42a: "}", 0x44a: "]", 0x411: "<", 0x431: ",", 0x42e: ">", 0x44e: "." }
    Loop, Parse, str
    {
        c := map%n%[Ord(A_LoopField)]
        if c {
            res := res . c
        } else {
            res := res . A_LoopField
        }
    }
    return res
}


GetLeftChars() {
    static chars := "QWERTYUIOP{}ASDFGHJKL:""ZXCVBNM<>~qwertyuiop[]asdfghjkl;'zxcvbnm,.``"
    len = StrLen(Clipboard)
    Loop
    {
        Clipboard =
        Send, +{Left}^c
        ClipWait
        len2 := StrLen(Clipboard)
        if ( len2 = len ) {
            break
        }
        if ( ! InStr(chars, SubStr(Clipboard, 1, 1)) ) {
            break
        }
        len := len2
    }
}


Pause::  ; Fix text
    prevClipboard := ClipboardAll
    Clipboard =
    Send, ^c
    ClipWait, 0.1
    if ( StrLen(Clipboard) < 1 ) {
        Send, ^+{Left}^c
        ClipWait
    }
    if (!ErrorLevel) {
        Loop, Parse, Clipboard
        {
            code := Ord(A_LoopField)
            if (0x41 <= code  && code <= 0x5A || 0x61 <= code  && code <= 0x7A || code == 0x5B || code == 0x5D || code == 0x7B || code == 0x7D || code == 0x3A || code == 0x3B || code == 0x22 || code == 0x27 || code == 0x60 || code == 0x7E || code == 0x2C || code == 0x2E || code == 0x3C || code == 0x3E ) {
                ; Eng chars, switching to Rus
                GetLeftChars()
                Clipboard := SwitchLang(Clipboard, 1)
                Send, ^v
                Send, {LAlt down}{LShift}{LAlt up}
                break
            }
            if (0x410 <= code  && code <= 0x42F || 0x430 <= code  && code <= 0x44F || code == 0x401 || code == 0x451) {
                ; Rus chars, switching to Eng
                Clipboard := SwitchLang(Clipboard, 2)
                Send, ^v
                Send, {LAlt down}{LShift}{LAlt up}
                break
            }
        }
        Sleep, 100
        Clipboard := prevClipboard
    }
return
