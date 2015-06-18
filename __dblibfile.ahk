DataCheck(selection) {
  global CONFIG_PATH
  IniRead requiredList, % CONFIG_PATH "\" selection ".ini", % "object", % "fields"
  loop parse, requiredList, `,
  {
    if (%A_LoopField% == "") {
      MsgBox, 48, Mandatory Fields, Please ensure all fields are populated to continue.
      GuiControl Focus, % A_LoopField
      return false
    }
  }
  return true
}
