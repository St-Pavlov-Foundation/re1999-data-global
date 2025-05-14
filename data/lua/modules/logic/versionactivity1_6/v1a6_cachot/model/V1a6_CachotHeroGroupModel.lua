module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotHeroGroupModel", package.seeall)

local var_0_0 = class("V1a6_CachotHeroGroupModel", ListScrollModel)

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
end

function var_0_0.onGetHeroGroupList(arg_3_0, arg_3_1)
	arg_3_0.curGroupSelectIndex = nil

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
	arg_9_0.battleId = arg_9_1
	arg_9_0.episodeId = arg_9_2
	arg_9_0.adventure = arg_9_3

	local var_9_0 = arg_9_1 and lua_battle.configDict[arg_9_1]
	local var_9_1 = arg_9_2 and lua_episode.configDict[arg_9_2]
	local var_9_2 = var_9_1 and lua_chapter.configDict[var_9_1.chapterId]

	arg_9_0.battleConfig = var_9_0
	arg_9_0.heroGroupTypeCo = var_9_1 and HeroConfig.instance:getHeroGroupTypeCo(var_9_1.chapterId)
	arg_9_0._episodeType = var_9_1 and var_9_1.type or 0

	local var_9_3 = arg_9_0:getAmountLimit(var_9_0)

	arg_9_0.weekwalk = var_9_2 and var_9_2.type == DungeonEnum.ChapterType.WeekWalk

	local var_9_4 = false
	local var_9_5 = var_9_2 and (var_9_2.type == DungeonEnum.ChapterType.Normal or var_9_2.type == DungeonEnum.ChapterType.Hard)

	if var_9_5 then
		arg_9_0.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	if arg_9_0.heroGroupTypeCo then
		local var_9_6 = arg_9_0.heroGroupTypeCo.id

		if arg_9_0._episodeType > 100 then
			var_9_6 = arg_9_0._episodeType
		end

		arg_9_0.curGroupSelectIndex = arg_9_0._groupTypeSelect[var_9_6]

		if not arg_9_0.curGroupSelectIndex then
			arg_9_0.curGroupSelectIndex = arg_9_0.heroGroupTypeCo.saveGroup == 1 and 0 or 1
		end
	else
		arg_9_0.curGroupSelectIndex = 1
	end

	arg_9_0.curGroupSelectIndex = V1a6_CachotModel.instance:getTeamInfo().groupIdx

	local var_9_7 = {}

	if var_9_0 and not string.nilorempty(var_9_0.aid) then
		var_9_7 = string.splitToNumber(var_9_0.aid, "#")
	end

	if var_9_0 and (var_9_0.trialLimit > 0 or not string.nilorempty(var_9_0.trialEquips)) then
		local var_9_8 = Activity104Model.instance:isSeasonChapter()
		local var_9_9

		if var_9_8 then
			var_9_9 = PlayerPrefsHelper.getString(PlayerPrefsKey.SeasonHeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()), "")
		else
			var_9_9 = PlayerPrefsHelper.getString(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. var_9_0.id, "")
		end

		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Trial
		arg_9_0._curGroupId = 1

		local var_9_10

		if string.nilorempty(var_9_9) then
			if arg_9_0.curGroupSelectIndex > 0 then
				var_9_10 = arg_9_0:generateTempGroup(arg_9_0._commonGroups[arg_9_0.curGroupSelectIndex], var_9_3, var_9_0 and var_9_0.useTemp == 2)
			else
				var_9_10 = arg_9_0.heroGroupTypeCo and arg_9_0:getCustomHeroGroupMo(arg_9_0.heroGroupTypeCo.id, true) or arg_9_0:generateTempGroup(nil, var_9_3, var_9_0 and var_9_0.useTemp == 2)
			end
		else
			local var_9_11 = cjson.decode(var_9_9)

			var_9_10 = HeroGroupMO.New()

			var_9_10:initByLocalData(var_9_11)
		end

		var_9_10:setTrials(arg_9_4)

		arg_9_0._heroGroupList = {
			var_9_10
		}
	elseif var_9_2 and Activity104Model.instance:isSeasonChapter() then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Season

		Activity104Model.instance:buildHeroGroup(arg_9_4)
	elseif var_9_2 and var_9_0 and var_9_0.useTemp ~= 0 or var_9_3 or #var_9_7 > 0 then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_9_0._heroGroupList = {}

		local var_9_12

		if var_9_2 and var_9_2.saveHeroGroup and (not var_9_0 or var_9_0.useTemp ~= 2) then
			if arg_9_0.curGroupSelectIndex > 0 then
				var_9_12 = arg_9_0:generateTempGroup(arg_9_0._commonGroups[arg_9_0.curGroupSelectIndex], var_9_3, var_9_0 and var_9_0.useTemp == 2)
			else
				var_9_12 = arg_9_0.heroGroupTypeCo and arg_9_0:getCustomHeroGroupMo(arg_9_0.heroGroupTypeCo.id, true) or arg_9_0:generateTempGroup(nil, var_9_3, var_9_0 and var_9_0.useTemp == 2)
			end
		end

		local var_9_13 = arg_9_0:generateTempGroup(var_9_12, var_9_3, var_9_0 and var_9_0.useTemp == 2)

		table.insert(arg_9_0._heroGroupList, var_9_13)

		arg_9_0._curGroupId = 1
	elseif not var_9_5 and var_9_2 then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Resources
		arg_9_0._heroGroupList = {}
		arg_9_0._curGroupId = 1

		if not arg_9_0._groupTypeCustom[arg_9_0.heroGroupTypeCo.id] then
			var_9_4 = true
		end

		local var_9_14 = arg_9_0.heroGroupTypeCo and arg_9_0:getCustomHeroGroupMo(arg_9_0.heroGroupTypeCo.id) or arg_9_0._commonGroups[1]

		table.insert(arg_9_0._heroGroupList, var_9_14)
	elseif var_9_5 then
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.NormalFb
		arg_9_0._heroGroupList = {}
		arg_9_0._curGroupId = 1

		local var_9_15 = arg_9_0:getCurGroupMO()

		if var_9_15 and var_9_15.aidDict then
			var_9_15.aidDict = nil
		end
	else
		arg_9_0.heroGroupType = ModuleEnum.HeroGroupType.Default
		arg_9_0._heroGroupList = {}
		arg_9_0._curGroupId = 1
	end

	arg_9_0:_setSingleGroup()
	arg_9_0:initRestrictHeroData(var_9_0)

	if var_9_4 then
		arg_9_0:saveCurGroupData()
	end
