" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/shxfee/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/shxfee/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/shxfee/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/shxfee/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/shxfee/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["coc.nvim"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/coc.nvim"
  },
  fzf = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/fzf"
  },
  ["fzf.vim"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/fzf.vim"
  },
  ["jellybeans.vim"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/jellybeans.vim"
  },
  ["lightline.vim"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/lightline.vim"
  },
  ["packer.nvim"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  tabular = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/tabular"
  },
  ultisnips = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-commentary"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-dadbod"
  },
  ["vim-dirvish"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-dirvish"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-dispatch"
  },
  ["vim-doge"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-doge"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-polyglot"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-polyglot"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-projectionist"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-sneak"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-sneak"
  },
  ["vim-solarized8"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-solarized8"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-test"
  },
  ["vim-wakatime"] = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vim-wakatime"
  },
  vimwiki = {
    loaded = true,
    path = "/home/shxfee/.local/share/nvim/site/pack/packer/start/vimwiki"
  }
}

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
