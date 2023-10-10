#Requires AutoHotkey v2.0

class Observable {
  __New() {
    ; this.child := child
    this.m_stateChanged := Event(this)
  }

  Test {
    get => "Hello World!"
  }

  StateChanged {
    get => this.m_stateChanged
  }

  GetTest() {
    return this.Test
  }

  OnEvent(name, handler) {
    this.StateChanged.Subscribe(name, handler)
  }
}