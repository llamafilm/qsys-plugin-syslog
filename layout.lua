-- debug mode
-- layout['code']={PrettyName='code',Style='None'}

local CurrentPage = PageNames[props['page_index'].Value]
if CurrentPage == 'Control' then
  -- header box
  table.insert(graphics, {
    Type = 'GroupBox',
    Size = { 400, 40 },
    Position = { 0, 0},
    Fill = { 72, 72, 72 },
    StrokeWidth = 0
  })

  -- header text
  table.insert(graphics, {
    Type = 'Label',
    Text = 'Syslog Sender',
    Position = { 100, 0 },
    Size = { 200, 40 },
    Color = { 220, 220, 220 },
    StrokeWidth = 0,
    FontSize = 24
  })

  -- header text version 
  table.insert(graphics, {
    Type = 'Label',
    Text = PluginInfo.BuildVersion,
    Position = { 360, 20 },
    Size = { 40, 20 },
    Color = { 220, 220, 220 },
    StrokeWidth = 0,
    FontSize = 10
  })

  -- background box
  table.insert(graphics, {
    Type = 'GroupBox',
    Size = { 400, 200 },
    Position = { 0, 40},
    Fill = { 220, 220, 220 },
    StrokeWidth = 0
  })

  -- host text entry
  table.insert(graphics, {
    Type = 'Label',
    HTextAlign = 'Right',
    Text = 'Host',
    Position = { 8, 50 },
    Size = { 60, 30 },
    Margin = 5,
    StrokeWidth = 0,
    FontSize = 12
  })
  layout['Host'] = {
    Position = { 68, 50 },
    Size = { 232,30 },
    Margin = 5,
    CornerRadius = 4,
    FontSize = 12        
  }

  -- port text entry
  table.insert(graphics, {
    Type = 'Label',
    HTextAlign = 'Right',
    Text = 'UDP Port',
    Position = { 8, 80 },
    Size = { 60, 30 },
    Margin = 5,
    StrokeWidth = 0,
    FontSize = 12
  })
  layout['Port'] = {
    Position = { 68, 80 },
    Size = { 50,30 },
    Margin = 5,
    CornerRadius = 4,
    FontSize = 12        
  }

  -- status display
  table.insert(graphics, {
    Type = 'Label',
    HTextAlign = 'Right',
    Text = 'Status',
    Position = { 118, 80 },
    Size = { 50, 30 },
    Margin = 5,
    StrokeWidth = 0,
    FontSize = 12
  })
  layout['Status'] = {
    Position = { 168, 80 },
    Size = { 132, 30 },
    Margin = 5,
    CornerRadius = 4   
  }

  -- message display
  table.insert(graphics, {
    Type = 'Label',
    HTextAlign = 'Left',
    Text = 'Last Entry',
    Position = { 10, 121 },
    Size = { 100, 30 },
    Margin = 5,
    StrokeWidth = 0,
    FontSize = 12
  })

  layout['last.entry'] = {
    Position = { 10,151 },
    Size = { 380,71 },
    Margin = 0,
    Padding = 4,
    CornerRadius = 4,
    FontSize = 12,
    HTextAlign = 'Left',
    VTextAlign = 'Top',
    IsReadOnly = true,
    WordWrap = true,
    PrettyName = 'Last Entry'
  }

  -- send button
  layout['Send'] = {
    Position = { 290, 121 },
    Size = { 100, 30 },
    Margin = 5,
    CornerRadius = 4,
    Legend = 'Send Now'
  }

  -- replicate default Event Log output pin but don't display it
  layout['last.script'] = { Style = 'None', PrettyName = 'Lua Script' }

end
