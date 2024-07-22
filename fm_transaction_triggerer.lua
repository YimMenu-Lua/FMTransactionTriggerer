local fm_transaction_triggerer_tab = gui.get_tab("Server Transactions")

local transaction_name  = ""
local transaction_price = 0

fm_transaction_triggerer_tab:add_imgui(function()
	transaction_name  = ImGui.InputText("Transaction Name", transaction_name, 100)
	transaction_price = ImGui.InputInt("Transaction Price", transaction_price)
	
	if ImGui.Button("Trigger Transaction") then
		script.run_in_fiber(function()
			if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("freemode")) > 0 then
				local tempvar = 0
				local hash    = joaat(transaction_name)
				script.call_function("TST", "freemode", "2D 06 09 00 00 5D ? ? ? 06", 0, {hash, transaction_price, tempvar, 0, 1, 0}) -- TO-DO: Check args
			else
				gui.show_error("Server Transactions", "Freemode is not running.")
			end
		end)
	end
end)