module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessShowEvaluateStep", package.seeall)

local var_0_0 = class("EliminateChessShowEvaluateStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = EliminateChessModel.instance:calEvaluateLevel()

	if var_1_0 == nil then
		arg_1_0:onDone(true)

		return
	end

	EliminateChessController.instance:openNoticeView(false, false, false, true, var_1_0, EliminateEnum.ShowEvaluateTime, arg_1_0._onPlayEnd, arg_1_0)
	EliminateChessModel.instance:clearTotalCount()
end

function var_0_0._onPlayEnd(arg_2_0)
	arg_2_0:onDone(true)
end

return var_0_0
