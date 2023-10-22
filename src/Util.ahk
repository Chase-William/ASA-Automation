#Requires AutoHotkey v2.0

RED_INDEX := 1
GREEN_INDEX := 2
BLUE_INDEX := 3

HexToDec(hex)
{
  if (InStr(hex, "0x") != 1)
    hex := "0x" hex
  return hex + 0
}

HexToDecArray(hex) {
  red := SubStr(hex, 3, 2)
  green := SubStr(hex,5, 2)
  blue := SubStr(hex, 7, 2)

  red := HexToDec(red)
  green := HexToDec(green)
  blue := HexToDec(blue)

  return [red, green, blue]
}

; Returns a boolean indicating if a number was given and if it is above the min threshold
IsValidNumber(text) {
  if (!IsNumber(text) || text < 50) {
    return false
  }
  return true
}