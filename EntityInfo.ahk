class EntityInfo {
  __New(
    ctx,
    toggleInventoryKey,
    searchbarPos,
    dropAllPos,
    transferAllPos
  ) {
    this.ctx := ctx
    this.toggleInventoryKey := toggleInventoryKey
    this.searchbarPos := searchbarPos
    this.dropAllPos := dropAllPos
    this.transferAllPos := transferAllPos
  }  

  ; Toggles the inventory open or close.
  ToggleInventory() {
    ControlSend Format("{1}", this.toggleInventoryKey),, this.ctx.arkWindowName
  }

  ; Focuses the searchbarPos; commonly used before text entry.
  FocusSearchbar() {
    Click this.searchbarPos.x, this.searchbarPos.y
  }

  ; Clicks the "Transfers All" button.
  TransferAll() {
    Click this.transferAllPos.x, this.transferAllPos.y
  }

  ; Clicks the "Drop All" button.
  DropAll() {
    Click this.dropAllPos.x, this.dropAllPos.y
  }

  ; Automatically focuses the searchbarPos, queries and performs a take all.
  SearchAndTakeAll(text) {
    this.FocusSearchbar()
    Sleep this.ctx.longWait
    ControlSendText text,, this.ctx.arkWindowName
    Sleep this.ctx.longWait
    this.TransferAll()
  }  

  ; Automatically focues the searchbarPos, queries and performs a drop all.
  SearchAndDropAll(text) {
    this.FocusSearchbar()
    Sleep this.ctx.mediumWait
    ControlSendText text,, this.ctx.arkWindowName
    Sleep this.ctx.mediumWait
    this.DropAll()
  }
}