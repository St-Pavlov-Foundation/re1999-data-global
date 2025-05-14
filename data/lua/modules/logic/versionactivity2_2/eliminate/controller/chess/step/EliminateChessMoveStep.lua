module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessMoveStep", package.seeall)

local var_0_0 = class("EliminateChessMoveStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.chessItem
	local var_1_1 = arg_1_0._data.time
	local var_1_2 = arg_1_0._data.animType

	if not var_1_1 or not var_1_0 then
		logError("步骤 Move 参数错误")
		arg_1_0:onDone(true)

		return
	end

	EliminateStepUtil.putMoveStepTable(arg_1_0._data)
	var_1_0:toMove(var_1_1, var_1_2, arg_1_0._onDone, arg_1_0)
end

return var_0_0
