module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessChangeStateStep", package.seeall)

local var_0_0 = class("EliminateChessChangeStateStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.x
	local var_1_1 = arg_1_0._data.y
	local var_1_2 = arg_1_0._data.fromState
	local var_1_3 = LengZhou6EliminateChessItemController.instance:getChessItem(var_1_0, var_1_1)

	if var_1_3 == nil then
		logError("步骤 ChangeState 棋子：" .. var_1_0, var_1_1 .. "不存在")
		arg_1_0:onDone(true)

		return
	end

	var_1_3:changeState(var_1_2, var_1_0, var_1_1)
	arg_1_0:onDone(true)
end

return var_0_0
