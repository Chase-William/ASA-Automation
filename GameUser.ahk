#include "Config.ahk"

SELF_INVENTORY_SEARCHBAR_CONFIG_KEY := "selfInventorySearchbar"
SELF_DROP_ALL_CONFIG_KEY := "selfDropAll"
SELF_FIRST_SLOT_CONFIG_KEY := "selfFirstSlot"
SELF_SPLIT_STACKS_CONFIG_KEY := "selfSplitStacks"
SELF_SPLIT_ALL_CONFIG_KEY := "selfSplitAll"
SELF_TRANSFER_ALL_CONFIG_KEY := "selfTransferAll"
FLUSH_TOILET_CONFIG_KEY := "flushToilet"
SPAWN_SEARCHBAR_CONFIG_KEY := "spawnSearchBar"
SPAWN_BUTTON_CONFIG_KEY := "spawnButton"
MEAT_FARM_SPAWN_CONFIG_KEY := "meatFarmSpawn"
OTHER_INVENTORY_SEARCHBAR_CONFIG_KEY := "otherInventorySearchBar"
OTHER_DROP_ALL_CONFIG_KEY := "otherDropAll"
OTHER_TRANSFER_ALL_CONFIG_KEY := "otherTransferAll"

SELF_INVENTORY_TOGGLE_CONFIG_KEY := "toggleSelfInventory"
OTHER_INVENTORY_TOGGLE_CONFIG_KEY := "toggleOtherInventory"
DEFECATE_CONFIG_KEY := "defecate"

SPAWN_REGION_TEXT_REGION_CONFIG_KEY := "spawnRegionTextRegion"

class GameUser {
  __New(cfg) {
    this.cfg := cfg
  }

  SpawnRegionTextRegion {
    get {
      if (!IsSet(m_spawnRegionTextRegion)) {
        this.m_spawnRegionTextRegion := Config.GetRegion(SPAWN_REGION_TEXT_REGION_CONFIG_KEY)
      }
      return this.m_spawnRegionTextRegion
    }
    set {      
      Config.SetRegion(SPAWN_REGION_TEXT_REGION_CONFIG_KEY, value)
      this.m_spawnRegionTextRegion := value
    }
  }

  DefecateKeybind {
    get {
      if (!IsSet(m_defecate)) {
        this.m_defecate := Config.GetKeybind(DEFECATE_CONFIG_KEY)
      }
      return this.m_defecate
    }
    set {      
      Config.SetKeybind(DEFECATE_CONFIG_KEY, value)
      this.m_defecate := value
    }
  }

  OtherInventoryToggleKeybind {
    get {
      if (!IsSet(m_otherInventoryToggle)) {
        this.m_otherInventoryToggle := Config.GetKeybind(OTHER_INVENTORY_TOGGLE_CONFIG_KEY)
      }
      return this.m_otherInventoryToggle
    }
    set {      
      Config.SetKeybind(OTHER_INVENTORY_TOGGLE_CONFIG_KEY, value)
      this.m_otherInventoryToggle := value
    }
  }

  SelfInventoryToggleKeybind {
    get {
      if (!IsSet(m_selfInventoryToggle)) {
        this.m_selfInventoryToggle := Config.GetKeybind(SELF_INVENTORY_TOGGLE_CONFIG_KEY)
      }
      return this.m_selfInventoryToggle
    }
    set {      
      Config.SetKeybind(SELF_INVENTORY_TOGGLE_CONFIG_KEY, value)
      this.m_selfInventoryToggle := value
    }
  }

  SelfInventorySearchbarPosition {
    get {
      if (!IsSet(m_selfInventorySearchbar)) {
        this.m_selfInventorySearchbar := Config.GetPosition(SELF_INVENTORY_SEARCHBAR_CONFIG_KEY)
      }
      return this.m_selfInventorySearchbar
    }
    set {      
      Config.SetPosition(SELF_INVENTORY_SEARCHBAR_CONFIG_KEY, value)
      this.m_selfInventorySearchbar := value
    }
  }

  SelfDropAllPosition {
    get {
      if (!IsSet(m_selfDropAll)) {
        this.m_selfDropAll := Config.GetPosition(SELF_DROP_ALL_CONFIG_KEY)
      }
      return this.m_selfDropAll
    }
    set {
      Config.SetPosition(SELF_DROP_ALL_CONFIG_KEY, value)
      this.m_selfDropAll := value
    }
  }

  SelfFirstSlotPosition {
    get {
      if (!IsSet(m_selfFirstSlot)) {
        this.m_selfFirstSlot := Config.GetPosition(SELF_FIRST_SLOT_CONFIG_KEY)
      }
      return this.m_selfFirstSlot
    }
    set {
      Config.SetPosition(SELF_FIRST_SLOT_CONFIG_KEY, value)
      this.m_selfFirstSlot := value
    }
  }

  SplitStacksPosition {
    get {
      if (!IsSet(m_splitStacks)) {
        this.m_splitStacks := Config.GetPosition(SELF_SPLIT_STACKS_CONFIG_KEY)
      }
      return this.m_splitStacks
    }
    set {
      Config.SetPosition(SELF_SPLIT_STACKS_CONFIG_KEY, value)
      this.m_splitStacks := value
    }
  }

