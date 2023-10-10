#Requires AutoHotkey v2.0

class BotController {
  __New(cfg, afk, paste) {
    this.cfg := cfg
    this.afk := afk
    this.paste := paste

    this.m_isBotOn := false

    this.pasteFunc := (*) => this.RunTask(this.paste.Farm.bind(this.paste))
  }

  IsBotOn {
    get => this.m_isBotOn
    set => this.m_isBotOn := value
  }

  ActivateBot() {
    this.IsBotOn := true
    ; MsgBox "Bot", "Enabled"
    SetTimer(this.pasteFunc, -2000)

    WinActivate(this.cfg.process.windowTitle)
  }

  DeactivateBot() {
    this.IsBotOn := false

    SetTimer(this.pasteFunc, 0)
  }

  RunTask(task) {
    this.afk.EndAFK()
    task()
    this.afk.BeginAFK()
  }
}