#Requires AutoHotkey v2.0

#include "../structures/Observable.ahk"

class ConsumeController extends Observable {
  __New(cfg, user) {
    this.base.base.__New()

    this.cfg := cfg
    this.user := user

    this.m_isAutoBrewOn := false
    this.m_isAutoEatOn := false
    this.m_isAutoDrinkOn := false

    this.autoBrewCallback := this.MaybeDrinkBrew.bind(this)

    ; this.m_stateChangedEvent := Event(this)
  }

  IsAutoBrewOn {
    get => this.m_isAutoBrewOn
    set {
      this.m_isAutoBrewOn := value
      super.m_stateChangedEvent.Invoke(AUTO_BREW_STATE_CHANGED, value)
    }
  }

  IsAutoEatOn {
    get => this.m_isAutoEatOn
    set {
      this.m_isAutoEatOn := value
      super.m_stateChangedEvent.Invoke(AUTO_EAT_STATE_CHANGED, value)
    }
  }

  IsAutoDrinkOn {
    get => this.m_isAutoDrinkOn
    set {
      this.m_isAutoDrinkOn := value
      super.m_stateChangedEvent.Invoke(AUTO_DRINK_STATE_CHANGED, value)
    }
  }

  AutoBrewToggle() {
    if this.IsAutoBrewOn := !this.IsAutoBrewOn {
      SetTimer(this.autoBrewCallback, this.cfg.delay._3xlw)
    } else {
      Settimer(this.autoBrewCallback, 0)
    }   
  }

  MaybeDrinkBrew() {
    pixel := PixelGetColor(this.user.SelfHealthThresholdPosition.X, this.user.SelfHealthThresholdPosition.Y)
    ; MsgBox pixel, pixel
    ; Parse hex color to rbg components

    red := SubStr(pixel, 3, 2)
    green := SubStr(pixel,5, 2)
    blue := SubStr(pixel, 7, 2)

    ; MsgBox "Test", Format("{1} {2} {3}", this.HexToDec(red), this.HexToDec(green), this.HexToDec(blue))

    red := HexToDec(red)
    green := HexToDec(green)
    blue := HexToDec(blue)

    rg := Abs(green - red)
    gb := Abs(blue - green)
    rb := Abs(blue - red)

    maskTotal := rg + gb + rb

    ; Range for health had
    if (maskTotal > 300 AND maskTotal < 360) {
      ; Health high, no need to med brew
      
    } 
    ; Range for health lost
    else if (maskTotal > 20 AND maskTotal < 80) {
      ; Health low, need to med brew
      ControlSend Format("{1}", this.user.SelfHealKeybind),, this.cfg.process.windowTitle
    }
  }

  AutoEatToggle() {
    if this.IsAutoEatOn := !this.IsAutoEatOn {
      ; SetTimer(autoBrewCallback, this.cfg.delay._3xlw)
    } else {
      ; Settimer(autoBrewCallback, 0)
    }  
  }

  AutoDrinkToggle() {
    if this.IsAutoDrinkOn := !this.IsAutoDrinkOn {
      ; SetTimer(autoBrewCallback, this.cfg.delay._3xlw)
    } else {
      ; Settimer(autoBrewCallback, 0)
    }  
  }
}