  SplitAllPosition {
    get {
      if (!IsSet(m_splitAll)) {
        this.m_splitAll := Config.GetPosition(SELF_SPLIT_ALL_CONFIG_KEY)
      }
      return this.m_splitAll
    }
    set {
      Config.SetPosition(SELF_SPLIT_ALL_CONFIG_KEY, value)
      this.m_splitAll := value
    }
  }

  SelfTransferAllPosition {
    get {
      if (!IsSet(m_selfTransferAll)) {
        this.m_selfTransferAll := Config.GetPosition(SELF_TRANSFER_ALL_CONFIG_KEY)
      }
      return this.m_selfTransferAll
    }
    set {
      Config.SetPosition(SELF_TRANSFER_ALL_CONFIG_KEY, value)
      this.m_selfTransferAll := value
    }
  }

  FlushToiletPosition {
    get {
      if (!IsSet(m_flushToilet)) {
        this.m_flushToilet := Config.GetPosition(FLUSH_TOILET_CONFIG_KEY)
      }
      return this.m_flushToilet
    }
    set {
      Config.SetPosition(FLUSH_TOILET_CONFIG_KEY, value)
      this.m_flushToilet := value
    }
  }

  SpawnSearchbarPosition {
    get {
      if (!IsSet(m_spawnSearchbar)) {
        this.m_spawnSearchbar := Config.GetPosition(SPAWN_SEARCHBAR_CONFIG_KEY)
      }
      return this.m_spawnSearchbar
    }
    set {
      Config.SetPosition(SPAWN_SEARCHBAR_CONFIG_KEY, value)
      this.m_spawnSearchbar := value
    }
  }

  SpawnButtonPosition {
    get {
      if (!IsSet(m_spawnButton)) {
        this.m_spawnButton := Config.GetPosition(SPAWN_BUTTON_CONFIG_KEY)
      }
      return this.m_spawnButton
    }
    set {
      Config.SetPosition(SPAWN_BUTTON_CONFIG_KEY, value)
      this.m_spawnButton := value
    }
  }

  MeatFarmSpawnPosition {
    get {
      if (!IsSet(m_meatFarmSpawn)) {
        this.m_meatFarmSpawn := Config.GetPosition(MEAT_FARM_SPAWN_CONFIG_KEY)
      }
      return this.m_meatFarmSpawn
    }
    set {
      Config.SetPosition(MEAT_FARM_SPAWN_CONFIG_KEY, value)
      this.m_meatFarmSpawn := value
    }
  }

  OtherInventorySearchbarPosition {
    get {
      if (!IsSet(m_otherInventorySearchbar)) {
        this.m_otherInventorySearchbar := Config.GetPosition(OTHER_INVENTORY_SEARCHBAR_CONFIG_KEY)
      }
      return this.m_otherInventorySearchbar
    }
    set {
      Config.SetPosition(OTHER_INVENTORY_SEARCHBAR_CONFIG_KEY, value)
      this.m_otherInventorySearchbar := value
    }
  }

  OtherDropAllPosition {
    get {
      if (!IsSet(m_otherDropAll)) {
        this.m_otherDropAll := Config.GetPosition(OTHER_DROP_ALL_CONFIG_KEY)
      }
      return this.m_otherDropAll
    }
    set {
      Config.SetPosition(OTHER_DROP_ALL_CONFIG_KEY, value)
    }
  }

  OtherTransferAllPosition {
    get {
      if (!IsSet(m_otherTransferAll)) {
        this.m_otherTransferAll := Config.GetPosition(OTHER_TRANSFER_ALL_CONFIG_KEY)
      }
      return this.m_otherTransferAll
    }
    set {
      Config.SetPosition(OTHER_TRANSFER_ALL_CONFIG_KEY, value)
    }
  }

  ; Clicks the respawn button on death screen.
  Respawn() {
    Click this.respawnButtonPos.x, this.respawnSearchbarPos.y
  }

  ; Focuses the respawn screen's searchbar.
  FocusRespawnSearchbar() {
    Click this.respawnSearchbarPos.x, this.respawnSearchbarPos.y
  }

  ; Focuses the searchbar, queries for a specific bed name.
  SearchBeds(text) {
    this.FocusRespawnSearchbar()
    Sleep this.cfg.delay.smw
    ; Enter bed name
    ControlSendText text,, this.cfg.process.windowTitle
  }

  ; Returns a boolean indicating if the respawn screen is available for interaction.
  IsRespawnScreenAvailable() {
    px := 0
    py := 0
    ; Search the area of the word "Region" of the "Spawn Region" message 
    ; for a color match
    return PixelSearch(
    &px, &py, 
    this.SpawnRegionTextRegion.left, ; need to fix this as it's currently a string
    this.SpawnRegionTextRegion.top,
    this.SpawnRegionTextRegion.right,
    this.SpawnRegionTextRegion.bottom, 
    this.cfg.color.RegionTextWhenDeadColor, 
    2 ; variance of color permitted
    )
  }

