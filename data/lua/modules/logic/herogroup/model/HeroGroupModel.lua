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

function var_0_0.getCustomHeroGroupMo(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._groupTypeCustom[arg_5_1] then
		if arg_5_2 then
			return arg_5_0:getMainGroupMo()
		end

		local var_5_0 = HeroGroupMO.New()

		var_5_0:init(arg_5_0:getMainGroupMo())

		arg_5_0._groupTypeCustom[arg_5_1] = var_5_0
	end

	return arg_5_0._groupTypeCustom[arg_5_1]
end

function var_0_0.onModifyHeroGroup(arg_6_0, arg_6_1)
	local var_6_0 = {}
	local var_6_1 = arg_6_0:getById(arg_6_1.groupId)

	if var_6_1 then
		var_6_1:init(arg_6_1)
	else
		local var_6_2 = HeroGroupMO.New()

		var_6_2:init(arg_6_1)
		arg_6_0:addAtLast(var_6_2)
	end

	arg_6_0:_updateScroll()
end

function var_0_0._updateScroll(arg_7_0)
	arg_7_0:onModelUpdate()
	arg_7_0:_setSingleGroup()
end

function var_0_0.isAdventureOrWeekWalk(arg_8_0)
	return arg_8_0.adventure or arg_8_0.weekwalk
end

function var_0_0.setParam(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = {
		battleId = arg_9_1,
		episodeId = arg_9_2,
		adventure = arg_9_3,
		isReConnect = arg_9_4
	}

	arg_9_0.battleId = arg_9_1
	arg_9_0.episodeId = arg_9_2
	arg_9_0.adventure = arg_9_3

	local var_9_1 = arg_9_1 and lua_battle.configDict[arg_9_1]
	local var_9_2 = arg_9_2 and lua_episode.configDict[arg_9_2]
	local var_9_3 = var_9_2 and lua_chapter.configDict[var_9_2.chapterId]

	arg_9_0.battleConfig = var_9_1
	arg_9_0.heroGroupTypeCo = var_9_2 and HeroConfig.instance:getHeroGroupTypeCo(var_9_2.chapterId)
	arg_9_0._episodeType = var_9_2 and var_9_2.type or 0

	local var_9_4 = arg_9_0:getAmountLimit(var_9_1)

	arg_9_0.weekwalk = var_9_3 and var_9_3.type == DungeonEnum.ChapterType.WeekWalk

	local var_9_5 = false
	local var_9_6 = var_9_3 and (var_9_3.type == DungeonEnum.ChapterType.Normal or var_9_3.type == DungeonEnum.ChapterType.Hard or var_9_3.type == DungeonEnum.ChapterType.Simple)

	if var_9_6 then
		arg_9_0.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	if arg_9_0.heroGroupTypeCo then
		local var_9_7 = arg_9_0.heroGroupTypeCo.id

		if arg_9_0._episodeType > 100 then
			var_9_7 = arg_9_0._episodeType
		end

		arg_9_0.curGroupSelectIndex = arg_9_0._groupTypeSelect[var_9_7]

		if not arg_9_0.curGroupSelectIndex then
			arg_9_0.curGroupSelectIndex = arg_9_0.heroGroupTypeCo.saveGroup == 1 and 0 or 1
		end
	else
		arg_9_0.curGroupSelectIndex = 1
	end

	local var_9_8 = {}

	if var_9_1 and not string.nilorempty(var_9_1.aid) then
		var_9_8 = string.splitToNumber(var_9_1.aid, "#")
	end

	local var_9_9 = HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(arg_9_0.episodeId)

	if var_9_1 and (var_9_1.trialLimit > 0 or not string.nilorempty(var_9_1.trialEquips)) or ToughBattleModel.instance:getAddTrialHeros() or var_9_9 then
		local var_9_10 = Activity104Model.instance:isSeasonChapter()
		local var_9_11

		if var_9_10 then
			var_9_11 = PlayerPrefsHelper.getString(Activity104Model.instance:getSeasonTrialPrefsKey(), "")
		else
			var_9_11 = PlayerPrefsHelper.getString(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. var_9_1.id, "")
		end

		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Trial
		arg_9_0._curGroupId = 1

		local var_9_12

		if var_9_1.trialLimit > 0 and var_9_1.onlyTrial == 1 then
			var_9_12 = arg_9_0:generateTempGroup(nil, nil, true)
		elseif string.nilorempty(var_9_11) then
			if arg_9_0.curGroupSelectIndex > 0 then
				var_9_12 = arg_9_0:generateTempGroup(arg_9_0._commonGroups[arg_9_0.curGroupSelectIndex], var_9_4, var_9_1 and var_9_1.useTemp == 2)
			else
				var_9_12 = arg_9_0.heroGroupTypeCo and arg_9_0:getCustomHeroGroupMo(arg_9_0.heroGroupTypeCo.id, true) or arg_9_0:generateTempGroup(nil, var_9_4, var_9_1 and var_9_1.useTemp == 2)
			end
		else
			local var_9_13 = cjson.decode(var_9_11)

			GameUtil.removeJsonNull(var_9_13)

			var_9_12 = arg_9_0:generateTempGroup(nil, nil, true)

			var_9_12:initByLocalData(var_9_13)
		end

		var_9_12:setTrials(arg_9_4)

		arg_9_0._heroGroupList = {
			var_9_12
		}

		if var_9_9 then
			arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.General

			HeroGroupSnapshotModel.instance:setParam(arg_9_0.episodeId)
		end
	elseif var_9_3 and SeasonHeroGroupHandler.checkIsSeasonEpisodeType(arg_9_0._episodeType) then
		local var_9_14 = SeasonHeroGroupHandler.buildSeasonHandleFunc[arg_9_0._episodeType]

		if var_9_14 then
			arg_9_0.heroGroupType = var_9_14(var_9_0)
		end
	elseif HeroGroupHandler.checkIsEpisodeType(arg_9_0._episodeType) then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.General

		HeroGroupSnapshotModel.instance:setParam(arg_9_0.episodeId)
	elseif var_9_3 and var_9_1 and var_9_1.useTemp ~= 0 or var_9_4 or #var_9_8 > 0 or var_9_1 and ToughBattleModel.instance:getEpisodeId() then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_9_0._heroGroupList = {}

		local var_9_15

		if var_9_3 and var_9_3.saveHeroGroup and (not var_9_1 or var_9_1.useTemp ~= 2) then
			if arg_9_0.curGroupSelectIndex > 0 then
				var_9_15 = arg_9_0:generateTempGroup(arg_9_0._commonGroups[arg_9_0.curGroupSelectIndex], var_9_4, var_9_1 and var_9_1.useTemp == 2)
			else
				var_9_15 = arg_9_0.heroGroupTypeCo and arg_9_0:getCustomHeroGroupMo(arg_9_0.heroGroupTypeCo.id, true) or arg_9_0:generateTempGroup(nil, var_9_4, var_9_1 and var_9_1.useTemp == 2)
			end
		end

		local var_9_16 = arg_9_0:generateTempGroup(var_9_15, var_9_4, var_9_1 and var_9_1.useTemp == 2)

		table.insert(arg_9_0._heroGroupList, var_9_16)

		arg_9_0._curGroupId = 1
	elseif not var_9_6 and var_9_3 then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Resources
		arg_9_0._heroGroupList = {}
		arg_9_0._curGroupId = 1

		if not arg_9_0._groupTypeCustom[arg_9_0.heroGroupTypeCo.id] then
			var_9_5 = true
		end

		local var_9_17 = arg_9_0.heroGroupTypeCo and arg_9_0:getCustomHeroGroupMo(arg_9_0.heroGroupTypeCo.id) or arg_9_0._commonGroups[1]
		local var_9_18 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
			var_9_3.name
		})

		var_9_17:setTempName(var_9_18)
		table.insert(arg_9_0._heroGroupList, var_9_17)
	elseif var_9_6 then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.NormalFb
		arg_9_0._heroGroupList = {}
		arg_9_0._curGroupId = 1

		local var_9_19 = arg_9_0:getCurGroupMO()

		if var_9_19 and var_9_19.aidDict then
			var_9_19.aidDict = nil
		end
	else
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Default
		arg_9_0._heroGroupList = {}
		arg_9_0._curGroupId = 1
	end

	arg_9_0:_setSingleGroup()
	arg_9_0:initRestrictHeroData(var_9_1)

	if var_9_5 then
		arg_9_0:saveCurGroupData()
	end
