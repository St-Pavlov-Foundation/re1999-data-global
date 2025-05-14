module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessShowStartStep", package.seeall)

local var_0_0 = class("EliminateChessShowStartStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data

	EliminateChessController.instance:openNoticeView(true, false, false, false, 0, var_1_0, arg_1_0._onPlayEnd, arg_1_0)
end

function var_0_0._onPlayEnd(arg_2_0)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.Match3ChessBeginViewClose)
	arg_2_0:onDone(true)
end

return var_0_0
