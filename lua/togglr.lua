local M = {}

local config = {
  -- Set "key" to false when calling "setup()" in order to disable the
  -- keymapping.
  key = "<Leader>tw",
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
    ["addClass"] = "removeClass"
  }
}

function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})

  if config.key then
    vim.cmd("noremap " .. opts.key ..
                " :lua require('togglr').toggle_word()<cr>")
  end

  -- add the reverse mappings to the hash
  for key, value in pairs(config.values) do
    config.values[value] = key
  end
end

function M.toggle_word()
  local value = vim.fn.expand("<cword>")
  local other_value = config.values[value]
  if other_value ~= nil then
    vim.cmd("normal! \"" .. config.register .. "ciw" .. other_value)
  end
end

function M.add(value1, value2)
  config.values[value1] = value2
  config.values[value2] = value1
end

return M
