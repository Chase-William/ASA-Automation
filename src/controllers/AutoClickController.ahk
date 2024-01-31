#Requires AutoHotkey v2.0

#include "../structures/Observable.ahk"

AUTO_CLICK_KEY_CONFIG_KEY := "autoClickKey"
USE_RIGHT_CLICK_CONFIG_KEY := "useRightClick"

AUTO_CLICK_KEY_FIELD_NAME := "m_autoClickKey"
USE_RIGHT_CLICK_FIELD_NAME := "m_useRightClick"

AUTO_CLICKER_STATE_CHANGED := "autoClickStateChanged"

class AutoClickController extends Observable {
  __New(cfg, user) { 
    this.cfg := cfg
    this.user := user
    
    this.m_isAutoClickerOn := false

    this.keystrokeCallback := (*) => ControlSend(this.AutoClickKey,, this.cfg.process.windowTitle)
    this.rightClickCallback := (*) => Click("Right")
  }

  UseRightClick {
    get => Config.GetMember(this, Config.GetToggle, USE_RIGHT_CLICK_FIELD_NAME, USE_RIGHT_CLICK_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetToggle, USE_RIGHT_CLICK_FIELD_NAME, USE_RIGHT_CLICK_CONFIG_KEY, value)
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
    if (this.UseRightClick) {
      return this.rightClickCallback
    }

    if (StrLen(this.AutoClickKey) != 0) {
      return this.keystrokeCallback
    }

    return Click
  }
}