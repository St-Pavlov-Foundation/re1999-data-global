module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.ResourceDataChangeStep", package.seeall)

local var_0_0 = class("ResourceDataChangeStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data.resourceIdMap

	if var_1_0 == nil then
		arg_1_0:onDone(true)

		return
	end

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		EliminateTeamChessModel.instance:updateResourceData(iter_1_0, iter_1_1)
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ResourceDataChange, var_1_0)
	arg_1_0:onDone(true)
end

return var_0_0
