#Requires AutoHotkey v2.0

#include "structures/Point.ahk"
#include "structures/Region.ahk"

CONFIG_FILE := "config.ini"
PROCESS_SECTION := "process"
DELAY_SECTION := "delay"
FILTER_SECTION := "filter"
POSITION_SECTION := "position"
KEYBIND_SECTION := "keybind"
HOTKEY_SECTION := "hotkey"
COLOR_SECTION := "color"
REGION_SECTION := "region"

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
AUTO_CLICK_INTERVAL_CONFIG_KEY := "autoClickInterval"
PIVOT_CAMERA_90_DEGREES_CONFIG_KEY := "pivotCamera90Degrees"

STONE_STR_CONFIG_KEY := "stone"
FLINT_STR_CONFIG_KEY := "flint"
BERRY_STR_CONFIG_KEY := "berry"
RAW_MEAT_STR_CONFIG_KEY := "rawMeat"
GIVE_ALL_STR_CONFIG_KEY := "giveAll"
TAKE_ALL_STR_CONFIG_KEY := "takeAll"

GIVE_ALL_STR_FIELD_NAME := "m_giveAll"
TAKE_ALL_STR_FIELD_NAME := "m_takeAll"
PIVOT_CAMERA_90_DEGREES_FIELD_NAME := "m_pivotCamera90Degrees"

SPAWN_SCREEN_BED_CONFIG_KEY := "spawnScreenBedColor"
REGION_TEXT_WHEN_DEAD_COLOR_CONFIG_KEY := "regionTextWhenDeadColor"

; SPAWN_REGION_TEXT_REGION_CONFIG_KEY := "spawnRegionTextRegion"


class Config {
  __New() {
    this.delay := Config.Delay()
    this.filter := Config.Filter()
    this.process := Config.Process()
    this.color := Config.Color()
    ;this.region := Config.Region()
  }

  ; class Region {
  ;   SpawnRegionTextRegion {
  ;     get {
  ;       if (!IsSet(m_spawnRegionTextRegion)) {
  ;         this.m_spawnRegionTextRegion := Config.GetRegion(SPAWN_REGION_TEXT_REGION_CONFIG_KEY)
  ;       }
  ;       return this.m_spawnRegionTextRegion
  ;     }
  ;     set {      
  ;       Config.SetRegion(SPAWN_REGION_TEXT_REGION_CONFIG_KEY, value)
  ;       this.m_spawnRegionTextRegion := value
  ;     }
  ;   }
  ; }

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

    RegionTextWhenDeadColor {
      get {
        if (!IsSet(m_regionTextWhenDeadColor)) {
          this.m_regionTextWhenDeadColor := Config.GetColor(REGION_TEXT_WHEN_DEAD_COLOR_CONFIG_KEY)
        }
        return this.m_regionTextWhenDeadColor
      }
      set {      
        Config.SetColor(REGION_TEXT_WHEN_DEAD_COLOR_CONFIG_KEY, value)
        this.m_regionTextWhenDeadColor := value
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
    PivotCamera90Degrees {
      get => Config.GetMember(this, Config.GetDelay, PIVOT_CAMERA_90_DEGREES_FIELD_NAME, PIVOT_CAMERA_90_DEGREES_CONFIG_KEY)
      set => Config.SetMember(this, Config.SetDelay, PIVOT_CAMERA_90_DEGREES_FIELD_NAME, PIVOT_CAMERA_90_DEGREES_CONFIG_KEY, value)
    }
  }

  ; Functions for the "process" section
  static GetProcess(key) {
    return IniRead(CONFIG_FILE, PROCESS_SECTION, key) 
  }
  static SetProcess(key, value) {
    IniWrite(value, CONFIG_FILE, PROCESS_SECTION, key)
  }

  ; Functions for the "delay" section
  static GetDelay(key) {
    return IniRead(CONFIG_FILE, DELAY_SECTION, key) 
  }
  static SetDelay(key, value) {
    IniWrite(value, CONFIG_FILE, DELAY_SECTION, key)
  }

  ; Functions for the "filter" section
  static GetFilter(key) {
    return IniRead(CONFIG_FILE, FILTER_SECTION, key) 
  }
  static SetFilter(key, value) {
    IniWrite(value, CONFIG_FILE, FILTER_SECTION, key)
  }

  ; Functions for the "position" section
  static GetPosition(key) {
    return Point.From(IniRead(CONFIG_FILE, POSITION_SECTION, key))
  }
  static SetPosition(key, value) {
    IniWrite(value.ToString(), CONFIG_FILE, POSITION_SECTION, key)
  }

  ; Functions for the "keybind" section
  static GetKeybind(key) {
    return IniRead(CONFIG_FILE, KEYBIND_SECTION, key)
  }
  static SetKeybind(key, value) {
    IniWrite(value, CONFIG_FILE, KEYBIND_SECTION, key)
  }

  ; Functions for the "hotkey" section
  static GetHotkey(key) {
    return IniRead(CONFIG_FILE, HOTKEY_SECTION, key)
  }
  static SetHotkey(key, value) {
    IniWrite(value, CONFIG_FILE, HOTKEY_SECTION, key)
  }

  ; Functions for the "color" section
  static GetColor(key) {
    return IniRead(CONFIG_FILE, COLOR_SECTION, key)
  }
  static SetColor(key, value) {
    IniWrite(value, CONFIG_FILE, COLOR_SECTION, key)
  } 

  ; Functions for the "region" section
  static GetRegion(key) {
    return Region.From(IniRead(CONFIG_FILE, REGION_SECTION, key))
  }
  static SetRegion(key, value) {
    IniWrite(value.ToString(), CONFIG_FILE, REGION_SECTION, key)
  }

  static Get(key, section) {
    return IniRead(CONFIG_FILE, section, key)
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