end

function var_0_0.setReplayParam(arg_10_0, arg_10_1)
	arg_10_0._replayParam = arg_10_1

	if arg_10_1 then
		if arg_10_1.replay_hero_data then
			for iter_10_0, iter_10_1 in pairs(arg_10_1.replay_hero_data) do
				local var_10_0 = HeroModel.instance:getById(iter_10_0)

				if var_10_0 and var_10_0.skin > 0 then
					iter_10_1.skin = var_10_0.skin
				end
			end
		end

		arg_10_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_10_0._heroGroupList = {}
		arg_10_0._heroGroupList[arg_10_1.id] = arg_10_1
		arg_10_0._curGroupId = arg_10_1.id

		arg_10_0:_setSingleGroup()
	end
end

function var_0_0.getReplayParam(arg_11_0)
	return arg_11_0._replayParam
end

function var_0_0.getAmountLimit(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	local var_12_0 = arg_12_0:_getAmountLimit(arg_12_1.additionRule)

	if var_12_0 then
		return var_12_0
	end

	return (arg_12_0:_getAmountLimit(arg_12_1.hiddenRule))
end

function var_0_0._getAmountLimit(arg_13_0, arg_13_1)
	if LuaUtil.isEmptyStr(arg_13_1) == false then
		local var_13_0 = GameUtil.splitString2(arg_13_1, true, "|", "#")

		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			if iter_13_1[1] == FightEnum.EntitySide.MySide then
				local var_13_1 = iter_13_1[2]
				local var_13_2 = lua_rule.configDict[var_13_1]

				if var_13_2 and var_13_2.type == DungeonEnum.AdditionRuleType.AmountLimit then
					return tonumber(var_13_2.effect)
				end
			end
		end
	end
end

function var_0_0.getBattleRoleNum(arg_14_0)
	local var_14_0 = arg_14_0.episodeId
	local var_14_1

	var_14_1 = var_14_0 and lua_episode.configDict[var_14_0]

	local var_14_2 = arg_14_0.battleId
	local var_14_3 = var_14_2 and lua_battle.configDict[var_14_2]

	return arg_14_0:getAmountLimit(var_14_3) or var_14_3 and var_14_3.roleNum
end

function var_0_0.generateTempGroup(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = HeroGroupMO.New()

	if not arg_15_1 and not arg_15_3 then
		arg_15_1 = arg_15_0:getById(arg_15_0._curGroupId)
	end

	if arg_15_1 then
		var_15_0:setSeasonCardLimit(arg_15_1:getSeasonCardLimit())
	end

	local var_15_1 = arg_15_0.battleId and lua_battle.configDict[arg_15_0.battleId]

	if var_15_1 then
		local var_15_2 = {}

		if not string.nilorempty(var_15_1.aid) then
			var_15_2 = string.splitToNumber(var_15_1.aid, "#")
		end

		local var_15_3 = {}
		local var_15_4 = HeroGroupHandler.getTrialHeros(arg_15_0.episodeId)

		if not string.nilorempty(var_15_4) then
			var_15_3 = GameUtil.splitString2(var_15_4, true)
		end

		arg_15_2 = arg_15_2 or var_15_1.roleNum

		local var_15_5 = var_15_1.playerMax

		var_15_0:initWithBattle(arg_15_1 or HeroGroupMO.New(), var_15_2, arg_15_2, var_15_5, nil, var_15_3)

		if arg_15_0.adventure then
			local var_15_6 = arg_15_0.episodeId and lua_episode.configDict[arg_15_0.episodeId]

			if var_15_6 then
				local var_15_7 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
					var_15_6.name
				})

				var_15_0:setTempName(var_15_7)
			end
		end
	else
		logError("临时编队没有战斗配置，永远不该发生")
		var_15_0:init(arg_15_1)
	end

	var_15_0:setTemp(true)

	return var_15_0
