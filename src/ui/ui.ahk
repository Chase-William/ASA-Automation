#Requires AutoHotkey v2.0

#include "components/tabs/KeybindTab.ahk"
#include "components/tabs/OtherInventoryTab.ahk"
#include "components/tabs/YourInventoryTab.ahk"
#include "components/tabs/HotkeyTab.ahk"
#include "components/tabs/DelaysTab.ahk"

MAIN_WINDOW_TITLE := "Automation"

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
  autoWalkText := myOverlay.AddText("Hidden cWhite", "Auto Walk/Sprint")
;   autoBrewText := myOverlay.AddText("Hidden cWhite", "Auto Brew")
;   autoEatText := myOverlay.AddText("Hidden cWhite", "Auto Eat")
;   autoDrinkText := myOverlay.AddText("Hidden cWhite", "Auto Drink")
  controller.autoClick.OnEvent(AUTO_CLICKER_STATE_CHANGED, (sender, isOn) => autoClickerText.Visible := isOn)
  controller.autoWalk.OnEvent(AUTO_WALK_STATE_CHANGED, (sender, isOn) => autoWalkText.Visible := isOn)
;   controller.consume.OnEvent(AUTO_BREW_STATE_CHANGED, (sender, isOn) => autoBrewText.Visible := isOn)
;   controller.consume.OnEvent(AUTO_EAT_STATE_CHANGED, (sender, isOn) => autoEatText.Visible := isOn)
;   controller.consume.OnEvent(AUTO_DRINK_STATE_CHANGED, (sender, isOn) => autoDrinkText.Visible := isOn)
  
  myOverlay.Show("x5 y" centerY - height / 2 " w" width " h" height " NoActivate")  ; NoActivate avoids deactivating the currently active window.
}

makeGui(app) {
  controller := app.controller
  windowTitle := MAIN_WINDOW_TITLE
  ; TraySetIcon(APP_ICON)

  width := "w" WINDOW_WIDTH
  height := "h" WINDOW_HEIGHT
  ; Create root gui object
  myGui := Gui(, windowTitle,)
  ; myGui.BackColor := "151414"
  
  ; WinSetTransColor("FFFFFF", MyGui)
  ; MyGui.Opt("ToolWindow")
  myGui.SetFont("q5", "Verdana")

  ; Closing logic
  myGui.OnEvent("Close", (*) => ExitApp())
  myGui.OnEvent("Escape", (*) => ExitApp())

  ; Create tabs
  myTabs := myGui.AddTab3("x0 y0 " width " " height, [
    "Hotkeys",
    "In-Game Keybinds",
    "Your Invent Pos",
    "Other's Invent Pos",
    "Delays"
  ])
  ; Needed for some reason to prevent tabs for rendering vertically
  myTabs.UseTab()

  ; Setup "Fire-Forget Toggles" tab
  ; Use "Toggles Tab"
  myTabs.UseTab(1)
  HotkeyTab(myGui, controller)

  ; Setup "In-Game Keybinds" tab
  myTabs.UseTab(2)
  KeybindTab(myGui, controller)
  ; this.AddInGameKeybindsTab(myGui, myTabs)

  ; Setup "Self" tab
  ; Use "Your Inventory Positions"
  myTabs.UseTab(3)
  YourInventoryTab(myGui, controller)

  ; Setup "Other" tab
  ; Use "Other's Inventory Positions" tab
  myTabs.UseTab(4)
  OtherInventoryTab(myGui, controller)

  myTabs.UseTab(5)
  DelaysTab(myGui, controller)

  ; Present content
  myGui.Show(width " " height)

  makeOverlay(controller)

  return myGui
}