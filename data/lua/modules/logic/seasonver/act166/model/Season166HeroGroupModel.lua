module("modules.logic.seasonver.act166.model.Season166HeroGroupModel", package.seeall)

local var_0_0 = class("Season166HeroGroupModel", BaseModel)

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
	arg_2_0.battleId = nil
	arg_2_0.episodeId = nil
	arg_2_0.adventure = nil
	arg_2_0.battleConfig = nil
	arg_2_0.heroGroupTypeCo = nil
	arg_2_0.episodeType = nil
	arg_2_0.weekwalk = nil
	arg_2_0.curGroupSelectIndex = 1
end

function var_0_0.onGetHeroGroupList(arg_3_0, arg_3_1)
	local var_3_0 = {}
	local var_3_1

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_2 = Season166HeroGroupMO.New()

		var_3_2:init(arg_3_1[iter_3_0])
		table.insert(var_3_0, var_3_2)
	end

	arg_3_0:setList(var_3_0)
end

function var_0_0.onGetCommonGroupList(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1.heroGroupCommons) do
		arg_4_0._commonGroups[iter_4_1.groupId] = Season166HeroGroupMO.New()

		arg_4_0._commonGroups[iter_4_1.groupId]:init(iter_4_1)
	end

	for iter_4_2 = 1, arg_4_0:getMaxHeroCountInGroup() do
		if not arg_4_0._commonGroups[iter_4_2] then
			arg_4_0._commonGroups[iter_4_2] = Season166HeroGroupMO.New()

			arg_4_0._commonGroups[iter_4_2]:init(Season166HeroGroupMO.New())
		end
	end

	for iter_4_3, iter_4_4 in ipairs(arg_4_1.heroGourpTypes) do
		arg_4_0._groupTypeSelect[iter_4_4.id] = iter_4_4.currentSelect

		if iter_4_4.id ~= ModuleEnum.HeroGroupServerType.Main and iter_4_4:HasField("groupInfo") then
			arg_4_0._groupTypeCustom[iter_4_4.id] = Season166HeroGroupMO.New()

			arg_4_0._groupTypeCustom[iter_4_4.id]:init(iter_4_4.groupInfo)
		end
	end
end

