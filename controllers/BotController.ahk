#Requires AutoHotkey v2.0

class BotController {
  __New(cfg, afk, paste) {
    this.cfg := cfg
    this.afk := afk
    this.paste := paste

    this.isBotActive := false

    this.pasteFunc := (*) => this.RunTask(this.paste.Farm.bind(this.paste))
  }

  ActivateBot() {
    this.isBotActive := true
    ; MsgBox "Bot", "Enabled"
    SetTimer(this.pasteFunc, -2000)

    WinActivate(this.cfg.process.windowTitle)
  }

  DeactivateBot() {
    this.isBotActive := false

    SetTimer(this.pasteFunc, 0)
  }

  RunTask(task) {
    this.afk.EndAFK()
    task()
    this.afk.BeginAFK()
  }
}