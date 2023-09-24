#Include "EntityInfo.ahk"

class SelfInfo extends EntityInfo {
  __New(
  ctx,
  toggleInventoryKey,
  defecateKey,
  searchbarPos,
  dropAllPos,
  firstSlotPos,
  splitStackPos,
  splitAllPos,
  transferAllPos,
  flushPos,
  respawnSearchbarPos,
  respawnButtonPos,
  regionTextBoundingBox,
  meatFarmBedPos
  ) {
    super.__New(
    ctx,
    toggleInventoryKey,
    searchbarPos,
    dropAllPos,
    transferAllPos
    )
    ; this.toggleInventoryKey := toggleInventoryKey
    ; this.searchbarPos := searchbarPos
    ; this.dropAllPos := dropAllPos
    this.defecateKey := defecateKey
    this.firstSlotPos := firstSlotPos
    this.splitStackPos := splitStackPos
    this.splitAllPos := splitAllPos
    ; this.transferAllPos := transferAllPos
    this.flushPos := flushPos
    this.respawnSearchbarPos := respawnSearchbarPos
    this.respawnButtonPos := respawnButtonPos
    this.regionTextBoundingBox := regionTextBoundingBox
    this.meatFarmBedPos := meatFarmBedPos
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
    Sleep this.ctx.smediumWait
    ; Enter bed name
    ControlSendText text,, this.ctx.arkWindowName
  }

  ; Returns a boolean indicating if the respawn screen is available for interaction.
  IsRespawnScreenAvailable() {
    px := 0
    py := 0
    ; Search the area of the word "Region" of the "Spawn Region" message 
    ; for a color match
    return PixelSearch(
    &px, &py, 
    this.regionTextBoundingBox.left,
    this.regionTextBoundingBox.top,
    this.regionTextBoundingBox.right,
    this.regionTextBoundingBox.bottom, 
    this.ctx.regionTextColorWhenDead, 
    2 ; variance of color permitted
    )
  }

  ; Selects the pre-determined self meat farm beds.
  SelectMeatFarmBeds() {
    Click this.meatFarmBedPos.x, this.meatFarmBedPos.y
  }

  ; Flushes the toilet.
  FlushToilet() {
    Click this.flushPos.x, this.flushPos.y
  }

  ; Triggers character defecation.
  Defecate() {
    ControlSend Format("{1}", this.defecateKey),, this.ctx.arkWindowName
  }

  ; Focuses the searchbar, queries for a specific bed name, searches the screen's pixels
  ; to find the beds, lastly focuses the found beds.
  ; SearchBedsAndAutoSelect(text) {
  ;   this.SearchBeds(text)
  ;   Sleep this.ctx.smediumWait
  ;   windowWidth := 0
  ;   windowHeight := 0
  ;   ; Get dimensions of the window
  ;   WinGetPos ,, &windowWidth, &windowHeight, this.ctx.arkWindowName

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

  ;   ; if (!PixelSearch(&x, &y, 100, 100, windowWidth - widthPadding, windowHeight - heightPadding, this.ctx.bedSearchColor, 0)) {
  ;   ;   MsgBox "Was unable to located a bed for selection.", "Error"
  ;   ; }
  ;   ; Select bed
  ;   Click x, y
  ; }

  ; SearchBedsAndSelectAtDeathMarker() {
  ;    this.SearchBeds(text)
  ;   Sleep this.ctx.smediumWait
  ;   windowWidth := 0
  ;   windowHeight := 0
  ;   ; Get dimensions of the window
  ;   WinGetPos ,, &windowWidth, &windowHeight, this.ctx.arkWindowName

  ;   ; Scan for pixel color of available beds with query active
  ;   x := 0
  ;   y := 0
  ;   ; Search the entire window for bed color
  ;   ; Added a little padding because beds should be more in the center of the screen *(optimization)
  ;   widthPadding := (windowWidth / 5)
  ;   heightPadding := (windowWidth / 5)
  ; }
}