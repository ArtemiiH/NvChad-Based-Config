return {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}