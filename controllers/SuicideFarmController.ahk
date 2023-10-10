#Requires AutoHotkey v2.0

class SuicideFarmController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user

    this.m_isSuicideFarmOn := false

    this.respawnCallback := this.Respawn.bind(this)
  }

  IsSuicideFarmOn {
    get => m_isSuicideFarmOn
    set => m_isSuicideFarmOn := value
  }

  AutoSuicideMeatFarmToggle() {
    if this.IsSuicideFarmOn := !this.IsSuicideFarmOn {
      SetTimer(respawnCallback, this.cfg.delay.xlw)
    } else {
      Settimer(respawnCallback, 0)
    }    
  }

  Respawn() {
    if (this.user.IsRespawnScreenAvailable()) {
      this.user.SearchBeds("meet my meat")
      Sleep this.cfg.delay.smw 
      this.user.SelectMeatFarmBeds()
      Sleep this.cfg.delay.smw
      this.user.Respawn() 
      Sleep this.cfg.delay.5xlw
    }
  }
}