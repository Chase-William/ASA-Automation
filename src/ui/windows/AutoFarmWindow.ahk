#Requires AutoHotkey v2.0

#include "../../Util.ahk"

class AutoFarmWindow {
  __New(cfg, farm) {
    this.cfg := cfg
    this.farm := farm

    this.m_visibility := false
    this.myGui := Gui(, "Auto Farm Settings")

    ; Closing logic
    this.myGui.OnEvent("Close", (*) => this.Visibility := false)
    this.myGui.OnEvent("Escape", (*) => this.Visibility := false)

    ; Create ui
    this.myGui.AddText("Section w50", "Drop All")
    this.dropAllEdit := this.myGui.AddEdit("x+m w200", SerializeArray(farm.AutoFarmDropAllFilter))
    this.myGui.AddText("Section XS w50", "Take All")
    this.takeAllEdit := this.myGui.AddEdit("x+m w200", SerializeArray(farm.AutoFarmTakeAllFilter))
  
    saveBtn := this.myGui.AddButton("XS", "Save")
    saveBtn.OnEvent("Click", this.OnSaveBtn_Clicked.bind(this))
    cancelBtn := this.myGui.AddButton("x+m", "Cancel")
    cancelBtn.OnEvent("Click", this.OnCancelBtn_Clicked.bind(this))
  }

  Visibility {
    get => this.m_visibility
    set {
      if (this.m_visibility != value) {
        if (value) {
          this.myGui.Show("w300 h100")
        } else {
          this.myGui.Hide()
        }
        this.m_visibility := value
      }
    }
  }

  OnCancelBtn_Clicked(sender, info) {
    this.dropAllEdit.Value := SerializeArray(this.farm.AutoFarmDropAllFilter)
    this.takeAllEdit.Value := SerializeArray(this.farm.AutoFarmTakeAllFilter)
  }

  OnSaveBtn_Clicked(sender, info) {
    this.farm.AutoFarmDropAllFilter := this.dropAllEdit.Value
    this.farm.AutoFarmTakeAllFilter := this.takeAllEdit.Value
  }
}