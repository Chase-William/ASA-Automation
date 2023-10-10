#Requires AutoHotkey v2.0

#include "components/tabs/KeybindTab.ahk"
#include "components/tabs/OtherInventoryTab.ahk"
#include "components/tabs/YourInventoryTab.ahk"
#include "components/tabs/HotkeyTab.ahk"

LIL_XD_HELPER_TOOL_WINDOW_TITLE := "Lil xD's Helping Tools"

WINDOW_WIDTH := 575
WINDOW_HEIGHT := 450
DEFAULT_MARGIN := 25

makeOverlay(controller) {

  centerY := A_ScreenHeight / 2

  width := 200
  height := 200

  myOverlay := Gui()
  
  myOverlay.Opt("+AlwaysOnTop -Caption +ToolWindow")  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
  myOverlay.BackColor := "000000"  ; Can be any RGB color (it will be made transparent below).
  myOverlay.SetFont("q5 s12 w100", "Verdana")  ; Set a large font size (32-point).
  ; CoordText := myOverlay.Add("Text", "cRed", "XXXXX YYYYY")  ; XX & YY serve to auto-size the window.
  ; Make all pixels of this color transparent and make the text itself translucent (150):
  WinSetTransColor(myOverlay.BackColor " 150", myOverlay)
  ; myOverlay.AddText(, isOn ? "On" : "Off")
  autoClickerText := myOverlay.AddText("Hidden cWhite", "Auto Clicker")
  autoBrewText := myOverlay.AddText("Hidden cWhite", "Auto Brew")
  autoEatText := myOverlay.AddText("Hidden cWhite", "Auto Eat")
  autoDrinkText := myOverlay.AddText("Hidden cWhite", "Auto Drink")
  controller.autoClick.OnEvent(AUTO_CLICKER_STATE_CHANGED, (sender, isOn) => autoClickerText.Visible := isOn)
  controller.consume.OnEvent(AUTO_BREW_STATE_CHANGED, (sender, isOn) => autoBrewText.Visible := isOn)
  controller.consume.OnEvent(AUTO_EAT_STATE_CHANGED, (sender, isOn) => autoEatText.Visible := isOn)
  controller.consume.OnEvent(AUTO_DRINK_STATE_CHANGED, (sender, isOn) => autoDrinkText.Visible := isOn)
  
  ; SetTimer(UpdateOSD, 200)
  ; UpdateOSD()  ; Make the first update immediate rather than waiting for the timer.
  myOverlay.Show("x5 y" centerY - height / 2 " w" width " h" height " NoActivate")  ; NoActivate avoids deactivating the currently active window.

  ; Must move after Show()
  ; myOverlay.Move(5, centerY - height / 2, width, height)
  ; UpdateOSD(*)
  ; {
  ;   MouseGetPos &MouseX, &MouseY
  ;   CoordText.Value := "X" MouseX ", Y" MouseY
  ; }
}

makeGui(controller) {
  windowTitle := LIL_XD_HELPER_TOOL_WINDOW_TITLE

  width := "w" WINDOW_WIDTH
  height := "h" WINDOW_HEIGHT
  ; Create root gui object
  myGui := Gui(, windowTitle,)
  ; MyGui.BackColor := "313338"
  
  ; WinSetTransColor("FFFFFF", MyGui)
  ; MyGui.Opt("ToolWindow")
  MyGui.SetFont("q5", "Verdana")

  ; Closing logic
  myGui.OnEvent("Close", (*) => ExitApp())
  myGui.OnEvent("Escape", (*) => ExitApp())

  ; Create tabs
  myTabs := myGui.AddTab3("x0 y0 " width " " height, [
    "Hotkeys",
    "In-Game Keybinds",
    "Your Invent Pos",
    "Other's Invent Pos"
  ])
  ; Needed for some reason to prevent tabs for rendering vertically
  myTabs.UseTab()

  ; Setup "Fire-Forget Toggles" tab
  ; Use "Toggles Tab"
  myTabs.UseTab(1)
  HotkeyTab(myGui, controller)
  ; Setup "Active Toggles" tab
  ; this.AddToggleTools(myGui, myTabs)
  ; Setup "In-Game Keybinds" tab
  myTabs.UseTab(2)
  KeybindTab(myGui, controller)
  ; this.AddInGameKeybindsTab(myGui, myTabs)

  ; Setup "Self" tab
  ; Use "Your Inventory Positions"
  myTabs.UseTab(3)
  YourInventoryTab(myGui, controller)
  ; this.AddYourInventoryTab(myGui, myTabs)

  ; Setup "Other" tab
  ; Use "Other's Inventory Positions" tab
  myTabs.UseTab(4)
  OtherInventoryTab(myGui, controller)

  ; Present content
  myGui.Show(width " " height)

  makeOverlay(controller)
}
  ; AddToolsTab(myGui, myTabs) {
  ;   ; Use "Toggles Tab"
  ;   myTabs.UseTab(1)

  ; }

  ; AddInGameKeybindsTab(myGui, myTabs) {
  ;   ; Use "In-Game Keybinds" tab
  ;   myTabs.UseTab(2)

  ;   myGui.AddText("w200 Section", "Toggle Inventory")
  ;   myGui.AddHotkey("x+m")
  ;   myGui.AddText("w200 XS Section", "Defecate")
  ;   myGui.AddHotkey("x+m")

  ;   saveBtn := myGui.AddButton("XS y+m w80", "Save")
  ;   saveBtn.OnEvent("Click", this.SaveKeybindsBtn_OnClick.bind(this))
  ; }

  ; AddYourInventoryTab(myGui, myTabs) {
  ;   ; Use "Your Inventory Positions"
  ;   myTabs.UseTab(3)


  ; }

  ; AddOtherInventoryTab(myGui, myTabs) {
  ;   ; Use "Other's Inventory Positions" tab
  ;   myTabs.UseTab(4)

  ;   otherTitle := myGui.AddText("w200 XS y+20", "Other's Inventory")
  ;   otherTitle.SetFont("Bold")
  ;   myGui.AddText(, "Contains info required for interaction with other entity's inventory.")

  ;   CoordinateInput(myGui, "Search Bar", controller.user.OtherInventorySearchbarPosition, false)
  ;   CoordinateInput(myGui, "Drop All", controller.user.OtherDropAllPosition)
  ;   CoordinateInput(myGui, "Transfer All", controller.user.OtherTransferAllPosition)

  ;   saveOtherBtn := MyGui.AddButton("XS y+m w80","Save")
  ;   saveOtherBtn.OnEvent("Click", this.SaveButton_OnClick.bind(this))
  ; }

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
; }