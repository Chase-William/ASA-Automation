#include "../LilxDHotkey.ahk"
#include "../Util.ahk"
#include "AutoClickController.ahk"
#include "MetalFarmController.ahk"
#include "ConsumeController.ahk"
#include "FishingController.ahk"
#include "TransferController.ahk"
#include "MovementController.ahk"
#include "PasteFarmController.ahk"
#include "FertFarmController.ahk"
#include "bot/AFKController.ahk"
#include "bot/BotController.ahk"
#include "DropAllController.ahk"
#include "SuicideFarmController.ahk"
#include "../structures/Event.ahk"

AUTO_CLICK_HOTKEY_CONFIG_KEY := "autoClick"
DROP_METAL_FARM_JUNK_CONFIG_KEY := "dropMetalFarmJunk"
AUTO_METAL_FARM_CONFIG_KEY := "autoMetalFarm"
; AUTO_SUICIDE_MEAT_FARM_CONFIG_KEY := "autoSuicideMeatFarm"
GIVE_ALL_CONFIG_KEY := "giveAll"
TAKE_ALL_CONFIG_KEY := "takeAll"
SELF_DROP_ALL_CONFIG_KEY := "selfDropAll"
OTHER_DROP_ALL_CONFIG_KEY := "otherDropAll"

AUTO_CLICKER_STATE_CHANGED := "AutoClicker"
AUTO_BREW_STATE_CHANGED := "AutoBrew"
AUTO_EAT_STATE_CHANGED := "AutoEat"
AUTO_DRINK_STATE_CHANGED := "AutoDrink"

class MiddlewareController {
  __New(
  cfg,
  user
  ) {
    ; Set instance variables
    this.cfg := cfg
    this.user := user
    this.autoClick := AutoClickController(cfg, user)
    ; this.autoClick.base := Observable()
    this.metalFarm := MetalFarmController(cfg, user)
    this.consume := ConsumeController(cfg, user)
    ; this.consume.base := Observable()
    this.fishing := FishingController(cfg, user)
    this.transfer := TransferController(cfg, user)
    this.drop := DropAllController(cfg, user)
    this.movement := MovementController(cfg, user)
    this.afk := AFKController(cfg, user, this.movement)
    this.paste := PasteFarmController(cfg, user, this.movement, this.afk)
    this.bot := BotController(cfg, this.afk, this.paste)
    this.suicide := SuicideFarmController(cfg, this)
    this.fert := FertFarmController(cfg, this)

    ; MsgBox "Test", this.autoClick.GetTest()

    ; Allows other functions to see state of other functions
    ; this.m_isAutoClickerOn := false
    ; this.m_isAutoMetalFarmOn := false

    ; Allow other functions to temporarily silence other functions
    ; this.m_silenceAutoClicker := false
    ; this.m_silenceAutoMetalFarm := false

    ; Event informing UI of changes
    ; this.m_stateChangedEvent := Event(this)

    ; autoclicker
    this.m_autoClickHotkey := LilxDHotkey(AUTO_CLICK_HOTKEY_CONFIG_KEY, this.AutoClickHotkey_Clicked.bind(this))
    this.m_autoClickHotkey.RegisterHotkey()

    ; auto metal farmer
    this.m_autoMetalFarmHotkey := LilxDHotkey(AUTO_METAL_FARM_CONFIG_KEY, this.AutoMetalFarmHotkey_Clicked.bind(this))
    this.m_autoMetalFarmHotkey.RegisterHotkey()

    ; metal farm junk dropper
    this.m_dropMetalFarmJunkHotkey := LilxDHotkey(DROP_METAL_FARM_JUNK_CONFIG_KEY, this.DropMetalFarmJunkHotkey_Clicked.bind(this))
    this.m_dropMetalFarmJunkHotkey.RegisterHotkey()

    ; Give all from self to other
    this.m_giveAll := LilxDHotkey(GIVE_ALL_CONFIG_KEY, this.GiveAllHotkey_Clicked.bind(this))
    this.m_giveAll.RegisterHotkey()

    ; Take all from other and give to self
    this.m_takeAll := LilxDHotkey(TAKE_ALL_CONFIG_KEY, this.TakeAllHotkey_Clicked.bind(this))
    this.m_takeAll.RegisterHotkey()

    ; Drop all from self inventory
    this.m_selfDropAll := LilxDHotkey(SELF_DROP_ALL_CONFIG_KEY, this.SelfDropAllHotkey_Clicked.bind(this))
    this.m_selfDropAll.RegisterHotkey()

    ; Drop all from other inventory
    this.m_otherDropAll := LilxDHotkey(OTHER_DROP_ALL_CONFIG_KEY, this.OtherDropAllHotkey_Clicked.bind(this))
    this.m_otherDropAll.RegisterHotkey()
  }

