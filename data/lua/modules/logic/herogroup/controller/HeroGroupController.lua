﻿module("modules.logic.herogroup.controller.HeroGroupController", package.seeall)

local var_0_0 = class("HeroGroupController", BaseController)

function var_0_0.addConstEvents(arg_1_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_1_0._onGetInfoFinish, arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_2_0._onGetFightRecordGroupReply, arg_2_0)
end

function var_0_0._onGetInfoFinish(arg_3_0)
	HeroGroupModel.instance:setParam()
end

function var_0_0.openGroupFightView(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._groupFightName = arg_4_0:_getGroupFightViewName(arg_4_2)

	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(arg_4_1, arg_4_2, arg_4_3)

	local var_4_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_4_1 = DungeonModel.instance:getEpisodeInfo(arg_4_2)
	local var_4_2 = var_4_1 and var_4_1.star == DungeonEnum.StarType.Advanced and var_4_1.hasRecord
	local var_4_3 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if var_4_0 and var_4_2 and not string.nilorempty(var_4_3) and cjson.decode(var_4_3)[tostring(arg_4_2)] then
		FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, arg_4_0._onGetFightRecordGroupReply, arg_4_0)
		FightRpc.instance:sendGetFightRecordGroupRequest(arg_4_2)

		return
	end

	local var_4_4 = HeroGroupModel.instance:getCurGroupMO()

	if arg_4_0:changeToDefaultEquip() and var_4_4 and not var_4_4.temp then
		HeroGroupModel.instance:saveCurGroupData(function()
			arg_4_0:_openGroupView()
		end)

		return
	end

	if HeroGroupModel.instance.heroGroupType == ModuleEnum.HeroGroupType.Trial and var_4_4 then
		var_4_4:saveData()
	end

	arg_4_0:_openGroupView()
end

function var_0_0._openGroupView(arg_6_0)
	if arg_6_0._groupFightName == ViewName.VersionActivity2_8HeroGroupBossView and arg_6_0:_bossEnterFight() then
		return
	end

	ViewMgr.instance:openView(arg_6_0._groupFightName)
end

function var_0_0._bossEnterFight(arg_7_0)
	local var_7_0 = HeroGroupModel.instance.episodeId
	local var_7_1 = var_7_0 and VersionActivity2_8BossConfig.instance:getHeroGroupId(var_7_0)
	local var_7_2 = var_7_1 and lua_hero_group_type.configDict[var_7_1]
	local var_7_3 = var_7_2 and var_7_2.changeForbiddenEpisode

	if not var_7_3 or var_7_3 == 0 then
		logError(string.format("HeroGroupController:_bossEnterFight episodeId:%s,heroGroupId:%s changeForbiddenEpisode nil", var_7_0, var_7_1))

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(var_7_3) then
		return
	end

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)

	if FightController.instance:setFightHeroSingleGroup() then
		local var_7_4 = FightModel.instance:getFightParam()

		var_7_4.isReplay = false
		var_7_4.multiplication = 1

		DungeonFightController.instance:sendStartDungeonRequest(var_7_4.chapterId, var_7_4.episodeId, var_7_4, 1)

		return true
	else
		logError(string.format("HeroGroupController:_bossEnterFight episodeId:%s,heroGroupId:%s setFightHeroSingleGroup failed", var_7_0, var_7_1))
	end
end

