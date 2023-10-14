#Requires AutoHotkey v2.0

; Represents a row like control containing a given title with: x,y entries.
class CoordinateInput {
  ; MyGui - Root Gui object
  ; title - Meaning of the x,y coordinate position
  ; position - Vector2 position
  ; XS - Aligning to the last X position of a saved "Section" enabled by default
  __New(myGui, title, position, XS := true) {
    myGui.AddText((XS ? "XS " : "") "Section w200", title)
    myGui.AddText("x+m", "x:")
    this.editX := myGui.AddEdit("x+5 w50",)
    this.editX.Value := position.x
    myGui.AddText("x+m", "y:")
    this.editY := myGui.AddEdit("x+5 w50",)
    this.editY.Value := position.y    
  }  

  GetPoint() {
    return Point(this.editX.Text, this.editY.Text)
  }
}