#Requires AutoHotkey v2.0

class KeybindTab {
  __New(myGui, controller) {    
    onChangeClosure := this.Hotkey_OnChange.bind(this)

    myGui.AddText("w200 Section", "Toggle Inventory Key")
    this.selfInvent := myGui.AddHotkey("x+m", controller.user.SelfInventoryToggleKeybind)
    this.selfInvent.OnEvent("Change", onChangeClosure)

    myGui.AddText("w200 XS Section", "Toggle Other Inventory Key")
    this.otherInvent := myGui.AddHotkey("x+m", controller.user.OtherInventoryToggleKeybind)
    this.otherInvent.OnEvent("Change", onChangeClosure)

    myGui.AddText("w200 XS Section", "Defecate Key")
    this.defecate := myGui.AddHotkey("x+m", controller.user.DefecateKeybind)
    this.defecate.OnEvent("Change", onChangeClosure)

    myGui.AddText("w200 XS Section", "Hotbar Heal Key")
    this.heal := myGui.AddHotkey("x+m", controller.user.SelfHealKeybind)
    this.heal.OnEvent("Change", onChangeClosure)

    myGui.AddText("w200 XS Section", "Hotbar Eat Key")
    this.eat := myGui.AddHotkey("x+m", controller.user.SelfEatKeybind)
    this.eat.OnEvent("Change", onChangeClosure)

    myGui.AddText("w200 XS Section", "Hotbar Drink Key")
    this.drink := myGui.AddHotkey("x+m", controller.user.SelfDrinkKeybind)
    this.drink.OnEvent("Change", onChangeClosure)

    this.saveBtn := myGui.AddButton("XS y+m w80", "Save")
    this.saveBtn.OnEvent("Click", this.SaveKeybindsBtn_OnClick.bind(this))
    this.saveBtn.Visible := false
  }

  ; Save keybinds
  SaveKeybindsBtn_OnClick(sender, info) {
    this.controller.user.SelfInventoryToggleKeybind := this.selfInvent.Value
    this.controller.user.OtherInventoryToggleKeybind := this.otherInvent.Value
    this.controller.user.DefecateKeybind := this.defecate.Value
    this.controller.user.SelfHealKeybind := this.heal.Value
    this.controller.user.SelfEatKeybind := this.eat.Value
    this.controller.user.SelfDrinkKeybind := this.drink.Value
    this.saveBtn.Visible := false
  }

  Hotkey_OnChange(sender, info) {
    this.saveBtn.Visible := true
  }
}