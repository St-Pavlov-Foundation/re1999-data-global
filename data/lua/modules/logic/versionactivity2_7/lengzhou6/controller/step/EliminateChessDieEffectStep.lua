module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessDieEffectStep", package.seeall)

local var_0_0 = class("EliminateChessDieEffectStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.x
	local var_1_1 = arg_1_0._data.y
	local var_1_2 = arg_1_0._data.skillEffect

	arg_1_0.chess = LengZhou6EliminateChessItemController.instance:getChessItem(var_1_0, var_1_1)

	if arg_1_0.chess == nil then
		logWarn("步骤 DieEffect 棋子：" .. var_1_0, var_1_1 .. "不存在")
		arg_1_0:onDone(true)

		return
	end

	arg_1_0.chess:toDie(EliminateEnum.AniTime.Die, var_1_2)
	LengZhou6EliminateChessItemController.instance:updateChessItem(var_1_0, var_1_1, nil)
	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, EliminateEnum_2_7.DieStepTime)
end

return var_0_0