end

function var_0_0.updateGroupIndex(arg_10_0)
	arg_10_0.curGroupSelectIndex = V1a6_CachotModel.instance:getTeamInfo().groupIdx
end

function var_0_0.setReplayParam(arg_11_0, arg_11_1)
	arg_11_0._replayParam = arg_11_1

	if arg_11_1 then
		arg_11_0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		arg_11_0._heroGroupList = {}
		arg_11_0._heroGroupList[arg_11_1.id] = arg_11_1
		arg_11_0._curGroupId = arg_11_1.id

		arg_11_0:_setSingleGroup()
	end
end

function var_0_0.getReplayParam(arg_12_0)
	return arg_12_0._replayParam
end

function var_0_0.getAmountLimit(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	local var_13_0 = arg_13_0:_getAmountLimit(arg_13_1.additionRule)

	if var_13_0 then
		return var_13_0
	end

	return (arg_13_0:_getAmountLimit(arg_13_1.hiddenRule))
end

function var_0_0._getAmountLimit(arg_14_0, arg_14_1)
	if LuaUtil.isEmptyStr(arg_14_1) == false then
		local var_14_0 = GameUtil.splitString2(arg_14_1, true, "|", "#")

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if iter_14_1[1] == FightEnum.EntitySide.MySide then
				local var_14_1 = iter_14_1[2]
				local var_14_2 = lua_rule.configDict[var_14_1]

				if var_14_2 and var_14_2.type == DungeonEnum.AdditionRuleType.AmountLimit then
					return tonumber(var_14_2.effect)
				end
			end
		end
	end
end

function var_0_0.getBattleRoleNum(arg_15_0)
	local var_15_0 = arg_15_0.episodeId
	local var_15_1

	var_15_1 = var_15_0 and lua_episode.configDict[var_15_0]

	local var_15_2 = arg_15_0.battleId
	local var_15_3 = var_15_2 and lua_battle.configDict[var_15_2]

	return arg_15_0:getAmountLimit(var_15_3) or var_15_3 and var_15_3.roleNum
end

function var_0_0.generateTempGroup(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = HeroGroupMO.New()

	if not arg_16_1 and not arg_16_3 then
		arg_16_1 = arg_16_0:getById(arg_16_0._curGroupId)
	end

	local var_16_1 = arg_16_0.battleId and lua_battle.configDict[arg_16_0.battleId]

	if var_16_1 then
		local var_16_2 = {}

		if not string.nilorempty(var_16_1.aid) then
			var_16_2 = string.splitToNumber(var_16_1.aid, "#")
		end

		local var_16_3 = {}

		if not string.nilorempty(var_16_1.trialHeros) then
			var_16_3 = GameUtil.splitString2(var_16_1.trialHeros, true)
		end

		arg_16_2 = arg_16_2 or var_16_1.roleNum

		local var_16_4 = var_16_1.playerMax

		var_16_0:initWithBattle(arg_16_1 or HeroGroupMO.New(), var_16_2, arg_16_2, var_16_4, nil, var_16_3)

		if arg_16_0.adventure and arg_16_0.episodeId and lua_episode.configDict[arg_16_0.episodeId] then
			-- block empty
		end
	else
		logError("临时编队没有战斗配置，永远不该发生")
		var_16_0:init(arg_16_1)
	end

	var_16_0:setTemp(true)

	return var_16_0
end

function var_0_0.setCurGroupId(arg_17_0, arg_17_1)
	arg_17_0._curGroupId = arg_17_1

	arg_17_0:_setSingleGroup()
end

function var_0_0._setSingleGroup(arg_18_0)
	local var_18_0 = arg_18_0:getCurGroupMO()

	if not var_18_0 then
		var_18_0 = HeroGroupMO.New()

		local var_18_1 = arg_18_0._curGroupId

		if arg_18_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			var_18_1 = var_18_1 - 1
		end

		var_18_0:init({
			groupId = var_18_1
		})
		arg_18_0:addAtLast(var_18_0)
	end

	V1a6_CachotHeroSingleGroupModel.instance:setSingleGroup(var_18_0)

	local var_18_2 = V1a6_CachotHeroSingleGroupModel.instance:getList()

	for iter_18_0 = 1, #var_18_2 do
		var_18_2[iter_18_0]:setAid(var_18_0.aidDict and var_18_0.aidDict[iter_18_0])

		if var_18_0.trialDict and var_18_0.trialDict[iter_18_0] then
			var_18_2[iter_18_0]:setTrial(unpack(var_18_0.trialDict[iter_18_0]))
		else
			var_18_2[iter_18_0]:setTrial()
		end
	end
end

function var_0_0.getCommonGroupName(arg_19_0, arg_19_1)
	arg_19_1 = arg_19_1 or arg_19_0.curGroupSelectIndex

	return formatLuaLang("cachot_team_name", GameUtil.getNum2Chinese(arg_19_1))
end

function var_0_0.setCommonGroupName(arg_20_0, arg_20_1, arg_20_2)
	arg_20_1 = arg_20_1 or arg_20_0.curGroupSelectIndex

	if arg_20_2 == arg_20_0:getCommonGroupName(arg_20_1) then
		return
	end

	arg_20_0._commonGroups[arg_20_1].name = arg_20_2

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function var_0_0.getCurGroupMO(arg_21_0)
	if arg_21_0.curGroupSelectIndex then
		return arg_21_0:getById(arg_21_0.curGroupSelectIndex)
	end

	return arg_21_0:getById(arg_21_0._curGroupId)
end

function var_0_0.setHeroGroupSelectIndex(arg_22_0, arg_22_1)
	if not arg_22_0.heroGroupTypeCo then
		logError("没有配置。。")

		return
	end

	if arg_22_1 == 0 and arg_22_0.heroGroupTypeCo.saveGroup == 0 then
		logError("无法切到玩法编队")

		return
	end

	if arg_22_0.curGroupSelectIndex == arg_22_1 then
		return
	end

	arg_22_0.curGroupSelectIndex = arg_22_1

	local var_22_0 = arg_22_0.heroGroupTypeCo.id

	if arg_22_0._episodeType > 100 then
		var_22_0 = arg_22_0._episodeType
	end

	arg_22_0._groupTypeSelect[var_22_0] = arg_22_1

	arg_22_0:_setSingleGroup()
	RogueRpc.instance:sendRogueGroupIdxChangeRequest(V1a6_CachotEnum.ActivityId, arg_22_1)

	return true
end

function var_0_0.getGroupTypeName(arg_23_0)
	if not arg_23_0.heroGroupTypeCo or arg_23_0.heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return arg_23_0.heroGroupTypeCo.name
end

function var_0_0.getMainGroupMo(arg_24_0)
	return arg_24_0:getById(1)
end

function var_0_0.cachotSaveCurGroup(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {}
	local var_25_1 = {}
	local var_25_2 = arg_25_0.curGroupSelectIndex
	local var_25_3 = arg_25_0:_getGroup(var_25_2, "", var_25_0, var_25_1, 1, V1a6_CachotEnum.HeroCountInGroup)

	RogueRpc.instance:sendRogueGroupChangeRequest(V1a6_CachotEnum.ActivityId, var_25_2, var_25_3, arg_25_1, arg_25_2)
end

function var_0_0._getGroup(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
	local var_26_0 = {
		id = arg_26_1,
		groupName = arg_26_2
	}
	local var_26_1 = arg_26_0:getCurGroupMO()
	local var_26_2 = {}
	local var_26_3 = {}

	for iter_26_0 = arg_26_5, arg_26_6 do
		local var_26_4 = V1a6_CachotHeroSingleGroupModel.instance:getById(iter_26_0)
		local var_26_5 = var_26_1:getPosEquips(iter_26_0 - 1)
		local var_26_6 = tonumber(var_26_5.equipUid[1])

		if var_26_6 and var_26_6 > 0 then
			table.insert(arg_26_4, var_26_6)
		end

		local var_26_7 = HeroModel.instance:getById(var_26_4.heroUid)
		local var_26_8 = var_26_7 and var_26_7.heroId or 0

		table.insert(var_26_2, var_26_8)
		table.insert(var_26_3, var_26_5)

		if var_26_8 > 0 then
			table.insert(arg_26_3, var_26_8)
		end
	end

	var_26_0.heroList = var_26_2
	var_26_0.equips = var_26_3
	var_26_0.clothId = var_26_1.clothId

	return var_26_0
end

function var_0_0.saveCurGroupData(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	return
end

function var_0_0.saveCurGroupData2(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	if not lua_episode.configDict[arg_28_0.episodeId] then
		return
	end

	arg_28_3 = arg_28_3 or arg_28_0:getCurGroupMO()

	if not arg_28_3 then
		return
	end

	if arg_28_0.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		arg_28_3:saveData()

		if arg_28_1 then
			arg_28_1(arg_28_2)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, arg_28_0.heroGroupType, 1)

		return
	end

	if arg_28_0.heroGroupType == ModuleEnum.HeroGroupType.Temp or arg_28_0.heroGroupType == ModuleEnum.HeroGroupType.Default then
		if arg_28_1 then
			arg_28_1(arg_28_2)
		end

		return
	end

	if arg_28_0.heroGroupType == ModuleEnum.HeroGroupType.Season then
		local var_28_0 = {
			groupIndex = arg_28_3.groupId,
			heroGroup = arg_28_3
		}

		arg_28_0:setHeroGroupSnapshot(arg_28_0.heroGroupType, arg_28_0.episodeId, true, var_28_0, arg_28_1, arg_28_2)

		return
	end

	local var_28_1 = arg_28_0.curGroupSelectIndex

	if var_28_1 == 0 then
		if arg_28_0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
			HeroGroupRpc.instance:sendUpdateHeroGroupRequest(arg_28_3.id, arg_28_3.heroList, arg_28_3.name, arg_28_3.clothId, arg_28_3.equips, nil, arg_28_1, arg_28_2)
		elseif arg_28_0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			local var_28_2 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

			FightParam.initFightGroup(var_28_2.fightGroup, arg_28_3.clothId, arg_28_3:getMainList(), arg_28_3:getSubList(), arg_28_3:getAllHeroEquips(), arg_28_3:getAllHeroActivity104Equips())
			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Resources, arg_28_0.heroGroupTypeCo.id, var_28_2, arg_28_1, arg_28_2)
		end
	else
		local var_28_3 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

		FightParam.initFightGroup(var_28_3.fightGroup, arg_28_3.clothId, arg_28_3:getMainList(), arg_28_3:getSubList(), arg_28_3:getAllHeroEquips(), arg_28_3:getAllHeroActivity104Equips())
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Common, var_28_1, var_28_3, arg_28_1, arg_28_2)
	end
end

function var_0_0.setHeroGroupSnapshot(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4, arg_29_5, arg_29_6)
	local var_29_0 = arg_29_2 and lua_episode.configDict[arg_29_2]

	if not var_29_0 then
		return
	end

	local var_29_1 = 0
	local var_29_2 = 0
	local var_29_3

	if arg_29_1 == ModuleEnum.HeroGroupType.Resources then
		var_29_2, var_29_1 = var_29_0.chapterId, ModuleEnum.HeroGroupSnapshotType.Resources
		var_29_3 = arg_29_0._heroGroupList[1]
	elseif arg_29_1 == ModuleEnum.HeroGroupType.Season then
		var_29_1 = ModuleEnum.HeroGroupSnapshotType.Season

		if arg_29_4 then
			var_29_2 = arg_29_4.groupIndex
			var_29_3 = arg_29_4.heroGroup
		end
	else
		logError("暂不支持此类编队快照")

		return
	end

	if var_29_3 and arg_29_3 then
		local var_29_4 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
		local var_29_5 = FightDef_pb.FightGroup()

		FightParam.initFightGroup(var_29_4.fightGroup, var_29_3.clothId, var_29_3:getMainList(), var_29_3:getSubList(), var_29_3:getAllHeroEquips(), var_29_3:getAllHeroActivity104Equips())
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(var_29_1, var_29_2, var_29_4, arg_29_5, arg_29_6)
	elseif arg_29_5 then
		arg_29_5(arg_29_6)
	end
end

function var_0_0.replaceSingleGroup(arg_30_0)
	local var_30_0 = arg_30_0:getCurGroupMO()

	if var_30_0 then
		local var_30_1 = V1a6_CachotHeroSingleGroupModel.instance:getList()

		var_30_0:replaceHeroList(var_30_1)
	end
end

function var_0_0.replaceSingleGroupEquips(arg_31_0)
	local var_31_0 = arg_31_0:getCurGroupMO()
	local var_31_1 = V1a6_CachotHeroSingleGroupModel.instance:getList()
	local var_31_2
	local var_31_3

	for iter_31_0, iter_31_1 in ipairs(var_31_1) do
		local var_31_4 = HeroModel.instance:getById(iter_31_1.heroUid)

		if var_31_4 and var_31_4:hasDefaultEquip() then
			local var_31_5 = {
				index = iter_31_0 - 1,
				equipUid = {
					var_31_4.defaultEquipUid
				}
			}

			var_31_0:updatePosEquips(var_31_5)
		end
	end
end

function var_0_0.replaceCloth(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:getCurGroupMO()

	if var_32_0 then
		var_32_0:replaceClothId(arg_32_1)
	end
end

function var_0_0.replaceEquips(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_2 or arg_33_0:getCurGroupMO()

	if var_33_0 then
		var_33_0:updatePosEquips(arg_33_1)
	end
end

function var_0_0.getCurGroupId(arg_34_0)
	return arg_34_0._curGroupId
end

function var_0_0.isPositionOpen(arg_35_0, arg_35_1)
	local var_35_0 = lua_open_group.configDict[arg_35_1]

	if not var_35_0 then
		return false
	end

	local var_35_1 = arg_35_0.episodeId and lua_episode.configDict[arg_35_0.episodeId]
	local var_35_2 = var_35_1 and lua_battle.configDict[var_35_1.battleId]
	local var_35_3 = var_35_2 and #string.splitToNumber(var_35_2.aid, "#") or 0

	if var_35_1 and var_35_1.type == DungeonEnum.EpisodeType.Sp and arg_35_1 <= var_35_3 then
		return true
	end

	if var_35_0.need_level > 0 and PlayerModel.instance:getPlayinfo().level < var_35_0.need_level then
		return false
	end

	if var_35_0.need_episode > 0 then
		local var_35_4 = DungeonModel.instance:getEpisodeInfo(var_35_0.need_episode)

		if not var_35_4 or var_35_4.star <= 0 then
			return false
		end

		local var_35_5 = lua_episode.configDict[var_35_0.need_episode].afterStory

		if var_35_5 and var_35_5 > 0 and not StoryModel.instance:isStoryFinished(var_35_5) then
			return false
		end
	end

	if var_35_0.need_enter_episode > 0 or var_35_0.need_finish_guide > 0 then
		if var_35_0.need_enter_episode > 0 then
			local var_35_6 = DungeonModel.instance:getEpisodeInfo(var_35_0.need_enter_episode)

			if var_35_6 and var_35_6.star > 0 or arg_35_0.episodeId == var_35_0.need_enter_episode then
				return true
			end
		end

		if var_35_0.need_finish_guide > 0 and GuideModel.instance:isGuideFinish(var_35_0.need_finish_guide) then
			return true
		end

		return false
	end

	return true
end

function var_0_0.positionOpenCount(arg_36_0)
	local var_36_0 = 0

	for iter_36_0 = 1, 4 do
		if arg_36_0:isPositionOpen(iter_36_0) then
			var_36_0 = var_36_0 + 1
		end
	end

	return var_36_0
end

function var_0_0.getPositionLockDesc(arg_37_0, arg_37_1)
	local var_37_0 = lua_open_group.configDict[arg_37_1]
	local var_37_1 = var_37_0 and var_37_0.need_episode

	if not var_37_1 or var_37_1 == 0 then
		return nil
	end

	local var_37_2 = DungeonConfig.instance:getEpisodeDisplay(var_37_1)

	return var_37_0.lock_desc, var_37_2
end

function var_0_0.getHighestLevel(arg_38_0)
	local var_38_0 = V1a6_CachotHeroSingleGroupModel.instance:getList()

	if not var_38_0 then
		return 0
	end

	local var_38_1 = 0

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		if iter_38_1.aid and iter_38_1.aid ~= -1 then
			local var_38_2 = lua_monster.configDict[tonumber(iter_38_1.aid)]

			if var_38_2 and var_38_1 < var_38_2.level then
				var_38_1 = var_38_2.level
			end
		elseif iter_38_1.heroUid then
			local var_38_3 = HeroModel.instance:getById(iter_38_1.heroUid)

			if var_38_3 and var_38_1 < var_38_3.level then
				var_38_1 = var_38_3.level
			end
		end
	end

	return var_38_1
end

function var_0_0.setHeroGroupItemPos(arg_39_0, arg_39_1)
	arg_39_0._herogroupItemPos = arg_39_1
end

function var_0_0.getHeroGroupItemPos(arg_40_0)
	return arg_40_0._herogroupItemPos
end

var_0_0.RestrictType = {
	Rare = 3,
	HeroId = 1,
	Career = 2
}

function var_0_0.initRestrictHeroData(arg_41_0, arg_41_1)
	arg_41_0.restrictHeroIdList = nil
	arg_41_0.restrictCareerList = nil
	arg_41_0.restrictRareList = nil

	local var_41_0 = arg_41_1 and arg_41_1.restrictRoles

	if string.nilorempty(var_41_0) then
		return
	end

	local var_41_1 = string.split(var_41_0, "|")
	local var_41_2
	local var_41_3

	for iter_41_0 = 1, #var_41_1 do
		local var_41_4 = string.splitToNumber(var_41_1[iter_41_0], "#")
		local var_41_5, var_41_6 = GameUtil.tabletool_fastRemoveValueByPos(var_41_4, 1)

		if var_41_6 == var_0_0.RestrictType.HeroId then
			arg_41_0.restrictHeroIdList = var_41_5
		elseif var_41_6 == var_0_0.RestrictType.Career then
			arg_41_0.restrictCareerList = var_41_5
		elseif var_41_6 == var_0_0.RestrictType.Rare then
			arg_41_0.restrictRareList = var_41_5
		else
			logError("un support restrict type : " .. tostring(var_41_6))
		end
	end
end

function var_0_0.isRestrict(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1 and HeroModel.instance:getById(arg_42_1)

	if not var_42_0 then
		return false
	end

	return arg_42_0.restrictHeroIdList and tabletool.indexOf(arg_42_0.restrictHeroIdList, var_42_0.heroId) or arg_42_0.restrictCareerList and tabletool.indexOf(arg_42_0.restrictCareerList, var_42_0.config.career) or arg_42_0.restrictRareList and tabletool.indexOf(arg_42_0.restrictRareList, var_42_0.config.rare)
end

function var_0_0.getCurrentBattleConfig(arg_43_0)
	return arg_43_0.battleConfig
end

var_0_0.instance = var_0_0.New()

return var_0_0
