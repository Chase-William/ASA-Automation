#Requires AutoHotkey v2.0

USE_SPRINT_CONFIG_KEY := "useSprint"
USE_SPRINT_FIELD_NAME := "m_useSprint"

AUTO_WALK_STATE_CHANGED := "autoWalk_changed"

global DisableOnManualWKey := false
global AutoWalker := false

; Disable auto walk visuals when key is pressed
$~w::{
  if (DisableOnManualWKey) {
    DisableOnManualWKey()
  }
}

; Handle the releasing of the w key
$w UP::{
  if (AutoWalker) {
    if (AutoWalker.IsOn) {
      Sleep 50
      AutoWalker.GetSynthesizer()()
    }      
  }
}

class AutoWalkController extends Observable {
  __New(cfg) {
    this.cfg := cfg

    this.m_isOn := false

    this.walkCallback := () => ControlSend("{w down}",, this.cfg.process.windowTitle)
    this.sprintCallback := () => ControlSend("{LSHIFT down}{w down}",, this.cfg.process.windowTitle)
    this.releaseWalkCallback := () => ControlSend("{w up}",, this.cfg.process.windowTitle)
    this.releaseSprintCallback := () => ControlSend("{LSHIFT up}{w up}",, this.cfg.process.windowTitle)

    this.releaseCallback := this.UseSprint ? this.releaseSprintCallback : this.releaseWalkCallback

    global DisableOnManualWKey := (*) => this.IsOn := false
    global AutoWalker := this
  }

  UseSprint {
    get => Config.GetMember(this, Config.GetToggle, USE_SPRINT_FIELD_NAME, USE_SPRINT_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetToggle, USE_SPRINT_FIELD_NAME, USE_SPRINT_CONFIG_KEY, value)
  }

  IsOn {
    get => this.m_isOn
    set {
      if (this.IsOn != value) {
        this.m_isOn := value        
        this.StateChanged.Invoke(AUTO_WALK_STATE_CHANGED, value)        
      }
    }
  } 

  AutoWalkToggle() {
    if (this.IsOn := !this.IsOn)
      this.GetSynthesizer()()
    else (this.releaseCallback)()
  }

  GetSynthesizer() {
    if (this.UseSprint) {
      this.releaseCallback := this.releaseSprintCallback
      return this.sprintCallback
    }
    this.releaseCallback := this.releaseWalkCallback
    return this.walkCallback
  }  
}