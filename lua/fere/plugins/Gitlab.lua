return {
  'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
  event = { 'BufReadPre', 'BufNewFile' },
  ft = { 'javascript', 'python' },
  opts = {
    statusline = {
      enabled = true,
    },
  },
}
