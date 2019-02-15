UrlEscape( url, flags ) {
    VarSetCapacity( newUrl,4096,0 ), pcche := 4096
    DllCall( "shlwapi\UrlEscapeW", Str,url, Str,newUrl, UIntP,pcche, UInt,flags )
    Return newUrl
}


UrlUnEscape( url, flags ) {
    VarSetCapacity( newUrl,4096,0 ), pcche := 4096
    DllCall( "shlwapi\UrlUnescapeW", Str,url, Str,newUrl, UIntP,pcche, UInt,flags )
    Return newUrl
}


OpenURL(url, title:="") {
    prevClipboard := ClipboardAll
    Clipboard =
    Send, ^c
    ClipWait
    if (!ErrorLevel) {
        aStr := UrlEscape( RegExReplace(RegExReplace(Clipboard, "\r?\n"," "), "(^\s+|\s+$)"), 0x00080000 | 0x00002000 | 0x00001000)
        Clipboard := prevClipboard
        if SubStr(aStr,1,8)="https://"
            Run, %aStr%
        else
            Run, %url%%aStr%
        if title {
            WinWait, %title%
            WinActivate, %title%
        }
    }
}


#^s::  ; YaTranslate with Win+Ctrl+s
  OpenURL("https://translate.yandex.ru/?text=", "Яндекс.Переводчик")
return


#^w::  ; Search in WikiPedia with Win+Ctrl+w
  OpenUrl("https://en.wikipedia.org/wiki/")
return


#^r::  ; Search in RU WikiPedia with Win+Ctrl+r
  OpenUrl("https://ru.wikipedia.org/wiki/")
return


#^g::  ; Search in Google with Win+Ctrl+g
  OpenUrl("https://www.google.com/search?q=")
return
