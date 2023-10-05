#include "../LilxDHotkey.ahk"
#include "../Util.ahk"
#include "FishingController.ahk"
#include "DinoNutureController.ahk"

AUTO_CLICK_HOTKEY_CONFIG_KEY := "autoClick"
DROP_METAL_FARM_JUNK_CONFIG_KEY := "dropMetalFarmJunk"
AUTO_METAL_FARM_CONFIG_KEY := "autoMetalFarm"
; AUTO_SUICIDE_MEAT_FARM_CONFIG_KEY := "autoSuicideMeatFarm"
AUTO_NURTURE_DINO_CONFIG_KEY := "autoNurtureDino"

class LilxDController {
  __New(
  cfg,
  user
  ) {
    ; Set instance variables
    this.cfg := cfg
    this.user := user
    this.fishing := FishingController(cfg, user)
    this.dinoNurturer := DinoNutureController(cfg, user)

    ; Allows other functions to see state of other functions
    this.isAutoClickerOn := false
    this.isAutoMetalFarmOn := false

    ; Allow other functions to temporarily silence other functions
    this.silenceAutoClicker := false
    this.silenceAutoMetalFarm := false

    ; autoclicker
    this.m_autoClickHotkey := LilxDHotkey(AUTO_CLICK_HOTKEY_CONFIG_KEY, this.AutoClickHotkey_Clicked.bind(this))
    this.m_autoClickHotkey.RegisterHotkey()

    ; auto metal farmer
    this.m_autoMetalFarmHotkey := LilxDHotkey(AUTO_METAL_FARM_CONFIG_KEY, this.AutoMetalFarm_Clicked.bind(this))
    this.m_autoMetalFarmHotkey.RegisterHotkey()

    ; metal farm junk dropper
    this.m_dropMetalFarmJunkHotkey := LilxDHotkey(DROP_METAL_FARM_JUNK_CONFIG_KEY, this.DropMetalFarmJunkHotkey_Clicked.bind(this))
    this.m_dropMetalFarmJunkHotkey.RegisterHotkey()

    ; Auto transfer filtered contents to dino
    this.m_autoNurtureDinoHotkey := LilxDHotkey(AUTO_NURTURE_DINO_CONFIG_KEY, this.AutoNutureDinoHotkey_Clicked.bind(this))
    this.m_autoNurtureDinoHotkey.RegisterHotkey()

    ; auto suicide meat farm
    ; this.m_autoSuicideMeatFarm := LilxDHotkey(AUTO_SUICIDE_MEAT_FARM_CONFIG_KEY, this.AutoSuicideMeatFarm_Clicked.bind(this))
    ; this.m_autoSuicideMeatFarm.RegisterHotkey()
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

  NurtureDinoHotkey {
    get => this.m_autoNurtureDinoHotkey
    set => this.m_autoNurtureDinoHotkey := value
  }

  AutoNutureDinoHotkey_Clicked(hotkey) {
    this.dinoNurturer.Nurture()
  }

  ; AutoSuicideMeatFarmHotkey {
  ;   get => this.m_autoSuicideMeatFarm
  ;   set => this.m_autoSuicideMeatFarm := value
  ; }

  AutoEat() {

  }

  AutoDrink() {

  }

  ; Plain auto-clicker
  AutoClickHotkey_Clicked(hotkey) {
    ; Run if hotkey detected     
    this.AutoClicker()
  }

  AutoClicker() {
    ; Static variable for holding instance bound callback
    static autoClickCallback
    ; Bind callback if not already
    if !IsSet(autoClickCallback) { 
      autoClickCallback := this.SilenceableClick.bind(this)
    }

    ; Run if hotkey detected     
    if this.isAutoClickerOn := !this.isAutoClickerOn {
      SetTimer(autoClickCallback, this.cfg.delay.autoClickInterval)
    } else {
      SetTimer(autoClickCallback, 0)
    }
  }

  SilenceableClick() {
    if (!this.silenceAutoClicker) {
      Click()
    }    
  }

  DropMetalFarmJunkHotkey_Clicked(hotkey) {
    ; SILENCE EXISTING AUTOCLICKERS IF RUNNING AND RESUME AFTER
    if (this.isAutoClickerOn) {
      this.silenceAutoClicker := true
    }
    else if (this.isAutoMetalFarmOn) {
      this.silenceAutoMetalFarm := true
    } 

    ; Perform drop
    this.HandleMetalRunItems()
    Sleep this.cfg.delay.sw

    ; Unsilence silenced functions
    if (this.silenceAutoClicker) {
      this.silenceAutoClicker := false
    }
    else if (this.silenceAutoMetalFarm) {
      this.silenceAutoMetalFarm := false
    }
  }

  AutoMetalFarm_Clicked(hotkey?) {
    this.AutoMetalFarm()
  }

  AutoMetalFarm() {
    ; Static variable for holding instance bound callback
    static metalFarmCallback
    ; Bind callback if not already
    if !IsSet(metalFarmCallback) { 
      metalFarmCallback := this.AutoClickMetalFarm.bind(this)
    }

    ; static on := false
    if this.isAutoMetalFarmOn := !this.isAutoMetalFarmOn {
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

  ; AutoSuicideMeatFarm_Clicked(hotkey) {
  ;   ; Static variable for holding instance bound callback
  ;   static respawnCallback
  ;   ; Bind callback if not already
  ;   if !IsSet(respawnCallback) { 
  ;     respawnCallback := this.Respawn.bind(this)
  ;   }
  ;   ; Static variable to toggle with
  ;   static on := false
  ;   if on := !on {
  ;     SetTimer respawnCallback, 1000
  ;   }
  ;   else Reload
  ;   }

  AutoSuicideMeatFarmToggle() {
    ; Static variable for holding instance bound callback
    static respawnCallback
    ; Bind callback if not already
    if !IsSet(respawnCallback) { 
      respawnCallback := this.Respawn.bind(this)
    }
    ; Static variable to toggle with
    static on := false
    if on := !on {
      SetTimer(respawnCallback, this.cfg.delay.xlw)
    } else {
      Settimer(respawnCallback, 0)
    }    
  }

  AutoBrewToggle() {
    ; Static variable for holding instance bound callback
    static autoBrewCallback
    ; Bind callback if not already
    if !IsSet(autoBrewCallback) { 
      autoBrewCallback := this.MaybeDrinkBrew.bind(this)
    }
    ; Static variable to toggle with
    static on := false
    if on := !on {
      SetTimer(autoBrewCallback, this.cfg.delay._3xlw)
    } else {
      Settimer(autoBrewCallback, 0)
    }   
  }

  MaybeDrinkBrew() {
    pixel := PixelGetColor(this.user.SelfHealthThresholdPosition.X, this.user.SelfHealthThresholdPosition.Y)
    ; MsgBox pixel, pixel
    ; Parse hex color to rbg components

    red := SubStr(pixel, 3, 2)
    green := SubStr(pixel,5, 2)
    blue := SubStr(pixel, 7, 2)

    ; MsgBox "Test", Format("{1} {2} {3}", this.HexToDec(red), this.HexToDec(green), this.HexToDec(blue))

    red := HexToDec(red)
    green := HexToDec(green)
    blue := HexToDec(blue)

    rg := Abs(green - red)
    gb := Abs(blue - green)
    rb := Abs(blue - red)

    maskTotal := rg + gb + rb

    ; Range for health had
    if (maskTotal > 300 AND maskTotal < 360) {
      ; Health high, no need to med brew
      
    } 
    ; Range for health lost
    else if (maskTotal > 20 AND maskTotal < 80) {
      ; Health low, need to med brew
      ControlSend Format("{1}", this.user.SelfHealKeybind),, this.cfg.process.windowTitle
    }
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
      Sleep this.cfg.delay.5xlw
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

  AutoFishToggle() {
    ; Static variable for holding instance bound callback
    static autoFishCallback
    ; Bind callback if not already
    if !IsSet(autoFishCallback) { 
      autoFishCallback := (*) => this.fishing.AutoFish()
    }
    ; Static variable to toggle with
    static on := false
    if on := !on {
      SetTimer(autoFishCallback, this.cfg.delay.mw)
    } else {
      Settimer(autoFishCallback, 0)
    }
  }

  ; AutoFish() {
  ;   this.fishing.AutoFish()
  ; }

  ; AutoFish() {
  ;   ; Load images once
  ;   static imgA := LoadPicture("assets/fishing/2560_1440_A_EDIT.png")
  ;   static imgC := LoadPicture("assets/fishing/2560_1440_C_EDIT.png")
  ;   static imgD := LoadPicture("assets/fishing/2560_1440_D_EDIT.png")
  ;   static imgE := LoadPicture("assets/fishing/2560_1440_E_EDIT.png")
  ;   static imgQ := LoadPicture("assets/fishing/2560_1440_Q_EDIT.png")
  ;   static imgS := LoadPicture("assets/fishing/2560_1440_S_EDIT.png")
  ;   static imgW := LoadPicture("assets/fishing/2560_1440_W_EDIT.png")
  ;   static imgX := LoadPicture("assets/fishing/2560_1440_X_EDIT.png")
  ;   static imgZ := LoadPicture("assets/fishing/2560_1440_Z_EDIT.png")

  ;   outX := 0
  ;   outY := 0
  ;   static windowWidth := 0
  ;   static windowHeight := 0
  ;   ; Only get window dimensions once since this program expects fullscreen or windowed fullscreen
  ;   if (windowWidth == 0) {
  ;     ; Get Width/Height of Window
  ;     WinGetPos(,, &windowWidth, &windowHeight, this.cfg.process.windowTitle)
  ;   }

  ;   static left := windowWidth / 2
  ;   static top := windowHeight / 2.2
  ;   static right := windowWidth / 1.2
  ;   static bottom := windowHeight

  ;   ; MsgBox Format("{1},left:{2},top:{3},right:{4},bottom:{5},outX:{6},outY:{7},img:{8}", windowHeight, left, top, right, bottom, outX, outY, imgA), Format("{1}", windowWidth)

  ;   search := (image) => ImageSearch(&outX, &outY, left, top, right, bottom, "*TransBlack *20 HBITMAP:*" image)

  ;   if (search(imgA)) {
  ;     ControlSend "a",, this.cfg.process.windowTitle
  ;   } 
  ;   else if (search(imgC)) {
  ;     ControlSend "c",, this.cfg.process.windowTitle
  ;   }
  ;   else if (search(imgD)) {
  ;     ControlSend "d",, this.cfg.process.windowTitle
  ;   }
  ;   else if (search(imgE)) {
  ;     ControlSend "e",, this.cfg.process.windowTitle
  ;   }
  ;   else if (search(imgQ)) {
  ;     ControlSend "q",, this.cfg.process.windowTitle
  ;   }
  ;   else if (search(imgS)) {
  ;     ControlSend "s",, this.cfg.process.windowTitle
  ;   }
  ;   else if (search(imgW)) {
  ;     ControlSend "w",, this.cfg.process.windowTitle
  ;   }
  ;   else if (search(imgX)) {
  ;     ControlSend "x",, this.cfg.process.windowTitle
  ;   }
  ;   else if (search(imgZ)) {
  ;     ControlSend "z",, this.cfg.process.windowTitle
  ;   } 
  ;   else {
  ;     ; MsgBox "No image found", "Test"
  ;   }
  ; }
}