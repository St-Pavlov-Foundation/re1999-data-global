module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.StrongHoldPowerChangeStep", package.seeall)

local var_0_0 = class("StrongHoldPowerChangeStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data

	if var_1_0.teamType == nil or var_1_0.diffValue == nil or var_1_0.strongholdId == nil then
		arg_1_0:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateStrongholdsScore(var_1_0.strongholdId, var_1_0.teamType, var_1_0.diffValue)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.StrongHoldPowerChange, var_1_0.strongholdId, var_1_0.teamType, var_1_0.diffValue)
	arg_1_0:onDone(true)
end

return var_0_0
