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

	if arg_4_0:changeToDefaultEquip() and not var_4_4.temp then
		HeroGroupModel.instance:saveCurGroupData(function()
			ViewMgr.instance:openView(arg_4_0._groupFightName)
		end)

		return
	end

	if HeroGroupModel.instance.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		var_4_4:saveData()
	end

	ViewMgr.instance:openView(arg_4_0._groupFightName)
end

function var_0_0._getGroupFightViewName(arg_6_0, arg_6_1)
	if not arg_6_0.ActivityIdToHeroGroupView then
		arg_6_0.ActivityIdToHeroGroupView = {
			[VersionActivity1_2Enum.ActivityId.Dungeon] = ViewName.V1a2_HeroGroupFightView,
			[VersionActivity1_3Enum.ActivityId.Dungeon] = ViewName.V1a3_HeroGroupFightView,
			[VersionActivity1_5Enum.ActivityId.Dungeon] = ViewName.V1a5_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.Dungeon] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity1_6Enum.ActivityId.DungeonBossRush] = ViewName.V1a6_HeroGroupFightView,
			[VersionActivity2_7Enum.ActivityId.Act191] = ViewName.Act191HeroGroupView
		}
		arg_6_0.ChapterTypeToHeroGroupView = {
			[DungeonEnum.ChapterType.WeekWalk] = ViewName.HeroGroupFightWeekwalkView,
			[DungeonEnum.ChapterType.WeekWalk_2] = ViewName.HeroGroupFightWeekwalk_2View,
			[DungeonEnum.ChapterType.TowerPermanent] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBoss] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerLimited] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.TowerBossTeach] = ViewName.TowerHeroGroupFightView,
			[DungeonEnum.ChapterType.Act183] = ViewName.Act183HeroGroupFightView
		}
	end

	local var_6_0 = DungeonConfig.instance:getEpisodeCO(arg_6_1)
	local var_6_1 = var_6_0 and DungeonConfig.instance:getChapterCO(var_6_0.chapterId)

	if var_6_1 then
		return arg_6_0.ActivityIdToHeroGroupView[var_6_1.actId] or arg_6_0.ChapterTypeToHeroGroupView[var_6_1.type] or ViewName.HeroGroupFightView
	end

	return ViewName.HeroGroupFightView
end

function var_0_0.changeToDefaultEquip(arg_7_0)
	local var_7_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_7_1 = var_7_0.equips
	local var_7_2 = var_7_0.heroList
	local var_7_3
	local var_7_4
	local var_7_5 = false

	for iter_7_0, iter_7_1 in ipairs(var_7_2) do
		local var_7_6 = HeroModel.instance:getById(iter_7_1)
		local var_7_7 = iter_7_0 - 1

		if var_7_6 and var_7_6:hasDefaultEquip() and var_7_6.defaultEquipUid ~= var_7_1[var_7_7].equipUid[1] then
			if var_7_7 <= arg_7_0:_checkEquipInPreviousEquip(var_7_7 - 1, var_7_6.defaultEquipUid, var_7_1) then
				local var_7_8 = arg_7_0:_checkEquipInBehindEquip(var_7_7 + 1, var_7_6.defaultEquipUid, var_7_1)

				if var_7_8 > 0 then
					var_7_1[var_7_8].equipUid[1] = var_7_1[var_7_7].equipUid[1]
				end

				var_7_1[var_7_7].equipUid[1] = var_7_6.defaultEquipUid
			elseif var_7_1[var_7_7].equipUid[1] == var_7_6.defaultEquipUid then
				var_7_1[var_7_7].equipUid[1] = "0"
			end

			var_7_5 = true
		end
	end

	return var_7_5
end

function var_0_0._checkEquipInBehindEquip(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not EquipModel.instance:getEquip(arg_8_2) then
		return -1
	end

	for iter_8_0 = arg_8_1, #arg_8_3 do
		if arg_8_2 == arg_8_3[iter_8_0].equipUid[1] then
			return iter_8_0
		end
	end

	return -1
end

function var_0_0._checkEquipInPreviousEquip(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not EquipModel.instance:getEquip(arg_9_2) then
		return arg_9_1 + 1
	end

	for iter_9_0 = arg_9_1, 0, -1 do
		if arg_9_2 == arg_9_3[iter_9_0].equipUid[1] then
			return iter_9_0
		end
	end

	return arg_9_1 + 1
end

function var_0_0._onGetFightRecordGroupReply(arg_10_0, arg_10_1)
	FightController.instance:unregisterCallback(FightEvent.RespGetFightRecordGroupReply, arg_10_0._onGetFightRecordGroupReply, arg_10_0)
	HeroGroupModel.instance:setReplayParam(arg_10_1)
	ViewMgr.instance:openView(arg_10_0._groupFightName)
end

function var_0_0.onReceiveHeroGroupSnapshot(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1.snapshotId
	local var_11_1 = arg_11_1.snapshotSubId
end

var_0_0.instance = var_0_0.New()

return var_0_0
