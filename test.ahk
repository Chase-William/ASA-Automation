#Requires AutoHotkey v2.0

class ThingClass {
  __New() {
    this.m_hello := "Hello"
  }

  Hello => this.m_hello
}

other := {}
other.getWorld := (*) => "World!"

thing := ThingClass()
thing.base.base := other

; Succeeds using field
MsgBox Format("{1} {2}", thing.m_hello, thing.getWorld()), "Value Property"
; Fails using property
MsgBox Format("{1} {2}", thing.Hello, thing.getWorld()), "Dynamic Property"