if vim.g.togglr_key == nil then
  vim.g.togglr_key = "<Leader>tw"
end

if vim.g.togglr_register == nil then
  vim.g.togglr_register = "t"
end

local togglr_values = {
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

-- add the reverse mappings to the hash
for key, value in pairs(togglr_values) do
  togglr_values[value] = key
end

function _G.ToggleWord()
  local value = vim.fn.expand("<cword>")
  local other_value = togglr_values[value]
  if other_value ~= nil then
    vim.cmd("normal! \"" .. vim.g.togglr_register .. "ciw" .. other_value)
  end
end

vim.cmd("noremap " .. vim.g.togglr_key .. " :lua ToggleWord()<cr>")

local M = {}
function M.add(value1, value2)
  togglr_values[value1] = value2
  togglr_values[value2] = value1
end
return M
