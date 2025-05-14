module("modules.logic.rouge.view.RougeHeroGroupFightViewLevel", package.seeall)

local var_0_0 = class("RougeHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function var_0_0._btnenemyOnClick(arg_1_0)
	local var_1_0 = DungeonConfig.instance:getEpisodeCO(arg_1_0._episodeId)

	if var_1_0.type == DungeonEnum.EpisodeType.WeekWalk then
		local var_1_1 = WeekWalkModel.instance:getCurMapId()

		EnemyInfoController.instance:openWeekWalkEnemyInfoView(var_1_1, arg_1_0._battleId)

		return
	elseif var_1_0.type == DungeonEnum.EpisodeType.Cachot then
		-- block empty
	elseif var_1_0.type == DungeonEnum.EpisodeType.BossRush then
		local var_1_2 = BossRushConfig.instance:getActivityId()
		local var_1_3, var_1_4 = BossRushConfig.instance:tryGetStageAndLayerByEpisodeId(arg_1_0._episodeId)

		EnemyInfoController.instance:openBossRushEnemyInfoView(var_1_2, var_1_3, var_1_4)

		return
	end

	if arg_1_0._fixHpRate then
		EnemyInfoController.instance:openRougeEnemyInfoView(arg_1_0._battleId, 1 + tonumber(arg_1_0._fixHpRate))

		return
	end

	local var_1_5 = RougeConfig1.instance:season()

	RougeRpc.instance:sendRougeMonsterFixAttrRequest(var_1_5, arg_1_0._onGetFixAttrRequest, arg_1_0)
end

function var_0_0._onGetFixAttrRequest(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_2 ~= 0 then
		return
	end

	arg_2_0._fixHpRate = arg_2_3.fixHpRate

	EnemyInfoController.instance:openRougeEnemyInfoView(arg_2_0._battleId, 1 + tonumber(arg_2_0._fixHpRate))
end

return var_0_0
