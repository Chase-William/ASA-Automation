#Requires AutoHotkey v2.0

class TransferController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user
    this.m_useGiveAllFilter := false
    this.m_useTakeAllFilter := false
  }
  
  UseGiveAllFilter {
    get => this.m_useGiveAllFilter
    set => this.m_useGiveAllFilter := value
  }

  UseTakeAllFilter {
    get => this.m_useTakeAllFilter
    set => this.m_useTakeAllFilter := value
  }

  GiveAll() {
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.lw
    if (this.UseGiveAllFilter) {
      this.user.SearchSelfAndGiveAll(this.cfg.filter.GiveAllFilter)
    } else {
      this.user.GiveAll()
    }
    Sleep this.cfg.delay.lw
    this.user.ToggleOtherInventory()
  }

  TakeAll() {
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.lw
    if (this.UseTakeAllFilter) {
      this.user.SearchOtherAndTakeAll(this.cfg.filter.TakeAllFilter)
    } else {
      this.user.TakeAll()
    }
    Sleep this.cfg.delay.lw
    this.user.ToggleOtherInventory()
  }
}