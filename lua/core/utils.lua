local function file_exists(name)
	local f = io.open(name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

local function substitute(cmd)
	cmd = cmd:gsub("%%", vim.fn.expand("%"))
	cmd = cmd:gsub("$fileBase", vim.fn.expand("%:r"))
	cmd = cmd:gsub("$filePath", vim.fn.expand("%:p"))
	cmd = cmd:gsub("$file", vim.fn.expand("%"))
	cmd = cmd:gsub("$dir", vim.fn.expand("%:p:h"))
	cmd = cmd:gsub(
		"$moduleName",
		vim.fn.substitute(
			vim.fn.substitute(vim.fn.fnamemodify(vim.fn.expand("%:r"), ":~:."), "/", ".", "g"),
			"\\",
			".",
			"g"
		)
	)
	cmd = cmd:gsub("#", vim.fn.expand("#"))
	cmd = cmd:gsub("$altFile", vim.fn.expand("#"))

	return cmd
end

function _G.run_code()
	local fileExtension = vim.fn.expand("%:e")
	local selectedCmd = ""
	local options = "bot 10 new | term "
	local supportedFiletypes = {
		html = {
			default = "%",
		},
		c = {
			default = "gcc % -o $fileBase && $fileBase",
			debug = "gcc -g % -o $fileBase && $fileBase",
			make = "make clean && make && ./$fileBase",
		},
		cs = {
			default = "dotnet run",
		},
		cpp = {
			default = "g++ % -o  $fileBase && $fileBase",
			debug = "g++ -g % -o  $fileBase",
			make = "make clean && make && ./$fileBase",
		},
		py = {
			default = "python %",
		},
		go = {
			default = "go run %",
		},
		java = {
			default = "java %",
		},
		js = {
			default = "node %",
			debug = "node --inspect %",
		},
		ts = {
			default = "tsc % && node $fileBase",
		},
		rs = {
			-- default = "rustc % && $fileBase",
			default = "cargo run",
		},
		php = {
			default = "php %",
		},
		r = {
			default = "Rscript %",
		},
		jl = {
			default = "julia %",
		},
		rb = {
			default = "ruby %",
		},
		pl = {
			default = "perl %",
		},
		scala = {
			default = "scala %",
		},
		ml = {
			default = "ocaml %",
		},
	}

	if supportedFiletypes[fileExtension] then
		local choices = {}
		for choice, _ in pairs(supportedFiletypes[fileExtension]) do
			table.insert(choices, choice)
		end

		if #choices == 0 then
			vim.notify("It doesn't contain any command", vim.log.levels.WARN, { title = "Code Runner" })
		elseif #choices == 1 then
			selectedCmd = supportedFiletypes[fileExtension][choices[1]]
			vim.cmd(options .. substitute(selectedCmd))
		else
			vim.ui.select(choices, { prompt = "Choose: " }, function(choice)
				selectedCmd = supportedFiletypes[fileExtension][choice]
				if selectedCmd then
					vim.cmd(options .. substitute(selectedCmd))
				end
			end)
		end
	else
		vim.notify("The filetype isn't included in the list", vim.log.levels.WARN, { title = "Code Runner" })
	end
end

P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(module)
	package.loaded[module] = nil
	return require(module)
end

R = function(name)
	RELOAD(name)
	return require(name)
end

------------------ pytest TestOnSave ------------------

local cmd = {
	"pytest",
	"--json-report",
	"--json-report-file=/dev/stderr",
	"-q",
	"--no-header",
	"--no-summary",
}

local attach_to_buffer = function(bufnr, command)
	local group = vim.api.nvim_create_augroup("TestOnSave", { clear = true })
	local ns = vim.api.nvim_create_namespace("TestOnSave")

	local state = {
		bufnr = bufnr,
		tests = {},
		summary = {},
	}

	local add_test = function(entry)
		local message = ""
		if entry.call.longrepr then
			message = entry.call.longrepr
		end

		state.tests[entry.nodeid] = {
			outcome = entry.outcome,
			nodeid = entry.nodeid,
			test = entry.keywords[1],
			file = entry.keywords[2],
			line_number = entry.lineno,
			message = message,
		}
	end

	vim.api.nvim_create_user_command("TestLineDiag", function()
		local line = vim.fn.line(".") - 1
		for _, test in pairs(state.tests) do
			if test.line_number == line then
				vim.notify(test.message, vim.log.levels.ERROR, {
					title = test.nodeid,
					on_open = function(win)
						local buf = vim.api.nvim_win_get_buf(win)
						vim.api.nvim_buf_set_option(buf, "filetype", "python")
					end,
				})
			end
		end
	end, {})

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		pattern = "*.py",
		callback = function()
			vim.fn.jobstart(command, {
				stdout_buffered = true,
				stderr_buffered = true,
				on_stderr = function(_, data)
					if not data then
						return
					end

					local decoded = vim.fn.json_decode(data)
					if not decoded then
						return
					else
						state.summary = decoded.summary
					end

					local tests = decoded.tests
					if not tests then
						return
					end

					vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

					for _, line in pairs(tests) do
						add_test(line)
						if state.tests[line.nodeid].outcome == "passed" then
							local text = { "✓", "DiagnosticOK" }
							vim.api.nvim_buf_set_extmark(bufnr, ns, state.tests[line.nodeid].line_number, 0, {
								virt_text = { text },
							})
						end
					end
				end,
				on_exit = function()
					local failed = {}
					for _, test in pairs(state.tests) do
						if test.outcome == "failed" then
							table.insert(failed, {
								bufnr = bufnr,
								lnum = test.line_number,
								col = 0,
								severity = vim.lsp.protocol.DiagnosticSeverity.Error,
								source = "pytest",
								message = "Test failed",
								user_data = {},
							})
						end
					end
					vim.diagnostic.set(ns, bufnr, failed, {})
					if state.summary.total == state.summary.passed then
						vim.notify("All tests passed", vim.log.levels.INFO, {
							title = state.summary.total .. " tests completed",
						})
					else
						vim.notify(
							"Passed: " .. state.summary.passed .. "\nFailed: " .. state.summary.failed,
							vim.log.levels.WARN,
							{
								title = state.summary.total .. " tests completed",
							}
						)
					end
				end,
			})
		end,
	})
end

vim.api.nvim_create_user_command("TestOnSave", function()
	attach_to_buffer(vim.api.nvim_get_current_buf(), cmd)
end, {})
