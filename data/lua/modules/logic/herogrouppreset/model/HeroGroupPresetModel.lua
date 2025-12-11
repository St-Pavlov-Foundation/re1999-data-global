module("modules.logic.herogrouppreset.model.HeroGroupPresetModel", package.seeall)

local var_0_0 = class("HeroGroupPresetModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.heroGroupType = ModuleEnum.HeroGroupType.Default
	arg_1_0._curGroupId = 1
	arg_1_0._lastHeroGroupSnapshotList = {}
	arg_1_0._lastHeroGroupList = {}
	arg_1_0._herogroupItemPos = {}
	arg_1_0._commonGroups = {}
	arg_1_0._groupTypeSelect = {}
	arg_1_0._groupTypeCustom = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.heroGroupType = ModuleEnum.HeroGroupType.Default
	arg_2_0._curGroupId = 1
	arg_2_0._lastHeroGroupSnapshotList = {}
	arg_2_0._lastHeroGroupList = {}
	arg_2_0._herogroupItemPos = {}
	arg_2_0._commonGroups = {}
	arg_2_0._groupTypeSelect = {}
	arg_2_0._groupTypeCustom = {}
	arg_2_0._replayParam = nil
	arg_2_0.battleId = nil
	arg_2_0.episodeId = nil
	arg_2_0.adventure = nil
	arg_2_0.battleConfig = nil
	arg_2_0.heroGroupTypeCo = nil
	arg_2_0._episodeType = nil
	arg_2_0.weekwalk = nil
	arg_2_0.curGroupSelectIndex = 1
end

function var_0_0.onGetHeroGroupList(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_2 = HeroGroupMO.New()

		var_3_2:init(arg_3_1[iter_3_0])
		table.insert(var_3_0, var_3_2)
	end

	arg_3_0:setList(var_3_0)
end

function var_0_0.getCommonGroupList(arg_4_0, arg_4_1)
	return arg_4_0._commonGroups[arg_4_1]
end

function var_0_0.onGetCommonGroupList(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1.heroGroupCommons) do
		arg_5_0._commonGroups[iter_5_1.groupId] = HeroGroupMO.New()

		arg_5_0._commonGroups[iter_5_1.groupId]:init(iter_5_1)
	end

	for iter_5_2 = 1, 4 do
		if not arg_5_0._commonGroups[iter_5_2] then
			arg_5_0._commonGroups[iter_5_2] = HeroGroupMO.New()

			arg_5_0._commonGroups[iter_5_2]:init(HeroGroupMO.New())
		end
	end

	for iter_5_3, iter_5_4 in ipairs(arg_5_1.heroGourpTypes) do
		arg_5_0._groupTypeSelect[iter_5_4.id] = iter_5_4.currentSelect

		if iter_5_4.id ~= ModuleEnum.HeroGroupServerType.Main and iter_5_4:HasField("groupInfo") then
			arg_5_0._groupTypeCustom[iter_5_4.id] = HeroGroupMO.New()

			arg_5_0._groupTypeCustom[iter_5_4.id]:init(iter_5_4.groupInfo)
		end
	end
end

function var_0_0.clearCustomHeroGroup(arg_6_0, arg_6_1)
	arg_6_0._groupTypeCustom[arg_6_1] = nil
end

function var_0_0.updateCustomHeroGroup(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = HeroGroupMO.New()

	var_7_0:init(arg_7_2)

	arg_7_0._groupTypeCustom[arg_7_1] = var_7_0
end

function var_0_0.getCustomHeroGroupMo(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._groupTypeCustom[arg_8_1] then
		if arg_8_2 then
			return arg_8_0:getMainGroupMo()
		end

		local var_8_0 = HeroGroupMO.New()

		var_8_0:init(arg_8_0:getMainGroupMo())

		arg_8_0._groupTypeCustom[arg_8_1] = var_8_0
	end

	return arg_8_0._groupTypeCustom[arg_8_1]
end

function var_0_0.onModifyHeroGroup(arg_9_0, arg_9_1)
	local var_9_0 = {}
	local var_9_1 = arg_9_0:getById(arg_9_1.groupId)

	if var_9_1 then
		var_9_1:init(arg_9_1)
	else
		local var_9_2 = HeroGroupMO.New()

		var_9_2:init(arg_9_1)
		arg_9_0:addAtLast(var_9_2)
	end

	arg_9_0:_updateScroll()
end

function var_0_0._updateScroll(arg_10_0)
	arg_10_0:onModelUpdate()
	arg_10_0:_setSingleGroup()
end

function var_0_0.isAdventureOrWeekWalk(arg_11_0)
	return arg_11_0.adventure or arg_11_0.weekwalk
end

function var_0_0.setParam(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	local var_12_0 = {
		battleId = arg_12_1,
		episodeId = arg_12_2,
		adventure = arg_12_3,
		isReConnect = arg_12_4
	}

	arg_12_0.battleId = arg_12_1
	arg_12_0.episodeId = arg_12_2
	arg_12_0.adventure = arg_12_3

	local var_12_1 = arg_12_1 and lua_battle.configDict[arg_12_1]
	local var_12_2 = arg_12_2 and lua_episode.configDict[arg_12_2]
	local var_12_3 = var_12_2 and lua_chapter.configDict[var_12_2.chapterId]

	arg_12_0.battleConfig = var_12_1
	arg_12_0.heroGroupTypeCo = var_12_2 and HeroConfig.instance:getHeroGroupTypeCo(var_12_2.chapterId)
	arg_12_0._episodeType = var_12_2 and var_12_2.type or 0

	if arg_12_5 then
		arg_12_0._episodeType = arg_12_5
	end

	local var_12_4 = arg_12_0:getAmountLimit(var_12_1)

	arg_12_0.weekwalk = var_12_3 and var_12_3.type == DungeonEnum.ChapterType.WeekWalk

	local var_12_5 = false
	local var_12_6 = var_12_3 and (var_12_3.type == DungeonEnum.ChapterType.Normal or var_12_3.type == DungeonEnum.ChapterType.Hard or var_12_3.type == DungeonEnum.ChapterType.Simple)

	if var_12_6 then
		arg_12_0.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	arg_12_0._isBossStory = var_12_3 and var_12_3.id == DungeonEnum.ChapterId.BossStory

	if arg_12_0._isBossStory then
		local var_12_7 = VersionActivity2_8BossConfig.instance:getHeroGroupId(arg_12_2)
		local var_12_8 = var_12_7 and lua_hero_group_type.configDict[var_12_7]

		if var_12_8 then
			arg_12_0.heroGroupTypeCo = var_12_8
		else
			logError(string.format("BossStory episodeId:%s heroGroupId:%s error", arg_12_2, var_12_7))
		end
	end

	if arg_12_0.heroGroupTypeCo then
		local var_12_9 = arg_12_0.heroGroupTypeCo.id

		if arg_12_0._episodeType > 100 then
			var_12_9 = arg_12_0._episodeType
		end

		arg_12_0.curGroupSelectIndex = arg_12_0._groupTypeSelect[var_12_9]

		if not arg_12_0.curGroupSelectIndex then
			arg_12_0.curGroupSelectIndex = arg_12_0.heroGroupTypeCo.saveGroup == 1 and 0 or 1
		end
	else
		arg_12_0.curGroupSelectIndex = 1
	end

	local var_12_10 = {}

	if var_12_1 and not string.nilorempty(var_12_1.aid) then
		var_12_10 = string.splitToNumber(var_12_1.aid, "#")
	end

	local var_12_11 = HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(arg_12_0.episodeId)

	if var_12_1 and (var_12_1.trialLimit > 0 or not string.nilorempty(var_12_1.trialEquips)) or ToughBattleModel.instance:getAddTrialHeros() or var_12_11 then
		local var_12_12 = Activity104Model.instance:isSeasonChapter()
		local var_12_13

		if var_12_12 then
			var_12_13 = PlayerPrefsHelper.getString(Activity104Model.instance:getSeasonTrialPrefsKey(), "")
		else
			var_12_13 = PlayerPrefsHelper.getString(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. var_12_1.id, "")
		end

		arg_12_0.heroGroupType = ModuleEnum.HeroGroupType.Trial
		arg_12_0._curGroupId = 1

		local var_12_14

		if var_12_1.trialLimit > 0 and var_12_1.onlyTrial == 1 then
			var_12_14 = arg_12_0:generateTempGroup(nil, nil, true)
		elseif string.nilorempty(var_12_13) or arg_12_0._isBossStory then
			if arg_12_0.curGroupSelectIndex > 0 then
				var_12_14 = arg_12_0:generateTempGroup(arg_12_0._commonGroups[arg_12_0.curGroupSelectIndex], var_12_4, var_12_1 and var_12_1.useTemp == 2)
			else
				var_12_14 = arg_12_0.heroGroupTypeCo and arg_12_0:getCustomHeroGroupMo(arg_12_0.heroGroupTypeCo.id, true)
				var_12_14 = arg_12_0:generateTempGroup(var_12_14, var_12_4, var_12_1 and var_12_1.useTemp == 2)
			end
		else
			local var_12_15 = cjson.decode(var_12_13)

			GameUtil.removeJsonNull(var_12_15)

			var_12_14 = arg_12_0:generateTempGroup(nil, nil, true)

			var_12_14:initByLocalData(var_12_15)
		end

		var_12_14:setTrials(arg_12_4)

		arg_12_0._heroGroupList = {
			var_12_14
		}

		if var_12_11 then
			arg_12_0.heroGroupType = ModuleEnum.HeroGroupType.General

			HeroGroupSnapshotModel.instance:setParam(arg_12_0.episodeId)
		end
	elseif var_12_3 and SeasonHeroGroupHandler.checkIsSeasonEpisodeType(arg_12_0._episodeType) then
		local var_12_16 = SeasonHeroGroupHandler.buildSeasonHandleFunc[arg_12_0._episodeType]

		if var_12_16 then
			arg_12_0.heroGroupType = var_12_16(var_12_0)
		end
	elseif arg_12_0._episodeType == DungeonEnum.EpisodeType.Odyssey then
		arg_12_0.heroGroupType = ModuleEnum.HeroGroupType.Odyssey

		HeroGroupPresetSingleGroupModel.instance:setMaxHeroCount(OdysseyEnum.MaxHeroGroupCount)
	elseif V2a9BossRushModel.instance:isV2a9BossRushSecondStageSpecialLayer(arg_12_0._episodeType, arg_12_0.episodeId) then
		arg_12_0.heroGroupType = ModuleEnum.HeroGroupType.Odyssey

		HeroGroupPresetSingleGroupModel.instance:setMaxHeroCount(OdysseyEnum.MaxHeroGroupCount)
	elseif HeroGroupHandler.checkIsEpisodeType(arg_12_0._episodeType) then
		arg_12_0.heroGroupType = ModuleEnum.HeroGroupType.General

		HeroGroupSnapshotModel.instance:setParam(arg_12_0.episodeId)
	elseif var_12_3 and var_12_1 and var_12_1.useTemp ~= 0 or var_12_4 or #var_12_10 > 0 or var_12_1 and ToughBattleModel.instance:getEpisodeId() then
		arg_12_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_12_0._heroGroupList = {}

		local var_12_17

		if var_12_3 and var_12_3.saveHeroGroup and (not var_12_1 or var_12_1.useTemp ~= 2) then
			if arg_12_0.curGroupSelectIndex > 0 then
				var_12_17 = arg_12_0:generateTempGroup(arg_12_0._commonGroups[arg_12_0.curGroupSelectIndex], var_12_4, var_12_1 and var_12_1.useTemp == 2)
			else
				var_12_17 = arg_12_0.heroGroupTypeCo and arg_12_0:getCustomHeroGroupMo(arg_12_0.heroGroupTypeCo.id, true) or arg_12_0:generateTempGroup(nil, var_12_4, var_12_1 and var_12_1.useTemp == 2)
			end
		end

		if arg_12_0._isBossStory then
			arg_12_0:_clearAids(var_12_17)
		end

		local var_12_18 = arg_12_0:generateTempGroup(var_12_17, var_12_4, var_12_1 and var_12_1.useTemp == 2)

		table.insert(arg_12_0._heroGroupList, var_12_18)

		arg_12_0._curGroupId = 1
	elseif not var_12_6 and var_12_3 then
		arg_12_0.heroGroupType = ModuleEnum.HeroGroupType.Resources
		arg_12_0._heroGroupList = {}
		arg_12_0._curGroupId = 1

		if not arg_12_0._groupTypeCustom[arg_12_0.heroGroupTypeCo.id] then
			var_12_5 = true
		end

		local var_12_19 = arg_12_0.heroGroupTypeCo and arg_12_0:getCustomHeroGroupMo(arg_12_0.heroGroupTypeCo.id) or arg_12_0._commonGroups[1]
		local var_12_20 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
			var_12_3.name
		})

		var_12_19:setTempName(var_12_20)
		table.insert(arg_12_0._heroGroupList, var_12_19)
	elseif var_12_6 then
		arg_12_0.heroGroupType = ModuleEnum.HeroGroupType.NormalFb
		arg_12_0._heroGroupList = {}
		arg_12_0._curGroupId = 1

		local var_12_21 = arg_12_0:getCurGroupMO()

		if var_12_21 and var_12_21.aidDict then
			var_12_21.aidDict = nil
		end

		if DungeonController.checkEpisodeFiveHero(arg_12_0.episodeId) then
			arg_12_0.heroGroupType = ModuleEnum.HeroGroupType.General

			HeroGroupSnapshotModel.instance:setParam(arg_12_0.episodeId)
		end
	else
		arg_12_0.heroGroupType = ModuleEnum.HeroGroupType.Default
		arg_12_0._heroGroupList = {}
		arg_12_0._curGroupId = 1
	end

	arg_12_0:_setSingleGroup()
	arg_12_0:initRestrictHeroData(var_12_1)

	if var_12_5 then
		arg_12_0:saveCurGroupData()
	end
end

function var_0_0._clearAids(arg_13_0, arg_13_1)
	if not arg_13_1 or not arg_13_1.heroList then
		return
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_1.heroList) do
		if iter_13_1 == "-1" then
			arg_13_1.heroList[iter_13_0] = "0"
		end
	end
end

function var_0_0.setReplayParam(arg_14_0, arg_14_1)
	arg_14_0._replayParam = arg_14_1

	if arg_14_1 then
		if arg_14_1.replay_hero_data then
			for iter_14_0, iter_14_1 in pairs(arg_14_1.replay_hero_data) do
				local var_14_0 = HeroModel.instance:getById(iter_14_0)

				if var_14_0 and var_14_0.skin > 0 then
					iter_14_1.skin = var_14_0.skin
				end
			end
		end

		arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_14_0._heroGroupList = {}
		arg_14_0._heroGroupList[arg_14_1.id] = arg_14_1
		arg_14_0._curGroupId = arg_14_1.id

		arg_14_0:_setSingleGroup()
	end
end

function var_0_0.getReplayParam(arg_15_0)
	return arg_15_0._replayParam
end

function var_0_0.getAmountLimit(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return
	end

	local var_16_0 = arg_16_0:_getAmountLimit(arg_16_1.additionRule)

	if var_16_0 then
		return var_16_0
	end

	return (arg_16_0:_getAmountLimit(arg_16_1.hiddenRule))
end

function var_0_0._getAmountLimit(arg_17_0, arg_17_1)
	if LuaUtil.isEmptyStr(arg_17_1) == false then
		local var_17_0 = GameUtil.splitString2(arg_17_1, true, "|", "#")

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			if iter_17_1[1] == FightEnum.EntitySide.MySide then
				local var_17_1 = iter_17_1[2]
				local var_17_2 = lua_rule.configDict[var_17_1]

				if var_17_2 and var_17_2.type == DungeonEnum.AdditionRuleType.AmountLimit then
					return tonumber(var_17_2.effect)
				end
			end
		end
	end
end

function var_0_0.getBattleRoleNum(arg_18_0)
	return HeroGroupPresetItemListModel.instance:getHeroNum()
end

function var_0_0.generateTempGroup(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = HeroGroupMO.New()

	if not arg_19_1 and not arg_19_3 then
		arg_19_1 = arg_19_0:getById(arg_19_0._curGroupId)
	end

	if arg_19_1 then
		var_19_0:setSeasonCardLimit(arg_19_1:getSeasonCardLimit())
	end

	local var_19_1 = arg_19_0.battleId and lua_battle.configDict[arg_19_0.battleId]

	if var_19_1 then
		local var_19_2 = {}

		if not string.nilorempty(var_19_1.aid) then
			var_19_2 = string.splitToNumber(var_19_1.aid, "#")
		end

		local var_19_3 = {}
		local var_19_4 = HeroGroupHandler.getTrialHeros(arg_19_0.episodeId)

		if not string.nilorempty(var_19_4) then
			var_19_3 = GameUtil.splitString2(var_19_4, true)
		end

		arg_19_2 = arg_19_2 or var_19_1.roleNum

		local var_19_5 = var_19_1.playerMax

		var_19_0:initWithBattle(arg_19_1 or HeroGroupMO.New(), var_19_2, arg_19_2, var_19_5, nil, var_19_3)

		if arg_19_0.adventure then
			local var_19_6 = arg_19_0.episodeId and lua_episode.configDict[arg_19_0.episodeId]

			if var_19_6 then
				local var_19_7 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
					var_19_6.name
				})

				var_19_0:setTempName(var_19_7)
			end
		end
	else
		logError("临时编队没有战斗配置，永远不该发生")
		var_19_0:init(arg_19_1)
	end

	var_19_0:setTemp(true)

	return var_19_0
end

function var_0_0.setCurGroupId(arg_20_0, arg_20_1)
	arg_20_0._curGroupId = arg_20_1

	arg_20_0:_setSingleGroup()
end

function var_0_0.setHeroGroupSnapshotType(arg_21_0, arg_21_1)
	arg_21_0._heroGroupSnapshotType = arg_21_1
end

function var_0_0.setHeroGroupMo(arg_22_0, arg_22_1)
	arg_22_0._heroGroupMO = arg_22_1
end

function var_0_0._setSingleGroup(arg_23_0)
	local var_23_0 = arg_23_0:getCurGroupMO()

	HeroGroupPresetSingleGroupModel.instance:setSingleGroup(var_23_0, true)
end

function var_0_0.getCommonGroupName(arg_24_0, arg_24_1, arg_24_2)
	arg_24_2 = arg_24_2 or arg_24_0:getHeroGroupSnapshotType()
	arg_24_1 = arg_24_1 or arg_24_0:getHeroGroupSelectIndex()

	if arg_24_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		local var_24_0 = HeroGroupSnapshotModel.instance:getGroupName()

		if string.nilorempty(var_24_0) then
			return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_24_1))
		else
			return var_24_0
		end
	end

	local var_24_1 = arg_24_0._commonGroups[arg_24_1].name

	if string.nilorempty(var_24_1) then
		return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_24_1))
	else
		return var_24_1
	end