  ; Used to subscribe to events
  ; OnEvent(name, handler) {
  ;   this.m_stateChangedEvent.Subscribe(name, handler)
  ; }
  
  ;
  ; The following contain references to LilxDHotkey class instances used for controlling hotkeys for controllers
  ;

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

  GiveAllHotkey {
    get => this.m_giveAll
    set => this.m_giveAll := value
  }

  TakeAllHotkey {
    get => this.m_takeAll
    set => this.m_takeAll := value
  }

  SelfDropAllHotkey {
    get => this.m_selfDropAll
    set => this.m_selfDropAll := value
  }

  OtherDropAllHotkey {
    get => this.m_otherDropAll
    set => this.m_otherDropAll := value
  }

  ; Pauses the following functions if needed
  ; 1. Auto Clicker
  ; 2. Auto Brew
  ; 3. Auto Eat
  ; 4. Auto Drink
  Interrupt(action) {
    restoreAutoClicker := false
    restoreAutoBrew := false
    restoreAutoEat := false
    restoreAutoDrink := false

    ; Store data of interrupted to be restored
    if (restoreAutoClicker := this.autoClick.IsAutoClickerOn) {
      this.autoClick.AutoClickToggle()
    }
    ; Perform requested function
    action()
    ; Perform restore and remove stored data
    if (restoreAutoClicker) {
      this.AutoClick.AutoClickToggle()
    }
  }

  ; Checks to see if one of the following uninterruptable functiona is already running
  ; 1. Bot
  ; 3. Paste Farm
  ; 4. Suicide Farm
  ; 5. Fert Farm
  ; 6. Take All
  ; 7. Give All
  ; 8. Self Drop All
  ; 9. Other Drop All
  CanExecute() {
    if (this.bot.IsBotOn ||
        this.paste.IsPasteBotOn ||
        this.suicide.IsSuicideFarmOn ||
        this.fert.IsAutoFertFarmOn ||
        this.transfer.IsTransferExecuting ||
        this.drop.IsDropAllExecuting
    ) {
      return false
    }
    return true
  }

  GiveAllHotkey_Clicked(hotkey) {
    if (this.CanExecute()) {
      this.Interrupt(this.transfer.GiveAll.bind(this.transfer))
    }
  }

  TakeAllHotkey_Clicked(hotkey) {
    this.transfer.TakeAll()
  }

  SelfDropAllHotkey_Clicked(hotkey) {
    this.drop.SelfDropAll()
  }

  OtherDropAllHotkey_Clicked(hotkey) {
    this.drop.OtherDropAll()
  }

  AutoClickHotkey_Clicked(hotkey) {  
    this.autoClick.AutoClickToggle()
  }

  AutoMetalFarmHotkey_Clicked(hotkey) {
    this.metalFarm.AutoMetalFarmToggle()
  }

  DropMetalFarmJunkHotkey_Clicked(hotkey) {
    this.metalFarm.HandleMetalRunItems()
    ; SILENCE EXISTING AUTOCLICKERS IF RUNNING AND RESUME AFTER
    ; if (this.IsAutoClickerOn) {
    ;   this.m_silenceAutoClicker := true
    ; }
    ; else if (this.m_isAutoMetalFarmOn) {
    ;   this.m_silenceAutoMetalFarm := true
    ; } 

    ; ; Perform drop
    ; this.HandleMetalRunItems()
    ; Sleep this.cfg.delay.sw

    ; ; Unsilence silenced functions
    ; if (this.m_silenceAutoClicker) {
    ;   this.m_silenceAutoClicker := false
    ; }
    ; else if (this.m_silenceAutoMetalFarm) {
    ;   this.m_silenceAutoMetalFarm := false
    ; }
  }

