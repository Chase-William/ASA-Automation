#include "Config.ahk"

; config.ini mappings
SELF_INVENTORY_SEARCHBAR_CONFIG_KEY := "selfInventorySearchbar"
SELF_DROP_ALL_CONFIG_KEY := "selfDropAll"
SELF_FIRST_SLOT_CONFIG_KEY := "selfFirstSlot"
SELF_SPLIT_STACKS_CONFIG_KEY := "selfSplitStacks"
SELF_SPLIT_ALL_CONFIG_KEY := "selfSplitAll"
SELF_TRANSFER_ALL_CONFIG_KEY := "selfTransferAll"
SELF_HEALTH_THRESHOLD_CONFIG_KEY := "selfHealthThreshold"
SELF_FOOD_THRESHOLD_CONFIG_KEY := "selfFoodThreshold"
SELF_WATER_THRESHOLD_CONFIG_KEY := "selfWaterThreshold"
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

SELF_HEAL_ACTIVATION_KEYBIND_CONFIG_KEY := "heal"
SELF_EAT_ACTIVATION_KEYBIND_CONFIG_KEY := "eat"
SELF_DRINK_ACTIVATION_KEYBIND_CONFIG_KEY := "drink"

; field names
SELF_INVENTORY_SEARCHBAR_FIELD_NAME := "selfInventorySearchbar"
SELF_DROP_ALL_FIELD_NAME := "m_selfDropAll"
SELF_FIRST_SLOT_FIELD_NAME := "m_selfFirstSlot"
SELF_SPLIT_STACKS_FIELD_NAME := "m_selfSplitStacks"
SELF_SPLIT_ALL_FIELD_NAME := "m_selfSplitAll"
SELF_TRANSFER_ALL_FIELD_NAME := "m_selfTransferAll"
SELF_HEALTH_THRESHOLD_FIELD_NAME := "m_selfHealthThreshold"
SELF_FOOD_THRESHOLD_FIELD_NAME := "m_selfFoodThreshold"
SELF_WATER_THRESHOLD_FIELD_NAME := "m_selfWaterThreshold"
FLUSH_TOILET_FIELD_NAME := "m_flushToilet"
SPAWN_SEARCHBAR_FIELD_NAME := "m_spawnSearchBar"
SPAWN_BUTTON_FIELD_NAME := "m_spawnButton"
MEAT_FARM_SPAWN_FIELD_NAME := "m_meatFarmSpawn"
OTHER_INVENTORY_SEARCHBAR_FIELD_NAME := "m_otherInventorySearchBar"
OTHER_DROP_ALL_FIELD_NAME := "m_otherDropAll"
OTHER_TRANSFER_ALL_FIELD_NAME := "m_otherTransferAll"
SELF_INVENTORY_TOGGLE_FIELD_NAME := "m_toggleSelfInventory"
OTHER_INVENTORY_TOGGLE_FIELD_NAME := "m_toggleOtherInventory"
DEFECATE_FIELD_NAME := "m_defecate"
SPAWN_REGION_TEXT_REGION_FIELD_NAME := "m_spawnRegionTextRegion"

SELF_HEAL_ACTIVATION_KEYBIND_FIELD_NAME := "m_heal"
SELF_EAT_ACTIVATION_KEYBIND_FIELD_NAME := "m_eat"
SELF_DRINK_ACTIVATION_KEYBIND_FIELD_NAME := "m_drink"

class GameUser {
  __New(cfg) {
    this.cfg := cfg
  }

  ; Regions

  SpawnRegionTextRegion {
    get => this.Get(Config.GetRegion, SPAWN_REGION_TEXT_REGION_FIELD_NAME, SPAWN_REGION_TEXT_REGION_CONFIG_KEY)
    set => this.Set(Config.SetRegion, SPAWN_REGION_TEXT_REGION_FIELD_NAME, SPAWN_REGION_TEXT_REGION_CONFIG_KEY, value)
  }

  ; Keybinds

  DefecateKeybind {
    get => this.Get(Config.GetKeybind, DEFECATE_FIELD_NAME, DEFECATE_CONFIG_KEY)
    set => this.Set(Config.SetKeybind, DEFECATE_FIELD_NAME, DEFECATE_CONFIG_KEY, value)
  }