function var_0_0.getCustomHeroGroupMo(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._groupTypeCustom[arg_5_1] then
		if arg_5_2 then
			return arg_5_0:getMainGroupMo()
		end

		local var_5_0 = Season166HeroGroupMO.New()

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
		local var_6_2 = Season166HeroGroupMO.New()

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
	arg_9_0.actId = Season166Model.instance:getCurSeasonId()

	local var_9_1 = arg_9_1 and lua_battle.configDict[arg_9_1]
	local var_9_2 = arg_9_2 and lua_episode.configDict[arg_9_2]
	local var_9_3 = var_9_2 and lua_chapter.configDict[var_9_2.chapterId]

	arg_9_0.episodeConfig = var_9_2
	arg_9_0.battleConfig = var_9_1
	arg_9_0.heroGroupTypeCo = var_9_2 and HeroConfig.instance:getHeroGroupTypeCo(var_9_2.chapterId)
	arg_9_0.episodeType = var_9_2 and var_9_2.type or 0

	local var_9_4 = arg_9_0:getAmountLimit(var_9_1)

	arg_9_0.weekwalk = var_9_3 and var_9_3.type == DungeonEnum.ChapterType.WeekWalk

	local var_9_5 = false
	local var_9_6 = var_9_3 and (var_9_3.type == DungeonEnum.ChapterType.Normal or var_9_3.type == DungeonEnum.ChapterType.Hard or var_9_3.type == DungeonEnum.ChapterType.Simple)

	if var_9_6 then
		arg_9_0.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	if arg_9_0.heroGroupTypeCo then
		local var_9_7 = arg_9_0.heroGroupTypeCo.id

		if arg_9_0.episodeType > 100 then
			var_9_7 = arg_9_0.episodeType
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

	if var_9_1 and (var_9_1.trialLimit > 0 or not string.nilorempty(var_9_1.trialEquips)) or ToughBattleModel.instance:getAddTrialHeros() then
		local var_9_9 = Activity104Model.instance:isSeasonChapter()
		local var_9_10

		if var_9_9 then
			var_9_10 = PlayerPrefsHelper.getString(Activity104Model.instance:getSeasonTrialPrefsKey(), "")
		else
			var_9_10 = PlayerPrefsHelper.getString(arg_9_0.actId .. "#" .. PlayerPrefsKey.Season166HeroGroupTrial .. "#" .. tostring(PlayerModel.instance:getMyUserId()) .. "#" .. var_9_1.id, "")
		end

		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Season166Base
		arg_9_0._curGroupId = 1

		local var_9_11

		if var_9_1.trialLimit > 0 and var_9_1.onlyTrial == 1 then
			var_9_11 = arg_9_0:generateTempGroup(nil, nil, true)
		elseif string.nilorempty(var_9_10) then
			if arg_9_0.curGroupSelectIndex > 0 then
				var_9_11 = arg_9_0:generateTempGroup(arg_9_0._commonGroups[arg_9_0.curGroupSelectIndex], var_9_4, var_9_1 and var_9_1.useTemp == 2)
			else
				var_9_11 = arg_9_0.heroGroupTypeCo and arg_9_0:getCustomHeroGroupMo(arg_9_0.heroGroupTypeCo.id, true) or arg_9_0:generateTempGroup(nil, var_9_4, var_9_1 and var_9_1.useTemp == 2)
			end
		else
			local var_9_12 = cjson.decode(var_9_10)

			GameUtil.removeJsonNull(var_9_12)

			var_9_11 = arg_9_0:generateTempGroup(nil, nil, true)

			var_9_11:initByLocalData(var_9_12)
		end

		var_9_11:setTrials(arg_9_4)

		arg_9_0._heroGroupList = {
			var_9_11
		}
	elseif var_9_3 and SeasonHeroGroupHandler.checkIsSeasonEpisodeType(arg_9_0.episodeType) then
		arg_9_0._heroGroupList = {}

		local var_9_13 = SeasonHeroGroupHandler.buildSeasonHandleFunc[arg_9_0.episodeType]

		if var_9_13 then
			arg_9_0.heroGroupType = var_9_13(var_9_0)
		end
	elseif var_9_3 and var_9_1 and var_9_1.useTemp ~= 0 or var_9_4 or #var_9_8 > 0 or var_9_1 and ToughBattleModel.instance:getEpisodeId() then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_9_0._heroGroupList = {}

		local var_9_14

		if var_9_3 and var_9_3.saveHeroGroup and (not var_9_1 or var_9_1.useTemp ~= 2) then
			if arg_9_0.curGroupSelectIndex > 0 then
				var_9_14 = arg_9_0:generateTempGroup(arg_9_0._commonGroups[arg_9_0.curGroupSelectIndex], var_9_4, var_9_1 and var_9_1.useTemp == 2)
			else
				var_9_14 = arg_9_0.heroGroupTypeCo and arg_9_0:getCustomHeroGroupMo(arg_9_0.heroGroupTypeCo.id, true) or arg_9_0:generateTempGroup(nil, var_9_4, var_9_1 and var_9_1.useTemp == 2)
			end
		end

		local var_9_15 = arg_9_0:generateTempGroup(var_9_14, var_9_4, var_9_1 and var_9_1.useTemp == 2)

		table.insert(arg_9_0._heroGroupList, var_9_15)

		arg_9_0._curGroupId = 1
	elseif not var_9_6 and var_9_3 then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Resources
		arg_9_0._heroGroupList = {}
		arg_9_0._curGroupId = 1

		if not arg_9_0._groupTypeCustom[arg_9_0.heroGroupTypeCo.id] then
			var_9_5 = true
		end

		local var_9_16 = arg_9_0.heroGroupTypeCo and arg_9_0:getCustomHeroGroupMo(arg_9_0.heroGroupTypeCo.id) or arg_9_0._commonGroups[1]
		local var_9_17 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
			var_9_3.name
		})

		var_9_16:setTempName(var_9_17)
		table.insert(arg_9_0._heroGroupList, var_9_16)
	elseif var_9_6 then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.NormalFb
		arg_9_0._heroGroupList = {}
		arg_9_0._curGroupId = 1

		local var_9_18 = arg_9_0:getCurGroupMO()

		if var_9_18 and var_9_18.aidDict then
			var_9_18.aidDict = nil
		end
	else
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Default
		arg_9_0._heroGroupList = {}
		arg_9_0._curGroupId = 1
	end

	arg_9_0:fixHeroGroupList()

	if var_9_5 then
		arg_9_0:saveCurGroupData()
	end
