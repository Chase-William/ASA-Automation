#Requires AutoHotkey v2.0

#include "../structures/Observable.ahk"

AUTO_CLICK_KEY_CONFIG_KEY := "autoClickKey"
USE_RIGHT_CLICK_CONFIG_KEY := "useRightClick"
GEFORCE_AUTO_CLICK_CONFIG_KEY := "geforceAutoClickKey"
GEFORCE_USE_RIGHT_CLICK_CONFIG_KEY := "geforceUseRightClick"

AUTO_CLICK_KEY_FIELD_NAME := "m_autoClickKey"
USE_RIGHT_CLICK_FIELD_NAME := "m_useRightClick"

AUTO_CLICKER_STATE_CHANGED := "autoClickStateChanged"
GEFORCE_AUTO_CLICKER_STATE_CHANGED := "geforceAutoClickStateChanged"

class AutoClickController extends Observable {
  __New(cfg, user, geforce := false) {  
    ; Seems that base prototypes are static as in multiple instancs of this class will use the same Obserable.. kinda odd..  
    this.base.base := Observable()
    this.cfg := cfg
    this.user := user
    
    this.m_isAutoClickerOn := false    

    ; Check if should use geforce config settings
    if (geforce) {
        this.m_keyConfigKey := GEFORCE_AUTO_CLICK_CONFIG_KEY
        this.m_useRightClickConfigKey := GEFORCE_USE_RIGHT_CLICK_CONFIG_KEY
        this.m_windowTitle := this.cfg.process.GeforceWindowTitle
        this.m_eventCode := GEFORCE_AUTO_CLICKER_STATE_CHANGED
    }
    else {
        this.m_keyConfigKey := AUTO_CLICK_KEY_CONFIG_KEY
        this.m_useRightClickConfigKey := USE_RIGHT_CLICK_CONFIG_KEY
        this.m_windowTitle := this.cfg.process.WindowTitle
        this.m_eventCode := AUTO_CLICKER_STATE_CHANGED  
    }    

    ; Callbacks for clicking
    this.defaultCallback := (*) => ControlClick(,this.m_windowTitle)
    this.keystrokeCallback := (*) => ControlSend(this.AutoClickKey,, this.m_windowTitle)
    this.rightClickCallback := (*) => ControlClick(,this.m_windowTitle,, "Right")
  }

  UseRightClick {
    get => Config.GetMember(this, Config.GetToggle, USE_RIGHT_CLICK_FIELD_NAME, this.m_useRightClickConfigKey)
    set => Config.SetMember(this, Config.SetToggle, USE_RIGHT_CLICK_FIELD_NAME, this.m_useRightClickConfigKey, value)
  }

  AutoClickKey {
    get => Config.GetMember(this, Config.GetRandom, AUTO_CLICK_KEY_FIELD_NAME, this.m_keyConfigKey)
    set => Config.SetMember(this, Config.SetRandom, AUTO_CLICK_KEY_FIELD_NAME, this.m_keyConfigKey, value)
  }

  IsAutoClickerOn {
    get => this.m_isAutoClickerOn
    set {
      this.m_isAutoClickerOn := Value
      this.StateChanged.Invoke(this.m_eventCode, value)
    }
  }

  Toggle() {
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

    return this.defaultCallback
  }
}