class LilxDHotkey {
  __New(key, mod?) {
    this.key := key
    if IsSet(mod)
      this.mod := mod
    else
      this.mod := ""
  }

  toString() => Format("{1}{2}", this.mod, this.key)
}