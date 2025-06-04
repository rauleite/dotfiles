-- o modulo lazy carrega o core.options antes de seu startup
require("core.lazy")
require("core.keymaps")

-- options pós-Lazy (que dependem de plugins)
require("core.options2")
