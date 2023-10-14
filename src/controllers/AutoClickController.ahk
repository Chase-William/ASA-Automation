#Requires AutoHotkey v2.0

AUTO_CLICK_KEY_CONFIG_KEY := "autoClickKey"

AUTO_CLICK_KEY_FIELD_NAME := "m_autoClickKey"

class AutoClickController extends Observable {
  __New(cfg, user) { 
    this.base.base.__New() 
    this.cfg := cfg
    this.user := user
    
    this.m_isAutoClickerOn := false

    this.keystrokeCallback := (*) => ControlSend(this.AutoClickKey,, this.cfg.process.windowTitle)
  }

  AutoClickKey {
    get => Config.GetMember(this, Config.GetRandom, AUTO_CLICK_KEY_FIELD_NAME, AUTO_CLICK_KEY_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetRandom, AUTO_CLICK_KEY_FIELD_NAME, AUTO_CLICK_KEY_CONFIG_KEY, value)
  }

  IsAutoClickerOn {
    get => this.m_isAutoClickerOn
    set {
      this.m_isAutoClickerOn := Value
      this.StateChanged.Invoke(AUTO_CLICKER_STATE_CHANGED, value)
    }
  }

  AutoClickToggle() {
    if this.IsAutoClickerOn := !this.IsAutoClickerOn {
      SetTimer(this.GetSynthesizer(), this.cfg.delay.autoClickInterval)
    } else {
      SetTimer(this.GetSynthesizer(), 0)
    } 
  }

  GetSynthesizer() {
    if (StrLen(this.AutoClickKey) != 0) {
      return this.keystrokeCallback
    } else {
      return Click
    }
  }
}