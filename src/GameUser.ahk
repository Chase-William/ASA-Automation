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
TELEPORT_SEARCH_BAR_POSITION_CONFIG_KEY := "teleportSearchBar"
SPAWN_BUTTON_CONFIG_KEY := "spawnButton"
OTHER_INVENTORY_SEARCHBAR_CONFIG_KEY := "otherInventorySearchBar"
OTHER_DROP_ALL_CONFIG_KEY := "otherDropAll"
OTHER_TRANSFER_ALL_CONFIG_KEY := "otherTransferAll"
OTHER_FIRST_SLOT_CONFIG_KEY := "otherFirstSlot"
SELF_INVENTORY_TOGGLE_CONFIG_KEY := "toggleSelfInventory"
OTHER_INVENTORY_TOGGLE_CONFIG_KEY := "toggleOtherInventory"
DEFECATE_CONFIG_KEY := "defecate"

SPAWN_REGION_TEXT_REGION_CONFIG_KEY := "spawnRegionTextRegion"
DETECT_INVENTORY_OPEN_REGION_TEXT_CONFIG_KEY := "detectInventoryOpenTextRegion"

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
OTHER_INVENTORY_SEARCHBAR_FIELD_NAME := "m_otherInventorySearchBar"
OTHER_DROP_ALL_FIELD_NAME := "m_otherDropAll"
OTHER_TRANSFER_ALL_FIELD_NAME := "m_otherTransferAll"
OTHER_FIRST_SLOT_FIELD_NAME := "m_otherFirstSlot"
SELF_INVENTORY_TOGGLE_FIELD_NAME := "m_toggleSelfInventory"
OTHER_INVENTORY_TOGGLE_FIELD_NAME := "m_toggleOtherInventory"
DEFECATE_FIELD_NAME := "m_defecate"
TELEPORT_SEARCH_BAR_POSITION_FIELD_NAME := "m_teleportSearchBar"

SPAWN_REGION_TEXT_REGION_FIELD_NAME := "m_spawnRegionTextRegion"
DETECT_INVENTORY_OPEN_REGION_TEXT_FIELD_NAME := "m_detectInventoryOpenTextRegion"

SELF_HEAL_ACTIVATION_KEYBIND_FIELD_NAME := "m_heal"
SELF_EAT_ACTIVATION_KEYBIND_FIELD_NAME := "m_eat"
SELF_DRINK_ACTIVATION_KEYBIND_FIELD_NAME := "m_drink"

class GameUser {
  __New(cfg) {
    this.cfg := cfg
  }

  ; Regions

  SpawnRegionTextRegion {
    get => Config.GetMember(this, Config.GetRegion, SPAWN_REGION_TEXT_REGION_FIELD_NAME, SPAWN_REGION_TEXT_REGION_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetRegion, SPAWN_REGION_TEXT_REGION_FIELD_NAME, SPAWN_REGION_TEXT_REGION_CONFIG_KEY, value)
  }

  DetectInventoryOpenTextRegion {
    get => Config.GetMember(this, Config.GetRegion, DETECT_INVENTORY_OPEN_REGION_TEXT_FIELD_NAME, DETECT_INVENTORY_OPEN_REGION_TEXT_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetRegion, DETECT_INVENTORY_OPEN_REGION_TEXT_FIELD_NAME, DETECT_INVENTORY_OPEN_REGION_TEXT_CONFIG_KEY, value)
  }

  ; Keybinds

  DefecateKeybind {
    get => Config.GetMember(this, Config.GetKeybind, DEFECATE_FIELD_NAME, DEFECATE_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetKeybind, DEFECATE_FIELD_NAME, DEFECATE_CONFIG_KEY, value)
  }

  OtherInventoryToggleKeybind {
    get => Config.GetMember(this, Config.GetKeybind, OTHER_INVENTORY_TOGGLE_FIELD_NAME, OTHER_INVENTORY_TOGGLE_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetKeybind, OTHER_INVENTORY_TOGGLE_FIELD_NAME, OTHER_INVENTORY_TOGGLE_CONFIG_KEY, value)
  }

  SelfInventoryToggleKeybind {
    get => Config.GetMember(this, Config.GetKeybind, SELF_INVENTORY_SEARCHBAR_FIELD_NAME, SELF_INVENTORY_TOGGLE_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetKeybind, SELF_INVENTORY_SEARCHBAR_FIELD_NAME, SELF_INVENTORY_TOGGLE_CONFIG_KEY, value)
  }

