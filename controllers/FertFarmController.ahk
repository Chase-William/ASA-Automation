#Requires AutoHotkey v2.0

class FertFarmController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user

    this.m_isAutoFertFarmOn := false
    this.fertCallback := this.MainFertLoop.bind(this)
  }

  IsAutoFertFarmOn {
    get => this.m_isAutoFertFarmOn
    set => this.m_isAutoFertFarmOn := value
  }

  AutoFertFarm(hotkey) {
    if this.IsAutoFertFarmOn := !this.IsAutoFertFarmOn {
      SetTimer(this.fertCallback, 1000)
    }
    else Reload
  } 

  MainFertLoop() {
    static count := 0
    if count++ < 250 {
      FertilizerFarm()
    } else {
      Reload
    }

    FertilizerFarm() {
      this.user.Defecate()
      Sleep this.cfg.delay.sw
      this.user.ToggleInventory()
      Sleep this.cfg.delay.mw
      this.user.FlushToilet()
      Sleep this.cfg.delay.sw
      this.user.ToggleInventory()
      Sleep this.cfg.delay.mw
    }
  }
}