  ; Selects the pre-determined self meat farm beds.
  SelectMeatFarmBeds() {
    Click this.MeatFarmSpawnPosition.x, this.MeatFarmSpawnPosition.y
  }

  ; Flushes the toilet.
  FlushToilet() {
    Click this.FlushToiletPosition.x, this.FlushToiletPosition.y
  }

  ; Triggers character defecation.
  Defecate() {
    ControlSend Format("{1}", this.DefecateKeybind),, this.cfg.process.windowTitle
  }

  ; Toggles the inventory open or close.
  ToggleSelfInventory() {
    ControlSend Format("{1}", this.SelfInventoryToggleKeybind),, this.cfg.process.windowTitle
  }

  ToggleOtherInventory() {
    ControlSend Format("{1}", this.OtherInventoryToggleKeybind),, this.cfg.process.windowTitle
  }

  ; Focuses the searchbarPos; commonly used before text entry.
  FocusSelfSearchbar() {
    Click this.SelfInventorySearchbarPosition.x, this.SelfInventorySearchbarPosition.y
  }

  FocusOtherSearchbar() {
    Click this.OtherInventorySearchbarPosition.x, this.OtherInventorySearchbarPosition.y
  }

  ;
  ;
  ;
  ; Sure would be nice to have abstract properties so we
  ; can get our data in respect to the derived type, therefore,
  ; preventing us from writing almost duplicate methods in the 
  ; derived classes.
  ;
  ;
  ;


  ; Give all from your inventory
  GiveAll() {
    Click this.SelfTransferAllPosition.x, this.SelfTransferAllPosition.y
  }

  ; Take all from other inventory
  TakeAll() {
    Click this.OtherTransferAllPosition.x, this.OtherTransferAllPosition.y
  }

  ; Clicks the "Drop All" button.
  SelfDropAll() {
    Click this.SelfDropAllPosition.x, this.SelfDropAllPosition.y
  }

  OtherDropAll() {
    Click this.OtherDropAllPosition.x, this.OtherDropAllPosition.y
  }

  ; Automatically focuses the searchbarPos, queries and performs a take all.
  SearchAndTakeAll(text) {
    this.FocusOtherSearchbar()
    Sleep this.cfg.delay.lw
    ControlSendText text,, this.cfg.process.windowTitle
    Sleep this.cfg.delay.lw
    this.TakeAll()
  }  

  ; Automatically focues the searchbarPos, queries and performs a drop all.
  SearchOtherAndDropAll(text) {
    this.FocusOtherSearchbar()
    Sleep this.cfg.delay.mw
    ControlSendText text,, this.cfg.process.windowTitle
    Sleep this.cfg.delay.mw
    this.OtherDropAll()
  }

  ; Focuses the searchbar, queries for a specific bed name, searches the screen's pixels
  ; to find the beds, lastly focuses the found beds.
  ; SearchBedsAndAutoSelect(text) {
  ;   this.SearchBeds(text)
  ;   Sleep this.cfg.smediumWait
  ;   windowWidth := 0
  ;   windowHeight := 0
  ;   ; Get dimensions of the window
  ;   WinGetPos ,, &windowWidth, &windowHeight, this.cfg.windowTitle

  ;   ; Scan for pixel color of available beds with query active
  ;   x := 0
  ;   y := 0
  ;   ; Search the entire window for bed color
  ;   ; Added a little padding because beds should be more in the center of the screen *(optimization)
  ;   widthPadding := (windowWidth / 5)
  ;   heightPadding := (windowWidth / 5)
  ;   ; If unable to locate either the normal bed icon or grayed bed icon, report and error.
  ;   try {
  ;     if (
  ;       !ImageSearch(&x, &y, 100, 100, windowWidth, windowHeight, "*50 normal_bed_icon_v3.png") && 
  ;       !ImageSearch(&x, &y, 100, 100, windowWidth, windowHeight, "*30 gray_bed_icon_v3.png")
  ;     ) {
  ;       MsgBox "Was unable to locate a bed for selection.", "Error"
  ;     }
  ;   }
  ;   catch as e {
  ;     MsgBox "Image for automatic bed detection failed to load.", "Error"
  ;   }

  ;   ; if (!PixelSearch(&x, &y, 100, 100, windowWidth - widthPadding, windowHeight - heightPadding, this.cfg.bedSearchColor, 0)) {
  ;   ;   MsgBox "Was unable to located a bed for selection.", "Error"
  ;   ; }
  ;   ; Select bed
  ;   Click x, y
  ; }

  ; SearchBedsAndSelectAtDeathMarker() {
  ;    this.SearchBeds(text)
  ;   Sleep this.cfg.smediumWait
  ;   windowWidth := 0
  ;   windowHeight := 0
  ;   ; Get dimensions of the window
  ;   WinGetPos ,, &windowWidth, &windowHeight, this.cfg.windowTitle

  ;   ; Scan for pixel color of available beds with query active
  ;   x := 0
  ;   y := 0
  ;   ; Search the entire window for bed color
  ;   ; Added a little padding because beds should be more in the center of the screen *(optimization)
  ;   widthPadding := (windowWidth / 5)
  ;   heightPadding := (windowWidth / 5)
  ; }
}