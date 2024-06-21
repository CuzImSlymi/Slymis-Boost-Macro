; if you have questions/problems you can ask me on discord, my user is slymih

#Requires AutoHotkey v2.0
#SingleInstance

IniFilePath := A_Desktop "\settings_boost.ini"

global Slot1 := "69", Slot2 := "69", Slot3 := "69", Slot4 := "69", Slot5 := "69", Slot6 := "69", Slot7 := "69"

LoadSettings()

; GUI
MyGui := Gui()
MyGui.SetFont("bold s13")
MyGui.Add("Text",, "Slymi's Boost Macro")
MyGui.SetFont("norm s9")
MyGui.Add("Text", "Section", " Enter the time for each Slot to be used in Seconds") 
MyGui.Add("Text", "Section", " Type 0 if you dont want the slot to be used:") 
MyGui.Add("Text",, "Slot 1:")
Slot1Edit := MyGui.Add("Edit", "w120", Slot1)
MyGui.Add("Text",, "Slot 2:")
Slot2Edit := MyGui.Add("Edit", "w120", Slot2)
MyGui.Add("Text",, "Slot 3:")
Slot3Edit := MyGui.Add("Edit", "w120", Slot3)
MyGui.Add("Text",, "Slot 4:")
Slot4Edit := MyGui.Add("Edit", "w120", Slot4)
MyGui.Add("Text",, "Slot 5:")
Slot5Edit := MyGui.Add("Edit", "w120", Slot5)
MyGui.Add("Text",, "Slot 6:")
Slot6Edit := MyGui.Add("Edit", "w120", Slot6)
MyGui.Add("Text",, "Slot 7:")
Slot7Edit := MyGui.Add("Edit", "w120", Slot7)

MyGui.Add("Text", "xm y+20") ; spacer
StartButton := MyGui.Add("Button", "xm y+10 w90 h30", "Start")  
StopButton := MyGui.Add("Button", "x+10 w90 h30", "Stop")  

MyGui.Show()

timers := []

StartButton.OnEvent("Click", StartMacro)
StopButton.OnEvent("Click", StopMacro)

StartMacro(*) {
    global Slot1, Slot2, Slot3, Slot4, Slot5, Slot6, Slot7
    global Slot1Edit, Slot2Edit, Slot3Edit, Slot4Edit, Slot5Edit, Slot6Edit, Slot7Edit
    global timers
    
    ; retrieve values from gui
    Slot1 := Slot1Edit.Value
    Slot2 := Slot2Edit.Value
    Slot3 := Slot3Edit.Value
    Slot4 := Slot4Edit.Value
    Slot5 := Slot5Edit.Value
    Slot6 := Slot6Edit.Value
    Slot7 := Slot7Edit.Value

    if (!IsNumber(Slot1) || !IsNumber(Slot2) || !IsNumber(Slot3) || !IsNumber(Slot4) || !IsNumber(Slot5) || !IsNumber(Slot6) || !IsNumber(Slot7)) {
        MsgBox("Only enter valid numbers, for decimal numbers use e.g 10.5, not 10,5")
        return
    }
    
    SaveSettings()
    
    ; clear existing timers
    for _, timer in timers {
        SetTimer(timer, "Delete")
    }
    timers := []
    
    if (Slot1 != "0") {
        SetTimer(PressKey1, Slot1 * 1000)
        timers.Push("PressKey1")
    }
    if (Slot2 != "0") {
        SetTimer(PressKey2, Slot2 * 1000)
        timers.Push("PressKey2")
    }
    if (Slot3 != "0") {
        SetTimer(PressKey3, Slot3 * 1000)
        timers.Push("PressKey3")
    }
    if (Slot4 != "0") {
        SetTimer(PressKey4, Slot4 * 1000)
        timers.Push("PressKey4")
    }
    if (Slot5 != "0") {
        SetTimer(PressKey5, Slot5 * 1000)
        timers.Push("PressKey5")
    }
    if (Slot6 != "0") {
        SetTimer(PressKey6, Slot6 * 1000)
        timers.Push("PressKey6")
    }
    if (Slot7 != "0") {
        SetTimer(PressKey7, Slot7 * 1000)
        timers.Push("PressKey7")
    }
}

StopMacro(*) {
    SaveSettings()
    ExitApp
}

PressKey1(*) {
    Send("1")
}

PressKey2(*) {
    Send("2")
}

PressKey3(*) {
    Send("3")
}

PressKey4(*) {
    Send("4")
}

PressKey5(*) {
    Send("5")
}

PressKey6(*) {
    Send("6")
}

PressKey7(*) {
    Send("7")
}

IsNumber(value) {
    return RegExMatch(value, "^\d+(\.\d+)?$")
}

MyGui.OnEvent("Close", GuiClose)

GuiClose(*) {
    SaveSettings()
    ExitApp
}

F1::StartMacro
F3::StopMacro

LoadSettings() {
    global IniFilePath, Slot1, Slot2, Slot3, Slot4, Slot5, Slot6, Slot7

    if !FileExist(IniFilePath) {
        CreateDefaultIni()
    } else {
        try {
            Contents := FileRead(IniFilePath)

            for Line in StrSplit(Contents, "`n") {
                if InStr(Line, "=") {
                    Key := Trim(StrSplit(Line, "=")[1])
                    Value := Trim(SubStr(Line, InStr(Line, "=") + 1))
                    if (Key = "Slot1") {
                        Slot1 := Value
                    } else if (Key = "Slot2") {
                        Slot2 := Value
                    } else if (Key = "Slot3") {
                        Slot3 := Value
                    } else if (Key = "Slot4") {
                        Slot4 := Value
                    } else if (Key = "Slot5") {
                        Slot5 := Value
                    } else if (Key = "Slot6") {
                        Slot6 := Value
                    } else if (Key = "Slot7") {
                        Slot7 := Value
                    }
                }
            }
        } catch {
            MsgBox("Error reading settings from INI file. Using default values.")
        }
    }
}

SaveSettings() {
    global IniFilePath, Slot1Edit, Slot2Edit, Slot3Edit, Slot4Edit, Slot5Edit, Slot6Edit, Slot7Edit

    Slot1 := Slot1Edit.Value
    Slot2 := Slot2Edit.Value
    Slot3 := Slot3Edit.Value
    Slot4 := Slot4Edit.Value
    Slot5 := Slot5Edit.Value
    Slot6 := Slot6Edit.Value
    Slot7 := Slot7Edit.Value

    Contents := "[Settings]`n"
    Contents .= "Slot1=" . Slot1 . "`n"
    Contents .= "Slot2=" . Slot2 . "`n"
    Contents .= "Slot3=" . Slot3 . "`n"
    Contents .= "Slot4=" . Slot4 . "`n"
    Contents .= "Slot5=" . Slot5 . "`n"
    Contents .= "Slot6=" . Slot6 . "`n"
    Contents .= "Slot7=" . Slot7

    FileDelete(IniFilePath)
    FileAppend(Contents, IniFilePath)
}

CreateDefaultIni() {
    global IniFilePath
    Contents := "[Settings]`nSlot1=69`nSlot2=69`nSlot3=69`nSlot4=69`nSlot5=69`nSlot6=69`nSlot7=69"
    FileAppend(Contents, IniFilePath)
    MsgBox("Created default INI file.")
}