end

function var_0_0.getAmountLimit(arg_10_0, arg_10_1)
	if not arg_10_1 then
		return
	end

	local var_10_0 = arg_10_0:_getAmountLimit(arg_10_1.additionRule)

	if var_10_0 then
		return var_10_0
	end

	return (arg_10_0:_getAmountLimit(arg_10_1.hiddenRule))
end

function var_0_0._getAmountLimit(arg_11_0, arg_11_1)
	if LuaUtil.isEmptyStr(arg_11_1) == false then
		local var_11_0 = GameUtil.splitString2(arg_11_1, true, "|", "#")

		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			if iter_11_1[1] == FightEnum.EntitySide.MySide then
				local var_11_1 = iter_11_1[2]
				local var_11_2 = lua_rule.configDict[var_11_1]

				if var_11_2 and var_11_2.type == DungeonEnum.AdditionRuleType.AmountLimit then
					return tonumber(var_11_2.effect)
				end
			end
		end
	end
end

function var_0_0.getBattleRoleNum(arg_12_0)
	local var_12_0 = arg_12_0.episodeId
	local var_12_1

	var_12_1 = var_12_0 and lua_episode.configDict[var_12_0]

	local var_12_2 = arg_12_0.battleId
	local var_12_3 = var_12_2 and lua_battle.configDict[var_12_2]

	return arg_12_0:getAmountLimit(var_12_3) or var_12_3 and var_12_3.roleNum
end

function var_0_0.generateTempGroup(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = Season166HeroGroupMO.New()

	if not arg_13_1 and not arg_13_3 then
		arg_13_1 = arg_13_0:getById(arg_13_0._curGroupId)
	end

	if arg_13_1 then
		var_13_0:setSeasonCardLimit(arg_13_1:getSeasonCardLimit())
	end

	local var_13_1 = arg_13_0.battleId and lua_battle.configDict[arg_13_0.battleId]

	if var_13_1 then
		local var_13_2 = {}

		if not string.nilorempty(var_13_1.aid) then
			var_13_2 = string.splitToNumber(var_13_1.aid, "#")
		end

		local var_13_3 = {}

		if not string.nilorempty(var_13_1.trialHeros) then
			var_13_3 = GameUtil.splitString2(var_13_1.trialHeros, true)
		end

		arg_13_2 = arg_13_2 or var_13_1.roleNum

		local var_13_4 = var_13_1.playerMax

		var_13_0:initWithBattle(arg_13_1 or Season166HeroGroupMO.New(), var_13_2, arg_13_2, var_13_4, nil, var_13_3)

		if arg_13_0.adventure then
			local var_13_5 = arg_13_0.episodeId and lua_episode.configDict[arg_13_0.episodeId]

			if var_13_5 then
				local var_13_6 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_groupName"), {
					var_13_5.name
				})

				var_13_0:setTempName(var_13_6)
			end
		end
	else
		logError("临时编队没有战斗配置，永远不该发生")
		var_13_0:init(arg_13_1)
	end

	var_13_0:setTemp(true)

	return var_13_0
end

function var_0_0.setCurGroupId(arg_14_0, arg_14_1)
	arg_14_0._curGroupId = arg_14_1

	arg_14_0:_setSingleGroup()
end

function var_0_0._setSingleGroup(arg_15_0)
	local var_15_0 = arg_15_0:getCurGroupMO()

	if not var_15_0 then
		var_15_0 = Season166HeroGroupMO.New()

		local var_15_1 = arg_15_0._curGroupId

		if arg_15_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			var_15_1 = var_15_1 - 1
		end

		local var_15_2 = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_name"), {
			luaLang("hero_group"),
			var_15_1
		})

		var_15_0:init({
			groupId = var_15_1,
			name = var_15_2
		})
		arg_15_0:addAtLast(var_15_0)
	end

	var_15_0:clearAidHero()
	Season166HeroSingleGroupModel.instance:setSingleGroup(var_15_0, true)
