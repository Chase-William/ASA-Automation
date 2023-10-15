#Requires AutoHotkey v2.0

#include "../structures/Observable.ahk"

class ConsumeController extends Observable {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user

    this.m_isAutoBrewOn := false
    this.m_isAutoEatOn := false
    this.m_isAutoDrinkOn := false

    this.autoBrewCallback := this.AutoBrew.bind(this)
    this.autoEatCallback := this.AutoEat.bind(this)
    this.autoDrinkCallback := this.AutoDrink.bind(this)
  }

  IsAutoBrewOn {
    get => this.m_isAutoBrewOn
    set {
      this.m_isAutoBrewOn := value
      this.StateChanged.Invoke(AUTO_BREW_STATE_CHANGED, value)
    }
  }

  IsAutoEatOn {
    get => this.m_isAutoEatOn
    set {
      this.m_isAutoEatOn := value
      this.StateChanged.Invoke(AUTO_EAT_STATE_CHANGED, value)
    }
  }

  IsAutoDrinkOn {
    get => this.m_isAutoDrinkOn
    set {
      this.m_isAutoDrinkOn := value
      this.StateChanged.Invoke(AUTO_DRINK_STATE_CHANGED, value)
    }
  }

  AutoBrewToggle() {
    if this.IsAutoBrewOn := !this.IsAutoBrewOn {
      SetTimer(this.autoBrewCallback, this.cfg.delay._3xlw)
    } else {
      SetTimer(this.autoBrewCallback, 0)
    }   
  }

  AutoEatToggle() {
    if this.IsAutoEatOn := !this.IsAutoEatOn {
      SetTimer(this.autoEatCallback, this.cfg.delay._3xlw)
    } else {
      SetTimer(this.autoEatCallback, 0)
    }  
  }

  AutoDrinkToggle() {
    if this.IsAutoDrinkOn := !this.IsAutoDrinkOn {
      SetTimer(this.autoDrinkCallback, this.cfg.delay._3xlw)
    } else {
      SetTimer(this.autoDrinkCallback, 0)
    }  
  }

  AutoBrew() {
    if (this.ThresholdReached(this.user.SelfHealthThresholdPosition.X, this.user.SelfHealthThresholdPosition.Y)) {
      this.user.MedBrew()
    }
  }

  AutoEat() {
    if (this.ThresholdReached(this.user.SelfFoodThresholdPosition.X, this.user.SelfFoodThresholdPosition.Y)) {
      this.user.Eat()
    }
  }

  AutoDrink() {
    if (this.ThresholdReached(this.user.SelfWaterThresholdPosition.X, this.user.SelfWaterThresholdPosition.Y)) {
      this.user.Drink()
    }
  }

  ThresholdReached(x, y) {
    pixel := PixelGetColor(x, y)
    ; MsgBox pixel, pixel
    ; Parse hex color to rbg components

    red := SubStr(pixel, 3, 2)
    green := SubStr(pixel,5, 2)
    blue := SubStr(pixel, 7, 2)

    red := HexToDec(red)
    green := HexToDec(green)
    blue := HexToDec(blue)

    rg := Abs(green - red)
    gb := Abs(blue - green)
    rb := Abs(blue - red)

    maskTotal := rg + gb + rb

    ; Range for health had
    ; if (maskTotal > 300 AND maskTotal < 360) {
    ;   ; Health high, no need to med brew
    ; } 
    ; Range for health lost
    if (maskTotal > 20 AND maskTotal < 80) {
      ; Health low, need to med brew
      ; ControlSend Format("{1}", this.user.SelfHealKeybind),, this.cfg.process.windowTitle
      return true
    }
    return false
  }
}