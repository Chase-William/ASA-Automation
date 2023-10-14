class LilxDHotkey {
  __New(configKey, actionCallback) {
    this.m_configKey := configKey
    this.m_actionCallback := actionCallback

    this.m_hotkeyStr := Config.GetHotkey(this.m_configKey)
    this.Key := this.m_hotkeyStr
  }

  ; Stores the hotkey as a string, does not enable or disabled the hotkey itself
  HotkeyStr {
    get => this.m_hotkeyStr
    set {
      Config.SetHotkey(this.m_configKey, value)
      this.m_hotkeyStr := value
      ; Update the isolated key info
      this.Key := value
    }
  }

  Key {
    get {
      if (!IsSet(m_hotkeyStr)) {
        Error("Property 'Key' should never be accessed before 'HotkeyStr' is initialized.")
      }
      return this.m_key
    }
    ; Should only be called from within this class
    set {
      if (StrLen(value) == 0) {
        this.m_key := ""
        return
      }
      dataArray := StrSplit(value, ["#", "!", "^", "+", "&", "<", ">", "<^>!", "*", "~", "$", "UP"],)
      key := dataArray[dataArray.Length]
      ; MsgBox "Test", key
      this.m_key := key
    }
  }

  UnregisterHotkey() {
    if (StrLen(this.HotkeyStr) > 0)
      Hotkey this.HotkeyStr,, "Off"
  }

  RegisterHotkey() {
    if (StrLen(this.HotkeyStr) > 0)
      Hotkey(this.HotkeyStr, this.m_actionCallback)
  }
}