  SelfHealKeybind {
    get => Config.GetMember(this, Config.GetKeybind, SELF_HEAL_ACTIVATION_KEYBIND_FIELD_NAME, SELF_HEAL_ACTIVATION_KEYBIND_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetKeybind, SELF_HEAL_ACTIVATION_KEYBIND_FIELD_NAME, SELF_HEAL_ACTIVATION_KEYBIND_CONFIG_KEY, value)
  }

  SelfEatKeybind {
    get => Config.GetMember(this, Config.GetKeybind, SELF_EAT_ACTIVATION_KEYBIND_FIELD_NAME, SELF_EAT_ACTIVATION_KEYBIND_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetKeybind, SELF_EAT_ACTIVATION_KEYBIND_FIELD_NAME, SELF_EAT_ACTIVATION_KEYBIND_CONFIG_KEY, value)
  }

  SelfDrinkKeybind {
    get => Config.GetMember(this, Config.GetKeybind, SELF_DRINK_ACTIVATION_KEYBIND_FIELD_NAME, SELF_DRINK_ACTIVATION_KEYBIND_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetKeybind, SELF_DRINK_ACTIVATION_KEYBIND_FIELD_NAME, SELF_DRINK_ACTIVATION_KEYBIND_CONFIG_KEY, value)
  }

  ; Positions

  SelfInventorySearchbarPosition {
    get => Config.GetMember(this, Config.GetPosition, SELF_INVENTORY_SEARCHBAR_FIELD_NAME, SELF_INVENTORY_SEARCHBAR_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SELF_INVENTORY_SEARCHBAR_FIELD_NAME, SELF_INVENTORY_SEARCHBAR_CONFIG_KEY, value)
  }

  SelfDropAllPosition {
    get => Config.GetMember(this, Config.GetPosition, SELF_DROP_ALL_FIELD_NAME, SELF_DROP_ALL_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SELF_DROP_ALL_FIELD_NAME, SELF_DROP_ALL_CONFIG_KEY, value)
  }

  SelfFirstSlotPosition {
    get => Config.GetMember(this, Config.GetPosition, SELF_FIRST_SLOT_FIELD_NAME, SELF_FIRST_SLOT_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SELF_FIRST_SLOT_FIELD_NAME, SELF_FIRST_SLOT_CONFIG_KEY, value)
  }

  SplitStacksPosition {
    get => Config.GetMember(this, Config.GetPosition, SELF_SPLIT_STACKS_FIELD_NAME, SELF_SPLIT_STACKS_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SELF_SPLIT_STACKS_FIELD_NAME, SELF_SPLIT_STACKS_CONFIG_KEY, value)
  }

  SplitAllPosition {
    get => Config.GetMember(this, Config.GetPosition, SELF_SPLIT_ALL_FIELD_NAME, SELF_SPLIT_ALL_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SELF_SPLIT_ALL_FIELD_NAME, SELF_SPLIT_ALL_CONFIG_KEY, value)
  }

  SelfTransferAllPosition {
    get => Config.GetMember(this, Config.GetPosition, SELF_TRANSFER_ALL_FIELD_NAME, SELF_TRANSFER_ALL_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SELF_TRANSFER_ALL_FIELD_NAME, SELF_TRANSFER_ALL_CONFIG_KEY, value)
  }

  SelfHealthThresholdPosition {
    get => Config.GetMember(this, Config.GetPosition, SELF_HEALTH_THRESHOLD_FIELD_NAME, SELF_HEALTH_THRESHOLD_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SELF_HEALTH_THRESHOLD_FIELD_NAME, SELF_HEALTH_THRESHOLD_CONFIG_KEY, value)
  }

  SelfFoodThresholdPosition {
    get => Config.GetMember(this, Config.GetPosition, SELF_FOOD_THRESHOLD_FIELD_NAME, SELF_FOOD_THRESHOLD_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SELF_FOOD_THRESHOLD_FIELD_NAME, SELF_FOOD_THRESHOLD_CONFIG_KEY, value)
  }

  SelfWaterThresholdPosition {
    get => Config.GetMember(this, Config.GetPosition, SELF_WATER_THRESHOLD_FIELD_NAME, SELF_WATER_THRESHOLD_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SELF_WATER_THRESHOLD_FIELD_NAME, SELF_WATER_THRESHOLD_CONFIG_KEY, value)
  }

  FlushToiletPosition {
    get => Config.GetMember(this, Config.GetPosition, FLUSH_TOILET_FIELD_NAME, FLUSH_TOILET_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, FLUSH_TOILET_FIELD_NAME, FLUSH_TOILET_CONFIG_KEY, value)
  }

  SpawnSearchbarPosition {
    get => Config.GetMember(this, Config.GetPosition, SPAWN_SEARCHBAR_FIELD_NAME, SPAWN_SEARCHBAR_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SPAWN_SEARCHBAR_FIELD_NAME, SPAWN_SEARCHBAR_CONFIG_KEY, value)
  }

