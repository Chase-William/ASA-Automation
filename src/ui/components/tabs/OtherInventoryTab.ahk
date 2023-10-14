#Requires AutoHotkey v2.0

class OtherInventoryTab {
  __New(myGui, controller) {
    this.controller := controller
    otherTitle := myGui.AddText("w200 XS y+20", "Other's Inventory")
    otherTitle.SetFont("Bold")
    myGui.AddText(, "Contains info required for interaction with other entity's inventory.")
    user := controller.user

    this.searchbar := CoordinateInput(myGui, "Search Bar", user.OtherInventorySearchbarPosition, false)
    this.dropAll := CoordinateInput(myGui, "Drop All", user.OtherDropAllPosition)
    this.transferAll := CoordinateInput(myGui, "Transfer All", user.OtherTransferAllPosition)

    saveOtherBtn := MyGui.AddButton("XS y+m w80","Save")
    saveOtherBtn.OnEvent("Click", this.SaveButton_OnClick.bind(this))
  }

  SaveButton_OnClick(sender, info) {
    this.controller.user.OtherInventorySearchbarPosition := this.searchbar.GetPoint()
    this.controller.user.OtherDropAllPosition := this.dropAll.GetPoint()
    this.controller.user.OtherTransferAllPosition := this.transferAll.GetPoint()    
  }
}