  ; AutoSuicideMeatFarmHotkey {
  ;   get => this.m_autoSuicideMeatFarm
  ;   set => this.m_autoSuicideMeatFarm := value
  ; }

  ; AutoEatToggle() {
  ;   if this.IsAutoEatOn := !this.IsAutoEatOn {
  ;     ; SetTimer(autoBrewCallback, this.cfg.delay._3xlw)
  ;   } else {
  ;     ; Settimer(autoBrewCallback, 0)
  ;   }  
  ; }

  ; AutoDrinkToggle() {
  ;   if this.IsAutoDrinkOn := !this.IsAutoDrinkOn {
  ;     ; SetTimer(autoBrewCallback, this.cfg.delay._3xlw)
  ;   } else {
  ;     ; Settimer(autoBrewCallback, 0)
  ;   }  
  ; }

  ; AutoClicker() {
  ;   ; Static variable for holding instance bound callback
  ;   static autoClickCallback
  ;   ; Bind callback if not already
  ;   if !IsSet(autoClickCallback) { 
  ;     autoClickCallback := this.SilenceableClick.bind(this)
  ;   }

  ;   ; Run if hotkey detected     
  ;   if this.IsAutoClickerOn := !this.IsAutoClickerOn {
  ;     SetTimer(autoClickCallback, this.cfg.delay.autoClickInterval)
  ;   } else {
  ;     SetTimer(autoClickCallback, 0)
  ;   }
  ; }

  ; SilenceableClick() {
  ;   if (!this.m_silenceAutoClicker) {
  ;     Click()
  ;   }    
  ; }

  ; AutoMetalFarm() {
  ;   ; Static variable for holding instance bound callback
  ;   static metalFarmCallback
  ;   ; Bind callback if not already
  ;   if !IsSet(metalFarmCallback) { 
  ;     metalFarmCallback := this.AutoClickMetalFarm.bind(this)
  ;   }

  ;   ; static on := false
  ;   if this.m_isAutoMetalFarmOn := !this.m_isAutoMetalFarmOn {
  ;     SetTimer(metalFarmCallback, this.cfg.delay.autoClickInterval)
  ;   } else {
  ;     SetTimer(metalFarmCallback, 0) 
  ;   }
  ; }

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

  ; AutoClickMetalFarm() {
  ;   ; Determines how many clicks must pass before
  ;   ; automatic dropping of unwanted items occurs
  ;   static
  ;   static clickThreshold := 400 ; Every 20 seconds perform clean inventory
  ;   static clicks := 0

  ;   ; Drop unwanted items
  ;   if (clicks == clickThreshold) {
  ;     this.HandleMetalRunItems()
  ;     Sleep this.cfg.delay.mw
  ;     clicks := 0 ; reset
  ;   }
  ;   Click 
  ;   clicks := clicks + 1 
  ; }

  ; ; Opens the invent and takes flint while dropping stone * berries
  ; HandleMetalRunItems() {
  ;   ; Open Inventory
  ;   this.user.ToggleOtherInventory()
  ;   Sleep this.cfg.delay.lw
  ;   ; Take Flint
  ;   this.user.SearchOtherAndTakeAll(this.cfg.filter.FlintStr)
  ;   Sleep this.cfg.delay.mw
  ;   ; Filter and drop berries
  ;   this.user.SearchOtherAndDropAll(this.cfg.filter.BerryStr)
  ;   Sleep this.cfg.delay.sw
  ;   ; Filter and drop stone
  ;   this.user.SearchOtherAndDropAll(this.cfg.filter.StoneStr) 
  ;   Sleep this.cfg.delay.sw
  ;   ; Close Inventory
  ;   this.user.ToggleOtherInventory()
  ; }

  ; AutoFishToggle() {
  ;   ; Static variable for holding instance bound callback
  ;   static autoFishCallback
  ;   ; Bind callback if not already
  ;   if !IsSet(autoFishCallback) { 
  ;     autoFishCallback := (*) => this.fishing.AutoFish()
  ;   }
  ;   ; Static variable to toggle with
  ;   static on := false
  ;   if on := !on {
  ;     SetTimer(autoFishCallback, this.cfg.delay.mw)
  ;   } else {
  ;     Settimer(autoFishCallback, 0)
  ;   }
  ; }

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