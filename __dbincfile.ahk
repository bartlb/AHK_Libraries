ButtonSubmit:
{
  Gui Submit, NoHide
  
FormatTime, CurrentDateTime1,, H:mm:ss
FormatTime, CurrentDateTime2,, M/d/yyy


APPEND := SR "," CurrentDateTime1 "," CurrentDateTime2 "," actionType
  
  if (csi_flag) {
    if (StrLen(SR) = 8) {
        ;~ FileAppend, % APPEND "`n", %A_ScriptDir%\logs\SR.csv
        ExitApp
    } else {
        GuiControl focus, SR
        return
      }
  }


  loop parse, STDREQ_FIELDS, `|
  {
    if (%A_LoopField% == "") {
      MsgBox, 48, Mandatory Fields, Please ensure all fields are populated to continue.
      GuiControl, focus, %A_LoopField%
      return
    }
  }

  if (GetProductData(product, "fields")) {
    loop % productData0
    {
      t_field := productData%A_Index%
      GuiControlGet header,, % "h_" t_field 
      productSpecific .= (productSpecific ? "`n" : "") header " " %t_field%
    }
  }
  
  if (actionType = "New SR") {
      DataCheck(product)
      FileRead csiOutput, % DATA_PATH "\output_template.txt"
      EmailCheck(product)
    } else if (actionType = "Escalation"){
      FileRead csiOutput, % DATA_PATH "\escalation_template.txt"
    }
  
  StringReplace, csiOutput, csiOutput, `[time`], % CurrentDateTime1
  StringReplace, csiOutput, csiOutput, `[date`], % CurrentDateTime2
  StringReplace, csiOutput, csiOutput, `[SIG`], % OracleSig
  StringReplace, csiOutput, csiOutput, `r`n, `n, all
  loop parse, STDREQ_FIELDS, `| 
  {
  StringReplace csiOutput, csiOutput, % "[" A_LoopField "]", % %A_LoopField%, All
  StringReplace csiOutput, csiOutput,  `[prodSpecific`], % productSpecific
  }

  
  
  Clipboard = %csiOutput%
  


Win_Q_Check = 1 
TrayTip, SR Note Creation, Place cursor in the description field and hit WIN+Q, 30000, 1
Gui, Minimize
pause on
return
}
