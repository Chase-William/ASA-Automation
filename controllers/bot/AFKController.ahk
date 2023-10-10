#Requires AutoHotkey v2.0

AWAITING_ORDERS_AFK_STATE := "awaiting"
LEAVING_AFK_STATE := "leaving"
ENTERING_AFK_STATE := "entering"
NOT_IN_AFK_STATE := "notAfk"

; Manages restoring the bot into an AFK state to await instructions
; THIS CONTROLLER IS NOT TOGGLED DIRECTLY BY THE USER, ONLY BY THE BOT CONTROLLER
class AFKController {
  __New(cfg, user, movement) {
    this.cfg := cfg
    this.user := user
    this.movement := movement
  }

  AFKState {
    
  }

  ; Puts character in afk state
  BeginAFK() {
    this.AFKState := ENTERING_AFK_STATE
    ; State begins at the spawn screen
    ; State ends resting peacefully in afk chamber chair
    this.user.SearchBeds("AFK Chamber")
    Sleep this.cfg.delay.lw
    this.user.SelectAFKChamberBeds()
    Sleep this.cfg.delay.lw
    this.user.Spawn()
    Sleep this.cfg.delay._2xlw ; MAY NEED TO CHANGE DEPENDING ON LAG

    ; Open fridge and take food and water
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.lw
    
    ; In the future filter food/water and take
    this.user.SearchOtherInventory("pigs feet")
    Sleep this.cfg.delay.mw
    this.user.TakeOtherFirstSlot()
    Sleep this.cfg.delay.mw
    this.user.ClearOtherSearchbar()
    Sleep this.cfg.delay.lw
    this.user.SearchOtherInventory("beatle juice")
    Sleep this.cfg.delay.mw
    this.user.TakeOtherFirstSlot()
    Sleep this.cfg.delay.mw
    this.user.SearchSelfInventory("pigs feet")
    Sleep this.cfg.delay.mw
    this.user.SelectSelfFirstSlot()
    Sleep this.cfg.delay.sw
    SendEvent "+8"
    Sleep this.cfg.delay.lw
    this.user.ClearSelfSearchbar()
    Sleep this.cfg.delay.lw
    this.user.SearchSelfInventory("beatle juice")
    Sleep this.cfg.delay.mw
    this.user.SelectSelfFirstSlot()
    Sleep this.cfg.delay.sw
    SendEvent "+0"
    Sleep this.cfg.delay.lw
    this.user.toggleOtherInventory()
    Sleep this.cfg.delay.lw
    this.movement.Look(LOOK_UP, this.cfg.delay._2xlw)
    this.movement.Move(MOVE_BACKWARDS, this.cfg.delay._2xlw)
    ; Mount chair
    this.user.Use()
    ; Ensure auto food and water are active
    ; Waiting
    this.AFKState := AWAITING_ORDERS_AFK_STATE
  }

  ; Ends character afk state
  EndAFK() {
    AFKState := LEAVING_AFK_STATE
    ; State begins in afk chamber chair
    ; State ends at spawn screen

    ; Dismount chair
    this.user.Use()
    Sleep this.cfg.delay.xlw

    ; Put food/water away in fridge
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.xlw
    this.user.GiveHotbarFoodAndDrink()
    Sleep this.cfg.delay.mw
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.lw
    this.movement.Look(LOOK_DOWN, this.cfg.delay._2xlw)
    this.user.Use()
    Sleep this.cfg.delay.lw
    AFKState := NOT_IN_AFK_STATE
    ; Ready to teleport
  }
}