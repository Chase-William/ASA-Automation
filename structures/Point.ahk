#Requires AutoHotkey v2.0

class Point {
  __New(x, y) {
    this.x := x
    this.y := y
  }

  static From(pointStr) {
    dataArray := StrSplit(pointStr, ",")
    return Point(dataArray[1], dataArray[2]) 
  }

  ToString() {
    return Format("{1},{2}", this.x, this.y)
  }
}