end

function var_0_0.setCommonGroupName(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_3 = arg_25_3 or arg_25_0:getHeroGroupSnapshotType()
	arg_25_1 = arg_25_1 or arg_25_0:getHeroGroupSelectIndex()

	if arg_25_2 == arg_25_0:getCommonGroupName(arg_25_1, arg_25_3) then
		return
	end

	if arg_25_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		HeroGroupSnapshotModel.instance:setGroupName(arg_25_3, arg_25_1, arg_25_2)
	else
		arg_25_0._commonGroups[arg_25_1].name = arg_25_2
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function var_0_0.getCurGroupMO(arg_26_0)
	return arg_26_0._heroGroupMO
end

function var_0_0.getHeroGroupSelectIndex(arg_27_0)
	if arg_27_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getSelectIndex()
	end

	return arg_27_0.curGroupSelectIndex
end

function var_0_0.getHeroGroupSnapshotType(arg_28_0)
	if arg_28_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getCurSnapshotId()
	end

	return ModuleEnum.HeroGroupSnapshotType.Common
end

function var_0_0.setHeroGroupSelectIndex(arg_29_0, arg_29_1)
	if arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		local var_29_0 = HeroGroupSnapshotModel.instance:setSelectIndex(nil, arg_29_1)

		if var_29_0 then
			arg_29_0:_setSingleGroup()
		end

		return var_29_0
	end

	if arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		arg_29_0:_setSingleGroup()

		return
	end

	if not arg_29_0.heroGroupTypeCo then
		logError("没有配置。。")

		return
	end

	if arg_29_1 == 0 and arg_29_0.heroGroupTypeCo.saveGroup == 0 then
		logError("无法切到玩法编队")

		return
	end

	if arg_29_0.curGroupSelectIndex == arg_29_1 then
		return
	end

	arg_29_0.curGroupSelectIndex = arg_29_1

	local var_29_1 = arg_29_0.heroGroupTypeCo.id

	if arg_29_0._episodeType > 100 then
		var_29_1 = arg_29_0._episodeType
	end

	if var_29_1 == 1 and arg_29_1 == ModuleEnum.FiveHeroEnum.FifthIndex then
		logError("编队设置错误，加个保底以及打印log线上确认问题")

		arg_29_1 = arg_29_0._groupTypeSelect[var_29_1] or 0
		arg_29_1 = math.min(arg_29_1, 4)
	end

	arg_29_0._groupTypeSelect[var_29_1] = arg_29_1

	arg_29_0:_setSingleGroup()
	HeroGroupRpc.instance:sendChangeHeroGroupSelectRequest(var_29_1, arg_29_1)

	return true
end

function var_0_0.getGroupTypeName(arg_30_0)
	if not arg_30_0.heroGroupTypeCo or arg_30_0.heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return arg_30_0.heroGroupTypeCo.name
end

function var_0_0.getMainGroupMo(arg_31_0)
	return arg_31_0:getById(1)
end

function var_0_0.externalSaveCurGroupData(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	if not arg_32_3 then
		return
	end

	local var_32_0 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

	if arg_32_0._heroGroupSnapshotType == HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit then
		FightParam.initTowerFightGroup(var_32_0.fightGroup, arg_32_3.clothId, arg_32_3:getMainList(), arg_32_3:getSubList(), arg_32_3:getAllHeroEquips(), arg_32_3:getAllHeroActivity104Equips(), arg_32_3:getAssistBossId(), not HeroGroupPresetController.instance:useTrial())
	else
		FightParam.initFightGroup(var_32_0.fightGroup, arg_32_3.clothId, arg_32_3:getMainList(), arg_32_3:getSubList(), arg_32_3:getAllHeroEquips(), arg_32_3:getAllHeroActivity104Equips(), arg_32_3:getAssistBossId())
	end

	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(arg_32_4, arg_32_5, var_32_0, arg_32_1, arg_32_2)
end

function var_0_0._saveCurGroupData(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	arg_33_3 = arg_33_3 or arg_33_0:getCurGroupMO()

	arg_33_0:externalSaveCurGroupData(arg_33_1, arg_33_2, arg_33_3, arg_33_0._heroGroupSnapshotType, arg_33_0._curGroupId)
end

function var_0_0.saveCurGroupData(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	arg_34_0:_saveCurGroupData(arg_34_1, arg_34_2, arg_34_3)

	do return end

	local var_34_0 = lua_episode.configDict[arg_34_0.episodeId]

	if not var_34_0 then
		if arg_34_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
			OdysseyHeroGroupController.instance:saveHeroGroupInfo(arg_34_3)
		end

		return
	end

	if var_34_0.type == DungeonEnum.EpisodeType.Cachot then
		return
	end

	arg_34_3 = arg_34_3 or arg_34_0:getCurGroupMO()

	if not arg_34_3 then
		return
	end

	arg_34_3:checkAndPutOffEquip()

	if arg_34_0.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		arg_34_3:saveData()

		if arg_34_1 then
			arg_34_1(arg_34_2)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, arg_34_0.heroGroupType, 1)

		return
	end

	if arg_34_0.heroGroupType == ModuleEnum.HeroGroupType.Temp or arg_34_0.heroGroupType == ModuleEnum.HeroGroupType.Default then
		if arg_34_1 then
			arg_34_1(arg_34_2)
		end

		return
	end

	if SeasonHeroGroupHandler.NeedGetHeroCardSeason[arg_34_0.heroGroupType] then
		SeasonHeroGroupHandler.setHeroGroupSnapshot(arg_34_3, arg_34_0.heroGroupType, arg_34_0.episodeId, arg_34_1, arg_34_2)

		return
	end

	if var_34_0.type == DungeonEnum.EpisodeType.Act183 then
		Act183HeroGroupController.instance:saveGroupData(arg_34_3, arg_34_0.heroGroupType, arg_34_0.episodeId, arg_34_1, arg_34_2)

		return
	end

	if DungeonController.checkEpisodeFiveHero(arg_34_0.episodeId) then
		DungeonController.saveFiveHeroGroupData(arg_34_3, arg_34_0.heroGroupType, arg_34_0.episodeId, arg_34_1, arg_34_2)

		return
	end

	local var_34_1 = arg_34_0.curGroupSelectIndex

	if var_34_1 == 0 then
		if arg_34_0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
			HeroGroupRpc.instance:sendUpdateHeroGroupRequest(arg_34_3.id, arg_34_3.heroList, arg_34_3.name, arg_34_3.clothId, arg_34_3.equips, nil, arg_34_1, arg_34_2)
		elseif arg_34_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			local var_34_2 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

			FightParam.initFightGroup(var_34_2.fightGroup, arg_34_3.clothId, arg_34_3:getMainList(), arg_34_3:getSubList(), arg_34_3:getAllHeroEquips(), arg_34_3:getAllHeroActivity104Equips())
			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Resources, arg_34_0.heroGroupTypeCo.id, var_34_2, arg_34_1, arg_34_2)
		end
	else
		local var_34_3 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

		if HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(arg_34_0.episodeId) then
			FightParam.initTowerFightGroup(var_34_3.fightGroup, arg_34_3.clothId, arg_34_3:getMainList(), arg_34_3:getSubList(), arg_34_3:getAllHeroEquips(), arg_34_3:getAllHeroActivity104Equips(), arg_34_3:getAssistBossId())
		else
			FightParam.initFightGroup(var_34_3.fightGroup, arg_34_3.clothId, arg_34_3:getMainList(), arg_34_3:getSubList(), arg_34_3:getAllHeroEquips(), arg_34_3:getAllHeroActivity104Equips(), arg_34_3:getAssistBossId())
		end

		if arg_34_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
			OdysseyHeroGroupController.instance:saveHeroGroupInfo(arg_34_3)

			return
		end

		local var_34_4 = ModuleEnum.HeroGroupSnapshotType.Common
		local var_34_5 = var_34_1

		if arg_34_0.heroGroupType == ModuleEnum.HeroGroupType.General then
			var_34_4 = HeroGroupSnapshotModel.instance:getCurSnapshotId()
			var_34_5 = HeroGroupSnapshotModel.instance:getCurGroupId()
		end

		if var_34_4 and var_34_5 then
			if var_34_0.type == DungeonEnum.EpisodeType.Survival then
				local var_34_6 = SurvivalMapModel.instance:getSceneMo().teamInfo

				if var_34_6 and var_34_6.assistMO then
					for iter_34_0, iter_34_1 in ipairs(var_34_3.fightGroup.heroList) do
						if var_34_6.assistMO.heroUid == iter_34_1 then
							var_34_3.fightGroup.assistHeroUid = var_34_6.assistMO.heroUid
							var_34_3.fightGroup.assistUserId = var_34_6.assistMO.userId
						end
					end
				end
			end

			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_34_4, var_34_5, var_34_3, arg_34_1, arg_34_2)
		else
			logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", var_34_4, var_34_5))
		end
	end
end

function var_0_0.setHeroGroupSnapshot(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4, arg_35_5, arg_35_6)
	local var_35_0 = {
		heroGroupType = arg_35_1,
		episodeId = arg_35_2,
		upload = arg_35_3,
		extendData = arg_35_4
	}
	local var_35_1 = arg_35_2 and lua_episode.configDict[arg_35_2]

	if not var_35_1 then
		return
	end

	local var_35_2 = 0
	local var_35_3 = 0
	local var_35_4
	local var_35_5

	if arg_35_1 == ModuleEnum.HeroGroupType.Resources then
		var_35_3, var_35_2 = var_35_1.chapterId, ModuleEnum.HeroGroupSnapshotType.Resources
		var_35_4 = arg_35_0._heroGroupList[1]
	elseif SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(arg_35_1) then
		local var_35_6 = SeasonHeroGroupHandler.setSeasonSnapShotHandleFunc[arg_35_1]

		if var_35_6 then
			var_35_2, var_35_3, var_35_4, var_35_5 = var_35_6(var_35_0)
		end
	else
		logError("暂不支持此类编队快照 : " .. tostring(arg_35_1))

		return
	end

	if var_35_4 and arg_35_3 then
		local var_35_7 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
		local var_35_8 = FightDef_pb.FightGroup()

		FightParam.initFightGroup(var_35_7.fightGroup, var_35_4.clothId, var_35_4:getMainList(), var_35_4:getSubList(), var_35_4:getAllHeroEquips(), var_35_5 or var_35_4:getAllHeroActivity104Equips())
		Season123HeroGroupUtils.processFightGroupAssistHero(arg_35_1, var_35_7.fightGroup)
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_35_2, var_35_3, var_35_7, arg_35_5, arg_35_6)
	elseif arg_35_5 then
		arg_35_5(arg_35_6)
	end
