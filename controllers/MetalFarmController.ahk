#Requires AutoHotkey v2.0

class MetalFarmController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user

    this.m_isAutoMetalFarmOn := false

    ; Determines how many clicks must pass before
    ; automatic dropping of unwanted items occurs
    this.clickThreshold := 400 ; About every 20 seconds perform clean inventory
    this.clicks := 0
  }

  AutoMetalFarmToggle() {
    ; Static variable for holding instance bound callback
    static metalFarmCallback
    ; Bind callback if not already
    if !IsSet(metalFarmCallback) { 
      metalFarmCallback := this.AutoClickMetalFarm.bind(this)
    }

    ; static on := false
    if this.m_isAutoMetalFarmOn := !this.m_isAutoMetalFarmOn {
      SetTimer(metalFarmCallback, this.cfg.delay.autoClickInterval)
    } else {
      SetTimer(metalFarmCallback, 0) 
    }
  }

  AutoClickMetalFarm() {
    ; Drop unwanted items
    if (this.clicks == this.clickThreshold) {
      this.HandleMetalRunItems()
      Sleep this.cfg.delay.mw
      this.clicks := 0 ; reset
    }
    Click 
    this.clicks := this.clicks + 1 
  }

  ; Opens the invent and takes flint while dropping stone * berries
  HandleMetalRunItems() {
    ; Open Inventory
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.lw
    ; Take Flint
    this.user.SearchOtherAndTakeAll(this.cfg.filter.FlintStr)
    Sleep this.cfg.delay.mw
    ; Filter and drop berries
    this.user.SearchOtherAndDropAll(this.cfg.filter.BerryStr)
    Sleep this.cfg.delay.sw
    ; Filter and drop stone
    this.user.SearchOtherAndDropAll(this.cfg.filter.StoneStr) 
    Sleep this.cfg.delay.sw
    ; Close Inventory
    this.user.ToggleOtherInventory()
  }
}