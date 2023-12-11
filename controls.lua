table.insert (ctrls, {
  Name = 'Host',
  ControlType = 'Text',
  Count = 1,
  UserPin = false,
})

table.insert (ctrls, {
  Name = 'Port',
  ControlType = 'Knob',
  Count = 1,
  UserPin = false,
  DefaultValue = 514,
  ControlUnit = 'Integer',
  Min = 1,
  Max = 65535
})

table.insert (ctrls, {
  Name = 'Status',
  ControlType = 'Indicator',
  IndicatorType = 'Status',
  Count = 1,
  UserPin = true,
  PinStyle = 'Output',
})

table.insert (ctrls, {
  Name = 'Send',
  ControlType = 'Button',
  ButtonType = 'Trigger',
  Count = 1
})

-- replicate normal Event Log functionality with embedded component
table.insert (ctrls, {
  Name = 'last.script',
  ControlType = 'Text',
  Count = 1,
  UserPin = true,
  PinStyle = 'Output'
})

table.insert (ctrls, {
  Name = 'last.entry',
  ControlType = 'Text',
  Count = 1,
  UserPin = true,
  PinStyle = 'Output'
})

-- debug mode
-- table.insert(ctrls,{Name = 'code',ControlType = 'Text',UserPin = false,PinStyle = 'Input',Count = 1})
