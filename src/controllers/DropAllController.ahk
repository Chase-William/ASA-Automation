#Requires AutoHotkey v2.0

USE_SELF_DROP_ALL_FILTER_CONFIG_KEY := "useSelfDropAllFilter"
USE_OTHER_DROP_ALL_FILTER_CONFIG_KEY := "useOtherDropAllFilter"
USE_AUTO_SELF_DROP_ALL_FILTER_CONFIG_KEY := "useSelfAutoDropWhenEncumbered"
USE_AUTO_OTHER_DROP_ALL_FILTER_CONFIG_KEY := "useOtherAutoDropWhenEncumbered"

USE_SELF_DROP_ALL_FILTER_FIELD_NAME := "m_useOtherDropAllFilter"
USE_OTHER_DROP_ALL_FILTER_FIELD_NAME := "m_useOtherDropAllFilter"
USE_AUTO_SELF_DROP_ALL_FILTER_FIELD_NAME := "m_useSelfAutoDropWhenEncumbered"
USE_AUTO_OTHER_DROP_ALL_FILTER_FIELD_NAME := "m_useOtherAutoDropWhenEncumbered"

class DropAllController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user

    this.m_isDropAllExecuting := false
  }

  IsDropAllExecuting {
    get => this.m_isDropAllExecuting
    set => this.m_isDropAllExecuting := value
  }

  UseSelfDropAllFilter {
    get => Config.GetMember(this, Config.GetToggle, USE_SELF_DROP_ALL_FILTER_FIELD_NAME, USE_SELF_DROP_ALL_FILTER_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetToggle, USE_SELF_DROP_ALL_FILTER_FIELD_NAME, USE_SELF_DROP_ALL_FILTER_CONFIG_KEY, value)
  }

  UseOtherDropAllFilter {
    get => Config.GetMember(this, Config.GetToggle, USE_OTHER_DROP_ALL_FILTER_FIELD_NAME, USE_OTHER_DROP_ALL_FILTER_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetToggle, USE_OTHER_DROP_ALL_FILTER_FIELD_NAME, USE_OTHER_DROP_ALL_FILTER_CONFIG_KEY, value)
  }

  ; UseSelfAutoDropWhenEncumbered {
  ;   get => Config.GetMember(this, Config.GetToggle, USE_AUTO_SELF_DROP_ALL_FILTER_FIELD_NAME, USE_AUTO_SELF_DROP_ALL_FILTER_CONFIG_KEY)
  ;   set => Config.SetMember(this, Config.SetToggle, USE_AUTO_SELF_DROP_ALL_FILTER_FIELD_NAME, USE_AUTO_SELF_DROP_ALL_FILTER_CONFIG_KEY, value)
  ; }

  ; UseOtherAutoDropWhenEncumbered {
  ;   get => Config.GetMember(this, Config.GetToggle, USE_AUTO_OTHER_DROP_ALL_FILTER_FIELD_NAME, USE_AUTO_OTHER_DROP_ALL_FILTER_CONFIG_KEY)
  ;   set => Config.SetMember(this, Config.SetToggle, USE_AUTO_OTHER_DROP_ALL_FILTER_FIELD_NAME, USE_AUTO_OTHER_DROP_ALL_FILTER_CONFIG_KEY, value)
  ; }

  SelfDropAll() {
    this.IsDropAllExecuting := true
    this.user.ToggleSelfInventory()
    Sleep this.cfg.delay.mw
    if (this.UseSelfDropAllFilter) {
      this.user.SearchSelfAndDropAll(this.cfg.filter.SelfDropAllFilter)
    } else {
      this.user.SelfDropAll()
    }
    Sleep this.cfg.delay.mw
    this.user.ToggleSelfInventory()
    this.IsDropAllExecuting := false
  }

  OtherDropAll() {
    this.IsDropAllExecuting := true
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.mw
    if (this.UseOtherDropAllFilter) {
      this.user.SearchOtherAndDropAll(this.cfg.filter.OtherDropAllFilter)
    } else {
      this.user.OtherDropAll()
    }
    Sleep this.cfg.delay.mw
    this.user.ToggleOtherInventory()
    this.IsDropAllExecuting := false
  }
}