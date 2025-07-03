module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessArrange_XYStep", package.seeall)

local var_0_0 = class("EliminateChessArrange_XYStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	if arg_1_0._data == nil or #arg_1_0._data < 1 then
		arg_1_0:onDone(true)

		return
	end

	for iter_1_0, iter_1_1 in ipairs(arg_1_0._data) do
		local var_1_0 = iter_1_1.x
		local var_1_1 = iter_1_1.y
		local var_1_2 = iter_1_1.viewItem

		if var_1_2 ~= nil then
			LengZhou6EliminateChessItemController.instance:updateChessItem(var_1_0, var_1_1, var_1_2)
		else
			local var_1_3 = LengZhou6EliminateChessItemController.instance:getChessItem(var_1_0, var_1_1)
			local var_1_4 = var_1_3:getData()
			local var_1_5 = var_1_4.x
			local var_1_6 = var_1_4.y
			local var_1_7 = LengZhou6EliminateChessItemController.instance:getChessItem(var_1_5, var_1_6)

			LengZhou6EliminateChessItemController.instance:updateChessItem(var_1_0, var_1_1, var_1_7)
			LengZhou6EliminateChessItemController.instance:updateChessItem(var_1_5, var_1_6, var_1_3)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
