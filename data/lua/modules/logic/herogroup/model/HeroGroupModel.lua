module("modules.logic.herogroup.model.HeroGroupModel", package.seeall)

local var_0_0 = class("HeroGroupModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.heroGroupType = ModuleEnum.HeroGroupType.Default
	arg_1_0._curGroupId = 1
	arg_1_0._lastHeroGroupSnapshotList = {}
	arg_1_0._lastHeroGroupList = {}
	arg_1_0._herogroupItemPos = {}
	arg_1_0._commonGroups = {}
	arg_1_0._groupTypeSelect = {}
	arg_1_0._groupTypeCustom = {}
	arg_1_0._groupSortList = {}
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
	arg_2_0._groupSortList = {}
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

function var_0_0.removeCommonGroupList(arg_5_0, arg_5_1)
	arg_5_0._commonGroups[arg_5_1] = nil
end

function var_0_0.addCommonGroupList(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._commonGroups[arg_6_1] then
		return
	end

	arg_6_0._commonGroups[arg_6_1] = arg_6_2
end

function var_0_0.onGetCommonGroupList(arg_7_0, arg_7_1)
	for iter_7_0, iter_7_1 in ipairs(arg_7_1.heroGroupCommons) do
		arg_7_0._commonGroups[iter_7_1.groupId] = HeroGroupMO.New()

		arg_7_0._commonGroups[iter_7_1.groupId]:init(iter_7_1)
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_1.heroGourpTypes) do
		arg_7_0._groupTypeSelect[iter_7_3.id] = iter_7_3.currentSelect

		if iter_7_3.id ~= ModuleEnum.HeroGroupServerType.Main and iter_7_3:HasField("groupInfo") then
			arg_7_0._groupTypeCustom[iter_7_3.id] = HeroGroupMO.New()

			arg_7_0._groupTypeCustom[iter_7_3.id]:init(iter_7_3.groupInfo)
		end
	end
end

function var_0_0.clearCustomHeroGroup(arg_8_0, arg_8_1)
	arg_8_0._groupTypeCustom[arg_8_1] = nil
end

function var_0_0.updateCustomHeroGroup(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = HeroGroupMO.New()

	var_9_0:init(arg_9_2)

	arg_9_0._groupTypeCustom[arg_9_1] = var_9_0
end

function var_0_0.getCustomHeroGroupMo(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._groupTypeCustom[arg_10_1] then
		if arg_10_2 then
			return arg_10_0:getMainGroupMo()
		end

		local var_10_0 = HeroGroupMO.New()

		var_10_0:init(arg_10_0:getMainGroupMo())

		arg_10_0._groupTypeCustom[arg_10_1] = var_10_0
	end

	return arg_10_0._groupTypeCustom[arg_10_1]
end

function var_0_0.onModifyHeroGroup(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = arg_11_0:getById(arg_11_1.groupId)

	if var_11_1 then
		var_11_1:init(arg_11_1)
	else
		local var_11_2 = HeroGroupMO.New()

		var_11_2:init(arg_11_1)
		arg_11_0:addAtLast(var_11_2)
	end

	arg_11_0:_updateScroll()
end

function var_0_0._updateScroll(arg_12_0)
	arg_12_0:onModelUpdate()
	arg_12_0:_setSingleGroup()
end

function var_0_0.isAdventureOrWeekWalk(arg_13_0)
	return arg_13_0.adventure or arg_13_0.weekwalk
end

function var_0_0.setParam(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	local var_14_0 = {
		battleId = arg_14_1,
		episodeId = arg_14_2,
		adventure = arg_14_3,
		isReConnect = arg_14_4
	}

	arg_14_0.battleId = arg_14_1
	arg_14_0.episodeId = arg_14_2
	arg_14_0.adventure = arg_14_3

	local var_14_1 = arg_14_1 and lua_battle.configDict[arg_14_1]
	local var_14_2 = arg_14_2 and lua_episode.configDict[arg_14_2]
	local var_14_3 = var_14_2 and lua_chapter.configDict[var_14_2.chapterId]

	arg_14_0.battleConfig = var_14_1
	arg_14_0.heroGroupTypeCo = var_14_2 and HeroConfig.instance:getHeroGroupTypeCo(var_14_2.chapterId)
	arg_14_0._episodeType = var_14_2 and var_14_2.type or 0

	if arg_14_5 then
		arg_14_0._episodeType = arg_14_5
	end

	local var_14_4 = arg_14_0:getAmountLimit(var_14_1)

	arg_14_0.weekwalk = var_14_3 and var_14_3.type == DungeonEnum.ChapterType.WeekWalk

	local var_14_5 = false
	local var_14_6 = var_14_3 and (var_14_3.type == DungeonEnum.ChapterType.Normal or var_14_3.type == DungeonEnum.ChapterType.Hard or var_14_3.type == DungeonEnum.ChapterType.Simple)

	if var_14_6 then
		arg_14_0.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	arg_14_0._isBossStory = var_14_3 and var_14_3.id == DungeonEnum.ChapterId.BossStory

	if arg_14_0._isBossStory then
		local var_14_7 = VersionActivity2_8BossConfig.instance:getHeroGroupId(arg_14_2)
		local var_14_8 = var_14_7 and lua_hero_group_type.configDict[var_14_7]

		if var_14_8 then
			arg_14_0.heroGroupTypeCo = var_14_8
		else
			logError(string.format("BossStory episodeId:%s heroGroupId:%s error", arg_14_2, var_14_7))
		end
	end

	if arg_14_0.heroGroupTypeCo then
		local var_14_9 = arg_14_0.heroGroupTypeCo.id

		if arg_14_0._episodeType > 100 then
			var_14_9 = arg_14_0._episodeType
		end

		arg_14_0.curGroupSelectIndex = arg_14_0._groupTypeSelect[var_14_9]

		if not arg_14_0.curGroupSelectIndex then
			arg_14_0.curGroupSelectIndex = arg_14_0.heroGroupTypeCo.saveGroup == 1 and 0 or 1
		end
	else
		arg_14_0.curGroupSelectIndex = 1
	end

	local var_14_10 = {}

	if var_14_1 and not string.nilorempty(var_14_1.aid) then
		var_14_10 = string.splitToNumber(var_14_1.aid, "#")
	end

	local var_14_11 = HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(arg_14_0.episodeId)

	if var_14_1 and (var_14_1.trialLimit > 0 or not string.nilorempty(var_14_1.trialEquips)) or ToughBattleModel.instance:getAddTrialHeros() or var_14_11 then
		local var_14_12 = Activity104Model.instance:isSeasonChapter()
		local var_14_13

		if var_14_12 then
			var_14_13 = PlayerPrefsHelper.getString(Activity104Model.instance:getSeasonTrialPrefsKey(), "")
		else
			var_14_13 = PlayerPrefsHelper.getString(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. var_14_1.id, "")
		end

		arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.Trial
		arg_14_0._curGroupId = 1

		local var_14_14

		if var_14_1.trialLimit > 0 and var_14_1.onlyTrial == 1 then
			var_14_14 = arg_14_0:generateTempGroup(nil, nil, true)
		elseif string.nilorempty(var_14_13) or arg_14_0._isBossStory then
			if arg_14_0.curGroupSelectIndex > 0 then
				var_14_14 = arg_14_0:generateTempGroup(arg_14_0:_getCommonBySelectIndex(), var_14_4, var_14_1 and var_14_1.useTemp == 2)
			else
				var_14_14 = arg_14_0.heroGroupTypeCo and arg_14_0:getCustomHeroGroupMo(arg_14_0.heroGroupTypeCo.id, true)
				var_14_14 = arg_14_0:generateTempGroup(var_14_14, var_14_4, var_14_1 and var_14_1.useTemp == 2)
			end
		else
			local var_14_15 = cjson.decode(var_14_13)

			GameUtil.removeJsonNull(var_14_15)

			var_14_14 = arg_14_0:generateTempGroup(nil, nil, true)

			var_14_14:initByLocalData(var_14_15)
		end

		var_14_14:setTrials(arg_14_4)

		arg_14_0._heroGroupList = {
			var_14_14
		}

		if var_14_11 then
			arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.General

			HeroGroupSnapshotModel.instance:setParam(arg_14_0.episodeId)
		end
	elseif var_14_3 and SeasonHeroGroupHandler.checkIsSeasonEpisodeType(arg_14_0._episodeType) then
		local var_14_16 = SeasonHeroGroupHandler.buildSeasonHandleFunc[arg_14_0._episodeType]

		if var_14_16 then
			arg_14_0.heroGroupType = var_14_16(var_14_0)
		end
	elseif arg_14_0._episodeType == DungeonEnum.EpisodeType.Odyssey then
		arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.Odyssey

		HeroSingleGroupModel.instance:setMaxHeroCount(OdysseyEnum.MaxHeroGroupCount)
	elseif V2a9BossRushModel.instance:isV2a9BossRushSecondStageSpecialLayer(arg_14_0._episodeType, arg_14_0.episodeId) then
		arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.Odyssey

		HeroSingleGroupModel.instance:setMaxHeroCount(OdysseyEnum.MaxHeroGroupCount)
	elseif HeroGroupHandler.checkIsEpisodeType(arg_14_0._episodeType) then
		arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.General

		HeroGroupSnapshotModel.instance:setParam(arg_14_0.episodeId)
	elseif var_14_3 and var_14_1 and var_14_1.useTemp ~= 0 or var_14_4 or #var_14_10 > 0 or var_14_1 and ToughBattleModel.instance:getEpisodeId() then
		arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_14_0._heroGroupList = {}

		local var_14_17

		if var_14_3 and var_14_3.saveHeroGroup and (not var_14_1 or var_14_1.useTemp ~= 2) then
			if arg_14_0.curGroupSelectIndex > 0 then
				var_14_17 = arg_14_0:generateTempGroup(arg_14_0:_getCommonBySelectIndex(), var_14_4, var_14_1 and var_14_1.useTemp == 2)
			else
				var_14_17 = arg_14_0.heroGroupTypeCo and arg_14_0:getCustomHeroGroupMo(arg_14_0.heroGroupTypeCo.id, true) or arg_14_0:generateTempGroup(nil, var_14_4, var_14_1 and var_14_1.useTemp == 2)
			end
		end

		if arg_14_0._isBossStory then
			arg_14_0:_clearAids(var_14_17)
		end

		local var_14_18 = arg_14_0:generateTempGroup(var_14_17, var_14_4, var_14_1 and var_14_1.useTemp == 2)

		table.insert(arg_14_0._heroGroupList, var_14_18)

		arg_14_0._curGroupId = 1
	elseif not var_14_6 and var_14_3 then
		arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.Resources
		arg_14_0._heroGroupList = {}
		arg_14_0._curGroupId = 1

		arg_14_0:_checkCommonSelectIndex()

		if arg_14_0._isBossStory then
			local var_14_19 = arg_14_0.heroGroupTypeCo and arg_14_0:getCustomHeroGroupMo(arg_14_0.heroGroupTypeCo.id) or arg_14_0._commonGroups[arg_14_0.curGroupSelectIndex]
			local var_14_20 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
				var_14_3.name
			})

			var_14_19:setTempName(var_14_20)
			table.insert(arg_14_0._heroGroupList, var_14_19)
		end
	elseif var_14_6 then
		arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.NormalFb
		arg_14_0._heroGroupList = {}
		arg_14_0._curGroupId = 1

		if DungeonController.checkEpisodeFiveHero(arg_14_0.episodeId) then
			arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.General

			HeroGroupSnapshotModel.instance:setParam(arg_14_0.episodeId)
		else
			arg_14_0:_checkCommonSelectIndex()
		end

		local var_14_21 = arg_14_0:getCurGroupMO()

		if var_14_21 and var_14_21.aidDict then
			var_14_21.aidDict = nil
		end
	else
		arg_14_0.heroGroupType = ModuleEnum.HeroGroupType.Default
		arg_14_0._heroGroupList = {}
		arg_14_0._curGroupId = 1
	end

	arg_14_0:_convertToPreset()
	arg_14_0:_setSingleGroup()
	arg_14_0:initRestrictHeroData(var_14_1)

	if var_14_5 then
		arg_14_0:saveCurGroupData()
	end
end

function var_0_0._convertToPreset(arg_15_0)
	arg_15_0._presetHeroGroupType = nil

	if arg_15_0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb or arg_15_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
		if arg_15_0._isBossStory then
			return
		end

		arg_15_0._presetHeroGroupType = HeroGroupPresetEnum.HeroGroupType.Common

		return
	end

	if arg_15_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		local var_15_0 = DungeonConfig.instance:getEpisodeCO(arg_15_0.episodeId)

		if var_15_0 and var_15_0.type == DungeonEnum.EpisodeType.TowerPermanent or var_15_0.type == DungeonEnum.EpisodeType.TowerLimited or var_15_0.type == DungeonEnum.EpisodeType.TowerDeep then
			if HeroGroupPresetEnum.HeroGroupSnapshotTypeOpen[HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit] then
				arg_15_0._presetHeroGroupType = HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit
			end

			return
		end
	end
end

function var_0_0._getCommonBySelectIndex(arg_16_0)
	arg_16_0:_checkCommonSelectIndex()

	return arg_16_0._commonGroups[arg_16_0.curGroupSelectIndex]
end

function var_0_0._checkCommonSelectIndex(arg_17_0)
	arg_17_0.curGroupSelectIndex = HeroGroupPresetHeroGroupSelectIndexController.instance:getCommonSelectedIndex(arg_17_0.curGroupSelectIndex)
end

function var_0_0.getPresetHeroGroupType(arg_18_0)
	return arg_18_0._presetHeroGroupType
end

function var_0_0._clearAids(arg_19_0, arg_19_1)
	if not arg_19_1 or not arg_19_1.heroList then
		return
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_1.heroList) do
		if iter_19_1 == "-1" then
			arg_19_1.heroList[iter_19_0] = "0"
		end
	end
end

function var_0_0.setReplayParam(arg_20_0, arg_20_1)
	arg_20_0._replayParam = arg_20_1

	if arg_20_1 then
		if arg_20_1.replay_hero_data then
			for iter_20_0, iter_20_1 in pairs(arg_20_1.replay_hero_data) do
				local var_20_0 = HeroModel.instance:getById(iter_20_0)

				if var_20_0 and var_20_0.skin > 0 then
					iter_20_1.skin = var_20_0.skin
				end
			end
		end

		arg_20_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_20_0._heroGroupList = {}
		arg_20_0._heroGroupList[arg_20_1.id] = arg_20_1
		arg_20_0._curGroupId = arg_20_1.id

		arg_20_0:_setSingleGroup()
	end
end

function var_0_0.getReplayParam(arg_21_0)
	return arg_21_0._replayParam
end

function var_0_0.getAmountLimit(arg_22_0, arg_22_1)
	if not arg_22_1 then
		return
	end

	local var_22_0 = arg_22_0:_getAmountLimit(arg_22_1.additionRule)

	if var_22_0 then
		return var_22_0
	end

	return (arg_22_0:_getAmountLimit(arg_22_1.hiddenRule))
end

function var_0_0._getAmountLimit(arg_23_0, arg_23_1)
	if LuaUtil.isEmptyStr(arg_23_1) == false then
		local var_23_0 = GameUtil.splitString2(arg_23_1, true, "|", "#")

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			if iter_23_1[1] == FightEnum.EntitySide.MySide then
				local var_23_1 = iter_23_1[2]
				local var_23_2 = lua_rule.configDict[var_23_1]

				if var_23_2 and var_23_2.type == DungeonEnum.AdditionRuleType.AmountLimit then
					return tonumber(var_23_2.effect)
				end
			end
		end
	end
end

function var_0_0.getBattleRoleNum(arg_24_0)
	if arg_24_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		return OdysseyEnum.MaxHeroGroupCount
	end

	local var_24_0 = arg_24_0.episodeId
	local var_24_1

	var_24_1 = var_24_0 and lua_episode.configDict[var_24_0]

	local var_24_2 = arg_24_0.battleId
	local var_24_3 = var_24_2 and lua_battle.configDict[var_24_2]

	return arg_24_0:getAmountLimit(var_24_3) or var_24_3 and var_24_3.roleNum
end

function var_0_0.generateTempGroup(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = HeroGroupMO.New()

	if not arg_25_1 and not arg_25_3 then
		arg_25_1 = arg_25_0:getMainGroupMo()
	end

	if arg_25_1 then
		var_25_0:setSeasonCardLimit(arg_25_1:getSeasonCardLimit())
	end

	local var_25_1 = arg_25_0.battleId and lua_battle.configDict[arg_25_0.battleId]

	if var_25_1 then
		local var_25_2 = {}

		if not string.nilorempty(var_25_1.aid) then
			var_25_2 = string.splitToNumber(var_25_1.aid, "#")
		end

		local var_25_3 = {}
		local var_25_4 = HeroGroupHandler.getTrialHeros(arg_25_0.episodeId)

		if not string.nilorempty(var_25_4) then
			var_25_3 = GameUtil.splitString2(var_25_4, true)
		end

		arg_25_2 = arg_25_2 or var_25_1.roleNum

		local var_25_5 = var_25_1.playerMax

		var_25_0:initWithBattle(arg_25_1 or HeroGroupMO.New(), var_25_2, arg_25_2, var_25_5, nil, var_25_3)

		if arg_25_0.adventure then
			local var_25_6 = arg_25_0.episodeId and lua_episode.configDict[arg_25_0.episodeId]

			if var_25_6 then
				local var_25_7 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
					var_25_6.name
				})

				var_25_0:setTempName(var_25_7)
			end
		end
	else
		logError("临时编队没有战斗配置，永远不该发生")
		var_25_0:init(arg_25_1)
	end

	var_25_0:setTemp(true)

	return var_25_0
end

function var_0_0.setCurGroupId(arg_26_0, arg_26_1)
	arg_26_0._curGroupId = arg_26_1

	arg_26_0:_setSingleGroup()
end

function var_0_0._setSingleGroup(arg_27_0)
	local var_27_0 = arg_27_0:getCurGroupMO()

	if not var_27_0 then
		var_27_0 = HeroGroupMO.New()

		local var_27_1 = arg_27_0._curGroupId

		if arg_27_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			var_27_1 = var_27_1 - 1
		end

		local var_27_2 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_name"), {
			luaLang("hero_group"),
			var_27_1
		})

		var_27_0:init({
			groupId = var_27_1,
			name = var_27_2
		})

		if not arg_27_0:getById(var_27_0.id) then
			arg_27_0:addAtLast(var_27_0)
		end
	end

	var_27_0:clearAidHero()
	HeroGroupHandler.hanldeHeroListData(arg_27_0.episodeId)
	HeroSingleGroupModel.instance:setSingleGroup(var_27_0, true)
