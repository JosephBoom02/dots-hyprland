----------------------------- CODICE ORIGINALE -----------------------------------

-- for i = 1, 10 do
--   hl.workspace_rule({
--     workspace = tostring(i),
--     monitor   = (i % 2 == 1) and "DP-2" or "DP-1",  -- odd → DP-2, even → DP-1
--     default   = (i == 1 or i == 2),                 -- default ws per monitor
--   })
-- end

----------------------------------------------------------------------------------

-- ── Workspace 1..10, adattivi al monitor collegato ──────────────────────
local TV    = "HDMI-A-2"
local LEFT  = "DP-1"   -- workspace pari
local RIGHT = "DP-2"   -- workspace dispari
local N     = 10

-- Insieme dei monitor attualmente collegati.
-- `excluded` serve su monitor.removed: il monitor appena staccato può
-- comparire ancora in get_monitors() mentre l'evento viene gestito.
local function connected(excluded)
  local set = {}
  local ok, mons = pcall(hl.get_monitors)
  if ok and mons then
    for _, m in ipairs(mons) do
      if m.name ~= excluded then set[m.name] = true end
    end
  end
  return set
end

-- Su quale monitor deve stare il workspace i
local function target_for(i, mons)
  if mons[TV] then
    return TV                                  -- TV collegata → tutto sulla TV
  elseif mons[LEFT] and mons[RIGHT] then
    return (i % 2 == 1) and RIGHT or LEFT      -- dispari → DP-2, pari → DP-1
  elseif mons[RIGHT] then
    return RIGHT
  elseif mons[LEFT] then
    return LEFT
  end
end

-- Nome del monitor di un workspace, tollerante al tipo restituito
local function ws_monitor_name(ws)
  if not ws or not ws.monitor then return nil end
  if type(ws.monitor) == "table" then return ws.monitor.name end
  return tostring(ws.monitor)
end

local function apply(excluded)
  local mons     = connected(excluded)
  local first_on = {}   -- monitor → primo workspace che gli spetta

  for i = 1, N do
    local name = target_for(i, mons)
    if name then
      if not first_on[name] then first_on[name] = i end

      hl.workspace_rule({
        workspace = tostring(i),
        monitor   = name,
        default   = (first_on[name] == i),
      })

      -- se il workspace esiste già ed è sul monitor sbagliato, spostalo
      pcall(function()
        local ws = hl.get_workspace(tostring(i))
        if ws and ws_monitor_name(ws) and ws_monitor_name(ws) ~= name then
          hl.dispatch(hl.dsp.workspace.move({
            workspace = tostring(i),
            monitor   = name,
          }))
        end
      end)
    end
  end

  -- porta ogni monitor sul primo workspace che gli spetta
  pcall(function()
    for name, i in pairs(first_on) do
      if mons[name] then
        hl.dispatch(hl.dsp.focus({ monitor = name }))
        hl.dispatch(hl.dsp.focus({ workspace = tostring(i) }))
      end
    end
  end)
end

apply()

hl.on("monitor.added", function()
  -- piccolo ritardo: all'evento il monitor può non essere ancora pronto
  local ok = pcall(function()
    hl.timer(function() apply() end, { timeout = 300, type = "oneshot" })
  end)
  if not ok then apply() end
end)

hl.on("monitor.removed", function(m)
  apply(m and m.name or nil)
end)