#Requires AutoHotkey v2.0

USE_GIVE_ALL_STR_CONFIG_KEY := "useGiveAllFilter"
USE_TAKE_ALL_STR_CONFIG_KEY := "useTakeAllFilter"

USE_GIVE_ALL_STR_FIELD_NAME := "m_useGiveAllFilter"
USE_TAKE_ALL_STR_FIELD_NAME := "m_useTakeAllFilter"

class TransferController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user
    this.m_useGiveAllFilter := false
    this.m_useTakeAllFilter := false

    this.m_isTransferExecuting := false
  }
  
  IsTransferExecuting {
    get => this.m_isTransferExecuting
    set => this.m_isTransferExecuting := value
  }

  UseGiveAllFilter {
    get => Config.GetMember(this, Config.GetToggle, USE_GIVE_ALL_STR_FIELD_NAME, USE_GIVE_ALL_STR_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetToggle, USE_GIVE_ALL_STR_FIELD_NAME, USE_GIVE_ALL_STR_CONFIG_KEY, value)
  }

  UseTakeAllFilter {
    get => Config.GetMember(this, Config.GetToggle, USE_TAKE_ALL_STR_FIELD_NAME, USE_TAKE_ALL_STR_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetToggle, USE_TAKE_ALL_STR_FIELD_NAME, USE_TAKE_ALL_STR_CONFIG_KEY, value)
  }

  GiveAll() {
    this.IsTransferExecuting := true
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.mw
    if (this.UseGiveAllFilter) {
      this.user.SearchSelfAndGiveAll(this.cfg.filter.GiveAllFilter)
    } else {
      this.user.GiveAll()
    }
    Sleep this.cfg.delay.mw
    this.user.ToggleOtherInventory()
    this.IsTransferExecuting := false
  }

  TakeAll() {
    this.IsTransferExecuting := true
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.mw
    if (this.UseTakeAllFilter) {
      this.user.SearchOtherAndTakeAll(this.cfg.filter.TakeAllFilter)
    } else {
      this.user.TakeAll()
    }
    Sleep this.cfg.delay.mw
    this.user.ToggleOtherInventory()
    this.IsTransferExecuting := false
  }
}