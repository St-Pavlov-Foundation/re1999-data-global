module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessBeginStep", package.seeall)

local var_0_0 = class("EliminateTeamChessBeginStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.time

	EliminateChessController.instance:openNoticeView(false, false, true, false, 0, var_1_0, nil, nil)
	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, var_1_0)
end

function var_0_0._onDone(arg_2_0)
	local var_2_0 = EliminateLevelModel.instance:getRoundNumber()
	local var_2_1 = EliminateLevelModel.instance:getLevelId()

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessRoundBegin, string.format("%s_%s", var_2_1, var_2_0))
	var_0_0.super._onDone(arg_2_0)
end

return var_0_0
