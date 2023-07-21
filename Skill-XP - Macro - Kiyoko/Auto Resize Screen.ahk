#NoEnv
#SingleInstance, force
SetCapsLockState, Off 
SetBatchLines -1
SoundPlay, SkillXP\Sound\on.wav
Version = 1.0
if (A_ScreenDPI != 96) {
    Run, ms-settings:display
    MsgBox,	16,Kiyoko's Macro, Your Scale `& layout settings need to be on 100`%
    ExitApp
}
global __Index__ := "Basic"
Gui, 2:Font, cBlack, Consolas
Gui, 2:Font, c4d79ff, Consolas
Gui, 2:+AlwaysOnTop -Caption
Gui, 2:Add, Text,xm-8 ym,Kiyoko's macro L to Exit K to Pause
Gui, 2:Add, Edit,ym+18 xm-8  -VScroll w214 h43 vStatus 
Gui, 2:Add, GroupBox,xm-10 ym-12 w300 h30
Gui, 2:Show, w216 h68, Kiyoko's Status Window
OnMessage(0x200,"MOUSEOVER")
WinWait, Kiyoko's Status Window
WinGetPos,,, W, H, Kiyoko's Status Window
WinGetPos,,,, _h_, ahk_class Shell_TrayWnd
ArrayPosition := [(A_ScreenWidth)-W, (A_ScreenHeight)-(H+_h_)]
WinMove, Kiyoko's Status Window,, ArrayPosition[1], ArrayPosition[2]
global Status
Notify(NewMessage) {
    Status.= NewMessage "`n"
    If (GetLine(Status, "`n") > 4)
        Status := SubStr(Status, InStr(Status,"`n") + 1)
    GuiControl, 2:, Status, %Status%
    Gui, 2:Submit, NoHide
}
Gui,+AlwaysOnTop -DPIScale -Caption +LastFound
Gui, Font, cBlack ,Consolas
Gui, Font, c4d79ff
Gui, Color, 404040, Font, cBlack, ,Consolas
Gui, Add, Text,x35 y10 w600 h50 +BackgroundTrans Center gMove, Version: %Version%  Version: %A_AhkVersion%
Gui, Add, Text,ym xm,Kiyoko's Macro
Gui, Add, GroupBox, xm ym+20 w30 h260
Gui, Add, GroupBox, xm+50 ym+20 w411 h260 vTitle, Home
Gui, Add, Text, xm+10 ym+40 gBack, K
Gui, Add, Picture,w27 h30 xm+2 ym+70         gTabDura, SkillXP\Icon&Menu\heart.png
Gui, Margin, 80, 50
Gui, Add, Text,ym xm             vd1            ,- Auto Screen Resize -
Gui, Add, DDL, w150 ym+20 xm     vd2            ,Both
Gui, Add, Text,ym+150 xm-1             vd3      ,- For more infos watch to the video on discord
Gui, Add, Text,ym+125 xm-1             vd4      ,- F2 to start the macro
Gui, Add, Text,ym+100 xm-1             vd5      ,- On the first Msg Box put how much cd does ur skill have.
Gui, Add, Button, x356 y250      vd15  gDura    ,Done
Gui, Margin, 80, 50
Gui, Add, Text, ym xm vm1 , Push up, Squat Macro
Gui, Add, Text, ym+45 xm vm3 , Basic Run Macro
Gui, Add, Button, ym+65 xm vm4 w70 grunmacro, Start
Notify("Loaded Ui")
HideTab("Treadmill")HideTab("Weight")HideTab("StrikePower")HideTab("StrikeSpeed")HideTab("Durability")HideTab("Misc")
Notify("Hide Tab")
IniRead, Treadmill, settings.ini, Data, Treadmill
IniRead, Weight, settings.ini, Data, Weight
IniRead, StrikePower, settings.ini, Data, StrikePower
IniRead, StrikeSpeed, settings.ini, Data, StrikeSpeed
IniRead, SkillXP, settings.ini, Data, SkillXP
for Item, Value in {"T": Treadmill, "W": Weight, "SP": Strikepower, "SS": StrikeSpeed, "d": Durability} {
    If (Value != "ERROR") {
        Loop, Parse, Value, `,
        {
            v := Item (A_Index * 2)
            GuiControl, ChooseString, %v%, %A_LoopField%
        }
    }
}
Notify("Loaded Settings")
Gui, Show, w480 h300
WinSet, Region, 0-0 R6-6 w480 h300
Notify("Succesfully Loaded Macro")Notify("Started at " A_Hour ":" A_Min ":" A_Sec)
Return
~k::pause
~l::ExitApp
Move:
    PostMessage, 0xA1, 2
Return
Back:
    GuiControl,, title, Home
    HideTab("Treadmill")HideTab("Weight")HideTab("StrikePower")HideTab("StrikeSpeed")HideTab("Durability")HideTab("Misc")
Return
TabSS:
    GuiControl,, title, Strike Speed Tab
    ShowTab("StrikeSpeed")
    Notify("Displaying StrikeSpeed Tab")
    HideTab("Treadmill")HideTab("Weight")HideTab("StrikePower")HideTab("Durability")HideTab("Misc")
Return
TabDura:
    GuiControl,, title, Skill XP Tab
    ShowTab("Durability")
    Notify("Displaying Skill XP Tab")
    HideTab("Treadmill")HideTab("Weight")HideTab("StrikePower")HideTab("StrikeSpeed")HideTab("Misc")
Return
Taball41:
    GuiControl,, title, Miscellaneous Tab
    ShowTab("Misc")
    Notify("Displaying Miscellaneous Tab")
    HideTab("Treadmill")HideTab("Weight")HideTab("StrikePower")HideTab("StrikeSpeed")HideTab("Durability")
Return


HideTab(Tab) {
    Switch Tab {
        case "Treadmill": v := "T"
        case "Weight": v := "W"
        case "StrikePower": v := "SP"
        case "StrikeSpeed": v := "SS"
        case "Durability": v := "d"
        case "Misc" : v:= "m"
    }
    Loop, 20
    {
        GuiControl, Hide, % v A_Index
    }
}
ShowTab(Tab) {
    Switch Tab {
        case "Treadmill": v := "T"
        case "Weight": v := "W"
        case "StrikePower": v := "SP"
        case "StrikeSpeed": v := "SS"
        case "Durability": v := "d"
        case "Misc" : v := "m"
    }
    Loop, 20
    {
        GuiControl, Show, % v A_Index
    }
}
SS:
    Gui, Submit, Hide
    Gui, Destroy
    Switch {
        case "Karate" : path1 := 960, path2 := 660
        case "Boxing" : path1 := 820, path2 := 580
        case "Capoeira" : path1 := 1300, path2 := 80
        case "Muay Thai" : path1 := 1100
        case "Advance Brawl" : path1 := 1800
    }
    If (SS4 = "Custom") {
        if (path1) {
            InputBox, path1, Kiyoko's Macro,%SS2% 1st Custom Walk Distance (Default: %path1%ms),, 400, 130
            if (ErrorLevel = 1) {
                MsgBox,,Kiyoko's Macro, Missing infomation 
                ExitApp
            }
        }
        if (path2) {
            InputBox, path2, Kiyoko's Macro,%SS2% 2nd Custom Walk Distance (Default: %path2%ms),, 400, 130
            If (ErrorLevel = 1) {
                MsgBox,,Kiyoko's Macro, Missing infomation 
                ExitApp
            }
        }
    }
Return
Dura:
    Gui, Submit, Hide
    Gui, Destroy
    __Index__ := "Durability"
    If (d6 = "Fatigue Estimate") {
        InputBox, MaxRound, Enter Round,,, 300 , 100
    }
    MsgBox, 262144,Kiyoko's Macro,Select account for left side
    IfMsgBox, Ok
    {
        Global LeftPID := Resize("Left")
    }
    MsgBox, 262144,Kiyoko's Macro,Select account for right side
    IfMsgBox, Ok
    {
        Global RightPID := Resize("Right")
    }
    MsgBox, 4,Kiyoko Auto Dura,Did it auto resized?
    IfMsgBox, No
    {
        Reload
    }

GetUrlStatus( URL, Timeout = -1 ) {
    ComObjError(0)
    static WinHttpReq := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WinHttpReq.Open("HEAD", URL, True), WinHttpReq.Send(), WinHttpReq.WaitForResponse(Timeout)  
    Return, WinHttpReq.Status()
}

Eat(i, v) {
    CoordMode, Mouse, Window
    CoordMode, Pixel, Window
    Loop
    {
        Sendinput, % sw("BackSpace")
        Notify("Sending Between " i)
        Switch i {
            case "1-0" : item := "0,9,8,7,6,5,4,3,2,1"
            case "2-0" : item := "0,9,8,7,6,5,4,3,2"
            case "3-0" : item := "0,9,8,7,6,5,4,3"
            case "4-0" : item := "0,9,8,7,6,5,4"
        }
        Loop, Parse, item, `,
        {
            Sendinput, % sw(A_LoopField)
            Sleep, 150
        }
        ImageSearch,,, 65, 525, 750, 585, SkillXP\BasicUI\3x2.bmp
        If (ErrorLevel = 1) { 
            If (v = "Inventory") or (v = "Scalar+Inventory") or (v = "Protein+Inventory") {
                Sendinput, % sw("``")
                Sleep, 500
                Switch i {
                    case "1-0" : v := 95, var := 10
                    case "2-0" : v := 165, var := 9
                    case "3-0" : v := 235, var := 8
                    case "4-0" : v := 305, var := 7
                }
                Loop, %var%
                {
                    ImageSearch, x, y, 80, 190, 670, 500, SkillXP\BasicUI\x8.bmp
                    If (ErrorLevel = 0) {
                        Click, %x%, %y%, Down
                        Click, %v%, 555, Up
                        v := v + 70
                    } else if (ErrorLevel = 1) {
                        If (A_Index = 1) {
                            Sendinput, % sw("``")
                            Return "Empty"
                        }
                        Break
                    }
                }
                Sleep 100
                Sendinput, % sw("``")
                MouseMove, 100, 480 ; doesn't have return here to repeat selection again 
            } else {
                Return "Empty"
            }
        } else {
            Notify("Found Slot")
            Break
        }
    }
    EatingTask := A_TickCount
	Loop,
	{
		Click, 100, 480
        Sleep, 100
		ImageSearch,,, 65, 525, 750, 585, SkillXP\BasicUI\3x2.bmp
		If (ErrorLevel = 1) {
			Return "Success"
		}
		ImageSearch,,, 125, 135, 140, 150, *30 SkillXP\BasicUI\Hunger.bmp
		If (ErrorLevel = 1) { 
			Return "Success"
		}
	} Until (EatingTask - A_TickCount > 60000)
	Return "Timeout"
}