end

function var_0_0.getCommonGroupName(arg_28_0, arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or arg_28_0:getHeroGroupSnapshotType()
	arg_28_1 = arg_28_1 or arg_28_0:getHeroGroupSelectIndex()

	if arg_28_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		local var_28_0 = HeroGroupSnapshotModel.instance:getGroupName()

		if string.nilorempty(var_28_0) then
			return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_28_1))
		else
			return var_28_0
		end
	end

	local var_28_1 = arg_28_0._commonGroups[arg_28_1]
	local var_28_2 = var_28_1 and var_28_1.name

	if string.nilorempty(var_28_2) then
		return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_28_1))
	else
		return var_28_2
	end
end

function var_0_0.setCommonGroupName(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_3 = arg_29_3 or arg_29_0:getHeroGroupSnapshotType()
	arg_29_1 = arg_29_1 or arg_29_0:getHeroGroupSelectIndex()

	if arg_29_2 == arg_29_0:getCommonGroupName(arg_29_1, arg_29_3) then
		return
	end

	if arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		HeroGroupSnapshotModel.instance:setGroupName(arg_29_3, arg_29_1, arg_29_2)
	else
		arg_29_0._commonGroups[arg_29_1].name = arg_29_2
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function var_0_0.getCurGroupMO(arg_30_0)
	if arg_30_0.heroGroupType == ModuleEnum.HeroGroupType.Temp or arg_30_0.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		return arg_30_0._heroGroupList[arg_30_0._curGroupId]
	elseif SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(arg_30_0.heroGroupType) then
		local var_30_0 = SeasonHeroGroupHandler.getSeasonCurrentHeroGroupMO[arg_30_0.heroGroupType]

		if var_30_0 then
			return var_30_0()
		end
	elseif arg_30_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
		if arg_30_0._isBossStory then
			return arg_30_0._heroGroupList[1]
		end

		return arg_30_0:_getCommonBySelectIndex()
	elseif arg_30_0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
		return arg_30_0:_getCommonBySelectIndex()
	elseif arg_30_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getCurGroup()
	elseif arg_30_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		return OdysseyHeroGroupModel.instance:getCurHeroGroup()
	else
		return arg_30_0:getById(arg_30_0._curGroupId)
	end
end

function var_0_0.getHeroGroupSelectIndex(arg_31_0)
	if arg_31_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getSelectIndex()
	end

	return arg_31_0.curGroupSelectIndex
end

function var_0_0.getHeroGroupSnapshotType(arg_32_0)
	if arg_32_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getCurSnapshotId()
	end

	return ModuleEnum.HeroGroupSnapshotType.Common
end

function var_0_0.setHeroGroupSelectIndex(arg_33_0, arg_33_1)
	if arg_33_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		local var_33_0 = HeroGroupSnapshotModel.instance:setSelectIndex(nil, arg_33_1)

		if var_33_0 then
			arg_33_0:_setSingleGroup()
		end

		return var_33_0
	end

	if arg_33_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		arg_33_0:_setSingleGroup()

		return
	end

	if not arg_33_0.heroGroupTypeCo then
		logError("没有配置。。")

		return
	end

	if arg_33_1 == 0 and arg_33_0.heroGroupTypeCo.saveGroup == 0 then
		logError("无法切到玩法编队")

		return
	end

	if arg_33_0.curGroupSelectIndex == arg_33_1 then
		return
	end

	arg_33_0.curGroupSelectIndex = arg_33_1

	local var_33_1 = arg_33_0.heroGroupTypeCo.id

	if arg_33_0._episodeType > 100 then
		var_33_1 = arg_33_0._episodeType
	end

	arg_33_0._groupTypeSelect[var_33_1] = arg_33_1

	arg_33_0:_setSingleGroup()
	HeroGroupRpc.instance:sendChangeHeroGroupSelectRequest(var_33_1, arg_33_1)

	return true
end

function var_0_0.getGroupTypeName(arg_34_0)
	if not arg_34_0.heroGroupTypeCo or arg_34_0.heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return arg_34_0.heroGroupTypeCo.name
end

function var_0_0.getMainGroupMo(arg_35_0)
	for iter_35_0 = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
		local var_35_0 = arg_35_0:getCommonGroupList(iter_35_0)

		if var_35_0 then
			return var_35_0
		end
	end
end

function var_0_0.saveCurGroupData(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = lua_episode.configDict[arg_36_0.episodeId]

	if not var_36_0 then
		if arg_36_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
			OdysseyHeroGroupController.instance:saveHeroGroupInfo(arg_36_3, nil, arg_36_1, arg_36_2)
		end

		return
	end

	if var_36_0.type == DungeonEnum.EpisodeType.Cachot then
		return
	end

	arg_36_3 = arg_36_3 or arg_36_0:getCurGroupMO()

	if not arg_36_3 then
		return
	end

	arg_36_3:checkAndPutOffEquip()

	if arg_36_0.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		arg_36_3:saveData()

		if arg_36_1 then
			arg_36_1(arg_36_2)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, arg_36_0.heroGroupType, 1)

		return
	end

	if arg_36_0.heroGroupType == ModuleEnum.HeroGroupType.Temp or arg_36_0.heroGroupType == ModuleEnum.HeroGroupType.Default then
		if arg_36_1 then
			arg_36_1(arg_36_2)
		end

		return
	end

	if SeasonHeroGroupHandler.NeedGetHeroCardSeason[arg_36_0.heroGroupType] then
		SeasonHeroGroupHandler.setHeroGroupSnapshot(arg_36_3, arg_36_0.heroGroupType, arg_36_0.episodeId, arg_36_1, arg_36_2)

		return
	end

	if var_36_0.type == DungeonEnum.EpisodeType.Act183 then
		Act183HeroGroupController.instance:saveGroupData(arg_36_3, arg_36_0.heroGroupType, arg_36_0.episodeId, arg_36_1, arg_36_2)

		return
	end

	if DungeonController.checkEpisodeFiveHero(arg_36_0.episodeId) then
		DungeonController.saveFiveHeroGroupData(arg_36_3, arg_36_0.heroGroupType, arg_36_0.episodeId, arg_36_1, arg_36_2)

		return
	end

	local var_36_1 = arg_36_0.curGroupSelectIndex

	if var_36_1 == 0 then
		logError("HeroGroupModel:saveCurGroupData: lastSelectGroupIndex 异常,值不能为0")
	else
		local var_36_2 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

		if HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(arg_36_0.episodeId) then
			FightParam.initTowerFightGroup(var_36_2.fightGroup, arg_36_3.clothId, arg_36_3:getMainList(), arg_36_3:getSubList(), arg_36_3:getAllHeroEquips(), arg_36_3:getAllHeroActivity104Equips(), arg_36_3:getAssistBossId())
		else
			FightParam.initFightGroup(var_36_2.fightGroup, arg_36_3.clothId, arg_36_3:getMainList(), arg_36_3:getSubList(), arg_36_3:getAllHeroEquips(), arg_36_3:getAllHeroActivity104Equips(), arg_36_3:getAssistBossId())
		end

		if arg_36_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
			OdysseyHeroGroupController.instance:saveHeroGroupInfo(arg_36_3, nil, arg_36_1, arg_36_2)

			return
		end

		local var_36_3 = ModuleEnum.HeroGroupSnapshotType.Common
		local var_36_4 = var_36_1

		if arg_36_0.heroGroupType == ModuleEnum.HeroGroupType.General then
			var_36_3 = HeroGroupSnapshotModel.instance:getCurSnapshotId()
			var_36_4 = HeroGroupSnapshotModel.instance:getCurGroupId()
		end

		if var_36_3 and var_36_4 then
			if var_36_0.type == DungeonEnum.EpisodeType.Survival then
				local var_36_5 = SurvivalMapModel.instance:getSceneMo().teamInfo

				if var_36_5 and var_36_5.assistMO then
					for iter_36_0, iter_36_1 in ipairs(var_36_2.fightGroup.heroList) do
						if var_36_5.assistMO.heroUid == iter_36_1 then
							var_36_2.fightGroup.assistHeroUid = var_36_5.assistMO.heroUid
							var_36_2.fightGroup.assistUserId = var_36_5.assistMO.userId
						end
					end
				end
			end

			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_36_3, var_36_4, var_36_2, arg_36_1, arg_36_2)
			HeroGroupPresetController.instance:initCopyHeroGroupList()
		else
			logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", var_36_3, var_36_4))
		end
	end
