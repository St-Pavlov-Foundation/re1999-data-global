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

function var_0_0.onGetCommonGroupList(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.heroGroupCommons) do
		arg_4_0._commonGroups[iter_4_1.groupId] = HeroGroupMO.New()

		arg_4_0._commonGroups[iter_4_1.groupId]:init(iter_4_1)
	end

	for iter_4_2 = 1, 4 do
		if not arg_4_0._commonGroups[iter_4_2] then
			arg_4_0._commonGroups[iter_4_2] = HeroGroupMO.New()

			arg_4_0._commonGroups[iter_4_2]:init(HeroGroupMO.New())
		end
	end

	for iter_4_3, iter_4_4 in ipairs(arg_4_1.heroGourpTypes) do
		arg_4_0._groupTypeSelect[iter_4_4.id] = iter_4_4.currentSelect

		if iter_4_4.id ~= ModuleEnum.HeroGroupServerType.Main and iter_4_4:HasField("groupInfo") then
			arg_4_0._groupTypeCustom[iter_4_4.id] = HeroGroupMO.New()

			arg_4_0._groupTypeCustom[iter_4_4.id]:init(iter_4_4.groupInfo)
		end
	end
end

function var_0_0.clearCustomHeroGroup(arg_5_0, arg_5_1)
	arg_5_0._groupTypeCustom[arg_5_1] = nil
end

