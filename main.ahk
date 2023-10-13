#requires AutoHotkey v2.0

#include "LilxDHotkey.ahk"
#include "controllers/MiddlewareController.ahk"
#include "GameUser.ahk"
#include "ui/ui.ahk"

SetKeyDelay(50)

; Get configs
cfg := Config()

; Get user object
user := GameUser(
  cfg
)

; Create the hotkey controller
controller := MiddlewareController(
  cfg,
  user
)

; Create the user interface that uses the controller
makeGui(controller)