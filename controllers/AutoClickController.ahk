#Requires AutoHotkey v2.0

AUTO_CLICK_KEY_CONFIG_KEY := "autoClickKey"

AUTO_CLICK_KEY_FIELD_NAME := "m_autoClickKey"

class AutoClickController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user
    
    this.m_isAutoClickerOn := false
  }

  AutoClickKey {
    get => Config.GetMember(this, AUTO_CLICK_KEY_FIELD_NAME, AUTO_CLICK_KEY_CONFIG_KEY)
    set => Config.SetMember(this, AUTO_CLICK_KEY_FIELD_NAME, AUTO_CLICK_KEY_CONFIG_KEY, value)
  }

  IsAutoClickerOn {
    get => this.m_isAutoClickerOn
    set {
      this.m_isAutoClickerOn := value
      ; super.StateChanged.Invoke(AUTO_CLICKER_STATE_CHANGED, value)
    }
  }

  AutoClickToggle() {  
    if this.IsAutoClickerOn := !this.IsAutoClickerOn {
      SetTimer(Click, this.cfg.delay.autoClickInterval)
    } else {
      SetTimer(Click, 0)
    }
  }
}