end

function var_0_0.setCurGroupId(arg_16_0, arg_16_1)
	arg_16_0._curGroupId = arg_16_1

	arg_16_0:_setSingleGroup()
end

function var_0_0._setSingleGroup(arg_17_0)
	local var_17_0 = arg_17_0:getCurGroupMO()

	if not var_17_0 then
		var_17_0 = HeroGroupMO.New()

		local var_17_1 = arg_17_0._curGroupId

		if arg_17_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			var_17_1 = var_17_1 - 1
		end

		local var_17_2 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_name"), {
			luaLang("hero_group"),
			var_17_1
		})

		var_17_0:init({
			groupId = var_17_1,
			name = var_17_2
		})

		if not arg_17_0:getById(var_17_0.id) then
			arg_17_0:addAtLast(var_17_0)
		end
	end

	var_17_0:clearAidHero()
	HeroGroupHandler.hanldeHeroListData(arg_17_0.episodeId)
	HeroSingleGroupModel.instance:setSingleGroup(var_17_0, true)
end

function var_0_0.getCommonGroupName(arg_18_0, arg_18_1, arg_18_2)
	arg_18_2 = arg_18_2 or arg_18_0:getHeroGroupSnapshotType()
	arg_18_1 = arg_18_1 or arg_18_0:getHeroGroupSelectIndex()

	if arg_18_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		local var_18_0 = HeroGroupSnapshotModel.instance:getGroupName()

		if string.nilorempty(var_18_0) then
			return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_18_1))
		else
			return var_18_0
		end
	end

	local var_18_1 = arg_18_0._commonGroups[arg_18_1].name

	if string.nilorempty(var_18_1) then
		return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_18_1))
	else
		return var_18_1
	end
