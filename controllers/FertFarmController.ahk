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

  AutoFertFarm() {
    WinActivate(this.cfg.process.windowTitle)
    if this.IsAutoFertFarmOn := !this.IsAutoFertFarmOn {
      SetTimer(this.fertCallback, -1000)
    }
  } 

  MainFertLoop() {
    count := 0
    While count++ < 250 {
      this.FertilizerFarm()
    }
    this.IsAutoFertFarmOn := false    
  }

  FertilizerFarm() {
    this.user.Defecate()
    Sleep this.cfg.delay.sw
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.mw
    this.user.FlushToilet()
    Sleep this.cfg.delay.sw
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.mw
  }
}