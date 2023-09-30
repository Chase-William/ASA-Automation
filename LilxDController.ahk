#include "LilxDHotkey.ahk"

AUTO_CLICK_HOTKEY_CONFIG_KEY := "autoClick"
DROP_METAL_FARM_JUNK_CONFIG_KEY := "dropMetalFarmJunk"
AUTO_METAL_FARM_CONFIG_KEY := "autoMetalFarm"
AUTO_SUICIDE_MEAT_FARM_CONFIG_KEY := "autoSuicideMeatFarm"

class LilxDController {
  __New(
  cfg,
  user
  ; autoClickHotkey,
  ; autoMetalFarmHotkey
  ) {
    ; Set instance variables
    this.cfg := cfg
    this.user := user
    
    ; autoclicker
    this.m_autoClickHotkey := LilxDHotkey(AUTO_CLICK_HOTKEY_CONFIG_KEY, this.AutoClickHotkey_Clicked.bind(this))
    this.m_autoClickHotkey.RegisterHotkey()

    ; auto metal farmer
    this.m_autoMetalFarmHotkey := LilxDHotkey(AUTO_METAL_FARM_CONFIG_KEY, this.AutoMetalFarm_Clicked.bind(this))
    this.m_autoMetalFarmHotkey.RegisterHotkey()

    ; metal farm junk dropper
    this.m_dropMetalFarmJunkHotkey := LilxDHotkey(DROP_METAL_FARM_JUNK_CONFIG_KEY, this.DropMetalFarmJunkHotkey_Clicked.bind(this))
    this.m_dropMetalFarmJunkHotkey.RegisterHotkey()

    ; auto suicide meat farm
    this.m_autoSuicideMeatFarm := LilxDHotkey(AUTO_SUICIDE_MEAT_FARM_CONFIG_KEY, this.AutoSuicideMeatFarm_Clicked.bind(this))
    this.m_autoSuicideMeatFarm.RegisterHotkey()

    ; Setup map of hotkeys to their object for later use
    ; this.hotkeys := Map()
    ; this.hotkeys[autoClickHotkey.toString()] := autoClickHotkey
    ; this.hotkeys[autoMetalFarmHotkey.toString()] := autoMetalFarmHotkey
    ; this.hotkeys[autouserMeatFarmHotkey.toString()] := autouserMeatFarmHotkey
    ; this.hotkeys[autoFertFarmHotkey.toString()] := autoFertFarmHotkey

    ; MsgBox autoMetalFarmHotkey.toString(), this.hotkeys[autoMetalFarmHotkey.toString()].key

    ; this.metalFarmBound := this.AutoClickMetalFarm.bind(this)

    ; Setup hotkeys
    ;Hotkey autoClickHotkey.toString(), this.AutoClickHotkey_Clicked.bind(this)
    ;Hotkey autoMetalFarmHotkey.toString(), this.AutoMetalFarm.bind(this)
    ; Hotkey autouserMeatFarmHotkey.toString(), this.userMeatFarm.bind(this)
    ; HotKey autoFertFarmHotkey.toString(), this.AutoFertFarm.bind(this)
  }

  AutoClickHotkey {
    get => this.m_autoClickHotkey
    set => this.m_autoClickHotkey := value
  }

  AutoMetalFarmHotkey {
    get => this.m_autoMetalFarmHotkey
    set => this.m_autoMetalFarmHotkey := value
  }

  DropMetalFarmJunkHotkey {
    get => this.m_dropMetalFarmJunkHotkey
    set => this.m_dropMetalFarmJunkHotkey := value
  }

  AutoSuicideMeatFarmHotkey {
    get => this.m_autoSuicideMeatFarm
    set => this.m_autoSuicideMeatFarm := value
  }

  ; Plain auto-clicker
  AutoClickHotkey_Clicked(hotkey) {
     ; Run if hotkey detectedS
     static on := false
     if on := !on {
      SetTimer(Click, this.cfg.delay.autoClickInterval)
     } else {
      SetTimer(Click, 0)
     }
  }

  DropMetalFarmJunkHotkey_Clicked(hotkey) {

      
    ;
    ;
    ; PAUSE EXISTING AUTOCLICKERS IF RUNNING AND RESUME AFTER
    ;
    ;


    this.HandleMetalRunItems()
  }

  AutoMetalFarm_Clicked(hotkey) {
    ; Static variable for holding instance bound callback
    static metalFarmCallback
    ; Bind callback if not already
    if !IsSet(metalFarmCallback) { 
      metalFarmCallback := this.AutoClickMetalFarm.bind(this)
    }

    static on := false
    if on := !on {
      SetTimer(metalFarmCallback, this.cfg.delay.autoClickInterval)
    } else {
      SetTimer(metalFarmCallback, 0) 
    }
  }

  ; AutoMetalFarm(hotkey) {
  ;   ; Static variable for holding instance bound callback
  ;   static metalFarmCallback
  ;   ; Bind callback if not already
  ;   if !IsSet(metalFarmCallback) { 
  ;     metalFarmCallback := this.AutoClickMetalFarm.bind(this)
  ;   }
  ;   ; Run if hotkey detected
  ;   if getkeystate(this.hotkeys[hotkey].key, "T")
  ;     SetTimer(metalFarmCallback, this.cfg.delay.autoClickInterval)
  ;   else
  ;     SetTimer(metalFarmCallback, 0) 
  ; }

  AutoSuicideMeatFarm_Clicked(hotkey) {
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

  Respawn() {
    if (this.user.IsRespawnScreenAvailable()) {
      this.user.SearchBeds("meet my meat")
      Sleep this.cfg.delay.smw 
      this.user.SelectMeatFarmBeds()
      Sleep this.cfg.delay.smw
      this.user.Respawn() 
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
      Sleep this.cfg.delay.mw
      clicks := 0 ; reset
    }
    Click 
    clicks := clicks + 1 
  }

  ; Opens the invent and takes flint while dropping stone * berries
  HandleMetalRunItems() {
    ; Open Inventory
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.lw
    ; Take Flint
    this.user.SearchAndTakeAll(this.cfg.filter.FlintStr)
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