end

function var_0_0.replaceSingleGroup(arg_36_0)
	local var_36_0 = arg_36_0:getCurGroupMO()

	if var_36_0 then
		local var_36_1 = HeroGroupPresetSingleGroupModel.instance:getList()

		var_36_0:replaceHeroList(var_36_1)
	end
end

function var_0_0.replaceSingleGroupEquips(arg_37_0)
	local var_37_0 = arg_37_0:getCurGroupMO()
	local var_37_1 = HeroGroupPresetSingleGroupModel.instance:getList()
	local var_37_2
	local var_37_3

	for iter_37_0, iter_37_1 in ipairs(var_37_1) do
		local var_37_4 = HeroModel.instance:getById(iter_37_1.heroUid)

		if var_37_4 and var_37_4:hasDefaultEquip() then
			local var_37_5 = {
				index = iter_37_0 - 1,
				equipUid = {
					var_37_4.defaultEquipUid
				}
			}

			var_37_0:updatePosEquips(var_37_5)
		end
	end
end

function var_0_0.replaceCloth(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getCurGroupMO()

	if var_38_0 then
		var_38_0:replaceClothId(arg_38_1)
	end
end

function var_0_0.replaceEquips(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_2 or arg_39_0:getCurGroupMO()

	if var_39_0 then
		var_39_0:updatePosEquips(arg_39_1)
	end
end

function var_0_0.getCurGroupId(arg_40_0)
	return arg_40_0._curGroupId
end

function var_0_0.isPositionOpen(arg_41_0, arg_41_1)
	if arg_41_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		return OdysseyHeroGroupModel.instance:isPositionOpen(arg_41_1)
	end

	local var_41_0 = lua_open_group.configDict[arg_41_1]

	if not var_41_0 then
		if arg_41_1 == ModuleEnum.FiveHeroEnum.MaxHeroNum and DungeonController.checkEpisodeFiveHero(arg_41_0.episodeId) then
			return true
		end

		return false
	end

	local var_41_1 = arg_41_0.episodeId and lua_episode.configDict[arg_41_0.episodeId]
	local var_41_2 = var_41_1 and lua_battle.configDict[var_41_1.battleId]
	local var_41_3 = var_41_2 and #FightStrUtil.instance:getSplitToNumberCache(var_41_2.aid, "#") or 0

	if var_41_1 and var_41_1.type == DungeonEnum.EpisodeType.Sp and arg_41_1 <= var_41_3 then
		return true
	end

	if var_41_0.need_level > 0 and PlayerModel.instance:getPlayinfo().level < var_41_0.need_level then
		return false
	end

	if var_41_0.need_episode > 0 then
		local var_41_4 = DungeonModel.instance:getEpisodeInfo(var_41_0.need_episode)

		if not var_41_4 or var_41_4.star <= 0 then
			return false
		end

		local var_41_5 = lua_episode.configDict[var_41_0.need_episode].afterStory

		if var_41_5 and var_41_5 > 0 and not StoryModel.instance:isStoryFinished(var_41_5) then
			return false
		end
	end

	if var_41_0.need_enter_episode > 0 or var_41_0.need_finish_guide > 0 then
		if var_41_0.need_enter_episode > 0 then
			local var_41_6 = DungeonModel.instance:getEpisodeInfo(var_41_0.need_enter_episode)

			if var_41_6 and var_41_6.star > 0 or arg_41_0.episodeId == var_41_0.need_enter_episode then
				return true
			end
		end

		if var_41_0.need_finish_guide > 0 and GuideModel.instance:isGuideFinish(var_41_0.need_finish_guide) then
			return true
		end

		return false
	end

	return true
end

function var_0_0.positionOpenCount(arg_42_0)
	local var_42_0 = 0

	for iter_42_0 = 1, 4 do
		if arg_42_0:isPositionOpen(iter_42_0) then
			var_42_0 = var_42_0 + 1
		end
	end

	return var_42_0
end

function var_0_0.getPositionLockDesc(arg_43_0, arg_43_1)
	local var_43_0 = lua_open_group.configDict[arg_43_1]
	local var_43_1 = var_43_0 and var_43_0.need_episode

	if not var_43_1 or var_43_1 == 0 then
		return nil
	end

	local var_43_2 = DungeonConfig.instance:getEpisodeDisplay(var_43_1)

	return var_43_0.lock_desc, var_43_2
end

function var_0_0.getHighestLevel(arg_44_0)
	local var_44_0 = HeroGroupPresetSingleGroupModel.instance:getList()

	if not var_44_0 then
		return 0
	end

	local var_44_1 = 0

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		if iter_44_1.aid and iter_44_1.aid ~= -1 then
			local var_44_2 = lua_monster.configDict[tonumber(iter_44_1.aid)]

			if var_44_2 and var_44_1 < var_44_2.level then
				var_44_1 = var_44_2.level
			end
		elseif iter_44_1.heroUid then
			local var_44_3 = HeroModel.instance:getById(iter_44_1.heroUid)

			if var_44_3 and var_44_1 < var_44_3.level then
				var_44_1 = var_44_3.level
			end
		end
	end

	return var_44_1
end

function var_0_0.setHeroGroupItemPos(arg_45_0, arg_45_1)
	arg_45_0._herogroupItemPos = arg_45_1
end

function var_0_0.getHeroGroupItemPos(arg_46_0)
	return arg_46_0._herogroupItemPos
end

var_0_0.RestrictType = {
	Rare = 3,
	HeroId = 1,
	Career = 2
}

function var_0_0.initRestrictHeroData(arg_47_0, arg_47_1)
	arg_47_0.restrictHeroIdList = nil
	arg_47_0.restrictCareerList = nil
	arg_47_0.restrictRareList = nil

	local var_47_0 = arg_47_1 and arg_47_1.restrictRoles

	if string.nilorempty(var_47_0) then
		return
	end

	local var_47_1 = string.split(var_47_0, "|")
	local var_47_2
	local var_47_3

	for iter_47_0 = 1, #var_47_1 do
		local var_47_4 = string.splitToNumber(var_47_1[iter_47_0], "#")
		local var_47_5, var_47_6 = GameUtil.tabletool_fastRemoveValueByPos(var_47_4, 1)

		if var_47_6 == var_0_0.RestrictType.HeroId then
			arg_47_0.restrictHeroIdList = var_47_5
		elseif var_47_6 == var_0_0.RestrictType.Career then
			arg_47_0.restrictCareerList = var_47_5
		elseif var_47_6 == var_0_0.RestrictType.Rare then
			arg_47_0.restrictRareList = var_47_5
		else
			logError("un support restrict type : " .. tostring(var_47_6))
		end
	end
end

function var_0_0.isRestrict(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_1 and HeroModel.instance:getById(arg_48_1)

	if not var_48_0 then
		return false
	end

	return arg_48_0.restrictHeroIdList and tabletool.indexOf(arg_48_0.restrictHeroIdList, var_48_0.heroId) or arg_48_0.restrictCareerList and tabletool.indexOf(arg_48_0.restrictCareerList, var_48_0.config.career) or arg_48_0.restrictRareList and tabletool.indexOf(arg_48_0.restrictRareList, var_48_0.config.rare)
end

function var_0_0.getCurrentBattleConfig(arg_49_0)
	return arg_49_0.battleConfig
end

var_0_0.instance = var_0_0.New()

return var_0_0
