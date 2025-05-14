module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessPowerChangeStep", package.seeall)

local var_0_0 = class("TeamChessPowerChangeStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data
	local var_1_1 = var_1_0.needShowDamage
	local var_1_2 = var_1_0.reasonId

	if var_1_0.uid == nil or var_1_0.diffValue == nil then
		arg_1_0:onDone(true)

		return
	end

	local var_1_3 = EliminateTeamChessEnum.teamChessPowerChangeStepTime
	local var_1_4 = EliminateTeamChessEnum.HpDamageType.Chess

	if var_1_2 ~= nil and EliminateTeamChessModel.instance.chessSkillIsGrowUp(tonumber(var_1_2)) then
		var_1_3 = EliminateTeamChessEnum.teamChessGrowUpToChangePowerStepTime
		var_1_4 = EliminateTeamChessEnum.HpDamageType.GrowUpToChess
	end

	EliminateTeamChessModel.instance:updateChessPower(var_1_0.uid, var_1_0.diffValue)

	if var_1_1 then
		local var_1_5 = TeamChessUnitEntityMgr.instance:getEntity(var_1_0.uid)

		if var_1_5 ~= nil then
			local var_1_6, var_1_7, var_1_8 = var_1_5:getTopPosXYZ()

			EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.PlayDamageEffect, var_1_0.diffValue, var_1_6, var_1_7 + 0.5, var_1_4)
		end
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessPowerChange, var_1_0.uid, var_1_0.diffValue)
	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, var_1_3)
end

return var_0_0
