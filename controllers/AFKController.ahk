#Requires AutoHotkey v2.0

class AFKController {
  __New(cfg, user, movement) {
    this.cfg := cfg
    this.user := user
    this.movement := movement
  }

  ; Puts character in afk state
  BeginAFK() {
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
    this.user.TakeOtherFirstSlot()
    Sleep this.cfg.delay.sw
    this.user.TakeOtherFirstSlot()
    Sleep this.cfg.delay.sw
    this.user.toggleOtherInventory()
    Sleep this.cfg.delay.lw
    this.movement.Look(LOOK_UP, this.cfg.delay._2xlw)
    this.movement.Move(MOVE_BACKWARDS, this.cfg.delay._2xlw)
    ; Mount chair
    this.user.Use()
    ; Ensure auto food and water are active
    ; Waiting
  }

  ; Ends character afk state
  EndAFK() {
    ; State begins in afk chamber chair
    ; State ends at spawn screen

    ; Dismount chair
    this.user.Use()
    Sleep this.cfg.delay.xlw

    ; Put food/water away in fridge
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.xlw
    this.user.GiveSelfFirstSlot()
    Sleep this.cfg.delay.mw
    this.user.GiveSelfFirstSlot()
    Sleep this.cfg.delay.mw
    this.user.ToggleOtherInventory()
    Sleep this.cfg.delay.lw
    this.movement.Look(LOOK_DOWN, this.cfg.delay._2xlw)
    this.user.Use()
    ; Ready to teleport
  }
}