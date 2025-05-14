module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessShowEndStep", package.seeall)

local var_0_0 = class("EliminateChessShowEndStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.time

	arg_1_0._cb = arg_1_0._data.cb

	local var_1_1 = arg_1_0._data.needShowEnd
	local var_1_2 = EliminateTeamChessEnum.matchToTeamChessStepTime
	local var_1_3 = math.min(var_1_0, var_1_2)

	if var_1_1 then
		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.Match3ChessEndViewOpen)
		EliminateChessController.instance:openNoticeView(false, true, false, false, 0, var_1_3, nil, nil)
	end

	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, var_1_2)
end

function var_0_0._onDone(arg_2_0)
	if arg_2_0._cb then
		arg_2_0._cb()
	end

	var_0_0.super._onDone(arg_2_0)
end

return var_0_0
