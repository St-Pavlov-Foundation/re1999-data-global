module("modules.logic.survival.controller.work.SurvivalBeginFightWork", package.seeall)

local var_0_0 = class("SurvivalBeginFightWork", SurvivalStepBaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(ModuleEnum.HeroGroupSnapshotType.Survival, arg_1_0._onRecvMsg, arg_1_0)
end

function var_0_0._onRecvMsg(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2 == 0 and not arg_2_0.context.fastExecute then
		local var_2_0 = SurvivalMapModel.instance:getSceneMo().unitsById[arg_2_0._stepMo.paramInt[1]]

		if var_2_0 then
			local var_2_1 = SurvivalEnum.Survival_EpisodeId
			local var_2_2 = DungeonConfig.instance:getEpisodeCO(var_2_1)

			DungeonFightController.instance:enterFightByBattleId(var_2_2.chapterId, var_2_1, var_2_0.co.battleId)

			arg_2_0.context.isEnterFight = true

			arg_2_0:onDone(true)
		else
			logError("战斗元件不存在" .. tostring(arg_2_0._stepMo.paramInt[1]))
			arg_2_0:onDone(true)
		end
	else
		arg_2_0:onDone(false)
	end
end

return var_0_0
