local colorscheme = "tokyonight"

if not pcall(vim.cmd, "colorscheme " .. colorscheme) then
  print("failed to set colorscheme")
  return
end
