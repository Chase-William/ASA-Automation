#Requires AutoHotkey v2.0

#include "../structures/Observable.ahk"

CROSSHAIR_SIZE_CONFIG_KEY := "size"
CROSSHAIR_BACK_COLOR_CONFIG_KEY := "backColor"
CROSSHAIR_ENABLED_CONFIG_KEY := "enabled"
CROSSHAIR_FILE_PATH_CONFIG_KEY := "crosshairFilePath"

CROSSHAIR_SIZE_FIELD_NAME := "m_size"
CROSSHAIR_BACK_COLOR_FIELD_NAME := "m_backColor"
CROSSHAIR_ENABLED_FIELD_NAME := "m_enabled"
CROSSHAIR_FILE_PATH_FIELD_NAME := "m_crosshairFilePath"

CROSSHAIR_VISIBILITY_CHANGED := "CrosshairVisibilityChanged"

class CustomCrosshairController extends Observable {
  __New() {
    this.base.base.__New() 
    ; windowWidth := 100
    ; windowHeight := 100

    ; crosshairWidth := 25
    ; crosshairHeight := 25

    this.m_isSettingsVisible := false

    this.m_guiCrosshairWindow := this.CreateNewCrosshairWindow()

    this.m_settingGuiWindow := Gui(,"Options")
    this.m_settingGuiWindow.SetFont("q5", "Verdana")
    changeCrosshairBtn := this.m_settingGuiWindow.AddButton("Section", "Change Crosshair")
    changeCrosshairBtn.OnEvent("Click", this.OnChangeCrosshairBtn_Clicked.bind(this))
    this.m_settingGuiWindow.AddText("Section XS", "Size")
    this.sizeSlider := this.m_settingGuiWindow.AddSlider("x+m", this.Size)    
    setSizeBtn := this.m_settingGuiWindow.AddButton("x+m", "Set")
    setSizeBtn.OnEvent("Click", this.OnSizeSetBtn_Clicked.bind(this))

    this.m_settingGuiWindow.AddText("Section XS", "Backing Color")
    this.colorEdit := this.m_settingGuiWindow.AddEdit("w64 x+m", this.BackColor)
    setColorBtn := this.m_settingGuiWindow.AddButton("x+m", "Set")
    setColorBtn.OnEvent("Click", this.OnColorSetBtn_Clicked.bind(this))

    if (this.IsVisible) {
      this.Show()
    }
  }

  Size {
    get => Config.GetMember(this, Config.GetCrosshair, CROSSHAIR_SIZE_FIELD_NAME, CROSSHAIR_SIZE_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetCrosshair, CROSSHAIR_SIZE_FIELD_NAME, CROSSHAIR_SIZE_CONFIG_KEY, value)
  }

  BackColor {
    get => Config.GetMember(this, Config.GetCrosshair, CROSSHAIR_BACK_COLOR_FIELD_NAME, CROSSHAIR_BACK_COLOR_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetCrosshair, CROSSHAIR_BACK_COLOR_FIELD_NAME, CROSSHAIR_BACK_COLOR_CONFIG_KEY, value)
  }

  BitmapOptions => "x0 y0 w" this.Size " h" this.Size

  CrosshairGuiOptions => "x" (A_ScreenWidth - this.Size) / 2 " y" (A_ScreenHeight - this.Size) / 2 " w" this.Size " h" this.Size " NoActivate"

  IsVisible {
    get => Config.GetMember(this, Config.GetCrosshair, CROSSHAIR_ENABLED_FIELD_NAME, CROSSHAIR_ENABLED_CONFIG_KEY)
    set {
      Config.SetMember(this, Config.SetCrosshair, CROSSHAIR_ENABLED_FIELD_NAME, CROSSHAIR_ENABLED_CONFIG_KEY, value)
      this.StateChanged.Invoke(CROSSHAIR_VISIBILITY_CHANGED, value)
    }
  }

  IsSettingsVisible {
    get => this.m_isSettingsVisible
    set => this.m_isSettingsVisible := value
  }

  CrosshairFilePath {
    get => Config.GetMember(this, Config.GetCrosshair, CROSSHAIR_FILE_PATH_FIELD_NAME, CROSSHAIR_FILE_PATH_CONFIG_KEY)
    set => Config.SetMember(this, Config.SetCrosshair, CROSSHAIR_FILE_PATH_FIELD_NAME, CROSSHAIR_FILE_PATH_CONFIG_KEY, value)
  }

  CrosshairWindow {
    get => this.m_guiCrosshairWindow
    set {
      ; Delete old window
      this.CrosshairWindow.Destroy()
      this.m_guiCrosshairWindow := value
    }
  }

  Show() {
    if (!this.IsVisible) {
      ; Prevent assignments when loaded value is already true
      this.IsVisible := true
    }
    this.CrosshairWindow.Show(this.CrosshairGuiOptions)
  }

  Hide() {
    this.CrosshairWindow.Hide()
    this.IsVisible := false    
  }

  ShowSettings() {
    this.m_isSettingsVisible := true
    this.m_settingGuiWindow.Show("w220 h110")
  }

  HideSettings() {
    if (this.m_isSettingsVisible := false) {
      this.m_settingGuiWindow.Hide()
      this.m_isSettingsVisible := false
    }
  }

  CreateNewCrosshairWindow() {
    window := Gui()
    window.Opt("+AlwaysOnTop -Caption +ToolWindow")  ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
    window.BackColor := this.BackColor  ; Can be any RGB color (it will be made transparent below).
    window.SetFont("q5 s12 w100", "Verdana")  ; Set a large font size (32-point).

    WinSetTransColor(window.BackColor " 150", window)

    window.AddPicture(this.BitmapOptions, this.CrosshairFilePath)

    return window
  }

  OnChangeCrosshairBtn_Clicked(sender, info) {
    filePath := FileSelect()
    if (this.CrosshairFilePath != filePath) {
      this.CrosshairFilePath := filePath
      this.CrosshairWindow := this.CreateNewCrosshairWindow()
      this.Show()
    }
  }

  OnSizeSetBtn_Clicked(sender, info) {
    if (this.sizeSlider.Value != this.Size) {
      this.Size := this.sizeSlider.Value
      this.CrosshairWindow := this.CreateNewCrosshairWindow()
      this.Show()
    }
  }

  OnColorSetBtn_Clicked(sender, info) {
    if (this.BackColor := this.colorEdit.Value) {
      this.BackColor := this.colorEdit.Value
      this.CrosshairWindow := this.CreateNewCrosshairWindow()
      this.Show()
    }
  }
}