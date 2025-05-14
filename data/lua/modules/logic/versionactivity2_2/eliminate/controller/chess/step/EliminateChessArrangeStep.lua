module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessArrangeStep", package.seeall)

local var_0_0 = class("EliminateChessArrangeStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	if arg_1_0._data == nil or #arg_1_0._data < 1 then
		arg_1_0:onDone(true)

		return
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._data) do
		local var_1_0 = iter_1_1.model
		local var_1_1 = iter_1_1.viewItem

		if var_1_0 and var_1_1 then
			EliminateChessItemController.instance:updateChessItem(var_1_0.x, var_1_0.y, var_1_1)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