function var_0_0.updateCustomHeroGroup(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = HeroGroupMO.New()

	var_6_0:init(arg_6_2)

	arg_6_0._groupTypeCustom[arg_6_1] = var_6_0
end

function var_0_0.getCustomHeroGroupMo(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._groupTypeCustom[arg_7_1] then
		if arg_7_2 then
			return arg_7_0:getMainGroupMo()
		end

		local var_7_0 = HeroGroupMO.New()

		var_7_0:init(arg_7_0:getMainGroupMo())

		arg_7_0._groupTypeCustom[arg_7_1] = var_7_0
	end

	return arg_7_0._groupTypeCustom[arg_7_1]
end

function var_0_0.onModifyHeroGroup(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = arg_8_0:getById(arg_8_1.groupId)

	if var_8_1 then
		var_8_1:init(arg_8_1)
	else
		local var_8_2 = HeroGroupMO.New()

		var_8_2:init(arg_8_1)
		arg_8_0:addAtLast(var_8_2)
	end

	arg_8_0:_updateScroll()
end

function var_0_0._updateScroll(arg_9_0)
	arg_9_0:onModelUpdate()
	arg_9_0:_setSingleGroup()
end

function var_0_0.isAdventureOrWeekWalk(arg_10_0)
	return arg_10_0.adventure or arg_10_0.weekwalk
end

function var_0_0.setParam(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	local var_11_0 = {
		battleId = arg_11_1,
		episodeId = arg_11_2,
		adventure = arg_11_3,
		isReConnect = arg_11_4
	}

	arg_11_0.battleId = arg_11_1
	arg_11_0.episodeId = arg_11_2
	arg_11_0.adventure = arg_11_3

	local var_11_1 = arg_11_1 and lua_battle.configDict[arg_11_1]
	local var_11_2 = arg_11_2 and lua_episode.configDict[arg_11_2]
	local var_11_3 = var_11_2 and lua_chapter.configDict[var_11_2.chapterId]

	arg_11_0.battleConfig = var_11_1
	arg_11_0.heroGroupTypeCo = var_11_2 and HeroConfig.instance:getHeroGroupTypeCo(var_11_2.chapterId)
	arg_11_0._episodeType = var_11_2 and var_11_2.type or 0

	if arg_11_5 then
		arg_11_0._episodeType = arg_11_5
	end

	local var_11_4 = arg_11_0:getAmountLimit(var_11_1)

	arg_11_0.weekwalk = var_11_3 and var_11_3.type == DungeonEnum.ChapterType.WeekWalk

	local var_11_5 = false
	local var_11_6 = var_11_3 and (var_11_3.type == DungeonEnum.ChapterType.Normal or var_11_3.type == DungeonEnum.ChapterType.Hard or var_11_3.type == DungeonEnum.ChapterType.Simple)

	if var_11_6 then
		arg_11_0.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	arg_11_0._isBossStory = var_11_3 and var_11_3.id == DungeonEnum.ChapterId.BossStory

	if arg_11_0._isBossStory then
		local var_11_7 = VersionActivity2_8BossConfig.instance:getHeroGroupId(arg_11_2)
		local var_11_8 = var_11_7 and lua_hero_group_type.configDict[var_11_7]

		if var_11_8 then
			arg_11_0.heroGroupTypeCo = var_11_8
		else
			logError(string.format("BossStory episodeId:%s heroGroupId:%s error", arg_11_2, var_11_7))
		end
	end

	if arg_11_0.heroGroupTypeCo then
		local var_11_9 = arg_11_0.heroGroupTypeCo.id

		if arg_11_0._episodeType > 100 then
			var_11_9 = arg_11_0._episodeType
		end

		arg_11_0.curGroupSelectIndex = arg_11_0._groupTypeSelect[var_11_9]

		if not arg_11_0.curGroupSelectIndex then
			arg_11_0.curGroupSelectIndex = arg_11_0.heroGroupTypeCo.saveGroup == 1 and 0 or 1
		end
	else
		arg_11_0.curGroupSelectIndex = 1
	end

	local var_11_10 = {}

	if var_11_1 and not string.nilorempty(var_11_1.aid) then
		var_11_10 = string.splitToNumber(var_11_1.aid, "#")
	end

	local var_11_11 = HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(arg_11_0.episodeId)

	if var_11_1 and (var_11_1.trialLimit > 0 or not string.nilorempty(var_11_1.trialEquips)) or ToughBattleModel.instance:getAddTrialHeros() or var_11_11 then
		local var_11_12 = Activity104Model.instance:isSeasonChapter()
		local var_11_13

		if var_11_12 then
			var_11_13 = PlayerPrefsHelper.getString(Activity104Model.instance:getSeasonTrialPrefsKey(), "")
		else
			var_11_13 = PlayerPrefsHelper.getString(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. var_11_1.id, "")
		end

		arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.Trial
		arg_11_0._curGroupId = 1

		local var_11_14

		if var_11_1.trialLimit > 0 and var_11_1.onlyTrial == 1 then
			var_11_14 = arg_11_0:generateTempGroup(nil, nil, true)
		elseif string.nilorempty(var_11_13) or arg_11_0._isBossStory then
			if arg_11_0.curGroupSelectIndex > 0 then
				var_11_14 = arg_11_0:generateTempGroup(arg_11_0._commonGroups[arg_11_0.curGroupSelectIndex], var_11_4, var_11_1 and var_11_1.useTemp == 2)
			else
				var_11_14 = arg_11_0.heroGroupTypeCo and arg_11_0:getCustomHeroGroupMo(arg_11_0.heroGroupTypeCo.id, true)
				var_11_14 = arg_11_0:generateTempGroup(var_11_14, var_11_4, var_11_1 and var_11_1.useTemp == 2)
			end
		else
			local var_11_15 = cjson.decode(var_11_13)

			GameUtil.removeJsonNull(var_11_15)

			var_11_14 = arg_11_0:generateTempGroup(nil, nil, true)

			var_11_14:initByLocalData(var_11_15)
		end

		var_11_14:setTrials(arg_11_4)

		arg_11_0._heroGroupList = {
			var_11_14
		}

		if var_11_11 then
			arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.General

			HeroGroupSnapshotModel.instance:setParam(arg_11_0.episodeId)
		end
	elseif var_11_3 and SeasonHeroGroupHandler.checkIsSeasonEpisodeType(arg_11_0._episodeType) then
		local var_11_16 = SeasonHeroGroupHandler.buildSeasonHandleFunc[arg_11_0._episodeType]

		if var_11_16 then
			arg_11_0.heroGroupType = var_11_16(var_11_0)
		end
	elseif arg_11_0._episodeType == DungeonEnum.EpisodeType.Odyssey then
		arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.Odyssey

		HeroSingleGroupModel.instance:setMaxHeroCount(OdysseyEnum.MaxHeroGroupCount)
	elseif V2a9BossRushModel.instance:isV2a9BossRushSecondStageSpecialLayer(arg_11_0._episodeType, arg_11_0.episodeId) then
		arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.Odyssey

		HeroSingleGroupModel.instance:setMaxHeroCount(OdysseyEnum.MaxHeroGroupCount)
	elseif HeroGroupHandler.checkIsEpisodeType(arg_11_0._episodeType) then
		arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.General

		HeroGroupSnapshotModel.instance:setParam(arg_11_0.episodeId)
	elseif var_11_3 and var_11_1 and var_11_1.useTemp ~= 0 or var_11_4 or #var_11_10 > 0 or var_11_1 and ToughBattleModel.instance:getEpisodeId() then
		arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_11_0._heroGroupList = {}

		local var_11_17

		if var_11_3 and var_11_3.saveHeroGroup and (not var_11_1 or var_11_1.useTemp ~= 2) then
			if arg_11_0.curGroupSelectIndex > 0 then
				var_11_17 = arg_11_0:generateTempGroup(arg_11_0._commonGroups[arg_11_0.curGroupSelectIndex], var_11_4, var_11_1 and var_11_1.useTemp == 2)
			else
				var_11_17 = arg_11_0.heroGroupTypeCo and arg_11_0:getCustomHeroGroupMo(arg_11_0.heroGroupTypeCo.id, true) or arg_11_0:generateTempGroup(nil, var_11_4, var_11_1 and var_11_1.useTemp == 2)
			end
		end

		if arg_11_0._isBossStory then
			arg_11_0:_clearAids(var_11_17)
		end

		local var_11_18 = arg_11_0:generateTempGroup(var_11_17, var_11_4, var_11_1 and var_11_1.useTemp == 2)

		table.insert(arg_11_0._heroGroupList, var_11_18)

		arg_11_0._curGroupId = 1
	elseif not var_11_6 and var_11_3 then
		arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.Resources
		arg_11_0._heroGroupList = {}
		arg_11_0._curGroupId = 1

		if not arg_11_0._groupTypeCustom[arg_11_0.heroGroupTypeCo.id] then
			var_11_5 = true
		end

		local var_11_19 = arg_11_0.heroGroupTypeCo and arg_11_0:getCustomHeroGroupMo(arg_11_0.heroGroupTypeCo.id) or arg_11_0._commonGroups[1]
		local var_11_20 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
			var_11_3.name
		})

		var_11_19:setTempName(var_11_20)
		table.insert(arg_11_0._heroGroupList, var_11_19)
	elseif var_11_6 then
		arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.NormalFb
		arg_11_0._heroGroupList = {}
		arg_11_0._curGroupId = 1

		local var_11_21 = arg_11_0:getCurGroupMO()

		if var_11_21 and var_11_21.aidDict then
			var_11_21.aidDict = nil
		end

		if DungeonController.checkEpisodeFiveHero(arg_11_0.episodeId) then
			arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.General

			HeroGroupSnapshotModel.instance:setParam(arg_11_0.episodeId)
		end
	else
		arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.Default
		arg_11_0._heroGroupList = {}
		arg_11_0._curGroupId = 1
	end

	arg_11_0:_setSingleGroup()
	arg_11_0:initRestrictHeroData(var_11_1)

	if var_11_5 then
		arg_11_0:saveCurGroupData()
	end
end

function var_0_0._clearAids(arg_12_0, arg_12_1)
	if not arg_12_1 or not arg_12_1.heroList then
		return
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_1.heroList) do
		if iter_12_1 == "-1" then
			arg_12_1.heroList[iter_12_0] = "0"
		end
	end
end

function var_0_0.setReplayParam(arg_13_0, arg_13_1)
	arg_13_0._replayParam = arg_13_1

	if arg_13_1 then
		if arg_13_1.replay_hero_data then
			for iter_13_0, iter_13_1 in pairs(arg_13_1.replay_hero_data) do
				local var_13_0 = HeroModel.instance:getById(iter_13_0)

				if var_13_0 and var_13_0.skin > 0 then
					iter_13_1.skin = var_13_0.skin
				end
			end
		end

		arg_13_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_13_0._heroGroupList = {}
		arg_13_0._heroGroupList[arg_13_1.id] = arg_13_1
		arg_13_0._curGroupId = arg_13_1.id

		arg_13_0:_setSingleGroup()
	end
end

function var_0_0.getReplayParam(arg_14_0)
	return arg_14_0._replayParam
end

function var_0_0.getAmountLimit(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return
	end

	local var_15_0 = arg_15_0:_getAmountLimit(arg_15_1.additionRule)

	if var_15_0 then
		return var_15_0
	end

	return (arg_15_0:_getAmountLimit(arg_15_1.hiddenRule))
end

function var_0_0._getAmountLimit(arg_16_0, arg_16_1)
	if LuaUtil.isEmptyStr(arg_16_1) == false then
		local var_16_0 = GameUtil.splitString2(arg_16_1, true, "|", "#")

		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			if iter_16_1[1] == FightEnum.EntitySide.MySide then
				local var_16_1 = iter_16_1[2]
				local var_16_2 = lua_rule.configDict[var_16_1]

				if var_16_2 and var_16_2.type == DungeonEnum.AdditionRuleType.AmountLimit then
					return tonumber(var_16_2.effect)
				end
			end
		end
	end
end

function var_0_0.getBattleRoleNum(arg_17_0)
	if arg_17_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		return OdysseyEnum.MaxHeroGroupCount
	end

	local var_17_0 = arg_17_0.episodeId
	local var_17_1

	var_17_1 = var_17_0 and lua_episode.configDict[var_17_0]

	local var_17_2 = arg_17_0.battleId
	local var_17_3 = var_17_2 and lua_battle.configDict[var_17_2]

	return arg_17_0:getAmountLimit(var_17_3) or var_17_3 and var_17_3.roleNum
end

function var_0_0.generateTempGroup(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = HeroGroupMO.New()

	if not arg_18_1 and not arg_18_3 then
		arg_18_1 = arg_18_0:getById(arg_18_0._curGroupId)
	end

	if arg_18_1 then
		var_18_0:setSeasonCardLimit(arg_18_1:getSeasonCardLimit())
	end

	local var_18_1 = arg_18_0.battleId and lua_battle.configDict[arg_18_0.battleId]

	if var_18_1 then
		local var_18_2 = {}

		if not string.nilorempty(var_18_1.aid) then
			var_18_2 = string.splitToNumber(var_18_1.aid, "#")
		end

		local var_18_3 = {}
		local var_18_4 = HeroGroupHandler.getTrialHeros(arg_18_0.episodeId)

		if not string.nilorempty(var_18_4) then
			var_18_3 = GameUtil.splitString2(var_18_4, true)
		end

		arg_18_2 = arg_18_2 or var_18_1.roleNum

		local var_18_5 = var_18_1.playerMax

		var_18_0:initWithBattle(arg_18_1 or HeroGroupMO.New(), var_18_2, arg_18_2, var_18_5, nil, var_18_3)

		if arg_18_0.adventure then
			local var_18_6 = arg_18_0.episodeId and lua_episode.configDict[arg_18_0.episodeId]

			if var_18_6 then
				local var_18_7 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
					var_18_6.name
				})

				var_18_0:setTempName(var_18_7)
			end
		end
	else
		logError("临时编队没有战斗配置，永远不该发生")
		var_18_0:init(arg_18_1)
	end

	var_18_0:setTemp(true)

	return var_18_0
end

function var_0_0.setCurGroupId(arg_19_0, arg_19_1)
	arg_19_0._curGroupId = arg_19_1

	arg_19_0:_setSingleGroup()
end

function var_0_0._setSingleGroup(arg_20_0)
	local var_20_0 = arg_20_0:getCurGroupMO()

	if not var_20_0 then
		var_20_0 = HeroGroupMO.New()

		local var_20_1 = arg_20_0._curGroupId

		if arg_20_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			var_20_1 = var_20_1 - 1
		end

		local var_20_2 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_name"), {
			luaLang("hero_group"),
			var_20_1
		})

		var_20_0:init({
			groupId = var_20_1,
			name = var_20_2
		})

		if not arg_20_0:getById(var_20_0.id) then
			arg_20_0:addAtLast(var_20_0)
		end
	end

	var_20_0:clearAidHero()
	HeroGroupHandler.hanldeHeroListData(arg_20_0.episodeId)
	HeroSingleGroupModel.instance:setSingleGroup(var_20_0, true)
