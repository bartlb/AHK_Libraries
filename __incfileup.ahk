ButtonSubmit:
{
  Gui Submit, NoHide

  ; Before performing any secondary checks, setting output variables, or preparing
  ; templates, be sure to check that all the default required fields are set. This way
  ; there's no chance of a check failing due to the lack of a required field being blank.
  loop parse, STDREQ_FIELDS, `|
  {
    if (%A_LoopField% == "") {
      MsgBox, 48, Mandatory Fields, Please ensure all fields are populated to continue.
      GuiControl Focus, % A_LoopField
      return 
    }
  }

  ; Next, check for the `actionType`; This value will be used to separate the scope of
  ; certain functionality and global variable values.
  if (actionType == "New SR") {
    ; Now that the scope is defined correctly (i.e. the `ButtonSubmit` event handler was
    ; called, and the `actionType` is set to "New SR"), we can check to see if the User
    ; is attempting to submit an SR Number, or the form itself.
    if (csi_flag) {
      if (StrLen(SRNumber) != 8) {
        GuiControl Focus, SRNumber
        return
      } else {
        ; [LOG/METRICS FUNCTIONALITY HERE]
        ExitApp
      }
    }

    DataCheck(product), EmailCheck(product)
    CSIOutput := "output_template.txt"
  } else {
    ; The generic 'else' statement will handle the "Escalation" `actionTYpe`, as it is
    ; the only other option and we've already confirmed that an option has been selected.
    CSIOutput := "escalation_template.txt"
  }

  ; Now, as the code needed to configure our CSI output has no direct effect on the logic
  ; contained in the `ButtonSubmit` event handler, it should be moved into its own block;
  ; this will both help to make the code more readable, and will boost performance.
  ; On a semi-related note, we need to make sure that we back-up the User's Clipboard
  ; before writing to it (this is a constant pain when a Hotkey application deletes the
  ; information that the User saved in their clipboard).
  clipBackup := Clipboard
  Clipboard  := CreateCSIOutput(CSIOutput)  ; See <lib\internals::CreateCSIOutput>
  Pause On

  return
}
