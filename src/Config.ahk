#Requires AutoHotkey v2.0

#include "structures/Point.ahk"
#include "structures/Region.ahk"

PROCESS_SECTION := "process"
DELAY_SECTION := "delay"
FILTER_SECTION := "filter"
POSITION_SECTION := "position"
KEYBIND_SECTION := "keybind"
HOTKEY_SECTION := "hotkey"
COLOR_SECTION := "color"
REGION_SECTION := "region"
TOGGLE_SECTION := "toggle"
RANDOM_SECTION := "random"
CROSSHAIR_SECTION := "crosshair"

PROCESS_NAME_CONFIG_KEY := "procName"
WINDOW_TITLE_CONFIG_KEY := "windowTitle"

_5XLW_CONFIG_KEY := "5xlw"
_4XLW_CONFIG_KEY := "4xlw"
_3XLW_CONFIG_KEY := "3xlw"
_2XLW_CONFIG_KEY := "2xlw"
XLW_CONFIG_KEY := "xlw"
LW_CONFIG_KEY := "lw"
MW_CONFIG_KEY := "mw"
SMW_CONFIG_KEY := "smw"
SW_CONFIG_KEY := "sw"
XSW_CONFIG_KEY := "xsw"
_2XSW_CONFIG_KEY := "2xsw"

AUTO_CLICK_INTERVAL_CONFIG_KEY := "autoClickInterval"

STONE_STR_CONFIG_KEY := "stone"
FLINT_STR_CONFIG_KEY := "flint"
BERRY_STR_CONFIG_KEY := "berry"
RAW_MEAT_STR_CONFIG_KEY := "rawMeat"
GIVE_ALL_STR_CONFIG_KEY := "giveAll"
TAKE_ALL_STR_CONFIG_KEY := "takeAll"
SELF_DROP_ALL_STR_CONFIG_KEY := "selfDropAll"
OTHER_DROP_ALL_STR_CONFIG_KEY := "otherDropAll"

GIVE_ALL_STR_FIELD_NAME := "m_giveAll"
TAKE_ALL_STR_FIELD_NAME := "m_takeAll"
SELF_DROP_ALL_STR_FIELD_NAME := "m_selfDropAll"
OTHER_DROP_ALL_STR_FIELD_NAME := "m_otherDropAll"

SPAWN_SCREEN_BED_CONFIG_KEY := "spawnScreenBedColor"
STANDARD_UI_TEXT_COLOR_CONFIG_KEY := "standardUITextColor"

