module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessShowBuffEffectStep", package.seeall)

local var_0_0 = class("EliminateTeamChessShowBuffEffectStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data
	local var_1_1 = var_1_0.vxEffectType
	local var_1_2 = var_1_0.uid
	local var_1_3 = var_1_0.time
	local var_1_4 = TeamChessUnitEntityMgr.instance:getEntity(var_1_2)

	if var_1_4 == nil then
		arg_1_0:onDone(true)

		return
	end

	local var_1_5 = EliminateTeamChessEnum.VxEffectTypeToPath[var_1_1]

	if string.nilorempty(var_1_5) then
		arg_1_0:onDone(true)

		return
	end

	var_1_3 = var_1_3 or EliminateTeamChessEnum.VxEffectTypePlayTime[var_1_1]

	local var_1_6, var_1_7, var_1_8 = var_1_4:getPosXYZ()

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessEffect, var_1_1, var_1_6, var_1_7, var_1_8, var_1_3)

	if var_1_3 ~= nil then
		TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, var_1_3)
	else
		arg_1_0:onDone(true)
	end
end

return var_0_0
