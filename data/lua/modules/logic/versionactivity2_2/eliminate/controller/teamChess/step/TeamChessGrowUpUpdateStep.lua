module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessGrowUpUpdateStep", package.seeall)

local var_0_0 = class("TeamChessGrowUpUpdateStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data
	local var_1_1 = var_1_0.uid
	local var_1_2 = var_1_0.skillId
	local var_1_3 = var_1_0.upValue

	if var_1_1 == nil or var_1_2 == nil or var_1_3 == nil then
		arg_1_0:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateSkillGrowUp(var_1_1, var_1_2, var_1_3)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessGrowUpSkillChange, var_1_1, var_1_2, var_1_3)
	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime)
end

return var_0_0
