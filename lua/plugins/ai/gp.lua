return {
  "robitx/gp.nvim",
  cmd = { "GpChatNew", "GpChatToggle", "GpChatRespond", "GpPopup" },
  config = function()
    require("gp").setup({
      -- use OpenAI by default
      provider = "openai",
      openai_params = {
        model = "gpt-4o",
      },
      -- max buffer lines to include context
      context_lines = 500,
    })

    -- Keymaps
    -- :GpChatNew        -- Start a new chat buffer with AI
    -- :GpChatToggle     -- Toggle visibility of the current GP chat
    -- :GpChatRespond    -- Respond to the last AI message
    -- :GpChatPaste      -- Paste selection into current chat
    -- :GpChatStop       -- Cancel an ongoing AI response
    -- :GpAppend         -- Append AI result after current line
    -- :GpPrepend        -- Prepend AI result before current line
    -- :GpRewrite        -- Rewrite selected lines using AI
    -- :GpImplement      -- Implement selected code (useful for stubs)
    -- :GpExplain        -- Explain selected code using AI
    -- :GpFix            -- Try to fix errors in selected code
    -- :GpDocs           -- Generate documentation for selected code
    -- :GpUnitTests      -- Generate unit tests for selected code
    -- :GpPopup          -- Open a one-shot popup prompt
    -- :GpContext        -- Print the context sent to the model
    -- :GpCommand        -- One-line prompt from command-line mode
    -- :GpActAs          -- Let AI act as a persona (e.g., "Python Tutor")
    -- :GpRun            -- Run custom AI instructions on selection
  end,
}
