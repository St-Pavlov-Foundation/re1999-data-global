module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessUpdateActiveMoveStep", package.seeall)

local var_0_0 = class("EliminateTeamChessUpdateActiveMoveStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data
	local var_1_1 = var_1_0.uid
	local var_1_2 = var_1_0.displacementState

	if var_1_1 == nil or var_1_2 == nil then
		arg_1_0:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateDisplacementState(var_1_1, var_1_2)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessUpdateActiveMoveState, var_1_1)
	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime)
end

return var_0_0
