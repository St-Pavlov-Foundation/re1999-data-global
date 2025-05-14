module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessDebugStep", package.seeall)

local var_0_0 = class("EliminateChessDebugStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = EliminateChessItemController.instance:getChess()
	local var_1_1 = EliminateChessModel.instance:getChessMoList()
	local var_1_2 = "\n"

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		for iter_1_2, iter_1_3 in ipairs(iter_1_1) do
			if iter_1_3._data then
				var_1_2 = var_1_2 .. " " .. tostring(iter_1_3._data.id)
			else
				var_1_2 = var_1_2 .. " " .. "-1"
			end
		end

		var_1_2 = var_1_2 .. "\n"
	end

	local var_1_3 = "\n"

	for iter_1_4, iter_1_5 in ipairs(var_1_1) do
		for iter_1_6, iter_1_7 in ipairs(iter_1_5) do
			if iter_1_7 then
				var_1_3 = var_1_3 .. " " .. tostring(iter_1_7.id)
			else
				var_1_3 = var_1_3 .. " " .. "-1"
			end
		end

		var_1_3 = var_1_3 .. "\n"
	end

	logNormal("chessStr = " .. var_1_2)
	logNormal("chessMOStr = " .. var_1_3)
	arg_1_0:onDone(true)
end

return var_0_0
