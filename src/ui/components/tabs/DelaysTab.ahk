#Requires AutoHotkey v2.0

#include "../../../Util.ahk"

class DelaysTab {
  __New(myGui, controller) {
    this.cfg := controller.cfg

    myGui.AddText(, "All delays are in milliseconds (1 second = 1000 milliseconds)")

    myGui.AddText("Section w120", "5x Delay:")
    this._5xlwEdit := myGui.AddEdit("x+m w40", controller.cfg.delay._5xlw)

    myGui.AddText("Section XS w120", "4x Delay:")
    this._4xlwEdit := myGui.AddEdit("x+m w40", controller.cfg.delay._4xlw)

    myGui.AddText("Section XS w120", "3x Delay:")
    this._3xlwEdit := myGui.AddEdit("x+m w40", controller.cfg.delay._3xlw)

    myGui.AddText("Section XS w120", "2x Delay:")
    this._2xlwEdit := myGui.AddEdit("x+m w40", controller.cfg.delay._2xlw)

    myGui.AddText("Section XS w120", "1x Delay:")
    this.xlwEdit := myGui.AddEdit("x+m w40", controller.cfg.delay.xlw)

    myGui.AddText("Section XS w120", "Long Delay:")
    this.lwEdit := myGui.AddEdit("x+m w40", controller.cfg.delay.lw)

    myGui.AddText("Section XS w120", "Medium Delay:")
    this.mwEdit := myGui.AddEdit("x+m w40", controller.cfg.delay.mw)

    myGui.AddText("Section XS w120", "Smedium Delay:")
    this.smwEdit := myGui.AddEdit("x+m w40", controller.cfg.delay.smw)

    myGui.AddText("Section XS w120", "Small Delay:")
    this.swEdit := myGui.AddEdit("x+m w40", controller.cfg.delay.sw)

    myGui.AddText("Section XS w120", "1x Small Delay:")
    this.xswEdit := myGui.AddEdit("x+m w40", controller.cfg.delay.xsw)

    myGui.AddText("Section XS w120", "2x Small Delay:")
    this._2xswEdit := myGui.AddEdit("x+m w40", controller.cfg.delay._2xsw)

    myGui.AddText("Section XS w120", "Auto Click Delay:")
    this.autoClickIntervalEdit := myGui.AddEdit("x+m w40", controller.cfg.delay.AutoClickInterval)

    saveBtn := myGui.AddButton(, "Save")
    saveBtn.OnEvent("Click", this.OnSaveBtn_Clicked.bind(this))
  }

  OnSaveBtn_Clicked(sender, info) {
    if (IsValidNumber(this._5xlwEdit.Value)) {
      this.cfg.delay._5xlw := this._5xlwEdit.Value
    }
    if (IsValidNumber(this._4xlwEdit.Value)) {
      this.cfg.delay._4xlw := this._4xlwEdit.Value
    }
    if (IsValidNumber(this._3xlwEdit.Value)) {
      this.cfg.delay._3xlw := this._3xlwEdit.Value
    }
    if (IsValidNumber(this._2xlwEdit.Value)) {
      this.cfg.delay._2xlw := this._2xlwEdit.Value
    }
    if (IsValidNumber(this.xlwEdit.Value)) {
      this.cfg.delay.xlw := this.xlwEdit.Value
    }
    if (IsValidNumber(this.lwEdit.Value)) {
      this.cfg.delay.lw := this.lwEdit.Value
    }
    if (IsValidNumber(this.mwEdit.Value)) {
      this.cfg.delay.mw := this.mwEdit.Value
    }
    if (IsValidNumber(this.smwEdit.Value)) {
      this.cfg.delay.smw := this.smwEdit.Value
    }
    if (IsValidNumber(this.swEdit.Value)) {
      this.cfg.delay.sw := this.swEdit.Value
    }
    if (IsValidNumber(this.xswEdit.Value)) {
      this.cfg.delay.xsw := this.xswEdit.Value
    }
    if (IsValidNumber(this._2xswEdit.Value)) {
      this.cfg.delay._2xsw := this._2xswEdit.Value
    }
    if (IsValidNumber(this.autoClickIntervalEdit.Value)) {
      this.cfg.delay.AutoClickInterval := this.autoClickIntervalEdit.Value
    }
    if (IsValidNumber(this.swEdit.Value)) {
      this.cfg.delay.sw := this.swEdit.Value
    }

    Reload
  }
}