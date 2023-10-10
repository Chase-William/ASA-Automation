#Requires AutoHotkey v2.0

SNAIL_GAPS_COUNT := 23
PASTE_COLLECTION_FREQUENCY := 5400000 ; 90 Minutes

class PasteFarmController {
  __New(cfg, user, movement, afk) {
    this.cfg := cfg
    this.user := user
    this.movement := movement
    this.afk := afk

    this.m_isPasteBotOn := false
  }

  IsPasteBotOn {
    get => this.m_isPasteBotOn
    set => this.m_isPasteBotOn := value
  }

  Farm() {
    IsPasteBotOn := true
    this.user.SearchBeds("16119205611813")
    Sleep this.cfg.delay.mw
    Click(this.user.PasteFarmSpawnPosition.x, this.user.PasteFarmSpawnPosition.y)
    Sleep this.cfg.delay.smw
    this.user.Spawn()

    ; Load area
    Sleep this.cfg.delay._3xlw

    ; Mount and Dismount ladder to align player
    this.user.Use()
    Sleep this.cfg.delay.mw
    this.user.Use()
    Sleep this.cfg.delay.lw

    ; Look down a little to prevent "e" from registering with railings
    ; Yet not too far to interact with dino poop or pooped paste
    this.movement.Look(LOOK_DOWN, this.cfg.delay.smw)

    ; Initial position to first snail
    this.movement.Move(MOVE_RIGHT, 500)

    ; Iterate over snails taking their paste and moving to the next
    index := 0
    while index++ < SNAIL_GAPS_COUNT {
      ; Wait after moving because of possible lag rubberband
      Sleep this.cfg.delay.mw
      this.user.OpenOtherInventorySafe()
      this.user.SearchOtherInventory("paste")
      Sleep this.cfg.delay.mw
      this.user.TakeOtherFirstSlot()
      Sleep this.cfg.delay.mw
      this.user.CloseOtherInventorySafe()
      this.movement.Move(MOVE_RIGHT, 200)
    }

    this.user.OpenOtherInventorySafe()
    this.user.SearchSelfInventory("paste")
    Sleep this.cfg.delay.mw
    
    ; Can be replaced on server with functional transfer all btn (give to)
    index := 0
    while index++ < 5 {
      ; Give past stacks, setup this way because current server does not support transfer all
      this.user.GiveSelfFirstSlot()
      Sleep this.cfg.delay.sw
    }

    this.user.CloseOtherInventorySafe()
    Sleep this.cfg.delay.mw
    this.movement.Look(LOOK_DOWN, this.cfg.delay._3xlw)

    ; Open spawn screen via selecting bed below character
    this.user.Use()
    Sleep this.cfg.delay.lw
    this.IsPasteBotOn := false
  }
}