function var_0_0._getGroupFightViewName(arg_8_0, arg_8_1)
	if not arg_8_0.ActivityIdToHeroGroupView then
		arg_8_0.ActivityIdToHeroGroupView = {
			[VersionActivity1_2Enum.ActivityId.Dungeon] = ViewName.V1a2_HeroGroupFightView,
			[VersionActivity1_3Enum.ActivityId.Dungeon] = ViewName.V1a3_HeroGroupFightView,
			[VersionActivity1_5Enum.ActivityId.Dungeon] = ViewName.V1a5_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.Dungeon] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.DungeonBossRush] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity2_7Enum.ActivityId.Act191] = ViewName.Act191HeroGroupView,
			[VersionActivity2_9Enum.ActivityId.Dungeon] = ViewName.VersionActivity2_9HeroGroupFightView
		}
		arg_8_0.ChapterTypeToHeroGroupView = {
			[DungeonEnum.ChapterType.WeekWalk] = ViewName.HeroGroupFightWeekwalkView,
			[DungeonEnum.ChapterType.WeekWalk_2] = ViewName.HeroGroupFightWeekwalk_2View,
			[DungeonEnum.ChapterType.TowerPermanent] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBoss] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerLimited] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBossTeach] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.Act183] = ViewName.Act183HeroGroupFightView,
			[DungeonEnum.ChapterType.Survival] = ViewName.SurvivalHeroGroupFightView,
			[DungeonEnum.ChapterType.Shelter] = ViewName.ShelterHeroGroupFightView,
			[DungeonEnum.ChapterType.Odyssey] = ViewName.OdysseyHeroGroupView
		}
		arg_8_0.ChapterIdToHeroGroupView = {
			[DungeonEnum.ChapterId.BossStory] = ViewName.VersionActivity2_8HeroGroupBossView
		}
	end

	local var_8_0 = DungeonConfig.instance:getEpisodeCO(arg_8_1)

	if var_8_0.type == DungeonEnum.EpisodeType.BossRush then
		local var_8_1 = BossRushController.instance:getGroupFightViewName(arg_8_1)

		if var_8_1 then
			return var_8_1
		end
	end

	local var_8_2 = var_8_0 and DungeonConfig.instance:getChapterCO(var_8_0.chapterId)

	if var_8_2 then
		return arg_8_0.ActivityIdToHeroGroupView[var_8_2.actId] or arg_8_0.ChapterTypeToHeroGroupView[var_8_2.type] or arg_8_0.ChapterIdToHeroGroupView[var_8_2.id] or ViewName.HeroGroupFightView
	end

	return ViewName.HeroGroupFightView
end

function var_0_0.changeToDefaultEquip(arg_9_0)
	local var_9_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_9_1 = var_9_0 and var_9_0.equips or {}
	local var_9_2 = var_9_0 and var_9_0.heroList or {}
	local var_9_3
	local var_9_4
	local var_9_5 = false

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		local var_9_6 = HeroModel.instance:getById(iter_9_1)
		local var_9_7 = iter_9_0 - 1

		if var_9_6 and var_9_6:hasDefaultEquip() and var_9_6.defaultEquipUid ~= var_9_1[var_9_7].equipUid[1] then
			if var_9_7 <= arg_9_0:_checkEquipInPreviousEquip(var_9_7 - 1, var_9_6.defaultEquipUid, var_9_1) then
				local var_9_8 = arg_9_0:_checkEquipInBehindEquip(var_9_7 + 1, var_9_6.defaultEquipUid, var_9_1)

				if var_9_8 > 0 then
					var_9_1[var_9_8].equipUid[1] = var_9_1[var_9_7].equipUid[1]
				end

				var_9_1[var_9_7].equipUid[1] = var_9_6.defaultEquipUid
			elseif var_9_1[var_9_7].equipUid[1] == var_9_6.defaultEquipUid then
				var_9_1[var_9_7].equipUid[1] = "0"
			end

			var_9_5 = true
		end
	end

	return var_9_5
end

function var_0_0._checkEquipInBehindEquip(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not EquipModel.instance:getEquip(arg_10_2) then
		return -1
	end

	for iter_10_0 = arg_10_1, #arg_10_3 do
		if arg_10_2 == arg_10_3[iter_10_0].equipUid[1] then
			return iter_10_0
		end
	end

	return -1
end

function var_0_0._checkEquipInPreviousEquip(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not EquipModel.instance:getEquip(arg_11_2) then
		return arg_11_1 + 1
	end

	for iter_11_0 = arg_11_1, 0, -1 do
		if arg_11_2 == arg_11_3[iter_11_0].equipUid[1] then
			return iter_11_0
		end
	end

	return arg_11_1 + 1
end

function var_0_0._onGetFightRecordGroupReply(arg_12_0, arg_12_1)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_12_0._onGetFightRecordGroupReply, arg_12_0)
	HeroGroupModel.instance:setReplayParam(arg_12_1)
	arg_12_0:_openGroupView()
end

function var_0_0.onReceiveHeroGroupSnapshot(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1.snapshotId
	local var_13_1 = arg_13_1.snapshotSubId
end

var_0_0.instance = var_0_0.New()

return var_0_0
