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
    this.flushToilet := CoordinateInput(myGui, "Flush Toilet", user.FlushToiletPosition)
    this.spawnSearchbar := CoordinateInput(myGui, "Spawn Search Bar", user.SpawnSearchbarPosition)
    this.spawnBtn := CoordinateInput(myGui, "Spawn Button", user.SpawnButtonPosition)
    this.meatFarmBeds := CoordinateInput(myGui, "Meat Farm Beds", user.MeatFarmSpawnPosition)

    this.spawnRegion := RegionInput(myGui, "Spawn Screen's `"Region`" text.", user.SpawnRegionTextRegion)
    
    saveSelfBtn := MyGui.AddButton("XS y+m w80","Save")
    saveSelfBtn.OnEvent("Click", this.SaveButton_OnClick.bind(this))
  }

  ; Event Handler for save button clicked
  SaveButton_OnClick(sender, info) {
    ; Save to user object which updates .ini
    user.SelfInventorySearchbarPosition := this.searchBar.GetPoint()
    user.SelfDropAllPosition := this.dropAll.GetPoint()
    user.SelfFirstSlotPosition := this.firstSlot.GetPoint()
    user.SelfTransferAllPosition := this.transferAll.GetPoint()
    user.SplitStacksPosition := this.splitStack.GetPoint()
    user.SplitAllPosition := this.splitAll.GetPoint()
    user.FlushToiletPosition := this.flushToilet.GetPoint()
    user.SpawnSearchbarPosition := this.spawnSearchbar.GetPoint()
    user.SpawnButtonPosition := this.spawnBtn.GetPoint()
    user.MeatFarmSpawnPosition := this.meatFarmBeds.GetPoint()

    user.SpawnRegionTextRegion := this.spawnRegion.GetRegion()
  }
}