end

function var_0_0.setCommonGroupName(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_3 = arg_19_3 or arg_19_0:getHeroGroupSnapshotType()
	arg_19_1 = arg_19_1 or arg_19_0:getHeroGroupSelectIndex()

	if arg_19_2 == arg_19_0:getCommonGroupName(arg_19_1, arg_19_3) then
		return
	end

	if arg_19_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		HeroGroupSnapshotModel.instance:setGroupName(arg_19_3, arg_19_1, arg_19_2)
	else
		arg_19_0._commonGroups[arg_19_1].name = arg_19_2
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function var_0_0.getCurGroupMO(arg_20_0)
	if arg_20_0.heroGroupType == ModuleEnum.HeroGroupType.Temp or arg_20_0.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		return arg_20_0._heroGroupList[arg_20_0._curGroupId]
	elseif SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(arg_20_0.heroGroupType) then
		local var_20_0 = SeasonHeroGroupHandler.getSeasonCurrentHeroGroupMO[arg_20_0.heroGroupType]

		if var_20_0 then
			return var_20_0()
		end
	elseif arg_20_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
		if arg_20_0.curGroupSelectIndex == 0 then
			return arg_20_0._heroGroupList[1]
		else
			return arg_20_0._commonGroups[arg_20_0.curGroupSelectIndex]
		end
	elseif arg_20_0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
		if arg_20_0.curGroupSelectIndex == 0 then
			return arg_20_0:getMainGroupMo()
		else
			return arg_20_0._commonGroups[arg_20_0.curGroupSelectIndex]
		end
	elseif arg_20_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getCurGroup()
	else
		return arg_20_0:getById(arg_20_0._curGroupId)
	end
end

function var_0_0.getHeroGroupSelectIndex(arg_21_0)
	if arg_21_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getSelectIndex()
	end

	return arg_21_0.curGroupSelectIndex
end

function var_0_0.getHeroGroupSnapshotType(arg_22_0)
	if arg_22_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		return HeroGroupSnapshotModel.instance:getCurSnapshotId()
	end

	return ModuleEnum.HeroGroupSnapshotType.Common
end

function var_0_0.setHeroGroupSelectIndex(arg_23_0, arg_23_1)
	if arg_23_0.heroGroupType == ModuleEnum.HeroGroupType.General then
		local var_23_0 = HeroGroupSnapshotModel.instance:setSelectIndex(nil, arg_23_1)

		if var_23_0 then
			arg_23_0:_setSingleGroup()
		end

		return var_23_0
	end

	if not arg_23_0.heroGroupTypeCo then
		logError("没有配置。。")

		return
	end

	if arg_23_1 == 0 and arg_23_0.heroGroupTypeCo.saveGroup == 0 then
		logError("无法切到玩法编队")

		return
	end

	if arg_23_0.curGroupSelectIndex == arg_23_1 then
		return
	end

	arg_23_0.curGroupSelectIndex = arg_23_1

	local var_23_1 = arg_23_0.heroGroupTypeCo.id

	if arg_23_0._episodeType > 100 then
		var_23_1 = arg_23_0._episodeType
	end

	arg_23_0._groupTypeSelect[var_23_1] = arg_23_1

	arg_23_0:_setSingleGroup()
	HeroGroupRpc.instance:sendChangeHeroGroupSelectRequest(var_23_1, arg_23_1)

	return true
end

function var_0_0.getGroupTypeName(arg_24_0)
	if not arg_24_0.heroGroupTypeCo or arg_24_0.heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return arg_24_0.heroGroupTypeCo.name
end

function var_0_0.getMainGroupMo(arg_25_0)
	return arg_25_0:getById(1)
end

function var_0_0.saveCurGroupData(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = lua_episode.configDict[arg_26_0.episodeId]

	if not var_26_0 then
		return
	end

	if var_26_0.type == DungeonEnum.EpisodeType.Cachot then
		return
	end

	arg_26_3 = arg_26_3 or arg_26_0:getCurGroupMO()

	if not arg_26_3 then
		return
	end

	arg_26_3:checkAndPutOffEquip()

	if arg_26_0.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		arg_26_3:saveData()

		if arg_26_1 then
			arg_26_1(arg_26_2)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, arg_26_0.heroGroupType, 1)

		return
	end

	if arg_26_0.heroGroupType == ModuleEnum.HeroGroupType.Temp or arg_26_0.heroGroupType == ModuleEnum.HeroGroupType.Default then
		if arg_26_1 then
			arg_26_1(arg_26_2)
		end

		return
	end

	if SeasonHeroGroupHandler.NeedGetHeroCardSeason[arg_26_0.heroGroupType] then
		SeasonHeroGroupHandler.setHeroGroupSnapshot(arg_26_3, arg_26_0.heroGroupType, arg_26_0.episodeId, arg_26_1, arg_26_2)

		return
	end

	if var_26_0.type == DungeonEnum.EpisodeType.Act183 then
		Act183HeroGroupController.instance:saveGroupData(arg_26_3, arg_26_0.heroGroupType, arg_26_0.episodeId, arg_26_1, arg_26_2)

		return
	end

	local var_26_1 = arg_26_0.curGroupSelectIndex

	if var_26_1 == 0 then
		if arg_26_0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
			HeroGroupRpc.instance:sendUpdateHeroGroupRequest(arg_26_3.id, arg_26_3.heroList, arg_26_3.name, arg_26_3.clothId, arg_26_3.equips, nil, arg_26_1, arg_26_2)
		elseif arg_26_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			local var_26_2 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

			FightParam.initFightGroup(var_26_2.fightGroup, arg_26_3.clothId, arg_26_3:getMainList(), arg_26_3:getSubList(), arg_26_3:getAllHeroEquips(), arg_26_3:getAllHeroActivity104Equips())
			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Resources, arg_26_0.heroGroupTypeCo.id, var_26_2, arg_26_1, arg_26_2)
		end
	else
		local var_26_3 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

		if HeroGroupHandler.checkIsTowerEpisodeByEpisodeId(arg_26_0.episodeId) then
			FightParam.initTowerFightGroup(var_26_3.fightGroup, arg_26_3.clothId, arg_26_3:getMainList(), arg_26_3:getSubList(), arg_26_3:getAllHeroEquips(), arg_26_3:getAllHeroActivity104Equips(), arg_26_3:getAssistBossId())
		else
			FightParam.initFightGroup(var_26_3.fightGroup, arg_26_3.clothId, arg_26_3:getMainList(), arg_26_3:getSubList(), arg_26_3:getAllHeroEquips(), arg_26_3:getAllHeroActivity104Equips(), arg_26_3:getAssistBossId())
		end

		local var_26_4 = ModuleEnum.HeroGroupSnapshotType.Common
		local var_26_5 = var_26_1

		if arg_26_0.heroGroupType == ModuleEnum.HeroGroupType.General then
			var_26_4 = HeroGroupSnapshotModel.instance:getCurSnapshotId()
			var_26_5 = HeroGroupSnapshotModel.instance:getCurGroupId()
		end

		if var_26_4 and var_26_5 then
			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_26_4, var_26_5, var_26_3, arg_26_1, arg_26_2)
		else
			logError(string.format("未设置快照id, 无法保存, snapshotId:%s, snapshotSubId:%s", var_26_4, var_26_5))
		end
	end
