module("modules.logic.herogroup.controller.HeroGroupController", package.seeall)

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

function var_0_0._checkCommonHeroGroup(arg_4_0, arg_4_1)
	if arg_4_1 ~= 10101 then
		return
	end

	if not GuideModel.instance:isGuideRunning(102) then
		return
	end

	local var_4_0 = 1
	local var_4_1 = HeroGroupModel.instance:getCommonGroupList(var_4_0)

	if not var_4_1 then
		logError("HeroGroupController:_checkCommonHeroGroup heroGroupMo nil")

		return
	end

	for iter_4_0 = 1, ModuleEnum.MaxHeroCountInGroup do
		local var_4_2 = var_4_1:getHeroByIndex(iter_4_0)

		if HeroModel.instance:getById(var_4_2) then
			return
		end
	end

	local var_4_3 = HeroModel.instance:getByHeroId(3028)

	if not var_4_3 then
		logError("HeroGroupController:_checkCommonHeroGroup appleHeroMo nil")

		return
	end

	local var_4_4 = var_4_3.uid

	var_4_1.heroList[1] = tostring(var_4_4)

	local var_4_5 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	FightParam.initFightGroup(var_4_5.fightGroup, var_4_1.clothId, var_4_1:getMainList(), var_4_1:getSubList(), var_4_1:getAllHeroEquips(), var_4_1:getAllHeroActivity104Equips(), var_4_1:getAssistBossId())

	local var_4_6 = ModuleEnum.HeroGroupSnapshotType.Common
	local var_4_7 = var_4_0

	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_4_6, var_4_7, var_4_5)
end

function var_0_0.openGroupFightView(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	callWithCatch(arg_5_0._checkCommonHeroGroup, arg_5_0, arg_5_2)

	arg_5_0._groupFightName = arg_5_0:_getGroupFightViewName(arg_5_2)

	HeroGroupModel.instance:setReplayParam(nil)
	HeroGroupModel.instance:setParam(arg_5_1, arg_5_2, arg_5_3)

	local var_5_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_5_1 = DungeonModel.instance:getEpisodeInfo(arg_5_2)
	local var_5_2 = var_5_1 and var_5_1.star == DungeonEnum.StarType.Advanced and var_5_1.hasRecord
	local var_5_3 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if var_5_0 and var_5_2 and not string.nilorempty(var_5_3) and cjson.decode(var_5_3)[tostring(arg_5_2)] then
		FightController.instance:registerCallback(FightEvent.RespGetFightRecordGroupReply, arg_5_0._onGetFightRecordGroupReply, arg_5_0)
		FightRpc.instance:sendGetFightRecordGroupRequest(arg_5_2)

		return
	end

	local var_5_4 = HeroGroupModel.instance:getCurGroupMO()

	if arg_5_0:changeToDefaultEquip() and var_5_4 and not var_5_4.temp then
		HeroGroupModel.instance:saveCurGroupData(function()
			arg_5_0:_openGroupView()
		end)

		return
	end

	if HeroGroupModel.instance.heroGroupType == ModuleEnum.HeroGroupType.Trial and var_5_4 then
		var_5_4:saveData()
	end

	arg_5_0:_openGroupView()
end

function var_0_0._openGroupView(arg_7_0)
	if arg_7_0._groupFightName == ViewName.VersionActivity2_8HeroGroupBossView and arg_7_0:_bossEnterFight() then
		return
	end

	ViewMgr.instance:openView(arg_7_0._groupFightName)
end

function var_0_0._bossEnterFight(arg_8_0)
	local var_8_0 = HeroGroupModel.instance.episodeId
	local var_8_1 = var_8_0 and VersionActivity2_8BossConfig.instance:getHeroGroupId(var_8_0)
	local var_8_2 = var_8_1 and lua_hero_group_type.configDict[var_8_1]
	local var_8_3 = var_8_2 and var_8_2.changeForbiddenEpisode

	if not var_8_3 or var_8_3 == 0 then
		logError(string.format("HeroGroupController:_bossEnterFight episodeId:%s,heroGroupId:%s changeForbiddenEpisode nil", var_8_0, var_8_1))

		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(var_8_3) then
		return
	end

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)

	if FightController.instance:setFightHeroSingleGroup() then
		local var_8_4 = FightModel.instance:getFightParam()

		var_8_4.isReplay = false
		var_8_4.multiplication = 1

		DungeonFightController.instance:sendStartDungeonRequest(var_8_4.chapterId, var_8_4.episodeId, var_8_4, 1)

		return true
	else
		logError(string.format("HeroGroupController:_bossEnterFight episodeId:%s,heroGroupId:%s setFightHeroSingleGroup failed", var_8_0, var_8_1))
	end
end

