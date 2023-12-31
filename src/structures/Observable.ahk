#Requires AutoHotkey v2.0

#include "Event.ahk"

class Observable {
  __New() {
    this.m_stateChanged := Event(this)
  }

  StateChanged {
    get => this.m_stateChanged
  }

  OnEvent(name, handler) {
    this.StateChanged.Subscribe(name, handler)
  }
}