MOUSEOVER() {
    If (A_Gui != "2")
        Return
    WinGetPos, X, Y, W, H, Kiyoko's Status Window 
    WinGetPos,,,, _h_, ahk_class Shell_TrayWnd
    ArrayPosition := [(A_ScreenWidth)-(W),(A_ScreenHeight)-(H+_h_)]
    If ((X = ArrayPosition[1]) AND (Y = ArrayPosition[2]))
        ArrayPosition := [(W)-(W),(A_ScreenHeight)-(H+_h_)]
    WinMove, Kiyoko's Status Window,, ArrayPosition[1], ArrayPosition[2]
}

Tag(v = "", i = "") {
    global Shiftlock
    ImageSearch,,, 20, 85, 170, 110, *20 SkillXP\BasicUI\combat.bmp
    if (ErrorLevel = 0) {
        SetTimer,, Off
        Notify("Found Combat Tag")
        if (Shiftlock = "on") {
            Sleep 300
            Sendinput, % sw("Shift")
            Notify("Shiftlock was on")
            Sleep 300
        }
        if (recordingtype != "Do nothing") {
            if (!GetColors(565, 90, "0xFFFFFF", 10)) {
                Sendinput, % sw("tab")
            }
            If (v = "Record") {
                Notify("Start Recording")
                IniRead, Key, settings.ini, Recording, Key
                If (Key = "Win+Alt+G") {
                    Send, % "#!" sw("g")
                } else {
                    Send, % sw(key)
                }
            }
            Sendinput, % sw("o","down")
            Sleep, 1500
            Sendinput, % sw("o","up")
            SoundPlay, SkillXP\Sound\broken.wav
            MouseMove, 575, 120
            Loop, 20
            {
               Send {WheelUp 10}
            }
            Mou(14, recordingtype)
            Click, 800, 120, down
            Click, 800, 248, up
            Mou(14, recordingtype)
            Click, 800, 248, down
            Click, 800, 376, up
            Mou(2, recordingtype)
            If (v = "ShadowPlay") {
                Notify("Start Shadow Play")
                IniRead, Key, settings.ini, Recording, Key
                If (Key = "Win+Alt+G") {
                    Send, % "#!" "{" sw("g")
                } else {
                    Send, % sw(key)
                }
            }
        }
        Loop,
        { 
            If (GetColors(50, 130, "0x3A3A3A", 40)) {
                Loop, 5
                {
                    Evasive("Walk")
                }
            } else {
                Evasive("Sprint")
            }
            ImageSearch,,, 20, 85, 170, 110, *20 SkillXP\BasicUI\combat.bmp
            if (ErrorLevel = 1) {
                Sleep, 300
                ImageSearch,,, 20, 85, 170, 110, *20 SkillXP\BasicUI\combat.bmp
                if (ErrorLevel = 1) {
                    Break
                }
            }
        }
    }
}