function var_0_0._getGroupFightViewName(arg_9_0, arg_9_1)
	if not arg_9_0.ActivityIdToHeroGroupView then
		arg_9_0.ActivityIdToHeroGroupView = {
			[VersionActivity1_2Enum.ActivityId.Dungeon] = ViewName.V1a2_HeroGroupFightView,
			[VersionActivity1_3Enum.ActivityId.Dungeon] = ViewName.V1a3_HeroGroupFightView,
			[VersionActivity1_5Enum.ActivityId.Dungeon] = ViewName.V1a5_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.Dungeon] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.DungeonBossRush] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity2_9Enum.ActivityId.Dungeon] = ViewName.VersionActivity2_9HeroGroupFightView
		}
		arg_9_0.ChapterTypeToHeroGroupView = {
			[DungeonEnum.ChapterType.WeekWalk] = ViewName.HeroGroupFightWeekwalkView,
			[DungeonEnum.ChapterType.WeekWalk_2] = ViewName.HeroGroupFightWeekwalk_2View,
			[DungeonEnum.ChapterType.TowerPermanent] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBoss] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerLimited] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBossTeach] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerDeep] = ViewName.TowerDeepHeroGroupFightView,
			[DungeonEnum.ChapterType.Act183] = ViewName.Act183HeroGroupFightView,
			[DungeonEnum.ChapterType.Odyssey] = ViewName.OdysseyHeroGroupView,
			[DungeonEnum.ChapterType.Survival] = ViewName.SurvivalHeroGroupFightView,
			[DungeonEnum.ChapterType.Shelter] = ViewName.ShelterHeroGroupFightView,
			[DungeonEnum.ChapterType.Act191] = ViewName.Act191HeroGroupView
		}
		arg_9_0.ChapterIdToHeroGroupView = {
			[DungeonEnum.ChapterId.BossStory] = ViewName.VersionActivity2_8HeroGroupBossView
		}
	end

	if DungeonController.checkEpisodeFiveHero(arg_9_1) then
		return ViewName.HeroGroupFightFiveHeroView
	end

	local var_9_0 = DungeonConfig.instance:getEpisodeCO(arg_9_1)

	if var_9_0.type == DungeonEnum.EpisodeType.BossRush then
		local var_9_1 = BossRushController.instance:getGroupFightViewName(arg_9_1)

		if var_9_1 then
			return var_9_1
		end
	end

	local var_9_2 = var_9_0 and DungeonConfig.instance:getChapterCO(var_9_0.chapterId)

	if var_9_2 then
		return arg_9_0.ActivityIdToHeroGroupView[var_9_2.actId] or arg_9_0.ChapterTypeToHeroGroupView[var_9_2.type] or arg_9_0.ChapterIdToHeroGroupView[var_9_2.id] or ViewName.HeroGroupFightView
	end

	return ViewName.HeroGroupFightView
end

function var_0_0.changeToDefaultEquip(arg_10_0)
	local var_10_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_10_1 = var_10_0 and var_10_0.equips or {}
	local var_10_2 = var_10_0 and var_10_0.heroList or {}
	local var_10_3
	local var_10_4
	local var_10_5 = false

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		local var_10_6 = HeroModel.instance:getById(iter_10_1)
		local var_10_7 = iter_10_0 - 1

		if var_10_6 and var_10_6:hasDefaultEquip() and var_10_6.defaultEquipUid ~= var_10_1[var_10_7].equipUid[1] then
			if var_10_7 <= arg_10_0:_checkEquipInPreviousEquip(var_10_7 - 1, var_10_6.defaultEquipUid, var_10_1) then
				local var_10_8 = arg_10_0:_checkEquipInBehindEquip(var_10_7 + 1, var_10_6.defaultEquipUid, var_10_1)

				if var_10_8 > 0 then
					var_10_1[var_10_8].equipUid[1] = var_10_1[var_10_7].equipUid[1]
				end

				var_10_1[var_10_7].equipUid[1] = var_10_6.defaultEquipUid
			elseif var_10_1[var_10_7].equipUid[1] == var_10_6.defaultEquipUid then
				var_10_1[var_10_7].equipUid[1] = "0"
			end

			var_10_5 = true
		end
	end

	return var_10_5
end

function var_0_0._checkEquipInBehindEquip(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not EquipModel.instance:getEquip(arg_11_2) then
		return -1
	end

	for iter_11_0 = arg_11_1, #arg_11_3 do
		if arg_11_2 == arg_11_3[iter_11_0].equipUid[1] then
			return iter_11_0
		end
	end

	return -1
end

function var_0_0._checkEquipInPreviousEquip(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not EquipModel.instance:getEquip(arg_12_2) then
		return arg_12_1 + 1
	end

	for iter_12_0 = arg_12_1, 0, -1 do
		if arg_12_2 == arg_12_3[iter_12_0].equipUid[1] then
			return iter_12_0
		end
	end

	return arg_12_1 + 1
end

function var_0_0._onGetFightRecordGroupReply(arg_13_0, arg_13_1)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_13_0._onGetFightRecordGroupReply, arg_13_0)
	HeroGroupModel.instance:setReplayParam(arg_13_1)
	arg_13_0:_openGroupView()
end

function var_0_0.onReceiveHeroGroupSnapshot(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1.snapshotId
	local var_14_1 = arg_14_1.snapshotSubId
	local var_14_2 = arg_14_1.groupInfo
end

var_0_0.instance = var_0_0.New()

return var_0_0
