#SingleInstance, Force

SetWorkingDir %A_ScriptDir%
SetBatchLines -1

; Variable to store the post-wait duration
postWaitTime := 0

; Show input box to select the number of seconds to wait after completing all tasks
InputBox, postWaitTime, Post Wait Duration, Please enter the cooldown of ur skill that u tryna make XP

; Validate the input
if (postWaitTime = "")
{
    MsgBox, You did not enter a post-wait duration. The macro will exit.
    return
}

Loop
{
    Pause, On  ; Pause the loop initially

    F2::  ; Main hotkey to start the macro
        Pause, Off  ; Resume the loop
        Loop
        {
            ; First part
            ; Start the macro
            SendInput, {w down}
            Sleep, 3000 ; Press 'w' for 2.5 seconds
            SendInput, {w up}

            ; Press Shift Lock once
            SendInput, +{LShift}
            Sleep, 1000

            ; Click at the specified position
            Click, -20, 423
            Sleep 1000

            ;second part
            SendInput, +{LShift}
            SendInput, {w down}
            Sleep, 3000 ; Press 'w' for 2.5 seconds
            SendInput, {w up}
            SendInput, {Click}
            Sleep, 1000
            SendInput, {s down}
            Sleep, 3000 ; Press 's' for 2.5 seconds
            SendInput, {s up}
            Sleep, 1000
            SendInput, +{LShift}
            Sleep, 500
            Click, 1397, 388
            SendInput, +{LShift}
            Sleep, 500
            SendInput, {s down}
            Sleep, 3000 ; Press 's' for 2.5 seconds
            SendInput, {s up}

            ; Wait for the specified post-wait duration
            Sleep, postWaitTime * 1000 ; Convert seconds to milliseconds
        }
        return
}

l::
ExitApp