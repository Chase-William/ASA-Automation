#include "../LilxDHotkey.ahk"
#include "../Util.ahk"
#include "AutoClickController.ahk"
; #include "TransferController.ahk"
; #include "MovementController.ahk"
; #include "DropAllController.ahk"
; #include "AutoWalkController.ahk"
; #include "CustomCrosshairController.ahk"
#include "../structures/Event.ahk"

AUTO_CLICK_HOTKEY_CONFIG_KEY := "autoClick"
GEFORCE_AUTO_CLICK_HOTKEY_CONFIG_KEY := "geforceAutoClick"
; HANDLE_FARM_CONFIG_KEY := "handleFarm"
; AUTO_FARM_CONFIG_KEY := "autoFarm"
; AUTO_WALK_HOTKEY_CONFIG_KEY := "autoWalk"
; AUTO_SUICIDE_MEAT_FARM_CONFIG_KEY := "autoSuicideMeatFarm"
; GIVE_ALL_CONFIG_KEY := "giveAll"
; TAKE_ALL_CONFIG_KEY := "takeAll"
; SELF_DROP_ALL_CONFIG_KEY := "selfDropAll"
; OTHER_DROP_ALL_CONFIG_KEY := "otherDropAll"


; AUTO_CLICKER_STATE_CHANGED := "AutoClicker"
; AUTO_BREW_STATE_CHANGED := "AutoBrew"
; AUTO_EAT_STATE_CHANGED := "AutoEat"
; AUTO_DRINK_STATE_CHANGED := "AutoDrink"

class MiddlewareController {
  __New(cfg, user) {
    ; Set instance variables
    this.cfg := cfg
    this.user := user
    this.autoClick := AutoClickController(cfg, user)
    this.geforceAutoClick := AutoClickController(cfg, user, true)

    ; autoclicker
    this.m_autoClickHotkey := LilxDHotkey(AUTO_CLICK_HOTKEY_CONFIG_KEY, this.AutoClickHotkey_Clicked.bind(this))
    this.m_autoClickHotkey.RegisterHotkey()

    this.m_geforceAutoClickHotkey := LilxDHotkey(GEFORCE_AUTO_CLICK_HOTKEY_CONFIG_KEY, this.GeforceAutoClickHotkey_Clicked.bind(this))
    this.m_geforceAutoClickHotkey.RegisterHotkey()
  }
  
  ;
  ; The following contain references to LilxDHotkey class instances used for controlling hotkeys for controllers
  ;

  AutoClickHotkey {
    get => this.m_autoClickHotkey
    set => this.m_autoClickHotkey := value
  }

  GeforceAutoClickHotkey {
    get => this.m_geforceAutoClickHotkey
    set => this.m_geforceAutoClickHotkey := value
  }


  ; Interrupts the following functions if needed
  ; 1. Auto Clicker
  Interrupt(action) {
    restoreAutoClicker := false

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
  ; 6. Take All
  ; 7. Give All
  ; 8. Self Drop All
  ; 9. Other Drop All
  CanExecute() {
    ; if (this.transfer.IsTransferExecuting ||
    ;     this.drop.IsDropAllExecuting
    ; ) {
    ;   return false
    ; }
    return true
  }

;   GiveAllHotkey_Clicked(hotkey) {
;     this.Run(this.transfer.GiveAll.bind(this.transfer))
;   }

;   TakeAllHotkey_Clicked(hotkey) {
;     this.Run(this.transfer.TakeAll.bind(this.transfer))
;   }

;   SelfDropAllHotkey_Clicked(hotkey) {
;     this.Run(this.drop.SelfDropAll.bind(this.drop))
;   }

;   OtherDropAllHotkey_Clicked(hotkey) {
;     this.Run(this.drop.OtherDropAll.bind(this.drop))
;   }

  AutoClickHotkey_Clicked(hotkey) {  
    if this.CanExecute() {
      ; Override and replace auto-farm if active
    ;   if (this.farm.IsAutoFarmOn && !this.farm.InInventory) {
    ;     this.farm.AutoFarmToggle()      
    ;   }
      this.autoClick.Toggle()
    }
  }

  GeforceAutoClickHotkey_Clicked(hotkey) {
    this.geforceAutoClick.Toggle()
  }

;   AutoFarmHotkey_Clicked(hotkey) {
;     this.Run(this.farm.AutoFarmToggle.bind(this.farm))
;   }

;   HandleFarmHotkey_Clicked(hotkey) {
;     this.Run(this.farm.HandleFarmRunItems.bind(this.farm))
;   }

;   AutoWalkHotkey_Clicked(hotkey) {
;     this.Run(this.autoWalk.AutoWalkToggle.bind(this.autoWalk))
;   }

  Run(action) {
    if this.CanExecute() {
      this.Interrupt(action)
    }
  }
}