  OtherInventoryToggleKeybind {
    get => this.Get(Config.GetKeybind, OTHER_INVENTORY_TOGGLE_FIELD_NAME, OTHER_INVENTORY_TOGGLE_CONFIG_KEY)
    set => this.Set(Config.SetKeybind, OTHER_INVENTORY_TOGGLE_FIELD_NAME, OTHER_INVENTORY_TOGGLE_CONFIG_KEY, value)
  }

  SelfInventoryToggleKeybind {
    get => this.Get(Config.GetKeybind, SELF_INVENTORY_SEARCHBAR_FIELD_NAME, SELF_INVENTORY_TOGGLE_CONFIG_KEY)
    set => this.Set(Config.SetKeybind, SELF_INVENTORY_SEARCHBAR_FIELD_NAME, SELF_INVENTORY_TOGGLE_CONFIG_KEY, value)
  }

  SelfHealKeybind {
    get => this.Get(Config.GetKeybind, SELF_HEAL_ACTIVATION_KEYBIND_FIELD_NAME, SELF_HEAL_ACTIVATION_KEYBIND_CONFIG_KEY)
    set => this.Set(Config.SetKeybind, SELF_HEAL_ACTIVATION_KEYBIND_FIELD_NAME, SELF_HEAL_ACTIVATION_KEYBIND_CONFIG_KEY, value)
  }

  SelfEatKeybind {
    get => this.Get(Config.GetKeybind, SELF_EAT_ACTIVATION_KEYBIND_FIELD_NAME, SELF_EAT_ACTIVATION_KEYBIND_CONFIG_KEY)
    set => this.Set(Config.SetKeybind, SELF_EAT_ACTIVATION_KEYBIND_FIELD_NAME, SELF_EAT_ACTIVATION_KEYBIND_CONFIG_KEY, value)
  }

  SelfDrinkKeybind {
    get => this.Get(Config.GetKeybind, SELF_DRINK_ACTIVATION_KEYBIND_FIELD_NAME, SELF_DRINK_ACTIVATION_KEYBIND_CONFIG_KEY)
    set => this.Set(Config.SetKeybind, SELF_DRINK_ACTIVATION_KEYBIND_FIELD_NAME, SELF_DRINK_ACTIVATION_KEYBIND_CONFIG_KEY, value)
  }

  ; Positions

  SelfInventorySearchbarPosition {
    get => this.Get(Config.GetPosition, SELF_INVENTORY_SEARCHBAR_FIELD_NAME, SELF_INVENTORY_SEARCHBAR_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SELF_INVENTORY_SEARCHBAR_FIELD_NAME, SELF_INVENTORY_SEARCHBAR_CONFIG_KEY, value)
  }

  SelfDropAllPosition {
    get => this.Get(Config.GetPosition, SELF_DROP_ALL_FIELD_NAME, SELF_DROP_ALL_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SELF_DROP_ALL_FIELD_NAME, SELF_DROP_ALL_CONFIG_KEY, value)
  }

  SelfFirstSlotPosition {
    get => this.Get(Config.GetPosition, SELF_FIRST_SLOT_FIELD_NAME, SELF_FIRST_SLOT_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SELF_FIRST_SLOT_FIELD_NAME, SELF_FIRST_SLOT_CONFIG_KEY, value)
  }

  SplitStacksPosition {
    get => this.Get(Config.GetPosition, SELF_SPLIT_STACKS_FIELD_NAME, SELF_SPLIT_STACKS_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SELF_SPLIT_STACKS_FIELD_NAME, SELF_SPLIT_STACKS_CONFIG_KEY, value)
  }

  SplitAllPosition {
    get => this.Get(Config.GetPosition, SELF_SPLIT_ALL_FIELD_NAME, SELF_SPLIT_ALL_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SELF_SPLIT_ALL_FIELD_NAME, SELF_SPLIT_ALL_CONFIG_KEY, value)
  }