end

function var_0_0.getCommonGroupName(arg_21_0, arg_21_1, arg_21_2)
	arg_21_2 = arg_21_2 or arg_21_0:getHeroGroupSnapshotType()
	arg_21_1 = arg_21_1 or arg_21_0:getHeroGroupSelectIndex()

	if arg_21_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		local var_21_0 = HeroGroupSnapshotModel.instance:getGroupName()

		if string.nilorempty(var_21_0) then
			return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_21_1))
		else
			return var_21_0
		end
	end

	local var_21_1 = arg_21_0._commonGroups[arg_21_1].name

	if string.nilorempty(var_21_1) then
		return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_21_1))
	else
		return var_21_1
	end
end

function var_0_0.setCommonGroupName(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_3 = arg_22_3 or arg_22_0:getHeroGroupSnapshotType()
	arg_22_1 = arg_22_1 or arg_22_0:getHeroGroupSelectIndex()

	if arg_22_2 == arg_22_0:getCommonGroupName(arg_22_1, arg_22_3) then
		return
	end

	if arg_22_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		HeroGroupSnapshotModel.instance:setGroupName(arg_22_3, arg_22_1, arg_22_2)
	else
		arg_22_0._commonGroups[arg_22_1].name = arg_22_2
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function var_0_0.getCurGroupMO(arg_23_0)
	if arg_23_0.heroGroupType == ModuleEnum.HeroGroupType.Temp or arg_23_0.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		return arg_23_0._heroGroupList[arg_23_0._curGroupId]
	elseif SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(arg_23_0.heroGroupType) then
		local var_23_0 = SeasonHeroGroupHandler.getSeasonCurrentHeroGroupMO[arg_23_0.heroGroupType]

		if var_23_0 then
			return var_23_0()
		end
	elseif arg_23_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
		if arg_23_0.curGroupSelectIndex == 0 then
			return arg_23_0._heroGroupList[1]
		else
			return arg_23_0._commonGroups[arg_23_0.curGroupSelectIndex]
		end
	elseif arg_23_0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
		if arg_23_0.curGroupSelectIndex == 0 then
			return arg_23_0:getMainGroupMo()
		else
			return arg_23_0._commonGroups[arg_23_0.curGroupSelectIndex]
		end
	elseif arg_23_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getCurGroup()
	elseif arg_23_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		return OdysseyHeroGroupModel.instance:getCurHeroGroup()
	else
		return arg_23_0:getById(arg_23_0._curGroupId)
	end
end

function var_0_0.getHeroGroupSelectIndex(arg_24_0)
	if arg_24_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getSelectIndex()
	end

	return arg_24_0.curGroupSelectIndex
end

function var_0_0.getHeroGroupSnapshotType(arg_25_0)
	if arg_25_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getCurSnapshotId()
	end

	return ModuleEnum.HeroGroupSnapshotType.Common
end

function var_0_0.setHeroGroupSelectIndex(arg_26_0, arg_26_1)
	if arg_26_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		local var_26_0 = HeroGroupSnapshotModel.instance:setSelectIndex(nil, arg_26_1)

		if var_26_0 then
			arg_26_0:_setSingleGroup()
		end

		return var_26_0
	end

	if arg_26_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		arg_26_0:_setSingleGroup()

		return
	end

	if not arg_26_0.heroGroupTypeCo then
		logError("没有配置。。")

		return
	end

	if arg_26_1 == 0 and arg_26_0.heroGroupTypeCo.saveGroup == 0 then
		logError("无法切到玩法编队")

		return
	end

	if arg_26_0.curGroupSelectIndex == arg_26_1 then
		return
	end

	arg_26_0.curGroupSelectIndex = arg_26_1

	local var_26_1 = arg_26_0.heroGroupTypeCo.id

	if arg_26_0._episodeType > 100 then
		var_26_1 = arg_26_0._episodeType
	end

	if var_26_1 == 1 and arg_26_1 == ModuleEnum.FiveHeroEnum.FifthIndex then
		logError("编队设置错误，加个保底以及打印log线上确认问题")

		arg_26_1 = arg_26_0._groupTypeSelect[var_26_1] or 0
		arg_26_1 = math.min(arg_26_1, 4)
	end

	arg_26_0._groupTypeSelect[var_26_1] = arg_26_1

	arg_26_0:_setSingleGroup()
	HeroGroupRpc.instance:sendChangeHeroGroupSelectRequest(var_26_1, arg_26_1)

	return true
end

function var_0_0.getGroupTypeName(arg_27_0)
	if not arg_27_0.heroGroupTypeCo or arg_27_0.heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return arg_27_0.heroGroupTypeCo.name
end

function var_0_0.getMainGroupMo(arg_28_0)
	return arg_28_0:getById(1)
end

function var_0_0.saveCurGroupData(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = lua_episode.configDict[arg_29_0.episodeId]

	if not var_29_0 then
		if arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
			OdysseyHeroGroupController.instance:saveHeroGroupInfo(arg_29_3, nil, arg_29_1, arg_29_2)
		end

		return
	end

	if var_29_0.type == DungeonEnum.EpisodeType.Cachot then
		return
	end

	arg_29_3 = arg_29_3 or arg_29_0:getCurGroupMO()

	if not arg_29_3 then
		return
	end

	arg_29_3:checkAndPutOffEquip()

	if arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		arg_29_3:saveData()

		if arg_29_1 then
			arg_29_1(arg_29_2)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, arg_29_0.heroGroupType, 1)

		return
	end

	if arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.Temp or arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.Default then
		if arg_29_1 then
			arg_29_1(arg_29_2)
		end

		return
	end

	if SeasonHeroGroupHandler.NeedGetHeroCardSeason[arg_29_0.heroGroupType] then
		SeasonHeroGroupHandler.setHeroGroupSnapshot(arg_29_3, arg_29_0.heroGroupType, arg_29_0.episodeId, arg_29_1, arg_29_2)

		return
	end

	if var_29_0.type == DungeonEnum.EpisodeType.Act183 then
		Act183HeroGroupController.instance:saveGroupData(arg_29_3, arg_29_0.heroGroupType, arg_29_0.episodeId, arg_29_1, arg_29_2)

		return
	end

	if DungeonController.checkEpisodeFiveHero(arg_29_0.episodeId) then
		DungeonController.saveFiveHeroGroupData(arg_29_3, arg_29_0.heroGroupType, arg_29_0.episodeId, arg_29_1, arg_29_2)

		return
	end

	local var_29_1 = arg_29_0.curGroupSelectIndex

	if var_29_1 == 0 then
		if arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
			HeroGroupRpc.instance:sendUpdateHeroGroupRequest(arg_29_3.id, arg_29_3.heroList, arg_29_3.name, arg_29_3.clothId, arg_29_3.equips, nil, arg_29_1, arg_29_2)
		elseif arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			local var_29_2 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

			FightParam.initFightGroup(var_29_2.fightGroup, arg_29_3.clothId, arg_29_3:getMainList(), arg_29_3:getSubList(), arg_29_3:getAllHeroEquips(), arg_29_3:getAllHeroActivity104Equips())
			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Resources, arg_29_0.heroGroupTypeCo.id, var_29_2, arg_29_1, arg_29_2)
		end
	else
		local var_29_3 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

		if HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(arg_29_0.episodeId) then
			FightParam.initTowerFightGroup(var_29_3.fightGroup, arg_29_3.clothId, arg_29_3:getMainList(), arg_29_3:getSubList(), arg_29_3:getAllHeroEquips(), arg_29_3:getAllHeroActivity104Equips(), arg_29_3:getAssistBossId())
		else
			FightParam.initFightGroup(var_29_3.fightGroup, arg_29_3.clothId, arg_29_3:getMainList(), arg_29_3:getSubList(), arg_29_3:getAllHeroEquips(), arg_29_3:getAllHeroActivity104Equips(), arg_29_3:getAssistBossId())
		end

		if arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
			OdysseyHeroGroupController.instance:saveHeroGroupInfo(arg_29_3, nil, arg_29_1, arg_29_2)

			return
		end

		local var_29_4 = ModuleEnum.HeroGroupSnapshotType.Common
		local var_29_5 = var_29_1

		if arg_29_0.heroGroupType == ModuleEnum.HeroGroupType.General then
			var_29_4 = HeroGroupSnapshotModel.instance:getCurSnapshotId()
			var_29_5 = HeroGroupSnapshotModel.instance:getCurGroupId()
		end

		if var_29_4 and var_29_5 then
			if var_29_0.type == DungeonEnum.EpisodeType.Survival then
				local var_29_6 = SurvivalMapModel.instance:getSceneMo().teamInfo

				if var_29_6 and var_29_6.assistMO then
					for iter_29_0, iter_29_1 in ipairs(var_29_3.fightGroup.heroList) do
						if var_29_6.assistMO.heroUid == iter_29_1 then
							var_29_3.fightGroup.assistHeroUid = var_29_6.assistMO.heroUid
							var_29_3.fightGroup.assistUserId = var_29_6.assistMO.userId
						end
					end
				end
			end

			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_29_4, var_29_5, var_29_3, arg_29_1, arg_29_2)
		else
			logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", var_29_4, var_29_5))
		end
	end
