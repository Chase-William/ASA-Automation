#Requires AutoHotkey v2.0

#include "../HotkeyControl.ahk"

class HotkeyTab {
  __New(myGui, controller) {
    this.controller := controller
    title := myGui.AddText("w200 Section", "Tool Control Panel")
    title.SetFont("Bold")

    onTop := myGui.AddCheckbox("x+m", "Always on Top?")
    onTop.OnEvent("Click", this.AlwaysOnTop_OnChecked.bind(this))

    ; myGui.AddText(, "Drop Metal Farm Junk")
    ; myGui.AddHotkey("x+m")

    ; myGui.AddText("Section w200", "Auto Clicker: ")
    ; autoClickHotkey := myGui.AddHotkey("x+m")

    ; myGui.AddText("Section XS w200", "Auto Metal Farmer:")
    ; autoMetalFarmHotkey := myGui.AddHotkey("x+m")
    
    HotkeyControl(myGui, "Auto Clicker:", this.controller.AutoClickHotkey,,,)
    HotkeyControl(myGui, "Auto Metal Farm", this.controller.AutoMetalFarmHotkey,,,)
    HotkeyControl(myGui, "Drop Metal Farm Junk:", this.controller.DropMetalFarmJunkHotkey,,,)
    HotkeyControl(myGui, "Auto Self Meat Farm", this.controller.AutoSuicideMeatFarmHotkey, true,,)
  }

  ; Handles check for keeping the tool window above all others
  AlwaysOnTop_OnChecked(sender, info) {
    WinSetAlwaysOnTop sender.Value, LIL_XD_HELPER_TOOL_WINDOW_TITLE
  }
}