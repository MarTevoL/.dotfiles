require("martevol.core")
require("martevol.lazy")

-- Load custom modules
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/user_functions", [[v:val =~ '\.lua$']])) do
  require("user_functions." .. file:gsub("%.lua$", ""))
end
