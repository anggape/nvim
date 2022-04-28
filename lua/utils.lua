local M = {}
local modes_short = {
    ["normal_visual"] = "",
    ["normal"] = "n",
    ["insert"] = "i",
    ["visual"] = "v",
    ["terminal"] = "t",
}

M.map = function(all_bindings)
    for mode, bindings in pairs(all_bindings) do
        for key, binding in pairs(bindings) do
            local options = { noremap = true }

            if type(binding) == "table" then
                vim.tbl_extend("force", options, binding[2])
                binding = binding[1]
            end

            vim.keymap.set(modes_short[mode], key, binding, options)
        end
    end
end

return M
