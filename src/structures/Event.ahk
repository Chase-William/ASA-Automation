#Requires AutoHotkey v2.0

; A very simple event class
; In my use case, I am never unsubscribing from events, therefore, I am not implementing it
class Event {
  __New(declaring) {
    this.declaring := declaring
    this.handlers := Map()
  }

  Subscribe(name, handler) {
    ; Initialze the array if needed
    if (!this.handlers.Has(name)) {
      this.handlers[name] := []
    }
    this.handlers[name].Push(handler)
  }

  ; Invokes the event causing all subscribed methods aka handlers to execute
  Invoke(name, value) {
    
    ; Error check if handlers were found
    if (!this.handlers.Has(name)) {
      ; throw Error("Error. Event " Format("{1}", name) " does not exist. Subscribe() was never called for this event.")
      return
    }

    ; Call all functions in handler array
    For handler in this.handlers[name] {
      handler(this.declaring, value)
    }
  }
}