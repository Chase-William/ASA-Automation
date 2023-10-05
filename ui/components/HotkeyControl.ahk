#Requires AutoHotkey v2.0

class HotkeyControl {
  __New(myGui, title, myHotkey, hotKeyOptions := "", btnOptions := "") {
    this.m_hotkeyStr := myHotkey.HotkeyStr
    this.m_myHotkey := myHotkey    

    myGui.AddText("w200 " hotKeyOptions " Section", title)
    hotkeyGui := myGui.AddHotkey("x+m", myHotkey.HotkeyStr)
    hotkeyGui.OnEvent("Change", this.Hotkey_OnChanged.bind(this))
    
    this.setBtn := myGui.AddButton("x+m w80 Hidden " btnOptions, "Set") 
    this.setBtn.OnEvent("Click", this.SetBtn_OnClick.bind(this))
  }

  HotkeyStr {
    get {
      return this.m_hotkeyStr
    }
    set {
      this.m_hotkeyStr := value
      this.setBtn.Visible := true
    }
  }

  ; Handles new key combination changes
  Hotkey_OnChanged(sender, info) {
    this.HotkeyStr := sender.Value
  }

  ; Perform the actual hotkey update with the OS
  SetBtn_OnClick(sender, info) {
    Hotkey this.m_myHotkey.HotkeyStr,, "Off"
    this.m_myHotkey.HotkeyStr := this.HotkeyStr
    this.m_myHotkey.RegisterHotkey()
    sender.Visible := false
  }
}