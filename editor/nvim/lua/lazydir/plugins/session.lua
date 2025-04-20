local spec = {
  {
    "rmagatti/auto-session",
    cmd = { "AutoSession", "SessionSave", "SessionRestore", "SessionRestoreFromFile" },
    keys = { "<leader>ss", "<leader>sr" },
    config = function()
      local dir = os.getenv("XDG_CACHE_HOME") .. "/nvim_sessions/"
      local session = require("auto-session")
      session.setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "/Users", "/", "/home" },
        auto_save_enabled = false,
        auto_restore_enabled = false,
        auto_session_enable_last_session = false,
        auto_session_root_dir = dir
      })

      utils.keymap("n", "<leader>sr",
        function(a)
          session.RestoreSession(a)
          print('Restored Session!')
        end,
        { desc = "Restore Session" })
      utils.keymap("n", "<leader>ss",
        function(a)
          session.SaveSession(a)
          print('Saved Session!')
        end,
        { desc = "Save Session" })
    end
  }

}
return spec
