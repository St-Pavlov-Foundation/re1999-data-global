module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessCheckStep", package.seeall)

local var_0_0 = class("EliminateChessCheckStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data

	LengZhou6EliminateController.instance:eliminateCheck(var_1_0)
	arg_1_0:onDone(true)
end

return var_0_0