Evasive(Type) {
    Switch Type {
        Case "Walk" : {
            Notify("Walk")
            Button := ["up", "down", "left", "Space", "right"]
            Random, Direction, 1, 2
            Random, DirectionSide , 3, 5
            Notify(Button[Direction] "," Button[DirectionSide])
            Sendinput, % sw(Button[Direction],"down") sw(Button[DirectionSide],"down")
            Sleep, 2500
            Sendinput, % sw(Button[Direction],"up") sw(Button[DirectionSide],"up")
        }
        Case "Sprint" : {
            Notify("Sprint")
            Random, Action, 1, 2
            If (Action = 1) {
                Random, Direction, 1, 4
                Button := ["w", "a", "s", "d"]
                Notify(Button[Direction])
                Sendinput, % sw("Space","down") sw(Button[Direction],"down")
                Sleep, 50
                Sendinput, % sw("q") sw(Button[Direction],"up") sw("Space","up") 
                Sleep, 1000
            } else { 
                Button := ["Space", "left", "right"]
                Random, Direction, 1, 3
                Notify(Button[Direction])
                SendInput, % sw("w") sw("w","down") sw(Button[Direction],"down")  
                Sleep, 2500
                SendInput, % sw("w","up") sw(Button[Direction],"up")  
                Sleep, 100
            }
        }
    }
}
Mou(i, v) {
    Base = 120
    Loop, %i%
    {
        MouseMove, 575, Base
        If (v = "Screenshot") {
            SendInput, {PrintScreen}
        }
        Base := Base + 30
        Sleep, 200
    }
}
Recorder:
    Gui, 3:Submit, Hide
    Gui, 3:Destroy
    If (!KeyCombo) or (!List) {
        MsgBox,,Kiyoko's Macro, Now you can open the Auto Skill EXP Macro
        ExitApp
    } else {
        IniWrite, %KeyCombo%, settings.ini, Recording, Key
        IniWrite, %List%, settings.ini, Recording, Type
    }
