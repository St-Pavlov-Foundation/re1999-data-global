module("modules.logic.fight.system.work.FightWorkDirectStartNewFightAfterEndFight", package.seeall)

local var_0_0 = class("FightWorkDirectStartNewFightAfterEndFight", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = FightDataHelper.fieldMgr.episodeId
	local var_1_1, var_1_2 = arg_1_0:getNextEpisodeIdByCurEpisodeId(var_1_0)

	FightMsgMgr.sendMsg(FightMsgId.RestartGame)

	local var_1_3 = arg_1_0:com_registWorkDoneFlowSequence()

	var_1_3:registWork(FightWorkClearBeforeRestart)
	var_1_3:registWork(FightWorkFunction, arg_1_0.clearFight, arg_1_0)
	arg_1_0:_addTransition(var_1_0, var_1_3)
	var_1_3:registWork(FightWorkChangeFightScene, var_1_1, var_1_2)
	var_1_3:registWork(FightWorkFunction, arg_1_0.startNewFight, arg_1_0, var_1_1, var_1_2)
	var_1_3:start()
end

function var_0_0.startNewFight(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = DungeonConfig.instance:getEpisodeCO(arg_2_1).chapterId

	DungeonModel.instance:SetSendChapterEpisodeId(var_2_0, arg_2_1)

	local var_2_1 = FightController.instance:setFightParamByEpisodeId(arg_2_1)

	var_2_1:setDungeon(var_2_0, arg_2_1)

	var_2_1.chapterId = var_2_0

	HeroGroupModel.instance:setParam(arg_2_2, arg_2_1)
	HeroGroupTrialModel.instance:setTrialByBattleId(arg_2_2)

	if FightController.instance:setFightHeroSingleGroup() then
		DungeonRpc.instance:sendStartDungeonRequest(var_2_1.chapterId, var_2_1.episodeId, var_2_1)
	else
		logError(string.format("FightWorkDirectStartNewFightAfterEndFight:startNewFight error battleId:%s,episodeId:%s", arg_2_2, arg_2_1))
	end
end

function var_0_0.getNextEpisodeIdByCurEpisodeId(arg_3_0, arg_3_1)
	if arg_3_1 == VersionActivity2_8BossEnum.AutoEnterNextEpisodeFight then
		local var_3_0 = VersionActivity2_8BossEnum.StoryBossLastEpisode
		local var_3_1 = DungeonConfig.instance:getEpisodeBattleId(var_3_0)

		return var_3_0, var_3_1
	end
end

function var_0_0.directStartNewFight(arg_4_0)
	if arg_4_0 == VersionActivity2_8BossEnum.AutoEnterNextEpisodeFight and DungeonModel.instance:hasPassLevelAndStory(arg_4_0) then
		return true
	end
end

function var_0_0.clearFight(arg_5_0)
	FightModel.instance:clear()
end

function var_0_0._addTransition(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == VersionActivity2_8BossEnum.AutoEnterNextEpisodeFight then
		local var_6_0 = VersionActivity2_8DungeonBossController.instance

		arg_6_2:registWork(FightWorkFunction, var_6_0.openVersionActivity2_8BossStoryEyeView, var_6_0)
		arg_6_2:registWork(FightWorkDelayTimer, 0.5)
	end
end

return var_0_0