end

function var_0_0.setHeroGroupSnapshot(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6)
	local var_30_0 = {
		heroGroupType = arg_30_1,
		episodeId = arg_30_2,
		upload = arg_30_3,
		extendData = arg_30_4
	}
	local var_30_1 = arg_30_2 and lua_episode.configDict[arg_30_2]

	if not var_30_1 then
		return
	end

	local var_30_2 = 0
	local var_30_3 = 0
	local var_30_4
	local var_30_5

	if arg_30_1 == ModuleEnum.HeroGroupType.Resources then
		var_30_3, var_30_2 = var_30_1.chapterId, ModuleEnum.HeroGroupSnapshotType.Resources
		var_30_4 = arg_30_0._heroGroupList[1]
	elseif SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(arg_30_1) then
		local var_30_6 = SeasonHeroGroupHandler.setSeasonSnapShotHandleFunc[arg_30_1]

		if var_30_6 then
			var_30_2, var_30_3, var_30_4, var_30_5 = var_30_6(var_30_0)
		end
	else
		logError("暂不支持此类编队快照 : " .. tostring(arg_30_1))

		return
	end

	if var_30_4 and arg_30_3 then
		local var_30_7 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
		local var_30_8 = FightDef_pb.FightGroup()

		FightParam.initFightGroup(var_30_7.fightGroup, var_30_4.clothId, var_30_4:getMainList(), var_30_4:getSubList(), var_30_4:getAllHeroEquips(), var_30_5 or var_30_4:getAllHeroActivity104Equips())
		Season123HeroGroupUtils.processFightGroupAssistHero(arg_30_1, var_30_7.fightGroup)
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_30_2, var_30_3, var_30_7, arg_30_5, arg_30_6)
	elseif arg_30_5 then
		arg_30_5(arg_30_6)
	end
