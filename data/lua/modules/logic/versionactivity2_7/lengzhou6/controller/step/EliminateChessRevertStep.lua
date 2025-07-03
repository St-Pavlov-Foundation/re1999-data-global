module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessRevertStep", package.seeall)

local var_0_0 = class("EliminateChessRevertStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	LengZhou6EliminateController.instance:revertRecord()
	arg_1_0:onDone(true)
end

return var_0_0
