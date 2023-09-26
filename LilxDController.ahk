class LilxDController {
  __New(
  ctx,
  self,
  other,
  autoClickHotkey,
  autoMetalFarmHotkey,
  autoSelfMeatFarmHotkey,
  autoFertFarmHotkey
  ) {
    ; Set instance variables
    this.ctx := ctx
    this.self := self
    this.other := other

    this.autoClickHotkey := autoClickHotkey

    ; Setup map of hotkeys to their object for later use
    ; this.hotkeys := Map()
    ; this.hotkeys[autoClickHotkey.toString()] := autoClickHotkey
    ; this.hotkeys[autoMetalFarmHotkey.toString()] := autoMetalFarmHotkey
    ; this.hotkeys[autoSelfMeatFarmHotkey.toString()] := autoSelfMeatFarmHotkey
    ; this.hotkeys[autoFertFarmHotkey.toString()] := autoFertFarmHotkey

    ; MsgBox autoMetalFarmHotkey.toString(), this.hotkeys[autoMetalFarmHotkey.toString()].key

    ; this.metalFarmBound := this.AutoClickMetalFarm.bind(this)

    ; Setup hotkeys
    Hotkey autoClickHotkey.toString(), this.AutoClickHotkey_Clicked.bind(this)
    Hotkey autoMetalFarmHotkey.toString(), this.AutoMetalFarm.bind(this)
    Hotkey autoSelfMeatFarmHotkey.toString(), this.SelfMeatFarm.bind(this)
    HotKey autoFertFarmHotkey.toString(), this.AutoFertFarm.bind(this)
  }

  ; Plain auto-clicker
  AutoClickHotkey_Clicked(hotkey) {
     ; Run if hotkey detected
     if getkeystate(this.autoClickHotkey.key, "T")
      SetTimer(Click, this.ctx.autoClickInterval)
    else
      SetTimer(Click, 0)
  }

  AutoMetalFarm(hotkey) {
    ; Static variable for holding instance bound callback
    static metalFarmCallback
    ; Bind callback if not already
    if !IsSet(metalFarmCallback) { 
      metalFarmCallback := this.AutoClickMetalFarm.bind(this)
    }
    ; Run if hotkey detected
    if getkeystate(this.hotkeys[hotkey].key, "T")
      SetTimer(metalFarmCallback, this.ctx.autoClickInterval)
    else
      SetTimer(metalFarmCallback, 0) 
  }

  SelfMeatFarm(hotkey) {
    ; Static variable for holding instance bound callback
    static respawnCallback
    ; Bind callback if not already
    if !IsSet(respawnCallback) { 
      respawnCallback := this.Respawn.bind(this)
    }
    ; Static variable to toggle with
    static on := false
    if on := !on {
      SetTimer respawnCallback, 1000
    }
    else Reload
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
        this.self.Defecate()
        Sleep this.ctx.smallWait
        this.other.ToggleInventory()
        Sleep this.ctx.mediumWait
        this.self.FlushToilet()
        Sleep this.ctx.smallWait
        this.other.ToggleInventory()
        Sleep this.ctx.mediumWait
      }
    }
  } 

  Respawn() {
    if (this.self.IsRespawnScreenAvailable()) {
      this.self.SearchBeds("meet my meat")
      Sleep this.ctx.smediumWait 
      this.self.SelectMeatFarmBeds()
      Sleep this.ctx.smediumWait
      this.self.Respawn() 
      Sleep 5000
    }
  }

  AutoClickMetalFarm() {
    ; Determines how many clicks must pass before
    ; automatic dropping of unwanted items occurs
    static
    static clickThreshold := 400 ; Every 20 seconds perform clean inventory
    static clicks := 0

    ; Drop unwanted items
    if (clicks == clickThreshold) {
      this.HandleMetalRunItems()
      Sleep this.ctx.mediumWait
      clicks := 0 ; reset
    }
    Click 
    clicks := clicks + 1 
  }

  ; Opens the invent and takes flint while dropping stone * berries
  HandleMetalRunItems() {
    ; Open Inventory
    this.other.ToggleInventory()
    Sleep this.ctx.longWait
    ; Take Flint
    this.other.SearchAndTakeAll(this.ctx.flintStr)
    Sleep this.ctx.mediumWait
    ; Filter and drop berries
    this.other.SearchAndDropAll(this.ctx.berries)
    Sleep this.ctx.smallWait
    ; Filter and drop stone
    this.other.SearchAndDropAll(this.ctx.stoneStr) 
    Sleep this.ctx.smallWait
    ; Close Inventory
    this.other.ToggleInventory()
  }
}