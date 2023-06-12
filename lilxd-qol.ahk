#z::Run "https://www.autohotkey.com" ; Win+Z

arkWindowName := "ARK: Survival Evolved"
arkProcessName := "ShooterGame.exe"
; Used as lag compensation
longWait := 750
mediumWait := 500
smallWait := 200
autoClickInterval := 1000 ; milliseconds

stoneStr := "Stone"
flintStr := "flint"
berries := "rr"

searchRawMeat := "Raw"

; State for inventory UI positions
inventory := {}
inventory.toggle := "F"
inventory.selfSearchbar := {
  x: 190,
  y: 240
}
inventory.selfFirstSlot := {
  x: 222,
  y: 364
}
inventory.selfSplitStack := {
  x: 236,
  y: 620
}
inventory.selfSplitAll := {
  x: 358,
  y: 700
}
inventory.otherSearchbar := {
  x: 1686,
  y: 242
}
inventory.otherDropAll := {
  x: 1960,
  y: 250
}
inventory.otherTakeAll := {
  x: 1900,
  y: 245
}

IsAutoClicking := false

;
; HOT KEYS
;

F9:: { ; F9 - handle metal run item build-up
  HandleMetalRunItems()
}

F10:: { ; F10 - split raw meat
  SplitRawMeat()
}

~capslock:: {
  if getkeystate("capslock", "T") 
    SetTimer(AutoClick, autoClickInterval)
  else
    SetTimer(AutoClick, 0)
}

; Does not open or close inventory
SplitRawMeat() {
  if PID := ProcessExist(arkProcessName) {
    ClearSearchbar()
    Sleep longWait
    ControlSend "{Backspace}",, arkWindowName
    Sleep mediumWait
    ControlSendText searchRawMeat,, arkWindowName
    Sleep mediumWait
    Click "Right", inventory.selfFirstSlot.x, inventory.selfFirstSlot.y
    Sleep mediumWait
    Click inventory.selfSplitStack.x, inventory.selfSplitStack.y
    Sleep mediumWait
    Click inventory.selfSplitAll.x, inventory.selfSplitAll.y
  }
}

AutoClick() {
  ; Determines how many clicks must pass before
  ; automatic dropping of unwanted items occurs
  static
  static clickThreshold := 5
  static clicks := 0

  ; Drop unwanted items
  if (clicks == clickThreshold) {
    HandleMetalRunItems()
    Sleep mediumWait
    clicks := 0 ; reset
  }
  Click 
  clicks := clicks + 1
}

; Opens the invent and takes flint while dropping stone * berries
HandleMetalRunItems() {
  ToggleInventory() ; open invent
  Sleep longWait
  ; Filter and drop
  TakeAllOtherSearchedItems(flintStr)
  Sleep mediumWait
  ; Filter and drop
  DropAllOtherSearchedItems(berries)
  Sleep smallWait
  DropAllOtherSearchedItems(stoneStr) 
  Sleep smallWait
  ToggleInventory()
}

; Focuses the searchbar and selects the filter word and deletes it
ClearSearchbar() {
  FocusOtherSearchbar()
  Sleep longWait
  ; Clear previous text so this is spammable
  Click ,,2
  ; SendMessage 0xB1,,,, arkWindowName
  Sleep smallWait
  ControlSend "{Backspace}",, arkWindowName
}

; Focuses the other's searchbar, filters items, takes filter result
TakeAllOtherSearchedItems(text) {
  FocusOtherSearchbar()
  Sleep longWait
  ControlSendText text,, arkWindowName
  Sleep longWait
  TakeFromOther()
}

; Focus and filter the searchbar and drop results
DropAllOtherSearchedItems(text) {
  FocusOtherSearchbar()
  Sleep mediumWait
  ControlSendText text,, arkWindowName
  Sleep mediumWait
  ClickOtherDropAll()
}

; Opens or Closes the inventory, aka toggle
ToggleInventory() {
  ControlSend Format("{1}", inventory.toggle),, arkWindowName
}

; Click the take all button in the other items inventory
TakeFromOther() {
  Click inventory.otherTakeAll.x, inventory.otherTakeAll.y
}

; Click the drop all button in the other entity's inventory
ClickOtherDropAll() {
  Click inventory.otherDropAll.x, inventory.otherDropAll.y
}

; Focus the search bar in the other entity's inventory
FocusOtherSearchbar() {
  Click inventory.otherSearchbar.x, inventory.otherSearchbar.y
}