vim.filetype.add({
  pattern = {
    ['.*'] = {
      -- Use a very low priority so this acts as a fallback for files that 
      -- don't already match standard extensions (like .py)
      priority = -math.huge,
      function(path, bufnr)
        -- Grab the first line of the buffer
        local first_line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
        
        -- Check if it contains the uv run shebang
        if first_line and first_line:match('^#!.*uv%s+run%s+%-%-script') then
          return 'python'
        end
      end
    }
  }
})
