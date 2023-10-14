#Requires AutoHotkey v2.0

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
}