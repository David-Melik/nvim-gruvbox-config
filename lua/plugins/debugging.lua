-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation

return {
	--{

	--  "mfussenegger/nvim-dap",
	--  dependencies = {

	--    "rcarriga/nvim-dap-ui", -- DAP UI
	--    "nvim-neotest/nvim-nio", -- Neotest integration
	--    "williamboman/mason.nvim", -- Mason package manager
	--    "jay-babu/mason-nvim-dap.nvim", --Mason use the dap more easly in the plugin config
	--    "theHamsta/nvim-dap-virtual-text", -- Inline variable values in DAP REPL using Treesitter
	--    "LiadOz/nvim-dap-repl-highlights", -- Syntax highlighting for DAP REPL
	--  },
	--  config = function()
	--    local dap = require "dap"
	--    local dapui = require "dapui"
	--    local mason_dap = require "mason-nvim-dap"

	--    --Ensure that all dap is installed
	--    mason_dap.setup {
	--      ensure_installed = { "codelldb", "python" },
	--      automatic_installation = true,
	--      handlers = {
	--        function(config)
	--          require("mason-nvim-dap").default_setup(config)
	--        end,
	--      },
	--    }

	--    -- To activate external terminal (can be a security issue on the kernel)

	--    -- NOTE: fix common issue "Error on launch: Failed to attach to the target process"
	--    -- because The kernel has a security restriction called ptrace_scope, which controls how processes can be debugged
	--    -- echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
	--    -- make it permanent
	--    -- echo "kernel.yama.ptrace_scope = 0" | sudo tee -a /etc/sysctl.d/10-ptrace.conf
	--    -- sudo sysctl --system
	--    -- cat /proc/sys/kernel/yama/ptrace_scope

	--    -- NOTE: to undo that
	--    -- sudo sed -i '/kernel.yama.ptrace_scope = 0/d' /etc/sysctl.d/10-ptrace.conf
	--    -- sudo sysctl --system

	--    local function set_ptrace_scope()
	--      local set_ptrace_cmd = "echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope"
	--      vim.fn.system(set_ptrace_cmd) -- Run the command to change ptrace_scope
	--      print "ptrace_scope set to 0 (for debugging)"
	--    end

	--    dap.configurations = {
	--      python = {
	--        {
	--          -- The first three options are required by nvim-dap
	--          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
	--          request = "launch",
	--          name = "Launch file",

	--          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

	--          program = vim.fn.expand "%:p", -- Expands to the full path of the current file
	--          -- This configuration will launch the current file if used.
	--          pythonPath = function()
	--            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
	--            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
	--            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
	--            local cwd = vim.fn.getcwd()
	--            if vim.fn.executable(cwd .. "/venv/bin/python3") == 1 then
	--              return cwd .. "/venv/bin/python3"
	--            elseif vim.fn.executable(cwd .. "/.venv/bin/python3") == 1 then
	--              return cwd .. "/.venv/bin/python3"
	--            else
	--              return "/usr/bin/python3"
	--            end
	--          end,
	--          console = "integratedTerminal",
	--          preLaunchTask = set_ptrace_scope,
	--        },
	--      },
	--    }

	--    -- Function for C/C++ file if the binary does not exist or force recompilation
	--    local function compile_c_language_file()
	--      -- Get the current file's name (without extension)
	--      local file_name = vim.fn.expand "%:t:r" -- Removes the extension (e.g., main.cpp -> main)
	--      local file_dir = vim.fn.expand "%:p:h" -- Get the directory of the current file
	--      local output_binary = file_dir .. "/" .. file_name -- Path to the output binary with same name as file
	--      -- Debug information
	--      print("File name: " .. file_name)
	--      print("File directory: " .. file_dir)
	--      print("Target binary: " .. output_binary)
	--      -- Always remove the existing binary (if any) to ensure we are recompiling
	--      if vim.fn.filereadable(output_binary) == 1 then
	--        print("Removing old binary: " .. output_binary)
	--        vim.fn.delete(output_binary) -- More reliable than os.remove in Neovim context
	--      end
	--      -- Determine compiler based on file extension
	--      local file_ext = vim.fn.expand "%:e" -- Get file extension
	--      local compiler_cmd = "gcc" -- Default to gcc

	--      if file_ext == "cpp" or file_ext == "cxx" or file_ext == "cc" then
	--        compiler_cmd = "g++"
	--      end
	--      -- Compile the file with debugging symbols and no optimization
	--      local compile_cmd = string.format(
	--        "%s -g -O0 %s -o %s",
	--        compiler_cmd,
	--        vim.fn.shellescape(vim.fn.expand "%:p"),
	--        vim.fn.shellescape(output_binary)
	--      )
	--      print("Compile command: " .. compile_cmd) -- Log the compile command
	--      -- Execute the compile command
	--      local compile_result = vim.fn.system(compile_cmd)
	--      -- Check if the compilation was successful
	--      if vim.v.shell_error == 0 then
	--        print("Compilation successful, binary created: " .. output_binary)
	--        return output_binary -- Return the path to the binary if successful
	--      else
	--        print("Compilation failed: " .. compile_result)
	--        vim.notify("Compilation failed: " .. compile_result, vim.log.levels.ERROR)
	--        return nil -- Return nil if compilation failed
	--      end
	--    end

	--    -- dap configuration for C++
	--    dap.configurations.cpp = {
	--      {
	--        name = "Launch File",
	--        type = "codelldb", -- Use "lldb" as the type since codelldb is the executable for lldb
	--        request = "launch",
	--        cwd = "${workspaceFolder}",
	--        args = {},
	--        stopAtEntry = true,

	--        program = function()
	--          return compile_c_language_file() or vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
	--        end,

	--        preLaunchTask = set_ptrace_scope, -- Optional: Run the command to set ptrace_scope before launching the debugger
	--      },
	--    }
	--    dap.configurations.c = dap.configurations.cpp

	--    -- Track debugging state
	--    local debug_running = false

	--    -- Debugging Keybindings
	--    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
	--    vim.keymap.set("n", "<leader>dB", function()
	--      dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
	--    end, { desc = "Set Conditional Breakpoint" })
	--    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
	--    vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
	--    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
	--    vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
	--    vim.keymap.set("n", "<leader>dp", dap.step_back, { desc = "Step Back" })
	--    vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart Debugging" })

	--    vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go Up in Call Stack" })
	--    vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go Down in Call Stack" })

	--    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle Debug UI" })
	--    vim.keymap.set("n", "<leader>dh", function()
	--      require("dap.ui.widgets").hover()
	--    end, { desc = "Hover Variables" })
	--    vim.keymap.set("n", "<leader>ds", function()
	--      require("dap.ui.widgets").scopes()
	--    end, { desc = "Show Scopes" })

	--    vim.keymap.set("n", "<leader>dx", function()
	--      dap.clear_breakpoints()
	--    end, { desc = "Clear All Breakpoints" })
	--    -- Stop debugging and close UI
	--    vim.keymap.set("n", "<leader>dq", function()
	--      debug_running = false
	--      dap.terminate()
	--      dapui.close()
	--      vim.cmd "silent! :bdelete! term://*" -- Close terminal buffers if any
	--    end, { desc = "Stop Debugging & Close UI" })
	--    -- Open UI when debugger initializes
	--    dap.listeners.after.event_initialized["dapui_config"] = function()
	--      debug_running = true
	--      dapui.open()
	--    end
	--    -- Don't automatically close UI on program termination
	--    dap.listeners.before.event_terminated["dapui_config"] = function()
	--      -- We keep the UI open even when the program terminates
	--      -- This allows examining variables after program ends
	--      vim.defer_fn(function()
	--        if debug_running then
	--          vim.notify("Program terminated but debug UI remains open", vim.log.levels.INFO)
	--        end
	--      end, 300)
	--    end

	--    -- Don't automatically close UI on program exit
	--    dap.listeners.before.event_exited["dapui_config"] = function()
	--      -- We keep the UI open even when the program exits
	--      -- This allows examining variables after program ends
	--      vim.defer_fn(function()
	--        if debug_running then
	--          vim.notify("Program exited but debug UI remains open", vim.log.levels.INFO)
	--        end
	--      end, 300)
	--    end

	--    dapui.setup()

	--    -- Setup DAP REPL Syntax Highlighting
	--    require("nvim-dap-repl-highlights").setup()

	--    -- Add a command to toggle the debug UI visibility
	--    vim.api.nvim_create_user_command("DebugUIToggle", function()
	--      dapui.toggle()
	--    end, {})

	--    -- Add command to explicitly close the debug session
	--    vim.api.nvim_create_user_command("DebugStop", function()
	--      debug_running = false
	--      dap.terminate()
	--      vim.defer_fn(function()
	--        dapui.close()
	--      end, 100)
	--    end, {})
	--  end,
	--},
}
