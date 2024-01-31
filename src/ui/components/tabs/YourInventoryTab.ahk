#Requires AutoHotkey v2.0

#include "../CoordinateInput.ahk"
#include "../RegionInput.ahk"

class YourInventoryTab {
  __New(myGui, controller) {
    this.controller := controller
    SelfTitle := myGui.AddText("w200", "Your Character/Inventory")
    SelfTitle.SetFont("Bold")
    myGui.AddText(, "Contains info required for interaction with your inventory.")  
    user := controller.user

    this.searchBar := CoordinateInput(myGui, "Search Bar", user.SelfInventorySearchbarPosition, false)
    this.dropAll := CoordinateInput(myGui, "Drop All", user.SelfDropAllPosition)
    this.firstSlot := CoordinateInput(myGui, "First Slot", user.SelfFirstSlotPosition)
    this.transferAll := CoordinateInput(myGui, "Transfer All", user.SelfTransferAllPosition)
    this.splitStack := CoordinateInput(myGui, "Split Stack", user.SplitStacksPosition)
    this.splitAll := CoordinateInput(myGui, "Split All", user.SplitAllPosition)
    ; this.flushToilet := CoordinateInput(myGui, "Flush Toilet", user.FlushToiletPosition)
    this.spawnSearchbar := CoordinateInput(myGui, "Spawn Search Bar", user.SpawnSearchbarPosition)
    this.spawnBtn := CoordinateInput(myGui, "Spawn Button", user.SpawnButtonPosition)
    this.spawnRegion := RegionInput(myGui, "Spawn Screen's `"Region`" text.", user.SpawnRegionTextRegion)
    
    saveSelfBtn := MyGui.AddButton("XS y+m w80","Save")
    saveSelfBtn.OnEvent("Click", this.SaveButton_OnClick.bind(this))
  }

  ; Event Handler for save button clicked
  SaveButton_OnClick(sender, info) {
    ; Save to user object which updates .ini
    this.controller.user.SelfInventorySearchbarPosition := this.searchBar.GetPoint()
    this.controller.user.SelfDropAllPosition := this.dropAll.GetPoint()
    this.controller.user.SelfFirstSlotPosition := this.firstSlot.GetPoint()
    this.controller.user.SelfTransferAllPosition := this.transferAll.GetPoint()
    this.controller.user.SplitStacksPosition := this.splitStack.GetPoint()
    this.controller.user.SplitAllPosition := this.splitAll.GetPoint()
    ; this.controller.user.FlushToiletPosition := this.flushToilet.GetPoint()
    this.controller.user.SpawnSearchbarPosition := this.spawnSearchbar.GetPoint()
    this.controller.user.SpawnButtonPosition := this.spawnBtn.GetPoint()
    this.controller.user.SpawnRegionTextRegion := this.spawnRegion.GetRegion()
  }
}