#Requires AutoHotkey v2.0

class ToggleControl {
  __New(myGui, title, function, options) {
    this.function := function
    toggleBox := myGui.AddCheckbox(options, title)
    toggleBox.OnEvent("Click", this.ToggleCheckbox_OnClick.bind(this))
  }

  ToggleCheckbox_OnClick(sender, info) {
    this.function()
  }
}