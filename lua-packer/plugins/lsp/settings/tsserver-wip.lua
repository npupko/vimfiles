return {
  cmd = { "docker", "compose", "run", "-T", "frontend", "typescript-language-server", "--stdio" },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
    'svelte',
  },
}