end

function var_0_0.getCommonGroupName(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or arg_16_0.curGroupSelectIndex

	local var_16_0 = arg_16_0._commonGroups[arg_16_1].name

	if string.nilorempty(var_16_0) then
		return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(arg_16_1))
	else
		return var_16_0
	end
end

function var_0_0.setCommonGroupName(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1 = arg_17_1 or arg_17_0.curGroupSelectIndex

	if arg_17_2 == arg_17_0:getCommonGroupName(arg_17_1) then
		return
	end

	arg_17_0._commonGroups[arg_17_1].name = arg_17_2

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function var_0_0.getCurGroupMO(arg_18_0)
	if SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(arg_18_0.heroGroupType) then
		local var_18_0 = SeasonHeroGroupHandler.getSeasonCurrentHeroGroupMO[arg_18_0.heroGroupType]

		if var_18_0 then
			return var_18_0()
		end
	elseif arg_18_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
		if arg_18_0.curGroupSelectIndex == 0 then
			return arg_18_0._heroGroupList[1]
		else
			return arg_18_0._commonGroups[arg_18_0.curGroupSelectIndex]
		end
	elseif arg_18_0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
		if arg_18_0.curGroupSelectIndex == 0 then
			return arg_18_0:getMainGroupMo()
		else
			return arg_18_0._commonGroups[arg_18_0.curGroupSelectIndex]
		end
	else
		return arg_18_0:getById(arg_18_0._curGroupId)
	end
end

function var_0_0.setHeroGroupSelectIndex(arg_19_0, arg_19_1)
	if not arg_19_0.heroGroupTypeCo then
		logError("没有配置。。")

		return
	end

	if arg_19_1 == 0 and arg_19_0.heroGroupTypeCo.saveGroup == 0 then
		logError("无法切到玩法编队")

		return
	end

	if arg_19_0.curGroupSelectIndex == arg_19_1 then
		return
	end

	arg_19_0.curGroupSelectIndex = arg_19_1

	local var_19_0 = arg_19_0.heroGroupTypeCo.id

	if arg_19_0.episodeType > 100 then
		var_19_0 = arg_19_0.episodeType
	end

	arg_19_0._groupTypeSelect[var_19_0] = arg_19_1

	arg_19_0:_setSingleGroup()
	HeroGroupRpc.instance:sendChangeHeroGroupSelectRequest(var_19_0, arg_19_1)

	return true
end

function var_0_0.getGroupTypeName(arg_20_0)
	if not arg_20_0.heroGroupTypeCo or arg_20_0.heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return arg_20_0.heroGroupTypeCo.name
end

function var_0_0.getMainGroupMo(arg_21_0)
	return arg_21_0:getById(1)
end

function var_0_0.saveCurGroupData(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	if not lua_episode.configDict[arg_22_0.episodeId] then
		return
	end

	arg_22_3 = arg_22_3 or arg_22_0:getCurGroupMO()

	if not arg_22_3 then
		return
	end

	arg_22_3:checkAndPutOffEquip()

	if arg_22_0.heroGroupType == ModuleEnum.HeroGroupType.Season166Base then
		arg_22_3:saveData()

		if arg_22_1 then
			arg_22_1(arg_22_2)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, arg_22_0.heroGroupType, 1)

		if arg_22_3.isHaveTrial then
			return
		end
	end

	if arg_22_0.heroGroupType == ModuleEnum.HeroGroupType.Temp or arg_22_0.heroGroupType == ModuleEnum.HeroGroupType.Default then
		if arg_22_1 then
			arg_22_1(arg_22_2)
		end

		return
	end

	SeasonHeroGroupHandler.setHeroGroupSnapshot(arg_22_3, arg_22_0.heroGroupType, arg_22_0.episodeId, arg_22_1, arg_22_2)
end

function var_0_0.setHeroGroupSnapshot(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5, arg_23_6)
	local var_23_0 = {
		heroGroupType = arg_23_1,
		episodeId = arg_23_2,
		upload = arg_23_3,
		extendData = arg_23_4
	}

	if not (arg_23_2 and lua_episode.configDict[arg_23_2]) then
		return
	end

	local var_23_1 = 0
	local var_23_2 = 0
	local var_23_3
	local var_23_4

	if SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(arg_23_1) then
		local var_23_5 = SeasonHeroGroupHandler.setSeasonSnapShotHandleFunc[arg_23_1]

		if var_23_5 then
			var_23_1, var_23_2, var_23_3, var_23_4 = var_23_5(var_23_0)
		end
	else
		logError("暂不支持此类编队快照 : " .. tostring(arg_23_1))

		return
	end

	if var_23_3 and arg_23_3 then
		local var_23_6 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

		FightParam.initFightGroup(var_23_6.fightGroup, var_23_3.clothId, var_23_3:getMainList(), var_23_3:getSubList(), var_23_3:getAllHeroEquips(), var_23_4 or var_23_3:getAllHeroActivity104Equips())
		Season166HeroGroupUtils.buildFightGroupAssistHero(arg_23_1, var_23_6.fightGroup)
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_23_1, var_23_2, var_23_6, arg_23_5, arg_23_6)
	elseif arg_23_5 then
		arg_23_5(arg_23_6)
	end
