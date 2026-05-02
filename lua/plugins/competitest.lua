vim.pack.add {
  'https://github.com/xeluxee/competitest.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}
require('competitest').setup {
  received_problems_path = '$(HOME)/Documents/projects/CP/$(JUDGE)/$(CONTEST)/$(PROBLEM).$(FEXT)',
  received_contests_directory = '$(HOME)/Documents/projects/CP/contests/$(JUDGE)/$(CONTEST)',
  -- /home/osk/Documents/projects/CP/templates/cpp

  -- evaluate_template_modifiers = true,
  template_file = {
    true,
    cpp = '~/Documents/projects/CP/templates/template.cpp',
    -- c = '~/path/to/file.cpp',
    -- py = '~/path/to/file.py',
  },
}
