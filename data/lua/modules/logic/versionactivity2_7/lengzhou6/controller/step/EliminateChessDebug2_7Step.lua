module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessDebug2_7Step", package.seeall)

local var_0_0 = class("EliminateChessDebug2_7Step", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	if not isDebugBuild then
		arg_1_0:onDone(true)

		return
	end

	local var_1_0 = LengZhou6EliminateChessItemController.instance:getChess()
	local var_1_1 = LocalEliminateChessModel.instance:getAllCell()
	local var_1_2 = "\n"

	for iter_1_0 = #var_1_0, 1, -1 do
		local var_1_3 = ""

		for iter_1_1 = 1, #var_1_0[iter_1_0] do
			local var_1_4 = 0
			local var_1_5 = -1

			if var_1_0[iter_1_1][iter_1_0] ~= nil then
				local var_1_6 = var_1_0[iter_1_1][iter_1_0]:getData()

				if var_1_6 ~= nil then
					local var_1_7 = var_1_6:getStatus()

					for iter_1_2 = 1, #var_1_7 do
						var_1_4 = var_1_4 + var_1_7[iter_1_2]
					end

					var_1_5 = var_1_6.id
				end
			end

			var_1_3 = var_1_3 .. var_1_5 .. "[" .. var_1_4 .. "]" .. " "
		end

		var_1_2 = var_1_2 .. var_1_3 .. "\n"
	end

	local var_1_8 = "\n"

	for iter_1_3 = #var_1_1, 1, -1 do
		local var_1_9 = ""

		for iter_1_4 = 1, #var_1_1[iter_1_3] do
			local var_1_10 = var_1_1[iter_1_4][iter_1_3]
			local var_1_11 = var_1_10:getStatus()
			local var_1_12 = 0

			for iter_1_5 = 1, #var_1_11 do
				var_1_12 = var_1_12 + var_1_11[iter_1_5]
			end

			var_1_9 = var_1_9 .. var_1_10.id .. "[" .. var_1_12 .. "]" .. " "
		end

		var_1_8 = var_1_8 .. var_1_9 .. "\n"
	end

	logNormal("chessStr = " .. var_1_2)
	logNormal("chessMOStr = " .. var_1_8)
	arg_1_0:onDone(true)
end

return var_0_0
