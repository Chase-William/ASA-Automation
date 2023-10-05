#Requires AutoHotkey v2.0

#include "../Config.ahk"
#include "../Util.ahk"

FISHING_SECTION := "fishing"

FISHING_LETTER_Q_CONFIG_KEY := "q"
FISHING_LETTER_W_CONFIG_KEY := "w"
FISHING_LETTER_A_CONFIG_KEY := "a"
FISHING_LETTER_S_CONFIG_KEY := "s"
FISHING_LETTER_Z_CONFIG_KEY := "z"
FISHING_LETTER_E_CONFIG_KEY := "e"
FISHING_LETTER_D_CONFIG_KEY := "d"
FISHING_LETTER_C_CONFIG_KEY := "c"
FISHING_LETTER_X_CONFIG_KEY := "x"

; Near white text is expected of fishing text commands
FISHING_PROMPT_TEXT_COLOR_THRESHOLD := 240

; Houses all the necessary logic/local data for automatic fishing
; This was done because automatic fishing is too complicated to implemented
; within the general controller.
class FishingController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user
    
    this.m_q := ParseFishingArray(FISHING_LETTER_Q_CONFIG_KEY)
    this.m_w := ParseFishingArray(FISHING_LETTER_W_CONFIG_KEY)
    this.m_a := ParseFishingArray(FISHING_LETTER_A_CONFIG_KEY)
    this.m_s := ParseFishingArray(FISHING_LETTER_S_CONFIG_KEY)
    this.m_z := ParseFishingArray(FISHING_LETTER_Z_CONFIG_KEY)
    this.m_e := ParseFishingArray(FISHING_LETTER_E_CONFIG_KEY)
    this.m_d := ParseFishingArray(FISHING_LETTER_D_CONFIG_KEY)
    this.m_c := ParseFishingArray(FISHING_LETTER_C_CONFIG_KEY)
    this.m_x := ParseFishingArray(FISHING_LETTER_X_CONFIG_KEY)

    ; this.m_autoRecast := false
  }

  ; AutoRecast {
  ;   get => this.m_autoRecast
  ;   set => this.m_autoRecast := value
  ; }

  AutoFish() {
    static centerX := 0
    static centerY := 0

    if (centerX == 0) {
      WinGetPos(,, &centerX, &centerY, this.cfg.process.windowTitle)
      centerX := centerX / 2
      centerY := centerY / 2
    }

    ; Check to recast if enabled
    ; if (this.AutoRecast) {
    ;   rgb := HexToDecArray(PixelGetColor(centerX, centerY))
    ;   if (rgb[RED_INDEX] < 15 AND
    ;       rgb[GREEN_INDEX] > 205 AND rgb[GREEN_INDEX] < 235 AND
    ;       rgb[BLUE_INDEX] > 205 AND rgb[BLUE_INDEX] < 235
    ;     ) {
    ;       Sleep this.cfg.delay._2xlw
    ;       Click
    ;       Sleep this.cfg.delay._2xlw
    ;       Click
    ;       return
    ;   }
    ; }

    ; Test each character in a specific order
    if (this.TestPixelColor(this.m_q)) {
      ControlSend("q",, this.cfg.process.windowTitle)
    } else if (this.TestPixelColor(this.m_w)) {
      ControlSend("w",, this.cfg.process.windowTitle)
    } else if (this.TestPixelColor(this.m_a)) {
      ControlSend("a",, this.cfg.process.windowTitle)
    } else if (this.TestPixelColor(this.m_s)) {
      ControlSend("s",, this.cfg.process.windowTitle)
    } else if (this.TestPixelColor(this.m_z)) {
      ControlSend("z",, this.cfg.process.windowTitle)
    } else if (this.TestPixelColor(this.m_e)) {
      ControlSend("e",, this.cfg.process.windowTitle)
    } else if (this.TestPixelColor(this.m_d)) {
      ControlSend("d",, this.cfg.process.windowTitle)
    } else if (this.TestPixelColor(this.m_c)) {
      ControlSend("c",, this.cfg.process.windowTitle)
    } else if (this.TestPixelColor(this.m_x)) {
      ControlSend("x",, this.cfg.process.windowTitle)
    } else {
      return ; No letter found
    }    
  }

  ; Test a character's positions for valid color value
  ; positions - positions array to test
  ; return - true for all matches, false for failure of one or more matches
  TestPixelColor(positions) {
    rgb := Array()
    ; Loop over all positions for this character
    for position in positions {
      rgb := HexToDecArray(PixelGetColor(position.x, position.y))
      if (rgb[RED_INDEX] < FISHING_PROMPT_TEXT_COLOR_THRESHOLD) {
        return false
      }
      if (rgb[GREEN_INDEX] < FISHING_PROMPT_TEXT_COLOR_THRESHOLD) {
        return false
      }
      if (rgb[BLUE_INDEX] < FISHING_PROMPT_TEXT_COLOR_THRESHOLD) {
        return false
      }
    }
    ; Success only occurs if all previous steps succeed
    return true
  }
}

; Returns an array of points as a result of parsing 
; the [fishing] section's | deliminated points
ParseFishingArray(key) {
  pointsStr := Config.Get(key, FISHING_SECTION)
  ; pointStrings := StrSplit(Config.Get(key, FISHING_SECTION), "|")
  points := Array()
  Loop Parse, pointsStr, "|" {
    ; Parse and push points onto array
    points.Push(Point.From(A_LoopField))
  }
  return points
}