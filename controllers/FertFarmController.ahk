#Requires AutoHotkey v2.0

class FertFarmController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user
  }

  AutoFertFarm(hotkey) {
    ; Static variable for holding instance bound callback
    ; static fertCallback
    ; ; Bind callback if not already
    ; if !IsSet(fertCallback) { 
    ;   fertCallback := this.MainFertLoop.bind(this)
    ; }

    static on := false
    if on := !on {
      SetTimer(MainFertLoop, 1000)
    }
    else Reload
    
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
}