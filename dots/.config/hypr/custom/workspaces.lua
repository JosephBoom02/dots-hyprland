-- ── Mappatura workspace ⇄ monitor, adattiva al setup collegato ──────────
local TV, LEFT, RIGHT = "HDMI-A-2", "DP-1", "DP-2"

-- true se un monitor con quel nome è collegato.
-- `excluded` serve durante monitor.removed: il monitor appena staccato
-- può ancora comparire in get_monitors() mentre l'evento viene gestito.
local function connected(name, excluded)
  if name == excluded then return false end
  for _, m in ipairs(hl.get_monitors()) do
    if m.name == name then return true end
  end
  return false
end

-- su quale monitor deve stare il workspace i, dato ciò che è collegato
local function target_for(i, excluded)
  local dp1 = connected(LEFT,  excluded)
  local dp2 = connected(RIGHT, excluded)
  local tv  = connected(TV,    excluded)

  if dp1 and dp2 then
    return (i % 2 == 1) and RIGHT or LEFT   -- dispari → DP-2, pari → DP-1
  elseif tv then
    return TV                               -- solo la TV → tutto sulla TV
  elseif dp2 then
    return RIGHT                            -- fallback: un solo DP collegato
  elseif dp1 then
    return LEFT
  end
  return nil                                -- niente di noto collegato
end

local function apply_workspaces(excluded)
  local has_default = {}   -- monitor → ha già un workspace di default?
  for i = 1, 10 do
    local mon = target_for(i, excluded)
    if mon then
      local is_default = not has_default[mon]
      has_default[mon] = true

      -- 1) aggiorna la regola (dove il workspace nascerà d'ora in poi)
      hl.workspace_rule({
        workspace = tostring(i),
        monitor   = mon,
        default   = is_default,   -- primo ws per ciascun monitor = default
      })

      -- 2) sposta subito il workspace se è già aperto sul monitor sbagliato
      local ws = hl.get_workspace(tostring(i))
      if ws and ws.monitor and ws.monitor.name ~= mon then
        hl.dispatch(hl.dsp.workspace.move({ workspace = tostring(i), monitor = mon }))
      end
    end
  end
end

apply_workspaces()                                     -- all'avvio / reload
hl.on("monitor.added",   function()   apply_workspaces()        end)
hl.on("monitor.removed", function(m)  apply_workspaces(m.name)  end)