end

function var_0_0.replaceSingleGroup(arg_24_0)
	local var_24_0 = arg_24_0:getCurGroupMO()

	if var_24_0 then
		local var_24_1 = Season166HeroSingleGroupModel.instance:getList()

		var_24_0:replaceHeroList(var_24_1)
	end
end

function var_0_0.replaceSingleGroupEquips(arg_25_0)
	local var_25_0 = arg_25_0:getCurGroupMO()
	local var_25_1 = Season166HeroSingleGroupModel.instance:getList()
	local var_25_2
	local var_25_3

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		local var_25_4 = HeroModel.instance:getById(iter_25_1.heroUid)

		if var_25_4 and var_25_4:hasDefaultEquip() then
			local var_25_5 = {
				index = iter_25_0 - 1,
				equipUid = {
					var_25_4.defaultEquipUid
				}
			}

			var_25_0:updatePosEquips(var_25_5)
		end
	end
end

function var_0_0.replaceCloth(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0:getCurGroupMO()

	if var_26_0 then
		var_26_0:replaceClothId(arg_26_1)
	end
end

function var_0_0.replaceEquips(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_2 or arg_27_0:getCurGroupMO()

	if var_27_0 then
		var_27_0:updatePosEquips(arg_27_1)
	end
end

function var_0_0.getCurGroupId(arg_28_0)
	return arg_28_0._curGroupId
end

function var_0_0.isPositionOpen(arg_29_0, arg_29_1)
	return arg_29_1 <= arg_29_0:getMaxHeroCountInGroup()
end

function var_0_0.positionOpenCount(arg_30_0)
	return arg_30_0:getMaxHeroCountInGroup()
end

function var_0_0.getHighestLevel(arg_31_0)
	local var_31_0 = Season166HeroSingleGroupModel.instance:getList()

	if not var_31_0 then
		return 0
	end

	local var_31_1 = 0

	for iter_31_0, iter_31_1 in ipairs(var_31_0) do
		if iter_31_1.aid and iter_31_1.aid ~= -1 then
			local var_31_2 = lua_monster.configDict[tonumber(iter_31_1.aid)]

			if var_31_2 and var_31_1 < var_31_2.level then
				var_31_1 = var_31_2.level
			end
		elseif iter_31_1.heroUid then
			local var_31_3 = HeroModel.instance:getById(iter_31_1.heroUid)

			if var_31_3 and var_31_1 < var_31_3.level then
				var_31_1 = var_31_3.level
			end
		end
	end

	return var_31_1
end

function var_0_0.setHeroGroupItemPos(arg_32_0, arg_32_1)
	arg_32_0._herogroupItemPos = arg_32_1
end

function var_0_0.getHeroGroupItemPos(arg_33_0)
	return arg_33_0._herogroupItemPos
end

var_0_0.RestrictType = {
	Rare = 3,
	HeroId = 1,
	Career = 2
}

function var_0_0.initRestrictHeroData(arg_34_0, arg_34_1)
	arg_34_0.restrictHeroIdList = nil
	arg_34_0.restrictCareerList = nil
	arg_34_0.restrictRareList = nil

	local var_34_0 = arg_34_1 and arg_34_1.restrictRoles

	if string.nilorempty(var_34_0) then
		return
	end

	local var_34_1 = string.split(var_34_0, "|")
	local var_34_2
	local var_34_3

	for iter_34_0 = 1, #var_34_1 do
		local var_34_4 = string.splitToNumber(var_34_1[iter_34_0], "#")
		local var_34_5, var_34_6 = GameUtil.tabletool_fastRemoveValueByPos(var_34_4, 1)

		if var_34_6 == var_0_0.RestrictType.HeroId then
			arg_34_0.restrictHeroIdList = var_34_5
		elseif var_34_6 == var_0_0.RestrictType.Career then
			arg_34_0.restrictCareerList = var_34_5
		elseif var_34_6 == var_0_0.RestrictType.Rare then
			arg_34_0.restrictRareList = var_34_5
		else
			logError("un support restrict type : " .. tostring(var_34_6))
		end
	end
end

function var_0_0.isRestrict(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_1 and HeroModel.instance:getById(arg_35_1)

	if not var_35_0 then
		return false
	end

	return arg_35_0.restrictHeroIdList and tabletool.indexOf(arg_35_0.restrictHeroIdList, var_35_0.heroId) or arg_35_0.restrictCareerList and tabletool.indexOf(arg_35_0.restrictCareerList, var_35_0.config.career) or arg_35_0.restrictRareList and tabletool.indexOf(arg_35_0.restrictRareList, var_35_0.config.rare)
end

function var_0_0.getCurrentBattleConfig(arg_36_0)
	return arg_36_0.battleConfig
end

function var_0_0.buildAidHeroGroup(arg_37_0)
	local var_37_0 = Season166Model.instance:getBattleContext()

	if var_37_0 then
		local var_37_1 = var_37_0.actId

		if not Season166Model.instance:getActInfo(var_37_1) then
			return
		end

		if not arg_37_0.battleConfig or string.nilorempty(arg_37_0.battleConfig.aid) then
			return
		end

		if #string.splitToNumber(arg_37_0.battleConfig.aid, "#") > 0 or arg_37_0.battleConfig.trialLimit > 0 then
			arg_37_0.aidHeroGroupMO = var_0_0.instance:generateTempGroup(nil, nil, true)

			arg_37_0.aidHeroGroupMO:setTemp(false)
		end
	end
end

function var_0_0.getCurrentHeroGroup(arg_38_0)
	local var_38_0 = Season166Model.instance:getBattleContext()

	if not var_38_0 then
		return
	end

	local var_38_1 = Season166Model.instance:getActInfo(var_38_0.actId)

	if not var_38_1 then
		return
	end

	if arg_38_0.battleConfig and not string.nilorempty(arg_38_0.battleConfig.aid) then
		return arg_38_0.aidHeroGroupMO
	end

	if arg_38_0:isSeason166BaseSpotEpisode(var_38_0.episodeId) then
		local var_38_2 = var_38_0.baseId

		return var_38_1.spotHeroGroupSnapshot[var_38_2]
	elseif arg_38_0:isSeason166TrainEpisode(var_38_0.episodeId) then
		return var_38_1.trainHeroGroupSnapshot[1]
	else
		logError("关卡类型异常或教学关卡trial或trialLimit试用角色为空，请检查关卡id： " .. var_38_0.episodeId)

		return var_38_1.trainHeroGroupSnapshot[1]
	end
end

function var_0_0.isSeason166BaseSpotEpisode(arg_39_0, arg_39_1)
	return arg_39_0:getEpisodeType(arg_39_1) == DungeonEnum.EpisodeType.Season166Base
end

function var_0_0.isSeason166TrainEpisode(arg_40_0, arg_40_1)
	return arg_40_0:getEpisodeType(arg_40_1) == DungeonEnum.EpisodeType.Season166Train
end

function var_0_0.isSeason166TeachEpisode(arg_41_0, arg_41_1)
	return arg_41_0:getEpisodeType(arg_41_1) == DungeonEnum.EpisodeType.Season166Teach
end

function var_0_0.getEpisodeType(arg_42_0, arg_42_1)
	local var_42_0 = DungeonConfig.instance:getEpisodeCO(arg_42_1 or arg_42_0.episodeId)

	return var_42_0 and var_42_0.type
end

function var_0_0.isSeason166Episode(arg_43_0, arg_43_1)
	return arg_43_0:isSeason166BaseSpotEpisode(arg_43_1) or arg_43_0:isSeason166TrainEpisode(arg_43_1) or arg_43_0:isSeason166TeachEpisode(arg_43_1)
end

function var_0_0.getMaxHeroCountInGroup(arg_44_0)
	if not Season166Model.instance:getBattleContext(true) then
		return ModuleEnum.MaxHeroCountInGroup
	end

	if not (arg_44_0.episodeId and lua_episode.configDict[arg_44_0.episodeId]) then
		logError("episodeId or config in lua_episode is null")

		return ModuleEnum.MaxHeroCountInGroup
	end

	local var_44_0 = ({
		[DungeonEnum.ChapterType.Season166Base] = Season166Controller.getMaxHeroGroupCount,
		[DungeonEnum.ChapterType.Season166Train] = Season166Controller.getMaxHeroGroupCount,
		[DungeonEnum.ChapterType.Season166Teach] = Season166Controller.getMaxHeroGroupCount
	})[DungeonEnum.ChapterType.Season166Base]

	if var_44_0 then
		return var_44_0()
	else
		return ModuleEnum.MaxHeroCountInGroup
	end
end

function var_0_0.getEpisodeConfigId(arg_45_0, arg_45_1)
	local var_45_0 = Season166Model.instance:getBattleContext(true)

	if not var_45_0 then
		return 0
	end

	if arg_45_0:isSeason166BaseSpotEpisode(arg_45_1) then
		return var_45_0.baseId
	elseif arg_45_0:isSeason166TrainEpisode(arg_45_1) then
		return var_45_0.trainId
	elseif arg_45_0:isSeason166TeachEpisode(arg_45_1) then
		return var_45_0.teachId
	end

	return 0
end

function var_0_0.getTrailHeroGroupList(arg_46_0)
	return arg_46_0._heroGroupList[arg_46_0._curGroupId]
end

function var_0_0.isHaveTrialCo(arg_47_0)
	return arg_47_0.battleConfig and arg_47_0.battleConfig.trialLimit > 0
end

function var_0_0.fixHeroGroupList(arg_48_0)
	local var_48_0 = arg_48_0:getMaxHeroCountInGroup()
	local var_48_1 = arg_48_0:getCurGroupMO()

	if not var_48_1.heroList then
		return
	end

	for iter_48_0 = 1, var_48_0 do
		if not var_48_1.heroList[iter_48_0] then
			var_48_1.heroList[iter_48_0] = "0"
		end
	end
end

function var_0_0.cleanAssistData(arg_49_0)
	local var_49_0 = arg_49_0:getCurGroupMO()

	if var_49_0 then
		for iter_49_0, iter_49_1 in ipairs(var_49_0.heroList) do
			if tonumber(iter_49_1) > 0 and not arg_49_0:checkAndGetSelfHero(iter_49_1) then
				var_49_0.heroList[iter_49_0] = "0"
			end
		end
	end

	Season166HeroSingleGroupModel.instance.assistMO = nil

	Season166Controller.instance:dispatchEvent(Season166Event.CleanAssistData)
end

function var_0_0.checkAndGetSelfHero(arg_50_0, arg_50_1)
	return HeroModel.instance:getById(arg_50_1)
end

function var_0_0.setCurGroupMaxPlayerCount(arg_51_0, arg_51_1)
	arg_51_0:getCurGroupMO():setMaxHeroCount(arg_51_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