end

function var_0_0.replaceSingleGroup(arg_31_0)
	local var_31_0 = arg_31_0:getCurGroupMO()

	if var_31_0 then
		local var_31_1 = HeroSingleGroupModel.instance:getList()

		var_31_0:replaceHeroList(var_31_1)
	end
end

function var_0_0.replaceSingleGroupEquips(arg_32_0)
	local var_32_0 = arg_32_0:getCurGroupMO()
	local var_32_1 = HeroSingleGroupModel.instance:getList()
	local var_32_2
	local var_32_3

	for iter_32_0, iter_32_1 in ipairs(var_32_1) do
		local var_32_4 = HeroModel.instance:getById(iter_32_1.heroUid)

		if var_32_4 and var_32_4:hasDefaultEquip() then
			local var_32_5 = {
				index = iter_32_0 - 1,
				equipUid = {
					var_32_4.defaultEquipUid
				}
			}

			var_32_0:updatePosEquips(var_32_5)
		end
	end
end

function var_0_0.replaceCloth(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getCurGroupMO()

	if var_33_0 then
		var_33_0:replaceClothId(arg_33_1)
	end
end

function var_0_0.replaceEquips(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_2 or arg_34_0:getCurGroupMO()

	if var_34_0 then
		var_34_0:updatePosEquips(arg_34_1)
	end
end

function var_0_0.getCurGroupId(arg_35_0)
	return arg_35_0._curGroupId
end

function var_0_0.isPositionOpen(arg_36_0, arg_36_1)
	if arg_36_0.heroGroupType == ModuleEnum.HeroGroupType.Odyssey then
		return OdysseyHeroGroupModel.instance:isPositionOpen(arg_36_1)
	end

	local var_36_0 = lua_open_group.configDict[arg_36_1]

	if not var_36_0 then
		if arg_36_1 == ModuleEnum.FiveHeroEnum.MaxHeroNum and DungeonController.checkEpisodeFiveHero(arg_36_0.episodeId) then
			return true
		end

		return false
	end

	local var_36_1 = arg_36_0.episodeId and lua_episode.configDict[arg_36_0.episodeId]
	local var_36_2 = var_36_1 and lua_battle.configDict[var_36_1.battleId]
	local var_36_3 = var_36_2 and #FightStrUtil.instance:getSplitToNumberCache(var_36_2.aid, "#") or 0

	if var_36_1 and var_36_1.type == DungeonEnum.EpisodeType.Sp and arg_36_1 <= var_36_3 then
		return true
	end

	if var_36_0.need_level > 0 and PlayerModel.instance:getPlayinfo().level < var_36_0.need_level then
		return false
	end

	if var_36_0.need_episode > 0 then
		local var_36_4 = DungeonModel.instance:getEpisodeInfo(var_36_0.need_episode)

		if not var_36_4 or var_36_4.star <= 0 then
			return false
		end

		local var_36_5 = lua_episode.configDict[var_36_0.need_episode].afterStory

		if var_36_5 and var_36_5 > 0 and not StoryModel.instance:isStoryFinished(var_36_5) then
			return false
		end
	end

	if var_36_0.need_enter_episode > 0 or var_36_0.need_finish_guide > 0 then
		if var_36_0.need_enter_episode > 0 then
			local var_36_6 = DungeonModel.instance:getEpisodeInfo(var_36_0.need_enter_episode)

			if var_36_6 and var_36_6.star > 0 or arg_36_0.episodeId == var_36_0.need_enter_episode then
				return true
			end
		end

		if var_36_0.need_finish_guide > 0 and GuideModel.instance:isGuideFinish(var_36_0.need_finish_guide) then
			return true
		end

		return false
	end

	return true
end

function var_0_0.positionOpenCount(arg_37_0)
	local var_37_0 = 0

	for iter_37_0 = 1, 4 do
		if arg_37_0:isPositionOpen(iter_37_0) then
			var_37_0 = var_37_0 + 1
		end
	end

	return var_37_0
end

function var_0_0.getPositionLockDesc(arg_38_0, arg_38_1)
	local var_38_0 = lua_open_group.configDict[arg_38_1]
	local var_38_1 = var_38_0 and var_38_0.need_episode

	if not var_38_1 or var_38_1 == 0 then
		return nil
	end

	local var_38_2 = DungeonConfig.instance:getEpisodeDisplay(var_38_1)

	return var_38_0.lock_desc, var_38_2
end

function var_0_0.getHighestLevel(arg_39_0)
	local var_39_0 = HeroSingleGroupModel.instance:getList()

	if not var_39_0 then
		return 0
	end

	local var_39_1 = 0

	for iter_39_0, iter_39_1 in ipairs(var_39_0) do
		if iter_39_1.aid and iter_39_1.aid ~= -1 then
			local var_39_2 = lua_monster.configDict[tonumber(iter_39_1.aid)]

			if var_39_2 and var_39_1 < var_39_2.level then
				var_39_1 = var_39_2.level
			end
		elseif iter_39_1.heroUid then
			local var_39_3 = HeroModel.instance:getById(iter_39_1.heroUid)

			if var_39_3 and var_39_1 < var_39_3.level then
				var_39_1 = var_39_3.level
			end
		end
	end

	return var_39_1
end

function var_0_0.setHeroGroupItemPos(arg_40_0, arg_40_1)
	arg_40_0._herogroupItemPos = arg_40_1
end

function var_0_0.getHeroGroupItemPos(arg_41_0)
	return arg_41_0._herogroupItemPos
end

var_0_0.RestrictType = {
	Rare = 3,
	HeroId = 1,
	Career = 2
}

function var_0_0.initRestrictHeroData(arg_42_0, arg_42_1)
	arg_42_0.restrictHeroIdList = nil
	arg_42_0.restrictCareerList = nil
	arg_42_0.restrictRareList = nil

	local var_42_0 = arg_42_1 and arg_42_1.restrictRoles

	if string.nilorempty(var_42_0) then
		return
	end

	local var_42_1 = string.split(var_42_0, "|")
	local var_42_2
	local var_42_3

	for iter_42_0 = 1, #var_42_1 do
		local var_42_4 = string.splitToNumber(var_42_1[iter_42_0], "#")
		local var_42_5, var_42_6 = GameUtil.tabletool_fastRemoveValueByPos(var_42_4, 1)

		if var_42_6 == var_0_0.RestrictType.HeroId then
			arg_42_0.restrictHeroIdList = var_42_5
		elseif var_42_6 == var_0_0.RestrictType.Career then
			arg_42_0.restrictCareerList = var_42_5
		elseif var_42_6 == var_0_0.RestrictType.Rare then
			arg_42_0.restrictRareList = var_42_5
		else
			logError("un support restrict type : " .. tostring(var_42_6))
		end
	end
end

function var_0_0.isRestrict(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_1 and HeroModel.instance:getById(arg_43_1)

	if not var_43_0 then
		return false
	end

	return arg_43_0.restrictHeroIdList and tabletool.indexOf(arg_43_0.restrictHeroIdList, var_43_0.heroId) or arg_43_0.restrictCareerList and tabletool.indexOf(arg_43_0.restrictCareerList, var_43_0.config.career) or arg_43_0.restrictRareList and tabletool.indexOf(arg_43_0.restrictRareList, var_43_0.config.rare)
end

function var_0_0.getCurrentBattleConfig(arg_44_0)
	return arg_44_0.battleConfig
end

function var_0_0.setHeroGroupType(arg_45_0, arg_45_1)
	arg_45_0._heroGroupType = arg_45_1
end

function var_0_0.getHeroGroupType(arg_46_0)
	return arg_46_0._heroGroupType
end

var_0_0.instance = var_0_0.New()

return var_0_0