Return
Saver:
    Gui, 4:Submit, Hide
    Gui, 4:Destroy
Return
Saved:
    Gui, Submit, Hide
    Gui, Destroy
Return
Exit(i) {
    CoordMode, Pixel, Window
    Sleep 1000
    global __Index__
    Switch __Index__ {
        case "Durability" : {
            Switch i {
                case "Exit Roblox" : {
                    f(LeftPID)
                    Loop,
                    {
                        ImageSearch,,, 20, 85, 170, 110, *20 SkillXP\BasicUI\combat.bmp
                    } Until (ErrorLevel = 1)
                    Process, Close, % LeftPID
                    f(RightPID)
                    Loop,
                    {
                        ImageSearch,,, 20, 85, 170, 110, *20 SkillXP\BasicUI\combat.bmp
                    } Until (ErrorLevel = 1)
                    Process, Close, % RightPID
                }
                case "Shutdown" : { 
                    Shutdown, 5
                }
            }
        }
        case "Basic" : {
            Switch i {
                case "Exit Roblox": {
                    Loop,
                    {
                        ImageSearch,,, 20, 85, 170, 110, *20 SkillXP\BasicUI\combat.bmp
                    } Until (ErrorLevel = 1)
                    Process, Close, RobloxPlayerBeta.exe
                } 
                case "Shutdown" : { 
                    Shutdown, 5
                }
            }
        }
    }
    Sleep 5000
    Sleep 5000
    ExitApp
}
GetLine(Text, var) {
    StringReplace, Text, Text, % var, % var, UseErrorLevel
    Return ( ( (var = "`n" || var = "`r") && (Text) ) ? ErrorLevel + 1 : ErrorLevel )
}