end

function var_0_0.setHeroGroupSnapshot(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5, arg_27_6)
	local var_27_0 = {
		heroGroupType = arg_27_1,
		episodeId = arg_27_2,
		upload = arg_27_3,
		extendData = arg_27_4
	}
	local var_27_1 = arg_27_2 and lua_episode.configDict[arg_27_2]

	if not var_27_1 then
		return
	end

	local var_27_2 = 0
	local var_27_3 = 0
	local var_27_4
	local var_27_5

	if arg_27_1 == ModuleEnum.HeroGroupType.Resources then
		var_27_3, var_27_2 = var_27_1.chapterId, ModuleEnum.HeroGroupSnapshotType.Resources
		var_27_4 = arg_27_0._heroGroupList[1]
	elseif SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(arg_27_1) then
		local var_27_6 = SeasonHeroGroupHandler.setSeasonSnapShotHandleFunc[arg_27_1]

		if var_27_6 then
			var_27_2, var_27_3, var_27_4, var_27_5 = var_27_6(var_27_0)
		end
	else
		logError("暂不支持此类编队快照 : " .. tostring(arg_27_1))

		return
	end

	if var_27_4 and arg_27_3 then
		local var_27_7 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
		local var_27_8 = FightDef_pb.FightGroup()

		FightParam.initFightGroup(var_27_7.fightGroup, var_27_4.clothId, var_27_4:getMainList(), var_27_4:getSubList(), var_27_4:getAllHeroEquips(), var_27_5 or var_27_4:getAllHeroActivity104Equips())
		Season123HeroGroupUtils.processFightGroupAssistHero(arg_27_1, var_27_7.fightGroup)
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_27_2, var_27_3, var_27_7, arg_27_5, arg_27_6)
	elseif arg_27_5 then
		arg_27_5(arg_27_6)
	end
