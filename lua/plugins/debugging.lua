return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "mfussenegger/nvim-dap-python", -- Python support
      "rcarriga/nvim-dap-ui", -- DAP UI
      "nvim-neotest/nvim-nio", -- Neotest integration
      "williamboman/mason.nvim", -- Mason package manager
      "LiadOz/nvim-dap-repl-highlights", -- Syntax highlighting for DAP REPL
      "theHamsta/nvim-dap-virtual-text", -- Inline variable values in DAP REPL using Treesitter
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"
      local dap_virtual_text = require "nvim-dap-virtual-text"

      -- Setup dap-ui
      dapui.setup()

      -- Set up dap-python with the python3 executable or path to your python interpreter
      require("dap-python").setup(vim.fn.exepath "python3") -- This will get the full path of python3 executable

      -- Python debugging configuration
      dap.configurations.python = {
        {
          name = "Launch Python File",
          type = "python",
          request = "launch",
          program = "${file}", -- Launch the currently open Python file
          pythonPath = function()
            return vim.fn.exepath "python3" -- Resolve full path to the python3 interpreter
          end,
        },
      }

      -- Add C/C++ Debugger (lldb)
      dap.adapters.lldb = {
        type = "executable",
        command = "/usr/lib/llvm-14/bin/lldb-vscode", -- Replace with the actual path to your lldb binary
        name = "lldb",
      }

      -- Enhanced helper function to compile the C/C++ file if the binary does not exist or force recompilation
      local function compile_cpp_file()
        -- Get the current file's name (without extension)
        local file_name = vim.fn.expand "%:t:r" -- Removes the extension (e.g., main.cpp -> main)
        local file_dir = vim.fn.expand "%:p:h" -- Get the directory of the current file
        local output_binary = file_dir .. "/" .. file_name -- Path to the output binary with same name as file

        -- Debug information
        print("File name: " .. file_name)
        print("File directory: " .. file_dir)
        print("Target binary: " .. output_binary)

        -- Always remove the existing binary (if any) to ensure we are recompiling
        if vim.fn.filereadable(output_binary) == 1 then
          print("Removing old binary: " .. output_binary)
          vim.fn.delete(output_binary) -- More reliable than os.remove in Neovim context
        end

        -- Determine compiler based on file extension
        local file_ext = vim.fn.expand "%:e" -- Get file extension
        local compiler_cmd = "gcc" -- Default to gcc

        if file_ext == "cpp" or file_ext == "cxx" or file_ext == "cc" then
          compiler_cmd = "g++"
        end

        -- Compile the file with debugging symbols and no optimization
        local compile_cmd = string.format(
          "%s -g -O0 %s -o %s",
          compiler_cmd,
          vim.fn.shellescape(vim.fn.expand "%:p"),
          vim.fn.shellescape(output_binary)
        )

        print("Compile command: " .. compile_cmd) -- Log the compile command

        -- Execute the compile command
        local compile_result = vim.fn.system(compile_cmd)

        -- Check if the compilation was successful
        if vim.v.shell_error == 0 then
          print("Compilation successful, binary created: " .. output_binary)
          return output_binary -- Return the path to the binary if successful
        else
          print("Compilation failed: " .. compile_result)
          vim.notify("Compilation failed: " .. compile_result, vim.log.levels.ERROR)
          return nil -- Return nil if compilation failed
        end
      end

      -- Update dap configuration for C++
      dap.configurations.cpp = {
        {
          name = "Launch Program",
          type = "lldb",
          request = "launch",
          program = function()
            return compile_cpp_file() or vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false, -- Change this to false
          args = {},
          runInTerminal = false,
          env = function()
            local variables = {}
            for k, v in pairs(vim.fn.environ()) do
              table.insert(variables, string.format("%s=%s", k, v))
            end
            return variables
          end,
        },
      }
      -- Use the same configuration for C files
      dap.configurations.c = dap.configurations.cpp

      -- Update the dap configuration for Rust
      dap.configurations.rust = {
        {
          name = "Launch Rust Program",
          type = "lldb",
          request = "launch",
          program = function()
            -- For Rust, try to use cargo build first
            local cargo_toml = vim.fn.findfile("Cargo.toml", vim.fn.getcwd() .. ";")
            if cargo_toml ~= "" then
            -- Cargo build logic...
            else
              -- Fallback to direct compilation
              return compile_cpp_file() or vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false, -- Change this to false
          stopAtEntry = true, -- Add this to stop at the main function
          args = {},
        },
      }
      -- .NET Debugger (netcoredbg) - Optional if needed
      local netcoredbg = vim.fn.exepath "netcoredbg"
      if netcoredbg ~= "" then
        dap.adapters.coreclr = {
          type = "executable",
          command = "netcoredbg",
          args = { "--interpreter=vscode" },
        }

        dap.configurations.cs = {
          {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
          },
        }
      end

      -- Track debugging state
      local debug_running = false

      -- Debugging Keybindings
      vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end, { desc = "Set Conditional Breakpoint" })
      vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
      vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<leader>dp", dap.step_back, { desc = "Step Back" })
      vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart Debugging" })

      vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go Up in Call Stack" })
      vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go Down in Call Stack" })

      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle Debug UI" })
      vim.keymap.set("n", "<leader>dh", function()
        require("dap.ui.widgets").hover()
      end, { desc = "Hover Variables" })
      vim.keymap.set("n", "<leader>ds", function()
        require("dap.ui.widgets").scopes()
      end, { desc = "Show Scopes" })

      vim.keymap.set("n", "<leader>dx", function()
        dap.clear_breakpoints()
      end, { desc = "Clear All Breakpoints" })

      -- Stop debugging and close UI
      vim.keymap.set("n", "<leader>dq", function()
        debug_running = false
        dap.terminate()
        dapui.close()
        vim.cmd "silent! :bdelete! term://*" -- Close terminal buffers if any
      end, { desc = "Stop Debugging & Close UI" })

      -- Modified DAP event listeners
      -- Open UI when debugger initializes
      dap.listeners.after.event_initialized["dapui_config"] = function()
        debug_running = true
        dapui.open()
      end

      -- Don't automatically close UI on program termination
      dap.listeners.before.event_terminated["dapui_config"] = function()
        -- We keep the UI open even when the program terminates
        -- This allows examining variables after program ends
        vim.defer_fn(function()
          if debug_running then
            vim.notify("Program terminated but debug UI remains open", vim.log.levels.INFO)
          end
        end, 300)
      end

      -- Don't automatically close UI on program exit
      dap.listeners.before.event_exited["dapui_config"] = function()
        -- We keep the UI open even when the program exits
        -- This allows examining variables after program ends
        vim.defer_fn(function()
          if debug_running then
            vim.notify("Program exited but debug UI remains open", vim.log.levels.INFO)
          end
        end, 300)
      end

      -- Enable virtual text in DAP for inline variable values using Treesitter
      dap_virtual_text.setup()

      -- Setup DAP REPL Syntax Highlighting
      require("nvim-dap-repl-highlights").setup()

      -- Add a command to toggle the debug UI visibility
      vim.api.nvim_create_user_command("DebugUIToggle", function()
        dapui.toggle()
      end, {})

      -- Add command to explicitly close the debug session
      vim.api.nvim_create_user_command("DebugStop", function()
        debug_running = false
        dap.terminate()
        vim.defer_fn(function()
          dapui.close()
        end, 100)
      end, {})
    end,
  },
}