  SpawnButtonPosition {
    get => Config.GetMember(this, Config.GetPosition, SPAWN_BUTTON_FIELD_NAME, SPAWN_BUTTON_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, SPAWN_BUTTON_FIELD_NAME, SPAWN_BUTTON_CONFIG_KEY, value)
  }

  OtherInventorySearchbarPosition {
    get => Config.GetMember(this, Config.GetPosition, OTHER_INVENTORY_SEARCHBAR_FIELD_NAME, OTHER_INVENTORY_SEARCHBAR_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, OTHER_INVENTORY_SEARCHBAR_FIELD_NAME, OTHER_INVENTORY_SEARCHBAR_CONFIG_KEY, value)
  }

  OtherDropAllPosition {
    get => Config.GetMember(this, Config.GetPosition, OTHER_DROP_ALL_FIELD_NAME, OTHER_DROP_ALL_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, OTHER_DROP_ALL_FIELD_NAME, OTHER_DROP_ALL_CONFIG_KEY, value)
  }

  OtherTransferAllPosition {
    get => Config.GetMember(this, Config.GetPosition, OTHER_TRANSFER_ALL_FIELD_NAME, OTHER_TRANSFER_ALL_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, OTHER_TRANSFER_ALL_FIELD_NAME, OTHER_TRANSFER_ALL_CONFIG_KEY, value)
  }

  ;
  ;
  ; Needs to be added to UI!
  ;
  ;
  OtherFirstSlotPosition {
    get => Config.GetMember(this, Config.GetPosition, OTHER_FIRST_SLOT_FIELD_NAME, OTHER_FIRST_SLOT_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, OTHER_FIRST_SLOT_FIELD_NAME, OTHER_FIRST_SLOT_CONFIG_KEY, value)
  }

  TeleportSearchBarPosition {
    get => Config.GetMember(this, Config.GetPosition, TELEPORT_SEARCH_BAR_POSITION_FIELD_NAME, TELEPORT_SEARCH_BAR_POSITION_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetPosition, TELEPORT_SEARCH_BAR_POSITION_FIELD_NAME, TELEPORT_SEARCH_BAR_POSITION_CONFIG_KEY, value)
  }

  ; Clicks the respawn button on death screen.
  Spawn() {
    Click this.SpawnButtonPosition.x, this.SpawnButtonPosition.y
  }

  ; Focuses the respawn screen's searchbar.
  FocusSpawnSearchbar() {
    Click this.SpawnSearchbarPosition.x, this.SpawnSearchbarPosition.y
  }

  FocusTeleportingSearchbar() {
    Click this.TeleportSearchBarPosition.x, this.TeleportSearchBarPosition.y
  }

  ; Focuses the searchbar, queries for a specific bed name.
  SearchBeds(text, isTeleporting := false) {
    if (isTeleporting)
      this.FocusTeleportingSearchbar()
    else
      this.FocusSpawnSearchbar()
    Sleep this.cfg.delay.mw
    ; Enter bed name
    ControlSendText text,, this.cfg.process.windowTitle
  }

  ; Presses E
  Use() {
    ControlSend("{E}",, this.cfg.process.windowTitle)
  }

  ; Returns a boolean indicating if the respawn screen is available for interaction.
  IsRespawnScreenAvailable() {
    px := 0
    py := 0
    ; Search the area of the word "Region" of the "Spawn Region" message 
    ; for a color match
    return PixelSearch(
      &px, &py, 
      this.SpawnRegionTextRegion.left,
      this.SpawnRegionTextRegion.top,
      this.SpawnRegionTextRegion.right,
      this.SpawnRegionTextRegion.bottom, 
      this.cfg.color.StandardUITextColor, 
      2 ; variance of color permitted
    )
  }

  IsInventoryOpen() {
    px := 0
    py := 0

    ; WinActivate(this.cfg.process.windowTitle)
    ; Sleep 1000
    ; MsgBox(PixelGetColor(190, 166), "")

    return PixelSearch(
      &px, &py, 
      this.DetectInventoryOpenTextRegion.left,
      this.DetectInventoryOpenTextRegion.top,
      this.DetectInventoryOpenTextRegion.right,
      this.DetectInventoryOpenTextRegion.bottom, 
      this.cfg.color.StandardUITextColor, 
      10
    )
  }

  ; Flushes the toilet.
  FlushToilet() {
    Click(this.FlushToiletPosition.x, this.FlushToiletPosition.y)
  }

  ; Triggers character defecation.
  Defecate() {
    ControlSend(this.DefecateKeybind,, this.cfg.process.windowTitle)
  }

