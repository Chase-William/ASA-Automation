#Requires AutoHotkey v2.0

#include "../ui/windows/AutoFarmWindow.ahk"

AUTO_FARM_DROP_ALL_FILTER_CONFIG_KEY := "autoFarmDropAllFilter"
AUTO_FARM_TAKE_ALL_FILTER_CONFIG_KEY := "autoFarmTakeAllFilter"

AUTO_FARM_DROP_ALL_FIELD_NAME := "m_autoFarmDropAllFilter"
AUTO_FARM_TAKE_ALL_FIELD_NAME := "m_autoFarmTakeAllFilter"

class AutoFarmController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user

    this.m_autoFarmWindow := AutoFarmWindow(cfg, this)

    this.m_isAutoMetalFarmOn := false
    this.m_inInventory := false

    this.farmCallback := this.AutoClickFarm.bind(this)
    ; Determines how many clicks must pass before
    ; automatic dropping of unwanted items occurs
    this.clickThreshold := 400 ; About every 20 seconds perform clean inventory
    this.clicks := 0
  }

  AutoFarmWindow => this.m_autoFarmWindow

  IsAutoFarmOn {
    get => this.m_isAutoMetalFarmOn
    set => this.m_isAutoMetalFarmOn := value
  }

  InInventory {
    get => this.m_inInventory
    set => this.m_inInventory := value
  }

  AutoFarmDropAllFilter {
    get => Config.GetMember(this, Config.GetFilter, AUTO_FARM_DROP_ALL_FIELD_NAME, AUTO_FARM_DROP_ALL_FILTER_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetFilter, AUTO_FARM_DROP_ALL_FIELD_NAME, AUTO_FARM_DROP_ALL_FILTER_CONFIG_KEY, value)
  }
  
  AutoFarmTakeAllFilter {
    get => Config.GetMember(this, Config.GetFilter, AUTO_FARM_TAKE_ALL_FIELD_NAME, AUTO_FARM_TAKE_ALL_FILTER_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetFilter, AUTO_FARM_TAKE_ALL_FIELD_NAME, AUTO_FARM_TAKE_ALL_FILTER_CONFIG_KEY, value)
  }

  AutoFarmToggle() {
    if this.IsAutoFarmOn := !this.IsAutoFarmOn {
      SetTimer(this.farmCallback, this.cfg.delay.autoClickInterval)
    } else {
      SetTimer(this.farmCallback, 0) 
    }
  }

  AutoClickFarm() {
    if (this.clicks == this.clickThreshold) {
      this.HandleFarmRunItems()
      Sleep this.cfg.delay.mw
      this.clicks := 0 ; reset
    }
    Click 
    this.clicks := this.clicks + 1 
  }

  ; Opens the invent and takes flint while dropping stone * berries
  HandleFarmRunItems() {
    this.InInventory := true
    ; Open Inventory
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.lw
    ; Take all items in filter array
    For filter in this.AutoFarmTakeAllFilter {
      this.user.SearchOtherAndTakeAll(filter)
      if (this.AutoFarmTakeAllFilter.Length == A_Index)
        Sleep this.cfg.delay.mw
      else
        Sleep this.cfg.delay.TransferAllCooldown 
    }
    ; Drop all items in filter array
    For filter in this.AutoFarmDropAllFilter {
      this.user.SearchOtherAndDropAll(filter)
      Sleep this.cfg.delay.mw
    }
    ; Close Inventory
    this.user.ToggleOtherInventory()
    this.InInventory := false
  }
}