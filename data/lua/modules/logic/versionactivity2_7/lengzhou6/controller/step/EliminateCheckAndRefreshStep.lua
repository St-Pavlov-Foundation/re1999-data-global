module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateCheckAndRefreshStep", package.seeall)

local var_0_0 = class("EliminateCheckAndRefreshStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = LocalEliminateChessModel.instance:canEliminate()

	if var_1_0 == nil or #var_1_0 < 3 then
		LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.ClearEliminateEffect)
		LocalEliminateChessModel.instance:createInitMoveState()
		LengZhou6EliminateController.instance:createInitMoveStepAndUpdatePos()
	end

	arg_1_0:onDone(true)
end

return var_0_0
