#region --- Au3Recorder generated code Start (v3.3.9.5 KeyboardLayout=00000412)  ---


#region --- Internal functions Au3Recorder Start ---
#pragma compile(Console, True)

#include <array.au3>

Func _Au3RecordSetup()
Opt('WinWaitDelay',100)
Opt('WinDetectHiddenText',1)
Opt('MouseCoordMode',0)
Local $aResult = DllCall('User32.dll', 'int', 'GetKeyboardLayoutNameW', 'wstr', '')
If $aResult[1] <> '00000412' Then
  MsgBox(64, 'Warning', 'Recording has been done under a different Keyboard layout' & @CRLF & '(00000412->' & $aResult[1] & ')')
EndIf

EndFunc

Func _WinWaitActivate($title,$text,$timeout=0)
	WinWait($title,$text,$timeout)
	If Not WinActive($title,$text) Then WinActivate($title,$text)
	WinWaitActive($title,$text,$timeout)
EndFunc
Func CheckWindows($aArray)
    For $i = 1 To Ubound($aArray) - 1
        If WinActive($aArray[$i][1]) Then
		   MsgBox(0, "Window Check", $aArray[$i][0] & " is active.")
	    EndIf
    Next
EndFunc

Func ActivateWindowOne($aArray)
	$searchstring1 = "nomad"
    For $i = 1 To Ubound($aArray) - 1
		Local $iPosition = StringInStr($aArray[$i][0], $searchstring1)
		If $iPosition > 0 Then

			If WinActivate($aArray[$i][1], "") Then

			Else
				MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR, "Error", "Window not activated")
			EndIf
		EndIf

    Next
EndFunc

Func _ConvertTime($timeToFormat)
    $timeSplit = StringSplit($timeToFormat, ":")

    $minute = Int($timeSplit[1])

    If $timeSplit[0] > 1 Then
        $second = Int($timeSplit[2])
    Else
        $second = 0
    EndIf



    $total =  $minute * 60 + $second

    Return($total)
EndFunc

Func Quit()
    Exit
EndFunc

_AU3RecordSetup()
HotKeySet("{ESC}","Quit") ;Press ESC key to qui

#endregion --- Internal functions Au3Recorder End ---





$value = "02:06"

$output = _ConvertTime($value)+2


$winList = WinList()
;CheckWindows($winList)
ActivateWindowOne($winList)

Sleep(1000)

MouseClick("left",400,400,1,10)


_WinWaitActivate("OBS 29.0.0 (64-bit, windows) - 프로파일: 제목 없음 - 장면: 제목 없음","")
MouseClick("left",1322,360,1)
Send("s")

Local $min = Number($output) * 1000
Sleep($min)

_WinWaitActivate("OBS 29.0.0 (64-bit, windows) - 프로파일: 제목 없음 - 장면: 제목 없음","")
MouseClick("left",1270,1,1)
Send("t")
#endregion --- Au3Recorder generated code End ---
