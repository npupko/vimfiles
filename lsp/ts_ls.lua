local function get_typescript_path()
  local tsserver_bin = vim.fn.trim(vim.fn.system("mise which tsserver 2>/dev/null"))
  if tsserver_bin ~= "" then
    local root = vim.fn.fnamemodify(tsserver_bin, ":h:h")
    local tsserver_js = root .. "/node_modules/typescript/lib/tsserver.js"
    if vim.fn.filereadable(tsserver_js) == 1 then
      return tsserver_js
    end
  end
end

return {
  init_options = {
    tsserver = {
      path = get_typescript_path(),
    },
  },
}
