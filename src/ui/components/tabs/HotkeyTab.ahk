#Requires AutoHotkey v2.0

#include "../HotkeyControl.ahk"
#include "../ToggleControl.ahk"
#include "../../../Util.ahk"

class HotkeyTab {
  __New(myGui, controller) {
    this.controller := controller
    title := myGui.AddText("w150 Section", "Control Panel")
    title.SetFont("Bold")

    onTop := myGui.AddCheckbox("x+m", "Always on Top?")
    onTop.OnEvent("Click", this.AlwaysOnTop_OnChecked.bind(this))

    ; myGui.AddText(, "Resolution")
    ; configOptions := GetConfigOptions()
    ; configComboBox := myGui.AddComboBox(, configOptions)

    myGui.AddLink("x+m x" (WINDOW_WIDTH - 100), '<a href="https://github.com/Chase-William/ASA-Automation#function-index">Documentation</a>')
    
    ; Auto Clicker
    HotkeyControl(myGui, "Auto Clicker Hotkey", this.controller.AutoClickHotkey,"XS w150", "x+m w100", "x+m")
    myGui.AddText("x+m", "Keystroke:")
    this.keystrokeHotkey := myGui.AddHotkey("x+m", this.controller.autoClick.AutoClickKey)
    keystrokeSetBtn := myGui.AddButton("x+m Hidden", "Set")
    this.keystrokeHotkey.OnEvent("Change", (*) => keystrokeSetBtn.Visible := true)
    keystrokeSetBtn.OnEvent("Click", this.AutoClickKeySetBtn_Clicked.bind(this))

    ; Auto Metal Farm
    HotkeyControl(myGui, "Auto Metal Farm", this.controller.AutoMetalFarmHotkey, "XS w150", "x+m w100", "x+m")
    ; Auto Metal Farm Drop Junk
    HotkeyControl(myGui, "Handle Metal Farm Junk", this.controller.DropMetalFarmJunkHotkey, "XS w150", "x+m w100", "x+m")
    
    ; Give All Functionality
    MyGui.AddGroupBox("XS Section w" (WINDOW_WIDTH - DEFAULT_MARGIN) " h85", "Transfer Items")

    HotkeyControl(myGui, "Give All", this.controller.GiveAllHotkey, "XS x20 y155 w60", "x+m w90", "x+m")
    myGui.AddText("x+m", "Filter:")
    giveAllFilterEdit := myGui.AddEdit("x+m w80", controller.cfg.filter.GiveAllFilter)
    giveAllFilterEdit.OnEvent("Change", (sender, info) => controller.cfg.filter.GiveAllFilter := sender.Value)
    giveAllFilterCheckbox := myGui.AddCheckbox("x+m", "")
    giveAllFilterCheckbox.OnEvent("Click", (sender, info) => this.controller.transfer.UseGiveAllFilter := sender.Value)

    ; Take All Functionality
    HotkeyControl(myGui, "Take All", this.controller.TakeAllHotkey, "XS x20 y185 w60", "x+m w90", "x+m")
    myGui.AddText("x+m", "Filter:")
    takeAllFilterEdit := myGui.AddEdit("x+m w80", controller.cfg.filter.TakeAllFilter)
    takeAllFilterEdit.OnEvent("Change", (sender, info) => controller.cfg.filter.TakeAllFilter := sender.Value)
    takeAllFilterCheckbox := myGui.AddCheckbox("x+m ", "")
    takeAllFilterCheckbox.OnEvent("Click", (sender, info) => this.controller.transfer.UseTakeAllFilter := sender.Value)

    ; Drop All Functionality
    MyGui.AddGroupBox("XS Section w" (WINDOW_WIDTH - DEFAULT_MARGIN) " h85", "Drop Items")

    ; Drop All Functionality
    HotkeyControl(myGui, "Player Drop All", this.controller.SelfDropAllHotkey, "XS x20 y245 w100", "x+m w90", "x+m")
    myGui.AddText("x+m", "Filter:")
    selfDropAllFilterEdit := myGui.AddEdit("x+m w80", controller.cfg.filter.SelfDropAllFilter)
    selfDropAllFilterEdit.OnEvent("Change", (sender, info) => controller.cfg.filter.SelfDropAllFilter := sender.Value)
    selfDropAllFilterCheckbox := myGui.AddCheckbox("x+m Checked" this.controller.drop.UseSelfDropAllFilter, "")
    selfDropAllFilterCheckbox.OnEvent("Click", (sender, info) => this.controller.drop.UseSelfDropAllFilter := sender.Value)

    HotkeyControl(myGui, "Other Drop All", this.controller.OtherDropAllHotkey, "XS x20 y275 w100", "x+m w90", "x+m")    
    myGui.AddText("x+m", "Filter:")
    otherDropAllFilterEdit := myGui.AddEdit("x+m w80", controller.cfg.filter.OtherDropAllFilter)
    otherDropAllFilterEdit.OnEvent("Change", (sender, info) => controller.cfg.filter.OtherDropAllFilter := sender.Value)
    otherDropAllFilterCheckbox := myGui.AddCheckbox("x+m Checked" this.controller.drop.UseOtherDropAllFilter, "")
    otherDropAllFilterCheckbox.OnEvent("Click", (sender, info) => this.controller.drop.UseOtherDropAllFilter := sender.Value)
 
    ToggleControl(myGui, "Auto Brew", (*) => this.controller.consume.AutoBrewToggle(), "Section XS")
    ToggleControl(myGui, "Auto Eat", (*) => this.controller.consume.AutoEatToggle(), "x+m")
    ToggleControl(myGui, "Auto Drink", (*) => this.controller.consume.AutoDrinkToggle(), "x+m")
    ToggleControl(myGui, "Auto Fish", (*) => this.controller.fishing.AutoFishToggle(), "Section XS")
    ToggleControl(myGui, "Auto Fert Farm", (*) => this.controller.fertFarm.AutoFertFarm(), "x+m")
  }

  AutoClickKeySetBtn_Clicked(sender, info) {
    this.controller.autoClick.AutoClickKey := this.keystrokeHotkey.Value
    sender.Visible := false
  }

  ; Handles check for keeping the tool window above all others
  AlwaysOnTop_OnChecked(sender, info) {
    WinSetAlwaysOnTop sender.Value, LIL_XD_HELPER_TOOL_WINDOW_TITLE
  }
}