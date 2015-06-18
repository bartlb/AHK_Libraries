DataCheck(Selection) {
  global CONFIG_PATH
  IniRead requiredList, % CONFIG_PATH "\" selection ".ini", % "object", % "fields"
    loop parse, requiredList, `,
    {
      if (%A_LoopField% == "") {
        data_flag :=true
      }
    }
    if (data_flag) {
        MsgBox, 48, Mandatory Fields, Please ensure all fields are populated to continue.
        Exit
      }
}
