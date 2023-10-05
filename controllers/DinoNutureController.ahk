#Requires AutoHotkey v2.0

class DinoNutureController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user
    this.m_useNurtureFilter := false
  }
  
  UseNurtureFilter {
    get => this.m_useNurtureFilter
    set => this.m_useNurtureFilter := value
  }

  Nurture() {
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.lw
    if (this.UseNurtureFilter) {
      this.user.SearchSelfAndGiveAll(this.cfg.filter.NurtureFilter)
    } else {
      this.user.GiveAll()
    }
    Sleep this.cfg.delay.lw
    this.user.ToggleOtherInventory()
  }
}