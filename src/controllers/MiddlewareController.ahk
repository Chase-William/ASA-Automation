#include "../LilxDHotkey.ahk"
#include "../Util.ahk"
#include "AutoClickController.ahk"
#include "AutoFarmController.ahk"
#include "ConsumeController.ahk"
#include "FishingController.ahk"
#include "TransferController.ahk"
#include "MovementController.ahk"
#include "FertFarmController.ahk"
#include "DropAllController.ahk"
#include "CustomCrosshairController.ahk"
#include "../structures/Event.ahk"

AUTO_CLICK_HOTKEY_CONFIG_KEY := "autoClick"
HANDLE_FARM_CONFIG_KEY := "handleFarm"
AUTO_FARM_CONFIG_KEY := "autoFarm"
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
  __New(cfg, user, farm := AutoFarmController(cfg, user)) {
    ; Set instance variables
    this.cfg := cfg
    this.user := user
    this.autoClick := AutoClickController(cfg, user)
    this.farm := farm
    this.fertFarm := FertFarmController(cfg, user)
    this.consume := ConsumeController(cfg, user)
    this.fishing := FishingController(cfg, user)
    this.transfer := TransferController(cfg, user)
    this.drop := DropAllController(cfg, user)
    this.movement := MovementController(cfg, user)
    this.crosshair := CustomCrosshairController()

    ; autoclicker
    this.m_autoClickHotkey := LilxDHotkey(AUTO_CLICK_HOTKEY_CONFIG_KEY, this.AutoClickHotkey_Clicked.bind(this))
    this.m_autoClickHotkey.RegisterHotkey()

    ; auto metal farmer
    this.m_autoFarmHotkey := LilxDHotkey(AUTO_FARM_CONFIG_KEY, this.AutoFarmHotkey_Clicked.bind(this))
    this.m_autoFarmHotkey.RegisterHotkey()

    ; metal farm junk dropper
    this.m_handleFarmHotkey := LilxDHotkey(HANDLE_FARM_CONFIG_KEY, this.HandleFarmHotkey_Clicked.bind(this))
    this.m_handleFarmHotkey.RegisterHotkey()

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
  
  ;
  ; The following contain references to LilxDHotkey class instances used for controlling hotkeys for controllers
  ;

  AutoClickHotkey {
    get => this.m_autoClickHotkey
    set => this.m_autoClickHotkey := value
  }

  AutoFarmHotkey {
    get => this.m_autoFarmHotkey
    set => this.m_autoFarmHotkey := value
  }

  HandleFarmHotkey {
    get => this.m_handleFarmHotkey
    set => this.m_handleFarmHotkey := value
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

  ; Interrupts the following functions if needed
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
    if (restoreAutoBrew := this.consume.IsAutoBrewOn) {
      this.consume.AutoBrewToggle()
    }
    if (restoreAutoEat := this.consume.IsAutoEatOn) {
      this.consume.AutoEatToggle()
    }
    if (restoreAutoDrink := this.consume.IsAutoDrinkOn) {
      this.consume.AutoDrinkToggle()
    }        
    ; Perform requested function
    action()
    ; Perform restore and remove stored data
    if (restoreAutoClicker) {
      this.AutoClick.AutoClickToggle()
    }
    if (restoreAutoBrew) {
      this.consume.AutoBrewToggle()
    }
    if (restoreAutoEat) {
      this.consume.AutoEatToggle()
    }
    if (restoreAutoDrink) {
      this.consume.AutoDrinkToggle()
    }
  }

  ; Checks to see if one of the following uninterruptable functiona is already running
  ; 5. Fert Farm
  ; 6. Take All
  ; 7. Give All
  ; 8. Self Drop All
  ; 9. Other Drop All
  CanExecute() {
    if (this.fertFarm.IsAutoFertFarmOn ||
        this.transfer.IsTransferExecuting ||
        this.drop.IsDropAllExecuting
    ) {
      return false
    }
    return true
  }

  GiveAllHotkey_Clicked(hotkey) {
    this.Run(this.transfer.GiveAll.bind(this.transfer))
  }

  TakeAllHotkey_Clicked(hotkey) {
    this.Run(this.transfer.TakeAll.bind(this.transfer))
  }

  SelfDropAllHotkey_Clicked(hotkey) {
    this.Run(this.drop.SelfDropAll.bind(this.drop))
  }

  OtherDropAllHotkey_Clicked(hotkey) {
    this.Run(this.drop.OtherDropAll.bind(this.drop))
  }

  AutoClickHotkey_Clicked(hotkey) {  
    if this.CanExecute() {
      ; Override and replace auto-farm if active
      if (this.farm.IsAutoFarmOn && !this.farm.InInventory) {
        this.farm.AutoFarmToggle()      
      }
      this.autoClick.AutoClickToggle()
    }
  }

  AutoFarmHotkey_Clicked(hotkey) {
    this.Run(this.farm.AutoFarmToggle.bind(this.farm))
  }

  HandleFarmHotkey_Clicked(hotkey) {
    this.Run(this.farm.HandleFarmRunItems.bind(this.farm))
  }

  Run(action) {
    if this.CanExecute() {
      this.Interrupt(action)
    }
  }
}