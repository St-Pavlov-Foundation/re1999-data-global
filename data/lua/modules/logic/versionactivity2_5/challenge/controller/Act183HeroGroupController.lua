module("modules.logic.versionactivity2_5.challenge.controller.Act183HeroGroupController", package.seeall)

local var_0_0 = class("Act183HeroGroupController", BaseController)

function var_0_0.enterFight(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._episodeId = arg_1_1
	arg_1_0._readyUseBadgeNum = arg_1_2

	local var_1_0 = Act183Helper.getEpisodeSnapShotType(arg_1_1)

	if not var_1_0 then
		logError(string.format("编队快照类型不存在 episodeId = %s", arg_1_1))

		return
	end

	Act183Model.instance:recordEpisodeSelectConditions(arg_1_3)
	HeroGroupRpc.instance:sendGetHeroGroupSnapshotListRequest(var_1_0, arg_1_0._enterFight, arg_1_0)
end

function var_0_0._enterFight(arg_2_0)
	local var_2_0 = DungeonConfig.instance:getEpisodeCO(arg_2_0._episodeId)

	if not var_2_0 then
		logError(string.format("关卡配置不存在 episodeId = %s", arg_2_0._episodeId))

		return
	end

	Act183Model.instance:recordEpisodeReadyUseBadgeNum(arg_2_0._readyUseBadgeNum)
	DungeonFightController.instance:enterFight(var_2_0.chapterId, arg_2_0._episodeId)
end

function var_0_0.saveGroupData(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(var_3_0.fightGroup, arg_3_1.clothId, arg_3_0:getMainList(arg_3_1), arg_3_1:getSubList(), arg_3_1:getAllHeroEquips(), arg_3_1:getAllHeroActivity104Equips(), arg_3_1:getAssistBossId())

	local var_3_1 = ModuleEnum.HeroGroupSnapshotType.Common
	local var_3_2 = 1

	if arg_3_2 == ModuleEnum.HeroGroupType.General then
		var_3_1 = HeroGroupSnapshotModel.instance:getCurSnapshotId()
		var_3_2 = HeroGroupSnapshotModel.instance:getCurGroupId()
	end

	if var_3_1 and var_3_2 then
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_3_1, var_3_2, var_3_0, arg_3_4, arg_3_5)
	else
		logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", var_3_1, var_3_2))
	end
end

function var_0_0.getMainList(arg_4_0, arg_4_1)
	local var_4_0 = {}
	local var_4_1 = 0
	local var_4_2 = HeroGroupModel.instance.battleId
	local var_4_3 = var_4_2 and lua_battle.configDict[var_4_2]
	local var_4_4 = var_4_3 and var_4_3.playerMax or ModuleEnum.HeroCountInGroup

	for iter_4_0 = 1, var_4_4 do
		local var_4_5 = arg_4_1.heroList[iter_4_0] or "0"

		if tonumber(var_4_5) < 0 then
			var_4_5 = "0"
		end

		var_4_0[iter_4_0] = var_4_5

		if var_4_5 ~= "0" and var_4_5 ~= 0 then
			var_4_1 = var_4_1 + 1
		end
	end

	return var_4_0, var_4_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
