local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

comment.setup {
    ---Add a space b/w comment and the line
    padding = true,

    ---Whether the cursor should stay at its position
    ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
    sticky = true,

    ---Lines to be ignored while comment/uncomment.
    ---Could be a regex string or a function that returns a regex string.
    ---Example: Use '^$' to ignore empty lines
    ignore = nil,

    ---LHS of toggle mappings in NORMAL + VISUAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = '<leader>cc',
        ---Block-comment toggle keymap
        block = '<leader>cb',
    },

    ---LHS of operator-pending mappings in NORMAL + VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = '<leader>cc',
        ---Block-comment keymap
        block = '<leader>cb',
    },

    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = '<leader>cO',
        ---Add comment on the line below
        below = '<leader>co',
        ---Add comment at the end of line
        eol = '<leader>cA',
    },

    ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    ---NOTE: If `mappings = false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping
        ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
        basic = true,
        ---Extra mapping
        extra = true,
        ---Extended mapping
        extended = false,
    },

    ---Pre-hook, called before commenting the line
    pre_hook = nil,

    ---Post-hook, called after commenting is done
    post_hook = nil,
}
