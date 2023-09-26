#Requires AutoHotkey v2.0

; Represents a row like control containing a given title with: x,y entries.
class CoordinateInput {
  ; MyGui - Root Gui object
  ; title - Meaning of the x,y coordinate position
  ; position - Vector2 position
  ; XS - Aligning to the last X position of a saved "Section" enabled by default
  __New(myGui, title, position, XS := true) {
    myGui.AddText((XS ? "XS " : "") "Section w200", title)
    myGui.AddText("x+m", "x:")
    editX := myGui.AddEdit("x+5 w50",)
    editX.Value := position.x
    myGui.AddText("x+m", "y:")
    editY := myGui.AddEdit("x+5 w50",)
    editY.Value := position.y
  }
}

; Represents a 2 row'd control containing a given title with: left,top,right,bottom entries.
class RectInput {
  ; MyGui - Root Gui object
  ; title - Meaning of the x,y coordinate position
  ; rect - Bounding box object: { left, top, right, bottom }
  ; XS - Aligning to the last X position of a saved "Section" enabled by default
  __New(myGui, title, rect, XS := true) {
    myGui.AddText((XS ? "XS " : "") "Section", title)

    myGui.AddText("XS", "left:")
    editLeft := myGui.AddEdit("x+m w50",)
    editLeft.Value := rect.left

    myGui.AddText("x+m", "top:")
    editTop := myGui.AddEdit("x+m w50",)
    editTop.Value := rect.top

    myGui.AddText("x+m", "right:")
    editRight := myGui.AddEdit("x+m w50",)
    editRight.Value := rect.right

    myGui.AddText("x+m", "bottom:")
    editBottom := myGui.AddEdit("x+m w50",)
    editBottom.Value := rect.bottom
  }
}


class ToolControl {
  __New(myGui, title, allowCheckbox := false, XS := true) {
    ;sameLine := (XS ? "XS" : "")

    if (allowCheckbox) {
      myGui.AddCheckbox("w200 " (XS ? "XS " : "") "Section", title)      
    } else {
      myGui.AddText("w200 " (XS ? "XS " : "") "Section", title)
      myGui.AddHotkey("x+m")
      myGui.AddButton("x+m w80", "Set")
    }     
  }
}

class UI {
  __New(controller) {
    this.controller := controller
    this.windowTitle := "Lil xD's Helping Tools"

    width := "w500"
    height := "h450"    
    ; Create root gui object
    myGui := Gui(, this.windowTitle,)
    ; Create tabs 
    myTabs := myGui.AddTab3("x0 y0 " width " " height, [
      "Tools",
      "In-Game Keybinds", 
      "Your Inventory Positions", 
      "Other's Inventory Positions"
    ])
    ; Needed for some reason to prevent tabs for rendering vertically
    myTabs.UseTab()   

    ; Setup "Fire-Forget Toggles" tab
    this.AddToolsTab(myGui, myTabs)
    ; Setup "Active Toggles" tab
    ; this.AddToggleTools(myGui, myTabs)
    ; Setup "In-Game Keybinds" tab
    this.AddInGameKeybindsTab(myGui, myTabs)
    ; Setup "Self" tab
    this.AddYourInventoryTab(myGui, myTabs)
    ; Setup "Other" tab
    this.AddOtherInventoryTab(myGui, myTabs)

    ; Present content
    myGui.Show(width " " height)
  }

  AddToolsTab(myGui, myTabs) {
    ; Use "Toggles Tab"
    myTabs.UseTab(1)

    title := myGui.AddText("w200 Section", "Tool Control Panel")
    title.SetFont("Bold")

    ; myGui.AddText(, "Drop Metal Farm Junk")
    ; myGui.AddHotkey("x+m")

    ; myGui.AddText("Section w200", "Auto Clicker: ")
    ; autoClickHotkey := myGui.AddHotkey("x+m")

    ; myGui.AddText("Section XS w200", "Auto Metal Farmer:")
    ; autoMetalFarmHotkey := myGui.AddHotkey("x+m")
    
    ToolControl(myGui, "Auto Clicker:",,)
    ToolControl(myGui, "Drop Metal Farm Junk:",,)
    ToolControl(myGui, "Auto Metal Farmer:",,)
    ToolControl(myGui, "Auto Self Meat Farm", true,)
  }

  AddInGameKeybindsTab(myGui, myTabs) {
    ; Use "In-Game Keybinds" tab
    myTabs.UseTab(2)    

    myGui.AddText("w200 Section", "Toggle Inventory")
    myGui.AddHotkey("x+m")
    myGui.AddText("w200 XS Section", "Defecate")
    myGui.AddHotkey("x+m")

    myGui.AddButton("XS y+m w80", "Save")
  }

  AddYourInventoryTab(myGui, myTabs) {
    ; Use "Your Inventory Positions"
    myTabs.UseTab(3)

    selfTitle := myGui.AddText("w200", "Your Character/Inventory")
    selfTitle.SetFont("Bold")
    myGui.AddText(, "Contains info required for interaction with your inventory.")

    CoordinateInput(myGui, "Search Bar", controller.self.searchbarPos, false)
    CoordinateInput(myGui, "Drop All", controller.self.dropAllPos)
    CoordinateInput(myGui, "First Slot", controller.self.firstSlotPos)
    CoordinateInput(myGui, "Transfer All", controller.self.transferAllPos)
    CoordinateInput(myGui, "Split Stack", controller.self.splitStackPos)
    CoordinateInput(myGui, "Split All", controller.self.splitAllPos)
    CoordinateInput(myGui, "Flush Toilet", controller.self.flushPos)
    CoordinateInput(myGui, "Respawn Search Bar", controller.self.transferAllPos)
    CoordinateInput(myGui, "Respawn Button", controller.self.transferAllPos)
    CoordinateInput(myGui, "Meat Farm Beds", controller.self.meatFarmBedPos)

    RectInput(myGui, "Spawn Screen's `"Region`" text.", controller.self.regionTextBoundingBox)
    saveSelfBtn := MyGui.AddButton("XS y+m w80","Save")
    saveSelfBtn.OnEvent("Click", this.SaveButton_OnClick.bind(this))
  }

  AddOtherInventoryTab(myGui, myTabs) {
    ; Use "Other's Inventory Positions" tab
    myTabs.UseTab(4)
    
    otherTitle := myGui.AddText("w200 XS y+20", "Other's Inventory")
    otherTitle.SetFont("Bold")
    myGui.AddText(, "Contains info required for interaction with other entity's inventory.")

    CoordinateInput(myGui, "Search Bar", controller.other.searchbarPos, false)
    CoordinateInput(myGui, "Drop All", controller.other.dropAllPos)
    CoordinateInput(myGui, "Transfer All", controller.other.transferAllPos)

    saveOtherBtn := MyGui.AddButton("XS y+m w80","Save")
    saveOtherBtn.OnEvent("Click", this.SaveButton_OnClick.bind(this))
  }

  ; Event Handler for save button clicked
  SaveButton_OnClick(sender, info) {
    ; Save to file
  }

  ; AutoClickCheckBox_OnChecked(sender, info) {
  ;   ; Determine if checked or not
  ;   if (sender.Value) {
  ;     ; When enabling through check box, set window to always be ontop to protect user
  ;     WinSetAlwaysOnTop True, this.windowTitle
  ;     controller.AutoClick()

  ;     ; MsgBox "Checked", "Checked"
  ;   } else {
  ;     WinSetAlwaysOnTop False, this.windowTitle
  ;     controller.AutoClick()

  ;     ; MsgBox "Not Checked", "Not Checked"
  ;   }
  ; }
}