; Gets the config needed for the current user's display size
; Return, valid filePath or empty string as user display size not supported
GetRequiredConfigFilePath() {
  options := Array()
  Loop Files "*.ini", "R" {
    ; Do not include the config.ini in the root directory
    if (StrLen(A_LoopFileDir) > 0) {
      sizeArray := StrSplit(StrSplit(A_LoopFileDir, "\")[2], "x")
      if (sizeArray[1] == A_ScreenWidth && sizeArray[2] == A_ScreenHeight) {
        return A_LoopFilePath
      }
    }
  }

  return ""
}

class Config {
  __New(configFilePath, delay?, filter?, process?, color?) {
    Config.m_configFilePath := configFilePath
    this.delay := IsSet(delay) ? delay : Config.Delay()
    this.filter := IsSet(filter) ? filter : Config.Filter()
    this.process := IsSet(process) ? process : Config.Process()
    this.color := IsSet(color) ? color : Config.Color()
  }

  static m_configFilePath := ""

  static ConfigFilePath {
    get => this.m_configFilePath
    set => this.m_configFilePath := value
  }

  class Color {
    SpawnScreenBedColor {
      get {
        if (!IsSet(m_spawnScreenBedColor)) {
          this.m_spawnScreenBedColor := Config.GetColor(SPAWN_SCREEN_BED_CONFIG_KEY)
        }
        return this.m_spawnScreenBedColor
      }
      set {      
        Config.SetColor(SPAWN_SCREEN_BED_CONFIG_KEY, value)
        this.m_spawnScreenBedColor := value
      }
    }

    StandardUITextColor {
      get {
        if (!IsSet(m_standardUITextColor)) {
          this.m_standardUITextColor := Config.GetColor(STANDARD_UI_TEXT_COLOR_CONFIG_KEY)
        }
        return this.m_standardUITextColor
      }
      set {      
        Config.SetColor(STANDARD_UI_TEXT_COLOR_CONFIG_KEY, value)
        this.m_standardUITextColor := value
      }
    }
  }

  class Process {
    ProcessName {
      get {
        if (!IsSet(m_procName)) {
          this.m_procName := Config.GetProcess(PROCESS_NAME_CONFIG_KEY)
        }
        return this.m_procName
      }
      set {      
        Config.SetProcess(PROCESS_NAME_CONFIG_KEY, value)
        this.m_procName := value
      }
    }
  
    WindowTitle {
      get {
        if (!IsSet(m_windowTitle)) {
          this.m_windowTitle := Config.GetProcess(WINDOW_TITLE_CONFIG_KEY)
        }
        return this.m_windowTitle
      }
      set {      
        Config.SetProcess(WINDOW_TITLE_CONFIG_KEY, value)
        this.m_windowTitle := value
      }
    }
  }

  class Filter {
    StoneStr {
      get {
        if (!IsSet(m_stone)) {
          this.m_stone := Config.GetFilter(STONE_STR_CONFIG_KEY)
        }
        return this.m_stone
      }
      set {      
        Config.SetFilter(STONE_STR_CONFIG_KEY, value)
        this.m_stone := value
      }
    }
    FlintStr {
      get {
        if (!IsSet(m_flint)) {
          this.m_flint := Config.GetFilter(FLINT_STR_CONFIG_KEY)
        }
        return this.m_flint
      }
      set {      
        Config.SetFilter(FLINT_STR_CONFIG_KEY, value)
        this.m_flint := value
      }
    }
    BerryStr {
      get {
        if (!IsSet(m_berry)) {
          this.m_berry := Config.GetFilter(BERRY_STR_CONFIG_KEY)
        }
        return this.m_berry
      }
      set {      
        Config.SetFilter(BERRY_STR_CONFIG_KEY, value)
        this.m_berry := value
      }
    }
    RawMeatStr {
      get {
        if (!IsSet(m_rawMeat)) {
          this.m_rawMeat := Config.GetFilter(RAW_MEAT_STR_CONFIG_KEY)
        }
        return this.m_rawMeat
      }
      set {      
        Config.SetFilter(RAW_MEAT_STR_CONFIG_KEY, value)
        this.m_rawMeat := value
      }
    }
    GiveAllFilter {
      get => Config.GetMember(this, Config.GetFilter, GIVE_ALL_STR_FIELD_NAME, GIVE_ALL_STR_CONFIG_KEY)
      set => Config.SetMember(this, Config.SetFilter, GIVE_ALL_STR_FIELD_NAME, GIVE_ALL_STR_CONFIG_KEY, value)
    }
    TakeAllFilter {
      get => Config.GetMember(this, Config.GetFilter, TAKE_ALL_STR_FIELD_NAME, TAKE_ALL_STR_CONFIG_KEY)
      set => Config.SetMember(this, Config.SetFilter, TAKE_ALL_STR_FIELD_NAME, TAKE_ALL_STR_CONFIG_KEY, value)    
    }
    SelfDropAllFilter {
      get => Config.GetMember(this, Config.GetFilter, SELF_DROP_ALL_STR_FIELD_NAME, SELF_DROP_ALL_STR_CONFIG_KEY)
      set => Config.SetMember(this, Config.SetFilter, SELF_DROP_ALL_STR_FIELD_NAME, SELF_DROP_ALL_STR_CONFIG_KEY, value)
    }
    OtherDropAllFilter {
      get => Config.GetMember(this, Config.GetFilter, OTHER_DROP_ALL_STR_FIELD_NAME, OTHER_DROP_ALL_STR_CONFIG_KEY)
      set => Config.SetMember(this, Config.SetFilter, OTHER_DROP_ALL_STR_FIELD_NAME, OTHER_DROP_ALL_STR_CONFIG_KEY, value)
    }
  }

  class Delay {
    _5xlw {
      get {
        if (!IsSet(m_5xlw)) {
          this.m_5xlw := Config.GetDelay(STONE_STR_CONFIG_KEY)
        }
        return this.m_5xlw
      }
      set {      
        Config.SetDelay(_5XLW_CONFIG_KEY, value)
        this.m_5xlw := value
      }
    }
    _4xlw {
      get {
        if (!IsSet(m_4xlw)) {
          this.m_4xlw := Config.GetDelay(_4XLW_CONFIG_KEY)
        }
        return this.m_4xlw
      }
      set {      
        Config.SetDelay(_4XLW_CONFIG_KEY, value)
        this.m_4xlw := value
      }
    }
    _3xlw {
      get {
        if (!IsSet(m_3xlw)) {
          this.m_3xlw := Config.GetDelay(_3XLW_CONFIG_KEY)
        }
        return this.m_3xlw
      }
      set {      
        Config.SetDelay(_3XLW_CONFIG_KEY, value)
        this.m_3xlw := value
      }
    }
    _2xlw {
      get {
        if (!IsSet(m_2xlw)) {
          this.m_2xlw := Config.GetDelay(_2XLW_CONFIG_KEY)
        }
        return this.m_2xlw
      }
      set {      
        Config.SetDelay(_2XLW_CONFIG_KEY, value)
        this.m_2xlw := value
      }
    }
    xlw {
      get {
        if (!IsSet(m_xlw)) {
          this.m_xlw := Config.GetDelay(XLW_CONFIG_KEY)
        }
        return this.m_xlw
      }
      set {      
        Config.SetDelay(XLW_CONFIG_KEY, value)
        this.m_xlw := value
      }
    }
    lw {
      get {
        if (!IsSet(m_lw)) {
          this.m_lw := Config.GetDelay(LW_CONFIG_KEY)
        }
        return this.m_lw
      }
      set {      
        Config.SetDelay(LW_CONFIG_KEY, value)
        this.m_lw := value
      }
    }
    mw {
      get {
        if (!IsSet(m_mw)) {
          this.m_mw := Config.GetDelay(MW_CONFIG_KEY)
        }
        return this.m_mw
      }
      set {      
        Config.SetDelay(MW_CONFIG_KEY, value)
        this.m_mw := value
      }
    }
    smw {
      get {
        if (!IsSet(m_smw)) {
          this.m_smw := Config.GetDelay(SMW_CONFIG_KEY)
        }
        return this.m_smw
      }
      set {      
        Config.SetDelay(SMW_CONFIG_KEY, value)
        this.m_smw := value
      }
    }
    sw {
      get {
        if (!IsSet(m_sw)) {
          this.m_sw := Config.GetDelay(SW_CONFIG_KEY)
        }
        return this.m_sw
      }
      set {      
        Config.SetDelay(SW_CONFIG_KEY, value)
        this.m_sw := value
      }
    }
    xsw {
      get {
        if (!IsSet(m_xsw)) {
          this.m_xsw := Config.GetDelay(XSW_CONFIG_KEY)
        }
        return this.m_xsw
      }
      set {      
        Config.SetDelay(XSW_CONFIG_KEY, value)
        this.m_xsw := value
      }
    }
    _2xsw {
      get {
        if (!IsSet(m_2xsw)) {
          this.m_2xsw := Config.GetDelay(_2XSW_CONFIG_KEY)
        }
        return this.m_2xsw
      }
      set {      
        Config.SetDelay(_2XSW_CONFIG_KEY, value)
        this.m_2xsw := value
      }
    }
    AutoClickInterval {
      get {
        if (!IsSet(m_autoClickInterval)) {
          this.m_autoClickInterval := Config.GetDelay(AUTO_CLICK_INTERVAL_CONFIG_KEY)
        }
        return this.m_autoClickInterval
      }
      set {      
        Config.SetDelay(AUTO_CLICK_INTERVAL_CONFIG_KEY, value)
        this.m_autoClickInterval := value
      }
    }
  }

  ; Functions for the "process" section
  static GetProcess(key) {
    return IniRead(Config.ConfigFilePath, PROCESS_SECTION, key) 
  }
  static SetProcess(key, value) {
    IniWrite(value, Config.ConfigFilePath, PROCESS_SECTION, key)
  }

  ; Functions for the "delay" section
  static GetDelay(key) {
    return IniRead(Config.ConfigFilePath, DELAY_SECTION, key) 
  }
  static SetDelay(key, value) {
    IniWrite(value, Config.ConfigFilePath, DELAY_SECTION, key)
  }

  ; Functions for the "filter" section
  static GetFilter(key) {
    return IniRead(Config.ConfigFilePath, FILTER_SECTION, key) 
  }
  static SetFilter(key, value) {
    IniWrite(value, Config.ConfigFilePath, FILTER_SECTION, key)
  }

  ; Functions for the "position" section
  static GetPosition(key) {
    return Point.From(IniRead(Config.ConfigFilePath, POSITION_SECTION, key))
  }
  static SetPosition(key, value) {
    IniWrite(value.ToString(), Config.ConfigFilePath, POSITION_SECTION, key)
  }

  ; Functions for the "keybind" section
  static GetKeybind(key) {
    return IniRead(Config.ConfigFilePath, KEYBIND_SECTION, key)
  }
  static SetKeybind(key, value) {
    IniWrite(value, Config.ConfigFilePath, KEYBIND_SECTION, key)
  }

  ; Functions for the "hotkey" section
  static GetHotkey(key) {
    return IniRead(Config.ConfigFilePath, HOTKEY_SECTION, key)
  }
  static SetHotkey(key, value) {
    IniWrite(value, Config.ConfigFilePath, HOTKEY_SECTION, key)
  }

  ; Functions for the "color" section
  static GetColor(key) {
    return IniRead(Config.ConfigFilePath, COLOR_SECTION, key)
  }
  static SetColor(key, value) {
    IniWrite(value, Config.ConfigFilePath, COLOR_SECTION, key)
  } 

  ; Functions for the "region" section
  static GetRegion(key) {
    return Region.From(IniRead(Config.ConfigFilePath, REGION_SECTION, key))
  }
  static SetRegion(key, value) {
    IniWrite(value.ToString(), Config.ConfigFilePath, REGION_SECTION, key)
  }

  ; Functions for the "toggle" section
  static GetToggle(key) {
    return IniRead(Config.ConfigFilePath, TOGGLE_SECTION, key)
  }
  static SetToggle(key, value) {
    IniWrite(value, Config.ConfigFilePath, TOGGLE_SECTION, key)
  }

  ; Functions for the "random" section
  static GetRandom(key) {
    return IniRead(Config.ConfigFilePath, RANDOM_SECTION, key)
  }
  static SetRandom(key, value) {
    IniWrite(value, Config.ConfigFilePath, RANDOM_SECTION, key)
  }

  ; Functions for the "crosshair" section
  static GetCrosshair(key) {
    return IniRead(Config.ConfigFilePath, CROSSHAIR_SECTION, key)
  }
  static SetCrosshair(key, value) {
    IniWrite(value, Config.ConfigFilePath, CROSSHAIR_SECTION, key)
  }

  static Get(key, section) {
    return IniRead(Config.ConfigFilePath, section, key)
  }

  ; Used as the getter for properties
  static GetMember(self, getter, memberName, configKey) {
    if (!IsSet(%memberName%)) {
      self.%memberName% := getter(this, configKey)
    }
    return self.%memberName%
  }

  ; Used as the setter for properties
  static SetMember(self, setter, memberName, configKey, value) {
    setter(self, configKey, value)
    self.%memberName% := value
  }
}
