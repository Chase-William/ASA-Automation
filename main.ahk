; This application is not designed to work with more than one:
; - SelfInfo
; - OtherInfo
; - LilxDController created and being used at one time

#Requires AutoHotkey v2.0

#Include "LilxDHotkey.ahk"
#Include "LilxDController.ahk"
#Include "SelfInfo.ahk"
#Include "OtherInfo.ahk"
#Include "UI.ahk"

ctx := {
  arkWindowName: "ARK: Survival Evolved",
  arkProcessName: "ShooterGame.exe",
  longWait: 750,
  mediumWait: 500,
  smediumWait: 350,
  smallWait: 200,
  autoClickInterval: 50, ; milliseconds
  stoneStr: "Stone",
  flintStr: "flint",
  berries: "rr",
  searchRawMeat: "Raw",
  bedSearchColor: 0x00B2B2, ; Color used when scanning for available beds
  regionTextColorWhenDead: 0x68FFFF, ; Color of the "Region" text when on death screen
  regionTextColorWhenFastTraveling: 0x0, ; Color of the "Region" text when on fast travel screen
  ; deathMarkerColor: 0xFF7D7C ; Color of the death marker
}

; Provide information about using your own inventory
self := SelfInfo(
  ctx,
  "R", ; Toggle inventory
  "'", ; Defecate
  { x: 190, y: 240}, ; Searchbar
  { x: 545, y: 246 }, ; Drop all
  { x: 222, y: 364 }, ; First slot
  { x: 236, y: 620 }, ; Split stacks
  { x: 358, y: 700 }, ; Split all
  { x: 480, y: 240 }, ; Transfer all *(give all)
  { x: 1290, y: 830 }, ; Flush toilet
  { x: 412, y: 1305 }, ; Respawn Search bar
  { x: 1145, y: 1303 }, ; Respawn Button
  ; Bounding Box of "Region" text on fast-travel and respawn screens
  { left: 2105, top: 120, right: 135, bottom: 170 },
  { x: 635, y: 670 } ; Spawn Location for self meat farm
)

; Provide Information about using another entity's inventory
other := OtherInfo(
  ctx,
  "F", ; Toggle inventory
  { x: 1686, y: 242 }, ; Searchbar
  { x: 1960, y: 250 }, ; Drop all
  { x: 1900, y: 245 } ; Transfer all *(take all)
)

; Create the hotkey controller
controller := LilxDController(
  ctx,
  self,
  other,
  LilxDHotkey("capslock", "~"), ; Autoclick
  LilxDHotkey("numlock", "~"), ; Auto Metal Farm
  LilxDHotkey("F9"), ; Auto Self Meat Farm
  LilxDHotkey("F8") ; Auto Fertilizer Farm
)

; Create the user interface that uses the controller
myUI := UI(controller)

; MsgBox "Test", test.searchbarPos

; A script for all your ARK needs by Lil xD

; arkWindowName := "ARK: Survival Evolved"
; arkProcessName := "ShooterGame.exe"
; ; Used as lag compensation
; longWait := 750
; mediumWait := 500
; smediumWait := 350
; smallWait := 200
; autoClickInterval := 50 ; milliseconds

; respawnSearchbarLoc := { x: 412, y: 1305 }
; ; NOTE: Spawn button can be inaccessible when bed selection is active
; respawnBtnLoc := { x: 1145, y: 1303 }

; stoneStr := "Stone"
; flintStr := "flint"
; berries := "rr"
; searchRawMeat := "Raw"

; ; State for inventory UI positions
; inventory := {}
; inventory.defecate := "'"
; inventory.otherInventoryToggle := "F"
; inventory.selfInventoryToggle := "R"
; inventory.selfSearchbar := {
;   x: 190,
;   y: 240
; }
; inventory.selfFirstSlot := {
;   x: 222,
;   y: 364
; }
; inventory.selfSplitStack := {
;   x: 236,
;   y: 620
; }
; inventory.selfSplitAll := {
;   x: 358,
;   y: 700
; }
; inventory.otherSearchbar := {
;   x: 1686,
;   y: 242
; }
; inventory.otherDropAll := {
;   x: 1960,
;   y: 250
; }
; inventory.otherTakeAll := {
;   x: 1900,
;   y: 245
; }
; inventory.selfDropAll := {
;   x: 545,
;   y: 246
; }
; inventory.transferAllFromSelf := {
;   x: 480,
;   y: 240
; }
; inventory.flushButton := {
;   x: 1290,
;   y: 830
; }

; ;
; ; HOT KEYS
; ;

; ; Drop all trash in metal run
; Numpad7::{
;   HandleMetalRunItems()
; }

; ; Split raw meat
; NumpadMult::{
;   SplitRawMeat()
; }

; ; Take all from other inventory
; NumpadDiv::{
;   DropAllSelf()
; }

; ; Take all from other inventory
; N::{
;   Click inventory.otherTakeAll.x, inventory.otherTakeAll.y
;   Sleep smediumWait
;   ToggleOtherInventory()
; }

; V::{
;   ToggleOtherInventory()
;   Sleep longWait
;   TransferAllToOther()
;   Sleep smediumWait  
;   ToggleOtherInventory()
; }

; ; Normal Autoclick
; ; ~capslock::{
; ;   if getkeystate("capslock", "T") 
; ;     SetTimer(Click, autoClickInterval)
; ;   else
; ;     SetTimer(Click, 0)
; ; }


; ; Autoclick with metal farm
; ~NumLock::{
;   if getkeystate("numlock", "T") 
;     SetTimer(AutoClickMetalFarm, autoClickInterval)
;   else
;     SetTimer(AutoClickMetalFarm, 0)
; }