  ; Toggles the inventory open or close.
  ToggleSelfInventory() {
    ControlSend(Format("{1}", this.SelfInventoryToggleKeybind),, this.cfg.process.windowTitle)
  }

  ToggleOtherInventory() {
    ControlSend(Format("{1}", this.OtherInventoryToggleKeybind),, this.cfg.process.windowTitle)
  }

  ; Focuses the searchbarPos; commonly used before text entry.
  FocusSelfSearchbar() {
    Click this.SelfInventorySearchbarPosition.x, this.SelfInventorySearchbarPosition.y
  }

  FocusOtherSearchbar() {
    Click this.OtherInventorySearchbarPosition.x, this.OtherInventorySearchbarPosition.y
  }

  ClearSelfSearchbar(focus := true) {
    if (focus) {
      this.FocusSelfSearchbar()
      Sleep this.cfg.delay.sw
    }
    this.ClearSearchbar()
  }

  ClearOtherSearchbar(focus := true) {
    if (focus) {
      this.FocusOtherSearchbar()
      Sleep this.cfg.delay.sw
    }
    this.ClearSearchbar()
  }

  ClearSearchbar() {
    Sleep this.cfg.delay.mw
    ; SetKeyDelay(50)
    SendEvent "^a{BackSpace}"
    Sleep this.cfg.delay.sw
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

  TakeOtherFirstSlot() {
    this.SelectOtherFirstSlot()
    Sleep this.cfg.delay.sw
    ControlSend("{T}",, this.cfg.process.windowTitle)    
  }

  GiveSelfFirstSlot() {
    this.SelectSelfFirstSlot()
    Sleep this.cfg.delay.sw
    ControlSend("{T}",, this.cfg.process.windowTitle)   
  }

  SelectSelfFirstSlot() {
    Click(this.SelfFirstSlotPosition.x, this.SelfFirstSlotPosition.y)
  }


  SelectOtherFirstSlot() {
    Click(this.OtherFirstSlotPosition.x, this.OtherFirstSlotPosition.y)
  }

  SearchOtherInventory(text) {
    this.FocusOtherSearchbar()
    Sleep this.cfg.delay.sw
    ControlSendText text,, this.cfg.process.windowTitle
  }

  SearchSelfInventory(text) {
    this.FocusSelfSearchbar()
    Sleep this.cfg.delay.sw
    ControlSendText text,, this.cfg.process.windowTitle
  }

  ; Automatically focuses the searchbarPos, queries and performs a take all.
  SearchOtherAndTakeAll(text) {
    this.SearchOtherInventory(text)
    Sleep this.cfg.delay.sw
    this.TakeAll()
  }  

  SearchSelfAndDropAll(text) {
    this.SearchSelfInventory(text)
    Sleep this.cfg.delay.sw
    this.SelfDropAll()
  }

  ; Automatically focues the searchbarPos, queries and performs a drop all.
  SearchOtherAndDropAll(text) {
    this.SearchOtherInventory(text)
    Sleep this.cfg.delay.smw
    this.OtherDropAll()
  }

  SearchSelfAndGiveAll(text) {
    this.SearchSelfInventory(text)
    Sleep this.cfg.delay.smw
    this.GiveAll()
  }

  OpenOtherInventorySafe() {
    this.LoopUntilTrue(this.ToggleOtherInventory.bind(this), this.IsInventoryOpen.bind(this))
  }

  CloseOtherInventorySafe() {
    this.LoopUntilFalse(this.ToggleOtherInventory.bind(this), this.IsInventoryOpen.bind(this))
  }

  OpenSelfInventorySafe() {
    this.LoopUntilTrue(this.ToggleSelfInventory.bind(this), this.IsInventoryOpen.bind(this))
  }

  CloseSelfInventorySafe() {
    this.LoopUntilFalse(this.ToggleSelfInventory.bind(this), this.IsInventoryOpen.bind(this))
  }

  LoopUntilTrue(action, check) {
    static delay := this.cfg.delay.mw
    Loop {
      action()
      Sleep delay := delay * 2
      ; delay := delay * 2 ; Each iteration double the wait time (helps with lag of operating in different locations)
    } Until check()
    ; Reset
    delay := this.cfg.delay.xlw
  }

  LoopUntilFalse(action, check) {
    this.LoopUntilTrue(action, () => !check())
  }

  MedBrew() {
    ControlSend(this.SelfHealKeybind,, this.cfg.process.windowTitle)
  }

  Eat() {
    ControlSend(this.SelfEatKeybind,, this.cfg.process.windowTitle)
  }

  Drink() {
    ControlSend(this.SelfDrinkKeybind,, this.cfg.process.windowTitle)
  }
}