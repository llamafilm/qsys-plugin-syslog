-- helper function for debugging
function Dump(o, indent)
  if indent == nil then indent = 0 end
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '\n' .. string.rep(' ', indent)  .. '['..k..'] = ' .. Dump(v, indent+2) .. ', '
    end
    return s .. ' }'
  else
    return tostring(o)
  end
end -- end Dump


function GetHostname()
  -- use Core Status component name, else fallback to unknown-qsys
  for k,v in pairs(Design.GetInventory()) do
    print(Dump(v))
    if v.Type == 'Processor' then
      -- remove all characters except alphanumeric and hyphen
      return v.Name:gsub("^%w-", "")
    end
  end

  return 'unknown-qsys'
end -- end GetHostname


function Send()
  -- load table from string representation
  local event = load(EventLog['last.script'].String)()
  if DebugTx then print(EventLog['last.script'].String) end

  -- expose output pins for internal component
  Controls['last.script'].String = EventLog['last.script'].String
  Controls['last.entry'].String = EventLog['last.entry'].String

  -- log will be empty on first run
  if event == nil then
    if DebugTx then print('no data in log') end
    return
  end

  -- Drop the last 3 digits because RFC5424 doesn't support nanoseconds
  local timestamp = string.sub(event['date'], 1, -5) .. 'Z'
  local severity
  if event['severity'] == 'Normal' then severity = 6 end
  if event['severity'] == 'Error' then severity = 3 end
  -- not sure which other severities are possible
  if event['severity'] == 'Warning' then severity = 4 end
  local priority = 14 * 8 + severity
  -- format based on RFC5424
  local payload = "<" .. priority .. ">1 " .. timestamp .. " " .. Hostname .. " qsys " .. event['category'] .. " - - " .. event['message']

  -- lookup host IP if using DNS
  local host = Network.GetHostByName(Controls.Host.String)
  if DebugTx then print('hostname resolution:', Dump(host)) end
  if host == nil then
    Controls.Status.Value = 2
    Controls.Status.String = 'Host resolution failed'
    return
  else
    Controls.Status.Value = 0
  end

  local socket = UdpSocket.New()
  socket:Open()
  if DebugTx then print('Sending to [' .. host.addresses[1] .. '] ' .. payload) end
  socket:Send(host.addresses[1], Controls.Port.Value, payload)
  socket:Close()
end -- end Send

-- main code that runs once on startup

--Debug level
DebugTx, DebugRx, DebugFunction = false, false, false
DebugPrint = Properties['Debug Print'].Value
if DebugPrint == 'Tx/Rx' then
  DebugTx, DebugRx = true, true
elseif DebugPrint == 'Tx' then
  DebugTx = true
elseif DebugPrint == 'Rx' then
  DebugRx = true
elseif DebugPrint == 'Function Calls' then
  DebugFunction = true
elseif DebugPrint == 'All' then
  DebugTx, DebugRx, DebugFunction = true, true, true
end

Hostname = GetHostname()

EventLog['last.script'].EventHandler = Send
Controls.Send.EventHandler = Send
Controls.Host.EventHandler = Send

-- send first message after init
Send()
