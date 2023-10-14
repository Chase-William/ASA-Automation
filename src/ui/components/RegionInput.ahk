#Requires AutoHotkey v2.0

; Represents a 2 row'd control containing a given title with: left,top,right,bottom entries.
class RegionInput {
  ; MyGui - Root Gui object
  ; title - Meaning of the x,y coordinate position
  ; rect - Bounding box object: { left, top, right, bottom }
  ; XS - Aligning to the last X position of a saved "Section" enabled by default
  __New(myGui, title, rect, XS := true) {
    myGui.AddText((XS ? "XS " : "") "Section", title)

    myGui.AddText("XS", "left:")
    this.editLeft := myGui.AddEdit("x+m w50",)
    this.editLeft.Value := rect.left

    myGui.AddText("x+m", "top:")
    this.editTop := myGui.AddEdit("x+m w50",)
    this.editTop.Value := rect.top

    myGui.AddText("x+m", "right:")
    this.editRight := myGui.AddEdit("x+m w50",)
    this.editRight.Value := rect.right

    myGui.AddText("x+m", "bottom:")
    this.editBottom := myGui.AddEdit("x+m w50",)
    this.editBottom.Value := rect.bottom
  }

  GetRegion() {
    return Region(this.editLeft.Value, this.editTop.Value, this.editRight.Value, this.editBottom.Value)
  }
}