end

function var_0_0.setHeroGroupSnapshot(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5, arg_37_6)
	local var_37_0 = {
		heroGroupType = arg_37_1,
		episodeId = arg_37_2,
		upload = arg_37_3,
		extendData = arg_37_4
	}
	local var_37_1 = arg_37_2 and lua_episode.configDict[arg_37_2]

	if not var_37_1 then
		return
	end

	local var_37_2 = 0
	local var_37_3 = 0
	local var_37_4
	local var_37_5

	if arg_37_1 == ModuleEnum.HeroGroupType.Resources then
		var_37_3, var_37_2 = var_37_1.chapterId, ModuleEnum.HeroGroupSnapshotType.Resources
		var_37_4 = arg_37_0._heroGroupList[1]
	elseif SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(arg_37_1) then
		local var_37_6 = SeasonHeroGroupHandler.setSeasonSnapShotHandleFunc[arg_37_1]

		if var_37_6 then
			var_37_2, var_37_3, var_37_4, var_37_5 = var_37_6(var_37_0)
		end
	else
		logError("暂不支持此类编队快照 : " .. tostring(arg_37_1))

		return
	end

	if var_37_4 and arg_37_3 then
		local var_37_7 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
		local var_37_8 = FightDef_pb.FightGroup()

		FightParam.initFightGroup(var_37_7.fightGroup, var_37_4.clothId, var_37_4:getMainList(), var_37_4:getSubList(), var_37_4:getAllHeroEquips(), var_37_5 or var_37_4:getAllHeroActivity104Equips())
		Season123HeroGroupUtils.processFightGroupAssistHero(arg_37_1, var_37_7.fightGroup)
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_37_2, var_37_3, var_37_7, arg_37_5, arg_37_6)
	elseif arg_37_5 then
		arg_37_5(arg_37_6)
	end
