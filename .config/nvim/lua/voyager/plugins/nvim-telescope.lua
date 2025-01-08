return  {
	  'nvim-telescope/telescope.nvim',
      dependencies =  { 
          'nvim-lua/plenary.nvim',
          'nvim-tree/nvim-web-devicons',
          {'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
          },
          "folke/todo-comments.nvim",
      },
      config = function()
          local builtin = require('telescope.builtin')
          local telescope = require('telescope')
          local actions = require('telescope.actions')
          local transform_mod = require("telescope.actions.mt").transform_mod

          local trouble = require("trouble")
          local trouble_telescope = require("trouble.sources.telescope")

          -- or create your custom action
          local custom_actions = transform_mod({
              open_trouble_qflist = function(prompt_bufnr)
                  trouble.toggle("quickfix")
              end,
          })

          telescope.setup({
              defaults = {
                  mappings = {
                      i = {
                          ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                          ["<C-j>"] = actions.move_selection_next, -- move to next result
                          ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
                          ["<C-t>"] = trouble_telescope.open,
                      },
                  },
              },
          })

          telescope.load_extension("fzf")




          vim.keymap.set('n', '<leader>pf', function()
              builtin.find_files({follow=true});
          end)
          vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = 'Telescope find files'})
          vim.keymap.set('n', '<leader>pc', builtin.live_grep, {desc = 'Telescope live grep'})
          vim.keymap.set('n', '<leader>ps', builtin.grep_string, {desc = 'Telescope grep string under cursor'})
          vim.keymap.set('n', '<leader>pb', builtin.buffers, {desc = 'Telescope buffers'})
          vim.keymap.set('n', '<leader>ph', builtin.help_tags, {desc = 'Telescope help tags'})
          vim.keymap.set('n', '<leader>pt', '<cmd>TodoTelescope<cr>', {desc = 'Find todos'})

      end
}

