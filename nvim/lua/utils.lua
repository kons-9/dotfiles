local M = {}

function M.keymap(mode, key, result, opts, lazy_nvim)
  if opts == nil then
    opts = {
      silent = true,
      nowait = false,
      expr = false,
      noremap = true,
    }
  end

  if opts.desc == nil then
    opts.desc = true
  end

  if lazy_nvim == nil then
    vim.api.nvim_set_keymap(mode, key, result, opts)
  end

  -- return is for lazy.nvim
  return {key, {result, opts}}
end

-- args contains augroup and autocmds
function M.make_autocmds(args)

  if args.augroup then
    vim.api.nvim_create_augroup(args.augroup, {clear = true})
  end
  for i, v in ipairs(args.autocmds) do
    local event = v[1]
    local command = v[2]

    if args.augroup then
      command.group = args.augroup
    end
    vim.api.nvim_create_autocmd(event, command)
  end
end

function M.safe_require(module, callback)
  local ok, safe_module = pcall(require, module)
  if ok then
    if callback then
      callback(safe_module)
    end
  else
    print("Error loading module " .. module)
  end
  return ok, safe_module
end



_G["utils"] = M
_G["g"] = vim.g