; ; Fert Farm
; F8::{
;   static on := false
;   if on := !on {
;     SetTimer(LoopDefecate, 1000)
;   }
;   else Reload
; }

; ; Self Meat Farm
; ; NOTE: Enable at spawn screen
; F9::{
;   static on := false
;   if on := !on {
;     SetTimer Respawn, 1000
;   }
;   else Reload
; }

; Respawn() {
;   ; Grab a color from the top left of the screen
;   ; Check pixel color that only exist when dead
;   ;color := PixelGetColor(50, 50)
;   px := 0
;   py := 0
;   ; Search the area of the "S" of "Spawn Region" for a color match with allowed color variation of 2
;   if (PixelSearch(&px, &py, 1936, 125, 1957, 167, 0x67FFFF, 2)) {
;     ; Focus the respawn searchbar
;     Click respawnSearchbarLoc.x, respawnSearchbarLoc.y
;     Sleep mediumWait
;     ControlSendText "meet my meat",, arkWindowName
;     Sleep mediumWait
;     ; Click on beds    
;     Click 637, 672
;     Sleep mediumWait
;     ; Spawn
;     Click respawnBtnLoc.x, respawnBtnLoc.y
;     ; Wait five seconds before scanning again
;     Sleep 5000
;   }
; }

; ;
; ; Helper Functions
; ;

; LoopDefecate() {
;   static count := 0
;   if count++ < 250 {
;     FertilizerFarm()
;   } else {
;     Reload
;   }
; }

; ; Does not open or close inventory
; SplitRawMeat() {
;   if PID := ProcessExist(arkProcessName) {
;     ClearSearchbar()
;     Sleep longWait
;     ControlSend "{Backspace}",, arkWindowName
;     Sleep mediumWait
;     ControlSendText searchRawMeat,, arkWindowName
;     Sleep mediumWait
;     Click "Right", inventory.selfFirstSlot.x, inventory.selfFirstSlot.y
;     Sleep mediumWait
;     Click inventory.selfSplitStack.x, inventory.selfSplitStack.y
;     Sleep mediumWait
;     Click inventory.selfSplitAll.x, inventory.selfSplitAll.y
;   }
; }

; AutoClickMetalFarm() {
;   ; Determines how many clicks must pass before
;   ; automatic dropping of unwanted items occurs
;   static
;   static clickThreshold := 400 ; Every 20 seconds perform clean inventory
;   static clicks := 0

;   ; Drop unwanted items
;   if (clicks == clickThreshold) {
;     HandleMetalRunItems()
;     Sleep mediumWait
;     clicks := 0 ; reset
;   }
;   Click 
;   clicks := clicks + 1
; }

; ; Opens the invent and takes flint while dropping stone * berries
; HandleMetalRunItems() {
;   ToggleOtherInventory() ; open invent
;   Sleep longWait
;   ; Filter and drop
;   TakeAllOtherSearchedItems(flintStr)
;   Sleep mediumWait
;   ; Filter and drop
;   DropAllOtherSearchedItems(berries)
;   Sleep smallWait
;   DropAllOtherSearchedItems(stoneStr) 
;   Sleep smallWait
;   ToggleOtherInventory()
; }

; ; Focuses the searchbar and selects the filter word and deletes it
; ClearSearchbar() {
;   FocusOtherSearchbar()
;   Sleep longWait
;   ; Clear previous text so this is spammable
;   Click ,,2
;   ; SendMessage 0xB1,,,, arkWindowName
;   Sleep smallWait
;   ControlSend "{Backspace}",, arkWindowName
; }

; ; Focuses the other's searchbar, filters items, takes filter result
; TakeAllOtherSearchedItems(text) {
;   FocusOtherSearchbar()
;   Sleep longWait
;   ControlSendText text,, arkWindowName
;   Sleep longWait
;   TakeFromOther()
; }

; ; Focus and filter the searchbar and drop results
; DropAllOtherSearchedItems(text) {
;   FocusOtherSearchbar()
;   Sleep mediumWait
;   ControlSendText text,, arkWindowName
;   Sleep mediumWait
;   ClickOtherDropAll()
; }

; ; Opens or closes another's inventory
; ToggleOtherInventory() {
;   ControlSend Format("{1}", inventory.otherInventoryToggle),, arkWindowName
; }

; ; Opens or closes the player's inventory
; ToggleSelfInventory() {
;   ControlSend Format("{1}", inventory.selfInventoryToggle),, arkWindowName
; }

; ; Click the take all button in the other items inventory
; TakeFromOther() {
;   Click inventory.otherTakeAll.x, inventory.otherTakeAll.y
; }

; ; Click the drop all button in the other entity's inventory
; ClickOtherDropAll() {
;   Click inventory.otherDropAll.x, inventory.otherDropAll.y
; }

; ; Focus the search bar in the other entity's inventory
; FocusOtherSearchbar() {
;   Click inventory.otherSearchbar.x, inventory.otherSearchbar.y
; }

; ; Drops all of the player's items
; DropAllSelf() {
;   ToggleSelfInventory()
;   Sleep longWait
;   Click inventory.selfDropAll.x, inventory.selfDropAll.y
;   Sleep mediumWait
;   ToggleSelfInventory()
; }

; TransferAllToOther() {
;   Click inventory.transferAllFromSelf.x, inventory.transferAllFromSelf.y
; }

; Defecate() {
;   ControlSend Format("{1}", inventory.defecate),, arkWindowName
; }

; FlushToilet() {
;   Click inventory.flushButton.x, inventory.flushButton.y
; }

; FertilizerFarm() {
;   Defecate()
;   Sleep smallWait
;   ToggleOtherInventory()
;   Sleep mediumWait
;   FlushToilet()
;   Sleep smallWait
;   ToggleOtherInventory()
;   Sleep mediumWait
; }