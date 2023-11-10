#Requires AutoHotkey v2.0

USE_GIVE_ALL_STR_CONFIG_KEY := "useGiveAllFilter"
USE_TAKE_ALL_STR_CONFIG_KEY := "useTakeAllFilter"
GIVE_ALL_STR_CONFIG_KEY := "giveAllFilter"
TAKE_ALL_STR_CONFIG_KEY := "takeAllFilter"

USE_GIVE_ALL_STR_FIELD_NAME := "m_useGiveAllFilter"
USE_TAKE_ALL_STR_FIELD_NAME := "m_useTakeAllFilter"

GIVE_ALL_STR_FIELD_NAME := "m_giveAllFilter"
TAKE_ALL_STR_FIELD_NAME := "m_takeAllFilter"

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

  GiveAllFilter {
    get => Config.GetMember(this, Config.GetFilter, GIVE_ALL_STR_FIELD_NAME, GIVE_ALL_STR_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetFilter, GIVE_ALL_STR_FIELD_NAME, GIVE_ALL_STR_CONFIG_KEY, value)
  }
  TakeAllFilter {
    get => Config.GetMember(this, Config.GetFilter, TAKE_ALL_STR_FIELD_NAME, TAKE_ALL_STR_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetFilter, TAKE_ALL_STR_FIELD_NAME, TAKE_ALL_STR_CONFIG_KEY, value)    
  }  

  GiveAll() {
    this.IsTransferExecuting := true
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.mw
    if (this.UseGiveAllFilter) {
      For filter in this.GiveAllFilter {
        this.user.SearchSelfAndGiveAll(filter)
        ; Avoid waiting for transfer all cooldown if finished
        if (this.GiveAllFilter.Length == A_Index)
          Sleep this.cfg.delay.mw
        else
          Sleep this.cfg.delay.TransferAllCooldown          
      }      
    } else {
      this.user.GiveAll()
      Sleep this.cfg.delay.mw
    }
    this.user.ToggleOtherInventory()
    this.IsTransferExecuting := false
  }

  TakeAll() {
    this.IsTransferExecuting := true
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.mw
    if (this.UseTakeAllFilter) {
      For filter in this.TakeAllFilter {        
        this.user.SearchOtherAndTakeAll(filter)
        if (this.TakeAllFilter.Length == A_Index)
          Sleep this.cfg.delay.sw
        else
          Sleep this.cfg.delay.TransferAllCooldown                
      }      
    } else {
      this.user.TakeAll()
      Sleep this.cfg.delay.mw
    }    
    this.user.ToggleOtherInventory()
    this.IsTransferExecuting := false
  }
}