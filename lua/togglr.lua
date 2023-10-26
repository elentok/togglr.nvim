local M = {}

---@type { key: string|boolean, debug: boolean, register: string, values: { [string]: string}}
local config = {
  -- Set "key" to false when calling in order to disable the keymapping.
  key = "<Leader>tw",
  debug = false,
  register = "t",
  values = {
    ["true"] = "false",
    ["True"] = "False",
    ["yes"] = "no",
    ["on"] = "off",
    ["enabled"] = "disabled",
    ["enable"] = "disable",
    ["left"] = "right",
    ["top"] = "bottom",
    ["should"] = "should_not",
    ["be_true"] = "be_false",
    ["border-left"] = "border-right",
    ["border-top"] = "border-bottom",
    ["margin-left"] = "margin-right",
    ["margin-top"] = "margin-bottom",
    ["padding-left"] = "padding-right",
    ["padding-top"] = "padding-bottom",
    ["addClass"] = "removeClass",
    ["column"] = "row",
    ["back"] = "fwd",
    ["up"] = "down",
    ["const"] = "let",
    ["+"] = "-",
  },
}

local function log(message)
  if config.debug then
    print("[TOGGLR] " .. message)
  end
end

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  local key = config.key
  if type(key) == "string" then
    vim.keymap.set("n", key, M.toggle_word, { desc = "Toggle word" })
  end

  -- add the reverse + uppercase mappings to the hash
  for value, opposite in pairs(config.values) do
    config.values[opposite] = value

    local upper_value = value:upper()
    local upper_opposite = opposite:upper()
    config.values[upper_value] = upper_opposite
    config.values[upper_opposite] = upper_value
  end
end

function M.toggle_word()
  local value = vim.fn.expand("<cword>")
  log("Toggle world from [" .. value .. "]")
  local other_value = config.values[value]
  if other_value ~= nil then
    log("Toggle world to [" .. other_value .. "]")
    vim.cmd('normal! "' .. config.register .. "ciw" .. other_value)
  else
    log("Did not find an opposite value for '" .. value .. "'")
  end
end

function M.add(value1, value2)
  config.values[value1] = value2
  config.values[value2] = value1
end

function M.print_config()
  print("Togglr config:", vim.inspect(config))
end

function M.debug_on()
  config.debug = true
  print("Togglr debug mode enabled")
end

function M.debug_off()
  config.debug = false
  print("Togglr debug mode disabled")
end

return M
