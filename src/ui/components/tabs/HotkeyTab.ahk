#Requires AutoHotkey v2.0

#include "../HotkeyControl.ahk"
#include "../ToggleControl.ahk"
#include "../../../Util.ahk"

class HotkeyTab {
  __New(myGui, controller) {
    this.controller := controller

    title := myGui.AddText("w100 Section", "Control Panel")
    title.SetFont("Bold")

    onTop := myGui.AddCheckbox("x+m", "Always on Top?")
    onTop.OnEvent("Click", this.AlwaysOnTop_OnChecked.bind(this))

    ; myGui.AddText(, "Resolution")
    ; configOptions := GetConfigOptions()
    ; configComboBox := myGui.AddComboBox(, configOptions)

    ; myGui.AddLink("x+m x", '<a href="https://discord.gg/kwg69tty">Docs/Discord</a>')
    myGui.AddText("x+m x" (WINDOW_WIDTH - 100), "Discord: lilxdiest")

    ; Auto Clicker
    {
        HotkeyControl(myGui, "Auto Clicker", this.controller.AutoClickHotkey,"XS w100", "x+m w100", "x+m")
        myGui.AddText("x+m", "Keystroke:")
        this.keystrokeHotkey := myGui.AddHotkey("x+m w80", this.controller.autoClick.AutoClickKey)
        keystrokeSetBtn := myGui.AddButton("x+m Hidden", "Set")
        this.keystrokeHotkey.OnEvent("Change", (*) => keystrokeSetBtn.Visible := true)
        keystrokeSetBtn.OnEvent("Click", this.AutoClickKeySetBtn_Clicked.bind(this))
        rightClickCheckBox := myGui.AddCheckbox("x+m Checked" this.controller.autoClick.UseRightClick, "Right Click")
        rightClickCheckBox.OnEvent("Click", (sender, info) => this.controller.autoClick.UseRightClick := sender.Value)
    }    
    
    ; Geforce Auto Clicker
    {
        HotkeyControl(myGui, "Geforce Auto Clicker", this.controller.GeforceAutoClickHotkey,"XS w100", "x+m w100", "x+m")
        myGui.AddText("x+m", "Keystroke:")
        this.geforceKeystrokeHotkey := myGui.AddHotkey("x+m w80", this.controller.geforceAutoClick.AutoClickKey)
        geforceKeystrokeSetBtn := myGui.AddButton("x+m Hidden", "Set")
        this.geforceKeystrokeHotkey.OnEvent("Change", (*) => geforceKeystrokeSetBtn.Visible := true)
        geforceKeystrokeSetBtn.OnEvent("Click", this.GeforceAutoClickKeySetBtn_Clicked.bind(this))
        rightClickCheckBox := myGui.AddCheckbox("x+m Checked" this.controller.geforceAutoClick.UseRightClick, "Right Click")
        rightClickCheckBox.OnEvent("Click", (sender, info) => this.controller.geforceAutoClick.UseRightClick := sender.Value)
    }    

    ; HotkeyControl(myGui, "Auto Walk", this.controller.AutoWalkHotkey, "XS w100", "x+m w100", "x+m")
    ; sprintCheckBox := myGui.AddCheckbox("x+m Checked" this.controller.autoWalk.UseSprint, "Sprint")
    ; sprintCheckBox.OnEvent("Click", (sender, info) => this.controller.autoWalk.UseSprint := sender.Value)

    ; Auto Metal Farm
    ; HotkeyControl(myGui, "Auto Farm", this.controller.AutoFarmHotkey, "XS w100", "x+m w100", "x+m")
    ; configureFarmBtn := myGui.AddButton("x+m", "Configure")
    ; configureFarmBtn.OnEvent("Click", (*) => this.controller.farm.AutoFarmWindow.Visibility := !this.controller.farm.AutoFarmWindow.Visibility)

    ; Auto Metal Farm Drop Junk
    ; HotkeyControl(myGui, "Handle Farm", this.controller.HandleFarmHotkey, "XS w100", "x+m w100", "x+m")
    
    ; Give All Functionality
    ; MyGui.AddGroupBox("XS Section w" (WINDOW_WIDTH - DEFAULT_MARGIN) " h85", "Transfer Items")

    ; HotkeyControl(myGui, "Give All", this.controller.GiveAllHotkey, "XS x20 y130 w60", "x+m w90", "x+m")
    ; myGui.AddText("x+m", "Filter:")
    ; giveAllFilterEdit := myGui.AddEdit("x+m w200", SerializeArray(controller.transfer.GiveAllFilter))
    ; giveAllFilterEdit.OnEvent("Change", (sender, info) => controller.transfer.GiveAllFilter := DeserializeToArray(sender.Value))
    ; giveAllFilterCheckbox := myGui.AddCheckbox("x+m Checked" this.controller.transfer.UseGiveAllFilter, "")
    ; giveAllFilterCheckbox.OnEvent("Click", (sender, info) => this.controller.transfer.UseGiveAllFilter := sender.Value)

    ; Take All Functionality
    ; HotkeyControl(myGui, "Take All", this.controller.TakeAllHotkey, "XS x20 y160 w60", "x+m w90", "x+m")
    ; myGui.AddText("x+m", "Filter:")
    ; takeAllFilterEdit := myGui.AddEdit("x+m w200", SerializeArray(controller.transfer.TakeAllFilter))
    ; takeAllFilterEdit.OnEvent("Change", (sender, info) => controller.transfer.TakeAllFilter := DeserializeToArray(sender.Value))
    ; takeAllFilterCheckbox := myGui.AddCheckbox("x+m Checked" this.controller.transfer.UseTakeAllFilter, "")
    ; takeAllFilterCheckbox.OnEvent("Click", (sender, info) => this.controller.transfer.UseTakeAllFilter := sender.Value)

    ; Drop All Functionality
    ; MyGui.AddGroupBox("XS Section w" (WINDOW_WIDTH - DEFAULT_MARGIN) " h85", "Drop Items")

    ; Drop All Functionality
    ; HotkeyControl(myGui, "Player Drop All", this.controller.SelfDropAllHotkey, "XS x20 y220 w100", "x+m w90", "x+m")
    ; myGui.AddText("x+m", "Filter:")
    ; selfDropAllFilterEdit := myGui.AddEdit("x+m w200", SerializeArray(controller.drop.SelfDropAllFilter))
    ; selfDropAllFilterEdit.OnEvent("Change", (sender, info) => controller.drop.SelfDropAllFilter := DeserializeToArray(sender.Value))
    ; selfDropAllFilterCheckbox := myGui.AddCheckbox("x+m Checked" this.controller.drop.UseSelfDropAllFilter, "")
    ; selfDropAllFilterCheckbox.OnEvent("Click", (sender, info) => this.controller.drop.UseSelfDropAllFilter := sender.Value)

    ; HotkeyControl(myGui, "Other Drop All", this.controller.OtherDropAllHotkey, "XS x20 y250 w100", "x+m w90", "x+m")    
    ; myGui.AddText("x+m", "Filter:")
    ; otherDropAllFilterEdit := myGui.AddEdit("x+m w200", SerializeArray(controller.drop.OtherDropAllFilter))
    ; otherDropAllFilterEdit.OnEvent("Change", (sender, info) => controller.drop.OtherDropAllFilter := DeserializeToArray(sender.Value))
    ; otherDropAllFilterCheckbox := myGui.AddCheckbox("x+m Checked" this.controller.drop.UseOtherDropAllFilter, "")
    ; otherDropAllFilterCheckbox.OnEvent("Click", (sender, info) => this.controller.drop.UseOtherDropAllFilter := sender.Value)
 
    ; ToggleControl(myGui, "Auto Brew", false, (*) => this.controller.consume.AutoBrewToggle(), "Section XS")
    ; ToggleControl(myGui, "Auto Eat", false, (*) => this.controller.consume.AutoEatToggle(), "x+m")
    ; ToggleControl(myGui, "Auto Drink", false, (*) => this.controller.consume.AutoDrinkToggle(), "x+m")
    ; ToggleControl(myGui, "Auto Fish", false, (*) => this.controller.fishing.AutoFishToggle(), "Section XS")
    ; ToggleControl(myGui, "Auto Fert Farm", false, (*) => this.controller.fertFarm.AutoFertFarm(), "x+m")

    ; toggleCrosshair := ToggleControl(
    ;   myGui, 
    ;   "Custom Crosshair",
    ;   this.controller.crosshair.IsVisible,
    ;   (self, sender, info) => (sender.Value ? this.controller.crosshair.Show.bind(this.controller.crosshair) : this.controller.crosshair.Hide.bind(this.controller.crosshair))(), 
    ;   "XS")

    ; this.controller.crosshair.OnEvent(CROSSHAIR_VISIBILITY_CHANGED, (*) => toggleCrosshair.CheckBox.Value := this.controller.crosshair.IsVisible)

    ; crosshairSettingsBtn := myGui.AddButton("x+m", "Crosshair Settings")
    ; crosshairSettingsBtn.OnEvent("Click", (*) => this.controller.crosshair.ShowSettings())
  }

  AutoClickKeySetBtn_Clicked(sender, info) {
    this.controller.autoClick.AutoClickKey := this.keystrokeHotkey.Value
    sender.Visible := false
  }

  GeforceAutoCLickKeySetBtn_Clicked(sender, info) {
    this.controller.geforceAutoClick.AutoClickKey := this.geforceKeystrokeHotkey.Value
    sender.Visible := false
  }

  ; Handles check for keeping the tool window above all others
  AlwaysOnTop_OnChecked(sender, info) {
    WinSetAlwaysOnTop sender.Value, MAIN_WINDOW_TITLE
  }
}