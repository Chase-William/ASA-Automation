#Requires AutoHotkey v2.0

SetKeyDelay(50)

APP_ICON := "assets/images/icon.png"

#include "Config.ahk"
#include "controllers/MiddlewareController.ahk"
#include "GameUser.ahk"
#include "ui/ui.ahk"

class App {
  __New(cfg?, user?, controller?) {
    this.cfg := IsSet(cfg) ? cfg : Config(GetRequiredConfigFilePath())
    this.user := IsSet(user) ? user : GameUser(this.cfg)
    this.m_controller := IsSet(controller) ? controller : MiddlewareController(this.cfg, this.user)
    this.myGui := makeGui(this)
  }

  AppIconFilePath => this.m_appIconFilePath
  Controller => this.m_controller
}