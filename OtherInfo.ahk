#Include "EntityInfo.ahk"

class OtherInfo extends EntityInfo {
  __New(
    ctx,
    toggleInventoryKey,
    searchbarPos,
    dropAllPos,
    transferAllPos
  ) {
    super.__New(
      ctx,
      toggleInventoryKey,
      searchbarPos,
      dropAllPos,
      transferAllPos
    )
  }
}