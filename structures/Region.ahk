#Requires AutoHotkey v2.0

class Region {
  __New(left, top, right, bottom) {
    this.left := left
    this.top := top
    this.right := right
    this.bottom := bottom
  }

  static From(regionStr) {
    dataArray := StrSplit(regionStr, ",")
    return Region(dataArray[1], dataArray[2], dataArray[3], dataArray[4])
  }

  ToString() {
    return Format("{1},{2},{3},{4}", this.left, this.top, this.right, this.bottom)
  }
}