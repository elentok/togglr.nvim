local M = {}

local config = {
  -- Set "key" to false when calling "setup()" in order to disable the
  -- keymapping.
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
    ["+"] = "-",
  },
}

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  if config.key then
    vim.keymap.set("n", config.key, M.toggle_word)
  end

  -- add the reverse mappings to the hash
  for key, value in pairs(config.values) do
    config.values[value] = key
  end
end

function M.toggle_word()
  local value = vim.fn.expand("<cword>")
  if config.debug then
    print("Toggle world from [" .. value .. "]")
  end
  local other_value = config.values[value]
  if config.debug then
    print("Toggle world to [" .. other_value .. "]")
  end
  if other_value ~= nil then
    vim.cmd('normal! "' .. config.register .. "ciw" .. other_value)
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
