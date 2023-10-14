#Requires AutoHotkey v2.0

SetKeyDelay(50)

#include "Config.ahk"
#include "controllers/MiddlewareController.ahk"
#include "GameUser.ahk"
#include "ui/ui.ahk"

class App {
  __New() {
    configFilePath := GetRequiredConfigFilePath()

    ; MsgBox configFilePath, "Asd"

    this.cfg := Config(configFilePath)
    this.user := GameUser(this.cfg)
    this.controller := MiddlewareController(this.cfg, this.user)
    this.myGui := makeGui(this.controller)
  }
}