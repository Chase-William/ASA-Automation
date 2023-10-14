#Requires AutoHotkey v2.0

SetKeyDelay(50)

APP_ICON := "assets/images/icon.png"

#include "Config.ahk"
#include "controllers/MiddlewareController.ahk"
#include "GameUser.ahk"
#include "ui/ui.ahk"

class App {
  __New() {
    this.configFilePath := GetRequiredConfigFilePath()
    ; MsgBox configFilePath, "Asd"

    this.cfg := Config(this.configFilePath)
    this.user := GameUser(this.cfg)
    this.m_controller := MiddlewareController(this.cfg, this.user)
    this.myGui := makeGui(this)
  }

  AppIconFilePath => this.m_appIconFilePath
  Controller => this.m_controller
}