  SelfTransferAllPosition {
    get => this.Get(Config.GetPosition, SELF_TRANSFER_ALL_FIELD_NAME, SELF_TRANSFER_ALL_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SELF_TRANSFER_ALL_FIELD_NAME, SELF_TRANSFER_ALL_CONFIG_KEY, value)
  }

  SelfHealthThresholdPosition {
    get => this.Get(Config.GetPosition, SELF_HEALTH_THRESHOLD_FIELD_NAME, SELF_HEALTH_THRESHOLD_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SELF_HEALTH_THRESHOLD_FIELD_NAME, SELF_HEALTH_THRESHOLD_CONFIG_KEY, value)
  }

  SelfFoodThresholdPosition {
    get => this.Get(Config.GetPosition, SELF_FOOD_THRESHOLD_FIELD_NAME, SELF_FOOD_THRESHOLD_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SELF_FOOD_THRESHOLD_FIELD_NAME, SELF_FOOD_THRESHOLD_CONFIG_KEY, value)
  }

  SelfWaterThresholdPosition {
    get => this.Get(Config.GetPosition, SELF_WATER_THRESHOLD_FIELD_NAME, SELF_WATER_THRESHOLD_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SELF_WATER_THRESHOLD_FIELD_NAME, SELF_WATER_THRESHOLD_CONFIG_KEY, value)
  }

  FlushToiletPosition {
    get => this.Get(Config.GetPosition, FLUSH_TOILET_FIELD_NAME, FLUSH_TOILET_CONFIG_KEY)
    set => this.Set(Config.SetPosition, FLUSH_TOILET_FIELD_NAME, FLUSH_TOILET_CONFIG_KEY, value)
  }

  SpawnSearchbarPosition {
    get => this.Get(Config.GetPosition, SPAWN_SEARCHBAR_FIELD_NAME, SPAWN_SEARCHBAR_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SPAWN_SEARCHBAR_FIELD_NAME, SPAWN_SEARCHBAR_CONFIG_KEY, value)
  }

  SpawnButtonPosition {
    get => this.Get(Config.GetPosition, SPAWN_BUTTON_FIELD_NAME, SPAWN_BUTTON_CONFIG_KEY)
    set => this.Set(Config.SetPosition, SPAWN_BUTTON_FIELD_NAME, SPAWN_BUTTON_CONFIG_KEY, value)
  }

  MeatFarmSpawnPosition {
    get => this.Get(Config.GetPosition, MEAT_FARM_SPAWN_FIELD_NAME, MEAT_FARM_SPAWN_CONFIG_KEY)
    set => this.Set(Config.SetPosition, MEAT_FARM_SPAWN_FIELD_NAME, MEAT_FARM_SPAWN_CONFIG_KEY, value)
  }

  OtherInventorySearchbarPosition {
    get => this.Get(Config.GetPosition, OTHER_INVENTORY_SEARCHBAR_FIELD_NAME, OTHER_INVENTORY_SEARCHBAR_CONFIG_KEY)
    set => this.Set(Config.SetPosition, OTHER_INVENTORY_SEARCHBAR_FIELD_NAME, OTHER_INVENTORY_SEARCHBAR_CONFIG_KEY, value)
  }

  OtherDropAllPosition {
    get => this.Get(Config.GetPosition, OTHER_DROP_ALL_FIELD_NAME, OTHER_DROP_ALL_CONFIG_KEY)
    set => this.Set(Config.SetPosition, OTHER_DROP_ALL_FIELD_NAME, OTHER_DROP_ALL_CONFIG_KEY, value)
  }

  OtherTransferAllPosition {
    get => this.Get(Config.GetPosition, OTHER_TRANSFER_ALL_FIELD_NAME, OTHER_DROP_ALL_CONFIG_KEY)
    set => this.Set(Config.SetPosition, OTHER_TRANSFER_ALL_FIELD_NAME, OTHER_DROP_ALL_CONFIG_KEY, value)
  }

  ; Used as the getter for properties
  Get(getter, memberName, configKey) {
    if (!IsSet(%memberName%)) {
      this.%memberName% := getter(this, configKey)
    }
    return this.%memberName%
  }

  ; Used as the setter for properties
  Set(setter, memberName, configKey, value) {
    setter(this, configKey, value)
    this.%memberName% := value
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