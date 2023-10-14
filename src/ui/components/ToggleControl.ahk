#Requires AutoHotkey v2.0

class ToggleControl {
  __New(myGui, title, value, function, options) {
    this.function := function
    this.m_checkbox := myGui.AddCheckbox(options (value ? " Checked1" : " Checked0"), title)
    this.m_checkbox.OnEvent("Click", this.ToggleCheckbox_OnClick.bind(this))
  }

  CheckBox => this.m_checkbox

  ToggleCheckbox_OnClick(sender, info) {
    this.function(sender, info)
  }
}