# Togglr

Togglr is a Neovim plugin that toggles boolean values (by pressing `<Leader>tw` in normal mode):

- true &harr; false
- on &harr; off
- enabled &harr; disabled
- left &harr; right
- top &harr; bottom
- margin-left &harr; margin-right
- etc...

## Installation

Using Lazy:

```lua
{
  "elentok/togglr.nvim",
  opts = {}
}
```

You can also customize the settings:

```lua
{
  "elentok/togglr.nvim",
  opts = {
    -- Specify key map (set to false or nil to disable)
    key = "<Leader>tw",

    -- Specify which register to use (to avoid overriding the default register)
    register = "t",

    -- Enable debugging mode
    debug = true,

    -- Add custom sets to values to toggle between
    values = {
      ["value"] = "opposite-value",
    },
  },
}
```

Using Packer:

```lua
use {
  'elentok/togglr.nvim',
  config = function()
    require('togglr').setup({
      -- options
    })
  end
}
```

If after the initial setup you want to add more values:

```lua
require('togglr').add('value', 'opposite-value')
```

To trigger the toggling manually:

```lua
require('togglr').toggle_word()
```