end

function var_0_0.replaceSingleGroup(arg_38_0)
	local var_38_0 = arg_38_0:getCurGroupMO()

	if var_38_0 then
		local var_38_1 = HeroSingleGroupModel.instance:getList()

		var_38_0:replaceHeroList(var_38_1)
	end
end

function var_0_0.replaceSingleGroupEquips(arg_39_0)
	local var_39_0 = arg_39_0:getCurGroupMO()
	local var_39_1 = HeroSingleGroupModel.instance:getList()
	local var_39_2
	local var_39_3

	for iter_39_0, iter_39_1 in ipairs(var_39_1) do
		local var_39_4 = HeroModel.instance:getById(iter_39_1.heroUid)

		if var_39_4 and var_39_4:hasDefaultEquip() then
			local var_39_5 = {
				index = iter_39_0 - 1,
				equipUid = {
					var_39_4.defaultEquipUid
				}
			}

			var_39_0:updatePosEquips(var_39_5)
		end
	end
end

function var_0_0.replaceCloth(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getCurGroupMO()

	if var_40_0 then
		var_40_0:replaceClothId(arg_40_1)
	end
end

function var_0_0.replaceEquips(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = arg_41_2 or arg_41_0:getCurGroupMO()

	if var_41_0 then
		var_41_0:updatePosEquips(arg_41_1)
	end
end

function var_0_0.getCurGroupId(arg_42_0)
	return arg_42_0._curGroupId
end

function var_0_0.isPositionOpen(arg_43_0, arg_43_1)
	if arg_43_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		return OdysseyHeroGroupModel.instance:isPositionOpen(arg_43_1)
	end

	local var_43_0 = lua_open_group.configDict[arg_43_1]

	if not var_43_0 then
		if arg_43_1 == ModuleEnum.FiveHeroEnum.MaxHeroNum and DungeonController.checkEpisodeFiveHero(arg_43_0.episodeId) then
			return true
		end

		return false
	end

	local var_43_1 = arg_43_0.episodeId and lua_episode.configDict[arg_43_0.episodeId]
	local var_43_2 = var_43_1 and lua_battle.configDict[var_43_1.battleId]
	local var_43_3 = var_43_2 and #FightStrUtil.instance:getSplitToNumberCache(var_43_2.aid, "#") or 0

	if var_43_1 and var_43_1.type == DungeonEnum.EpisodeType.Sp and arg_43_1 <= var_43_3 then
		return true
	end

	if var_43_0.need_level > 0 and PlayerModel.instance:getPlayinfo().level < var_43_0.need_level then
		return false
	end

	if var_43_0.need_episode > 0 then
		local var_43_4 = DungeonModel.instance:getEpisodeInfo(var_43_0.need_episode)

		if not var_43_4 or var_43_4.star <= 0 then
			return false
		end

		local var_43_5 = lua_episode.configDict[var_43_0.need_episode].afterStory

		if var_43_5 and var_43_5 > 0 and not StoryModel.instance:isStoryFinished(var_43_5) then
			return false
		end
	end

	if var_43_0.need_enter_episode > 0 or var_43_0.need_finish_guide > 0 then
		if var_43_0.need_enter_episode > 0 then
			local var_43_6 = DungeonModel.instance:getEpisodeInfo(var_43_0.need_enter_episode)

			if var_43_6 and var_43_6.star > 0 or arg_43_0.episodeId == var_43_0.need_enter_episode then
				return true
			end
		end

		if var_43_0.need_finish_guide > 0 and GuideModel.instance:isGuideFinish(var_43_0.need_finish_guide) then
			return true
		end

		return false
	end

	return true
end

function var_0_0.positionOpenCount(arg_44_0)
	local var_44_0 = 0

	for iter_44_0 = 1, 4 do
		if arg_44_0:isPositionOpen(iter_44_0) then
			var_44_0 = var_44_0 + 1
		end
	end

	return var_44_0
end

function var_0_0.getPositionLockDesc(arg_45_0, arg_45_1)
	local var_45_0 = lua_open_group.configDict[arg_45_1]
	local var_45_1 = var_45_0 and var_45_0.need_episode

	if not var_45_1 or var_45_1 == 0 then
		return nil
	end

	local var_45_2 = DungeonConfig.instance:getEpisodeDisplay(var_45_1)

	return var_45_0.lock_desc, var_45_2
end

function var_0_0.getHighestLevel(arg_46_0)
	local var_46_0 = HeroSingleGroupModel.instance:getList()

	if not var_46_0 then
		return 0
	end

	local var_46_1 = 0

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		if iter_46_1.aid and iter_46_1.aid ~= -1 then
			local var_46_2 = lua_monster.configDict[tonumber(iter_46_1.aid)]

			if var_46_2 and var_46_1 < var_46_2.level then
				var_46_1 = var_46_2.level
			end
		elseif iter_46_1.heroUid then
			local var_46_3 = HeroModel.instance:getById(iter_46_1.heroUid)

			if var_46_3 and var_46_1 < var_46_3.level then
				var_46_1 = var_46_3.level
			end
		end
	end

	return var_46_1
end

function var_0_0.setHeroGroupItemPos(arg_47_0, arg_47_1)
	arg_47_0._herogroupItemPos = arg_47_1
end

function var_0_0.getHeroGroupItemPos(arg_48_0)
	return arg_48_0._herogroupItemPos
end

var_0_0.RestrictType = {
	Rare = 3,
	HeroId = 1,
	Career = 2
}

function var_0_0.initRestrictHeroData(arg_49_0, arg_49_1)
	arg_49_0.restrictHeroIdList = nil
	arg_49_0.restrictCareerList = nil
	arg_49_0.restrictRareList = nil

	local var_49_0 = arg_49_1 and arg_49_1.restrictRoles

	if string.nilorempty(var_49_0) then
		return
	end

	local var_49_1 = string.split(var_49_0, "|")
	local var_49_2
	local var_49_3

	for iter_49_0 = 1, #var_49_1 do
		local var_49_4 = string.splitToNumber(var_49_1[iter_49_0], "#")
		local var_49_5, var_49_6 = GameUtil.tabletool_fastRemoveValueByPos(var_49_4, 1)

		if var_49_6 == var_0_0.RestrictType.HeroId then
			arg_49_0.restrictHeroIdList = var_49_5
		elseif var_49_6 == var_0_0.RestrictType.Career then
			arg_49_0.restrictCareerList = var_49_5
		elseif var_49_6 == var_0_0.RestrictType.Rare then
			arg_49_0.restrictRareList = var_49_5
		else
			logError("un support restrict type : " .. tostring(var_49_6))
		end
	end
end

function var_0_0.isRestrict(arg_50_0, arg_50_1)
	local var_50_0 = arg_50_1 and HeroModel.instance:getById(arg_50_1)

	if not var_50_0 then
		return false
	end

	return arg_50_0.restrictHeroIdList and tabletool.indexOf(arg_50_0.restrictHeroIdList, var_50_0.heroId) or arg_50_0.restrictCareerList and tabletool.indexOf(arg_50_0.restrictCareerList, var_50_0.config.career) or arg_50_0.restrictRareList and tabletool.indexOf(arg_50_0.restrictRareList, var_50_0.config.rare)
end

function var_0_0.getCurrentBattleConfig(arg_51_0)
	return arg_51_0.battleConfig
end

function var_0_0.setHeroGroupType(arg_52_0, arg_52_1)
	arg_52_0._heroGroupType = arg_52_1
end

function var_0_0.getHeroGroupType(arg_53_0)
	return arg_53_0._heroGroupType
end

function var_0_0.setBattleAndEpisodeId(arg_54_0, arg_54_1, arg_54_2)
	arg_54_0.battleId = arg_54_1
	arg_54_0.episodeId = arg_54_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