end

function var_0_0.replaceSingleGroup(arg_28_0)
	local var_28_0 = arg_28_0:getCurGroupMO()

	if var_28_0 then
		local var_28_1 = HeroSingleGroupModel.instance:getList()

		var_28_0:replaceHeroList(var_28_1)
	end
end

function var_0_0.replaceSingleGroupEquips(arg_29_0)
	local var_29_0 = arg_29_0:getCurGroupMO()
	local var_29_1 = HeroSingleGroupModel.instance:getList()
	local var_29_2
	local var_29_3

	for iter_29_0, iter_29_1 in ipairs(var_29_1) do
		local var_29_4 = HeroModel.instance:getById(iter_29_1.heroUid)

		if var_29_4 and var_29_4:hasDefaultEquip() then
			local var_29_5 = {
				index = iter_29_0 - 1,
				equipUid = {
					var_29_4.defaultEquipUid
				}
			}

			var_29_0:updatePosEquips(var_29_5)
		end
	end
end

function var_0_0.replaceCloth(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0:getCurGroupMO()

	if var_30_0 then
		var_30_0:replaceClothId(arg_30_1)
	end
end

function var_0_0.replaceEquips(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_2 or arg_31_0:getCurGroupMO()

	if var_31_0 then
		var_31_0:updatePosEquips(arg_31_1)
	end
end

function var_0_0.getCurGroupId(arg_32_0)
	return arg_32_0._curGroupId
end

function var_0_0.isPositionOpen(arg_33_0, arg_33_1)
	local var_33_0 = lua_open_group.configDict[arg_33_1]

	if not var_33_0 then
		return false
	end

	local var_33_1 = arg_33_0.episodeId and lua_episode.configDict[arg_33_0.episodeId]
	local var_33_2 = var_33_1 and lua_battle.configDict[var_33_1.battleId]
	local var_33_3 = var_33_2 and #FightStrUtil.instance:getSplitToNumberCache(var_33_2.aid, "#") or 0

	if var_33_1 and var_33_1.type == DungeonEnum.EpisodeType.Sp and arg_33_1 <= var_33_3 then
		return true
	end

	if var_33_0.need_level > 0 and PlayerModel.instance:getPlayinfo().level < var_33_0.need_level then
		return false
	end

	if var_33_0.need_episode > 0 then
		local var_33_4 = DungeonModel.instance:getEpisodeInfo(var_33_0.need_episode)

		if not var_33_4 or var_33_4.star <= 0 then
			return false
		end

		local var_33_5 = lua_episode.configDict[var_33_0.need_episode].afterStory

		if var_33_5 and var_33_5 > 0 and not StoryModel.instance:isStoryFinished(var_33_5) then
			return false
		end
	end

	if var_33_0.need_enter_episode > 0 or var_33_0.need_finish_guide > 0 then
		if var_33_0.need_enter_episode > 0 then
			local var_33_6 = DungeonModel.instance:getEpisodeInfo(var_33_0.need_enter_episode)

			if var_33_6 and var_33_6.star > 0 or arg_33_0.episodeId == var_33_0.need_enter_episode then
				return true
			end
		end

		if var_33_0.need_finish_guide > 0 and GuideModel.instance:isGuideFinish(var_33_0.need_finish_guide) then
			return true
		end

		return false
	end

	return true
end

function var_0_0.positionOpenCount(arg_34_0)
	local var_34_0 = 0

	for iter_34_0 = 1, 4 do
		if arg_34_0:isPositionOpen(iter_34_0) then
			var_34_0 = var_34_0 + 1
		end
	end

	return var_34_0
end

function var_0_0.getPositionLockDesc(arg_35_0, arg_35_1)
	local var_35_0 = lua_open_group.configDict[arg_35_1]
	local var_35_1 = var_35_0 and var_35_0.need_episode

	if not var_35_1 or var_35_1 == 0 then
		return nil
	end

	local var_35_2 = DungeonConfig.instance:getEpisodeDisplay(var_35_1)

	return var_35_0.lock_desc, var_35_2
end

function var_0_0.getHighestLevel(arg_36_0)
	local var_36_0 = HeroSingleGroupModel.instance:getList()

	if not var_36_0 then
		return 0
	end

	local var_36_1 = 0

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		if iter_36_1.aid and iter_36_1.aid ~= -1 then
			local var_36_2 = lua_monster.configDict[tonumber(iter_36_1.aid)]

			if var_36_2 and var_36_1 < var_36_2.level then
				var_36_1 = var_36_2.level
			end
		elseif iter_36_1.heroUid then
			local var_36_3 = HeroModel.instance:getById(iter_36_1.heroUid)

			if var_36_3 and var_36_1 < var_36_3.level then
				var_36_1 = var_36_3.level
			end
		end
	end

	return var_36_1
end

function var_0_0.setHeroGroupItemPos(arg_37_0, arg_37_1)
	arg_37_0._herogroupItemPos = arg_37_1
end

function var_0_0.getHeroGroupItemPos(arg_38_0)
	return arg_38_0._herogroupItemPos
end

var_0_0.RestrictType = {
	Rare = 3,
	HeroId = 1,
	Career = 2
}

function var_0_0.initRestrictHeroData(arg_39_0, arg_39_1)
	arg_39_0.restrictHeroIdList = nil
	arg_39_0.restrictCareerList = nil
	arg_39_0.restrictRareList = nil

	local var_39_0 = arg_39_1 and arg_39_1.restrictRoles

	if string.nilorempty(var_39_0) then
		return
	end

	local var_39_1 = string.split(var_39_0, "|")
	local var_39_2
	local var_39_3

	for iter_39_0 = 1, #var_39_1 do
		local var_39_4 = string.splitToNumber(var_39_1[iter_39_0], "#")
		local var_39_5, var_39_6 = GameUtil.tabletool_fastRemoveValueByPos(var_39_4, 1)

		if var_39_6 == var_0_0.RestrictType.HeroId then
			arg_39_0.restrictHeroIdList = var_39_5
		elseif var_39_6 == var_0_0.RestrictType.Career then
			arg_39_0.restrictCareerList = var_39_5
		elseif var_39_6 == var_0_0.RestrictType.Rare then
			arg_39_0.restrictRareList = var_39_5
		else
			logError("un support restrict type : " .. tostring(var_39_6))
		end
	end
end

function var_0_0.isRestrict(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_1 and HeroModel.instance:getById(arg_40_1)

	if not var_40_0 then
		return false
	end

	return arg_40_0.restrictHeroIdList and tabletool.indexOf(arg_40_0.restrictHeroIdList, var_40_0.heroId) or arg_40_0.restrictCareerList and tabletool.indexOf(arg_40_0.restrictCareerList, var_40_0.config.career) or arg_40_0.restrictRareList and tabletool.indexOf(arg_40_0.restrictRareList, var_40_0.config.rare)
end

function var_0_0.getCurrentBattleConfig(arg_41_0)
	return arg_41_0.battleConfig
end

var_0_0.instance = var_0_0.New()

return var_0_0
