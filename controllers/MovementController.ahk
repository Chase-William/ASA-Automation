#Requires AutoHotkey v2.0

; TURN_LEFT := "Left"
; TURN_RIGHT := "Right"
; DEGREES_90 := 90
; DEGREES_180 := 180

MOVE_LEFT := "A"
MOVE_FORWARD := "W"
MOVE_RIGHT := "D"
MOVE_BACKWARDS := "S"

LOOK_DOWN := "Down"
LOOK_UP := "Up"

class MovementController {
  __New(cfg, user) {
    this.cfg := cfg
    this.user := user
  }

  ; Moves the character in a given direction for a specified duration
  ; direction - left, foward, right, reverse
  ; duration - time in milliseconds
  Move(direction, duration) {
    Sleep 2000
    ControlSend("{" direction " down}",, this.cfg.process.windowTitle)
    Sleep duration
    ControlSend("{" direction " up}",, this.cfg.process.windowTitle)
  }

  Look(direction, duration) {
    ControlSend("{" direction " down}",, this.cfg.process.windowTitle)
    Sleep duration
    ControlSend("{" direction " up}",, this.cfg.process.windowTitle)
  }

  ; Turn(direction, degrees) {
  ;   Sleep this.cfg.delay._2xlw

  ;   directionStr := direction == TURN_LEFT ? TURN_LEFT : TURN_RIGHT
  ;   delay := degrees == DEGREES_90 ? this.cfg.delay.pivotCamera90Degrees : 200

  ;   ControlSend("{" directionStr " down}",, this.cfg.process.windowTitle)
  ;   Sleep delay
  ;   ControlSend("{" directionStr " up}",, this.cfg.process.windowTitle)
  ; }

  ; TurnLeft90Degrees() {
  ;   static toggle := false
  ;   ; Static variable for holding instance bound callback
  ;   static turnFunc
  ;   ; Bind callback if not already
  ;   if !IsSet(turnFunc) { 
  ;     turnFunc := Left.bind(this)
  ;   }

  ;   Sleep this.cfg.delay._2xlw

  ;   Left()
  ;   Sleep this.cfg.delay.pivotCamera90Degrees
  ;   ControlSend("{Left up}",, this.cfg.process.windowTitle)

  ;   if toggle := !toggle {
  ;     ; SetTimer(turnFunc, 100)
  ;   }
  ;   else {
  ;     ; Settimer(turnFunc, 0)
  ;   }

  ;   Left() {
  ;     ControlSend("{Left down}",, this.cfg.process.windowTitle)
  ;   }
  ; }
}