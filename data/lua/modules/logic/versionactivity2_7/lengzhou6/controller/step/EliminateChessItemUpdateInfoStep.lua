module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessItemUpdateInfoStep", package.seeall)

local var_0_0 = class("EliminateChessItemUpdateInfoStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.x
	local var_1_1 = arg_1_0._data.y

	if var_1_0 == nil or var_1_1 == nil then
		arg_1_0:onDone(true)

		return
	end

	local var_1_2 = LocalEliminateChessModel.instance:changeCellId(var_1_0, var_1_1, EliminateEnum_2_7.ChessTypeToIndex.stone)
	local var_1_3 = LengZhou6EliminateChessItemController.instance:getChessItem(var_1_0, var_1_1)

	if var_1_2 ~= nil and var_1_3 ~= nil then
		var_1_3:initData(var_1_2)
	end

	arg_1_0:onDone(true)
end

return var_0_0
