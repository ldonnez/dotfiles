vim.g.lightline = {
      colorscheme = 'nord';
      active = {
        left = { { 'mode', 'paste' }, { 'gitbranch', 'readonly', 'filename', 'modified' } };
        right = { { 'fileformat', 'fileencoding', 'filetype' } }
      };
      component_function = { gitbranch = 'fugitive#head', };
}