sw(key, state = "") {
    return "{" . format("sc{:x}", getKeySC(key)) " " . state . "}"
}
DurabilityFunction(i, v) {
    CoordMode, Pixel, Screen
    CoordMode, Mouse, Screen
    Switch v {
        case "Left" : f(LeftPID)
        case "Right" : f(RightPID)
    }
    Notify("Activating Dura")
    Sendinput, 2
    Sleep 1000
    StartDuraTimer := A_TickCount
    Switch v {
        case "Left" : {
            Click, 50, 470
            Sleep 500
            Notify("Activated Left Screen Dura")
            f(RightPID) 
        }
        case "Right" : {
            Click, 850, 470
            Sleep 500
            Notify("Activated Right Screen Dura")
            f(LeftPID)
        }
    }
    Notify("Activated Durability")
    Curr := "Full", ColorsID := "0x444444, 0x3D3DA2"
    OuterLoop:
    Loop,
    {
        If (A_TickCount - StartDuraTimer > 26000) {
            Notify("Took > 26 Secconds")
            Break
        }
        Switch v {
            case "Left" : Click, 850, 470
            case "Right" : Click, 50, 470
        }
        Switch Curr {
            case "Full" : Sleep, 200
            case "Half" : Sleep, 400
            case "Low"  : Sleep, 600
        }
        Y1 := 105, Y2 := 106
        Switch v {
            case "Left" : {
                Switch Curr {
                    case "Full" : X1 := 130, X2 := 131
                    case "Half" : X1 := 90, X2 := 91
                    case "Low" : X1 := 80, X2 := 81
                }
            }
            case "Right" : {
                Switch Curr {
                    case "Full" : X1 := 930, X2 := 931
                    case "Half" : X1 := 890, X2 := 891
                    case "Low" : X1 := 880, X2 := 881          
                }
            }
        }
        If (i != "None") {
            X1 := X1 + 20
            X2 := X2 + 20
        }
        Loop, Parse, ColorsID, `,
        {
            If (GetColors(X2, Y2, A_LoopField, 30)) {
                Switch Curr {
                    case "Full" : Curr := "Half"
                    case "Half" : Curr := "Low"
                    case "Low" : Break OuterLoop
                }
                Notify("Current Phase " Curr " for" v)
                Break
            }
        }
    }
    Switch v {
        case "Left" : f(LeftPID)
        case "Right" : f(RightPID)
    }
    Sleep 500
    Switch v {
        case "Left" : {
            ImageSearch,,, 10, 90, 260, 120, *30 SkillXP\BasicUI\HPBar.bmp
            If (ErrorLevel = 0) {
                Return "Push"
            }
            Click, 50, 470, 10
        }
        case "Right" : {
            ImageSearch,,, 810, 90, 1060, 120, *30 SkillXP\BasicUI\HPBar.bmp
            If (ErrorLevel = 0) {
                Return "Push"
            }
            Click, 850, 470, 10
        }
    }
    Notify("Finished Durability")
}

Resize(i) {
    ; Make it return PID and place ui in specific position
    WinActive("Roblox")
    Switch i {
        case "Left" : WinMove, Roblox,, (0)-(10), (0)-(10), 100, 100
        case "Right" : WinMove, Roblox,, (0)-(-790), (0)-(10), 100, 100
    }
    WinGet, v, PID, Roblox
    Return v
}

f(i) {
    WinActivate, ahk_pid %i%
    Sleep 100
}
GuiClose:
    ExitApp
Return
runmacro:
    gui, Destroy
    IniRead, i, settings.ini, Data, AutoRun
    gui, add, ddl, ym vv1,run|strave|strave+knock|burnfat
    if (i != "ERROR") or (!i) {
        GuiControl, ChooseString, v1, %i% 
    }
    gui, add, button, ym gSaved, Start
    gui, show,, Kiyoko's Stam Macro 
    WinWaitClose, Kiyoko's Stam Macro
    WinActive("Roblox")
    MouseMove, 409, 491
    Loop
    {
        if WinExist("Ahk_exe RobloxPlayerBeta.exe") {
            WinActivate
            WinGetPos,,,W,H,A
            if ((W >= A_ScreenWidth) & (H >= A_ScreenHeight)) {
                Send, % sw("F11")
                Sleep, 1000
            }
            if ((W > 816) & ( H > 638)) {
                WinMove, Ahk_exe RobloxPlayerBeta.exe,,,, 800, 599 
                Notify("Resized Window")
            }
        } else {
            MsgBox,,Kiyoko's Macro,Roblox not active,3
            ExitApp
        }
        switch v1 {
            case "run" : {
                SendInput, % sw("w")sw("w", "down")
                Sleep 4000
                SendInput, % sw("w", "up")
                If (GetColors(35, 130, "0x3A3A3A", 40)) {
                    Notify("Wait, 10000")
                    Sleep 10000
                }
                ImageSearch,,, 40, 135, 50, 150, *30 SkillXP\BasicUI\Hunger.bmp
                If (ErrorLevel = 0) {
                    Switch Eat("1-0", "Inventory") {
                        Case "Success" : Sendinput, % sw("BackSpace")
                    }
                }
            }
            case "strave+knock" : {
                SendInput, % sw("down","down")sw("w")sw("w", "down")
                Sleep 4000
                SendInput, % sw("w", "up")sw("down","up")
            }
            case "strave" : {
                SendInput, % sw("down","down")sw("w")sw("w", "down")
                Sleep 4000
                SendInput, % sw("w", "up")sw("down","up")
                ImageSearch,,, 40, 135, 50, 150, *30 SkillXP\BasicUI\Hunger.bmp
                If (ErrorLevel = 0) {
                    Switch Eat("1-0", "Inventory") {
                        Case "Success" : Sendinput, % sw("BackSpace")
                    }
                }
            }
            case "burnfat" : {
                SendInput, % sw("down","down")sw("w")sw("w", "down")
                Sleep, 4000
                SendInput, % sw("w", "up")sw("down","up")
                If (GetColors(35, 130, "0x3A3A3A", 40)) {
                    Notify("Wait, 10000")
                    Sleep, 10000
                }
                ImageSearch,,, 0, 145, 70, 170, *10 SkillXP\BasicUI\DrinkStatus3.bmp
                If (ErrorLevel = 1) {
                    Notify("status not found")
                    Sendinput, {Backspace}1
                    Sleep, 150
                    ImageSearch,,, 65, 525, 750, 585, SkillXP\BasicUI\3x2.bmp
                    If (ErrorLevel = 1) { 
                        notify("fatburner has ranout from inventory")
                        v1 := "run"
                    } else {
                        Click
                        waittime := A_TickCount
                        Loop,
                        {
                            Sleep, 100
                            ImageSearch,,, 0, 145, 70, 170, *10 SkillXP\BasicUI\DrinkStatus3.bmp
                        } Until (ErrorLevel = 0) or (A_TickCount - waittime > 12000)
                        notify("dranked fatburner")
                        Sendinput, {BackSpace}
                    }
                }
            }
        }
    }
Return

PressR:
    Sendinput, % sw("r")
Return

GetColors(x, y, target, tolerance) {
    PixelGetColor, OutputVar, x, y
    tr := format("{:d}","0x" . substr(target,3,2)),tg := format("{:d}","0x" . substr(target,5,2)), tb := format("{:d}","0x" . substr(target,7,2))
    pr := format("{:d}","0x" . substr(OutputVar,3,2)),pg := format("{:d}","0x" . substr(OutputVar,5,2)),pb := format("{:d}","0x" . substr(OutputVar,7,2))
    distance := sqrt((tr-pr)**2+(tg-pg)**2+(pb-tb)**2)
    if (distance<tolerance)
        return true
    return false
}








