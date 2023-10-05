#Requires AutoHotkey v2.0

#include "../HotkeyControl.ahk"
#include "../ToggleControl.ahk"

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
    
    HotkeyControl(myGui, "Auto Clicker:", this.controller.AutoClickHotkey, "XS")
    HotkeyControl(myGui, "Auto Metal Farm", this.controller.AutoMetalFarmHotkey, "XS")
    HotkeyControl(myGui, "Handle Metal Farm Junk:", this.controller.DropMetalFarmJunkHotkey, "XS")
    HotkeyControl(myGui, "Nurture Dino", this.controller.NurtureDinoHotkey, "XS")
    nurtureFilterCheckbox := myGui.AddCheckbox("XS Section ", "Use Nurture Filter?")
    nurtureFilterCheckbox.OnEvent("Click", (sender, info) => this.controller.dinoNurturer.UseNurtureFilter := sender.Value)
    myGui.AddText("x+m", "Filter:")
    nurtureFilterEdit := myGui.AddEdit("x+m w80", controller.cfg.filter.NurtureFilter)
    nurtureFilterEdit.OnEvent("Change", (sender, info) => controller.cfg.filter.NurtureFilter := sender.Value)

    ToggleControl(myGui, "Auto Self Meat Farm", (*) => this.controller.AutoSuicideMeatFarmToggle(), "Section XS")
    ToggleControl(myGui, "Auto Brew", (*) => this.controller.AutoBrewToggle(), "Section XS")
    ToggleControl(myGui, "Auto Eat", (*) => {}, "x+m")
    ToggleControl(myGui, "Auto Eat", (*) => {}, "x+m")
    ToggleControl(myGui, "Auto Fish", (*) => this.controller.AutoFishToggle(), "Section XS")

    ; HotkeyControl(myGui, "Nurture Dino", (*) => this.controll)
    ; autoRecast := myGui.AddCheckbox("x+m", "Auto Recast")
    ; autoRecast.OnEvent("Click", this.AutoRecastCheckbox_OnClick.bind(this))
    

    ; ToggleControl(myGui, "Auto Eat", this.controller., true,,)
    ; ToggleControl(myGui, "Auto Drink", this.controller., true,,)
  }

  ; AutoRecastCheckbox_OnClick(sender, info) {
  ;   ; Toggle recast
  ;   this.controller.fishing.AutoRecast := sender.Value
  ; }

  ; Handles check for keeping the tool window above all others
  AlwaysOnTop_OnChecked(sender, info) {
    WinSetAlwaysOnTop sender.Value, LIL_XD_HELPER_TOOL_WINDOW_TITLE
  }
}