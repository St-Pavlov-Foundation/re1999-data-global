module("modules.logic.seasonver.act166.model.Season166HeroGroupModel", package.seeall)

slot0 = class("Season166HeroGroupModel", BaseModel)

function slot0.onInit(slot0)
	slot0.heroGroupType = ModuleEnum.HeroGroupType.Default
	slot0._curGroupId = 1
	slot0._lastHeroGroupSnapshotList = {}
	slot0._lastHeroGroupList = {}
	slot0._herogroupItemPos = {}
	slot0._commonGroups = {}
	slot0._groupTypeSelect = {}
	slot0._groupTypeCustom = {}
end

function slot0.reInit(slot0)
	slot0.heroGroupType = ModuleEnum.HeroGroupType.Default
	slot0._curGroupId = 1
	slot0._lastHeroGroupSnapshotList = {}
	slot0._lastHeroGroupList = {}
	slot0._herogroupItemPos = {}
	slot0._commonGroups = {}
	slot0._groupTypeSelect = {}
	slot0._groupTypeCustom = {}
	slot0.battleId = nil
	slot0.episodeId = nil
	slot0.adventure = nil
	slot0.battleConfig = nil
	slot0.heroGroupTypeCo = nil
	slot0.episodeType = nil
	slot0.weekwalk = nil
	slot0.curGroupSelectIndex = 1
end

function slot0.onGetHeroGroupList(slot0, slot1)
	slot2 = {}
	slot3 = nil

	for slot7 = 1, #slot1 do
		slot3 = Season166HeroGroupMO.New()

		slot3:init(slot1[slot7])
		table.insert(slot2, slot3)
	end

	slot0:setList(slot2)
end

function slot0.onGetCommonGroupList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.heroGroupCommons) do
		slot0._commonGroups[slot6.groupId] = Season166HeroGroupMO.New()

		slot0._commonGroups[slot6.groupId]:init(slot6)
	end

	for slot5 = 1, slot0:getMaxHeroCountInGroup() do
		if not slot0._commonGroups[slot5] then
			slot0._commonGroups[slot5] = Season166HeroGroupMO.New()

			slot0._commonGroups[slot5]:init(Season166HeroGroupMO.New())
		end
	end

	for slot5, slot6 in ipairs(slot1.heroGourpTypes) do
		slot0._groupTypeSelect[slot6.id] = slot6.currentSelect

		if slot6.id ~= ModuleEnum.HeroGroupServerType.Main and slot6:HasField("groupInfo") then
			slot0._groupTypeCustom[slot6.id] = Season166HeroGroupMO.New()

			slot0._groupTypeCustom[slot6.id]:init(slot6.groupInfo)
		end
	end
end

function slot0.getCustomHeroGroupMo(slot0, slot1, slot2)
	if not slot0._groupTypeCustom[slot1] then
		if slot2 then
			return slot0:getMainGroupMo()
		end

		slot3 = Season166HeroGroupMO.New()

		slot3:init(slot0:getMainGroupMo())

		slot0._groupTypeCustom[slot1] = slot3
	end

	return slot0._groupTypeCustom[slot1]
end

function slot0.onModifyHeroGroup(slot0, slot1)
	slot2 = {}

	if slot0:getById(slot1.groupId) then
		slot2:init(slot1)
	else
		slot2 = Season166HeroGroupMO.New()

		slot2:init(slot1)
		slot0:addAtLast(slot2)
	end

	slot0:_updateScroll()
end

function slot0._updateScroll(slot0)
	slot0:onModelUpdate()
	slot0:_setSingleGroup()
end

function slot0.isAdventureOrWeekWalk(slot0)
	return slot0.adventure or slot0.weekwalk
end

function slot0.setParam(slot0, slot1, slot2, slot3, slot4)
	slot5 = {
		battleId = slot1,
		episodeId = slot2,
		adventure = slot3,
		isReConnect = slot4
	}
	slot0.battleId = slot1
	slot0.episodeId = slot2
	slot0.adventure = slot3
	slot0.actId = Season166Model.instance:getCurSeasonId()
	slot6 = slot1 and lua_battle.configDict[slot1]
	slot7 = slot2 and lua_episode.configDict[slot2]
	slot8 = slot7 and lua_chapter.configDict[slot7.chapterId]
	slot0.episodeConfig = slot7
	slot0.battleConfig = slot6
	slot0.heroGroupTypeCo = slot7 and HeroConfig.instance:getHeroGroupTypeCo(slot7.chapterId)
	slot0.episodeType = slot7 and slot7.type or 0
	slot9 = slot0:getAmountLimit(slot6)
	slot0.weekwalk = slot8 and slot8.type == DungeonEnum.ChapterType.WeekWalk
	slot10 = false

	if slot8 and (slot8.type == DungeonEnum.ChapterType.Normal or slot8.type == DungeonEnum.ChapterType.Hard or slot8.type == DungeonEnum.ChapterType.Simple) then
		slot0.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	if slot0.heroGroupTypeCo then
		slot12 = slot0.heroGroupTypeCo.id

		if slot0.episodeType > 100 then
			slot12 = slot0.episodeType
		end

		slot0.curGroupSelectIndex = slot0._groupTypeSelect[slot12]

		if not slot0.curGroupSelectIndex then
			slot0.curGroupSelectIndex = slot0.heroGroupTypeCo.saveGroup == 1 and 0 or 1
		end
	else
		slot0.curGroupSelectIndex = 1
	end

	slot12 = {}

	if slot6 and not string.nilorempty(slot6.aid) then
		slot12 = string.splitToNumber(slot6.aid, "#")
	end

	if slot6 and (slot6.trialLimit > 0 or not string.nilorempty(slot6.trialEquips)) or ToughBattleModel.instance:getAddTrialHeros() then
		slot14 = nil
		slot14 = (not Activity104Model.instance:isSeasonChapter() or PlayerPrefsHelper.getString(Activity104Model.instance:getSeasonTrialPrefsKey(), "")) and PlayerPrefsHelper.getString(slot0.actId .. "#" .. PlayerPrefsKey.Season166HeroGroupTrial .. "#" .. tostring(PlayerModel.instance:getMyUserId()) .. "#" .. slot6.id, "")
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Season166Base
		slot0._curGroupId = 1
		slot15 = nil

		if slot6.trialLimit > 0 and slot6.onlyTrial == 1 then
			slot15 = slot0:generateTempGroup(nil, , true)
		elseif string.nilorempty(slot14) then
			if slot0.curGroupSelectIndex > 0 then
				slot15 = slot0:generateTempGroup(slot0._commonGroups[slot0.curGroupSelectIndex], slot9, slot6 and slot6.useTemp == 2)
			else
				slot15 = slot0.heroGroupTypeCo and slot0:getCustomHeroGroupMo(slot0.heroGroupTypeCo.id, true) or slot0:generateTempGroup(nil, slot9, slot6 and slot6.useTemp == 2)
			end
		else
			slot16 = cjson.decode(slot14)

			GameUtil.removeJsonNull(slot16)
			slot0:generateTempGroup(nil, , true):initByLocalData(slot16)
		end

		slot15:setTrials(slot4)

		slot0._heroGroupList = {
			slot15
		}
	elseif slot8 and SeasonHeroGroupHandler.checkIsSeasonEpisodeType(slot0.episodeType) then
		slot0._heroGroupList = {}

		if SeasonHeroGroupHandler.buildSeasonHandleFunc[slot0.episodeType] then
			slot0.heroGroupType = slot13(slot5)
		end
	elseif slot8 and slot6 and slot6.useTemp ~= 0 or slot9 or #slot12 > 0 or slot6 and ToughBattleModel.instance:getEpisodeId() then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		slot0._heroGroupList = {}
		slot13 = nil

		if slot8 and slot8.saveHeroGroup and (not slot6 or slot6.useTemp ~= 2) then
			slot13 = (slot0.curGroupSelectIndex <= 0 or slot0:generateTempGroup(slot0._commonGroups[slot0.curGroupSelectIndex], slot9, slot6 and slot6.useTemp == 2)) and (slot0.heroGroupTypeCo and slot0:getCustomHeroGroupMo(slot0.heroGroupTypeCo.id, true) or slot0:generateTempGroup(nil, slot9, slot6 and slot6.useTemp == 2))
		end

		table.insert(slot0._heroGroupList, slot0:generateTempGroup(slot13, slot9, slot6 and slot6.useTemp == 2))

		slot0._curGroupId = 1
	elseif not slot11 and slot8 then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Resources
		slot0._heroGroupList = {}
		slot0._curGroupId = 1

		if not slot0._groupTypeCustom[slot0.heroGroupTypeCo.id] then
			slot10 = true
		end

		slot13 = slot0.heroGroupTypeCo and slot0:getCustomHeroGroupMo(slot0.heroGroupTypeCo.id) or slot0._commonGroups[1]

		slot13:setTempName(GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_name"), {
			slot8.name,
			luaLang("hero_group")
		}))
		table.insert(slot0._heroGroupList, slot13)
	elseif slot11 then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.NormalFb
		slot0._heroGroupList = {}
		slot0._curGroupId = 1

		if slot0:getCurGroupMO() and slot13.aidDict then
			slot13.aidDict = nil
		end
	else
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Default
		slot0._heroGroupList = {}
		slot0._curGroupId = 1
	end

	slot0:fixHeroGroupList()

	if slot10 then
		slot0:saveCurGroupData()
	end
end

function slot0.getAmountLimit(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0:_getAmountLimit(slot1.additionRule) then
		return slot2
	end

	return slot0:_getAmountLimit(slot1.hiddenRule)
end

function slot0._getAmountLimit(slot0, slot1)
	if LuaUtil.isEmptyStr(slot1) == false then
		slot6 = "#"

		for slot6, slot7 in ipairs(GameUtil.splitString2(slot1, true, "|", slot6)) do
			if slot7[1] == FightEnum.EntitySide.MySide and lua_rule.configDict[slot7[2]] and slot10.type == DungeonEnum.AdditionRuleType.AmountLimit then
				return tonumber(slot10.effect)
			end
		end
	end
end

function slot0.getBattleRoleNum(slot0)
	slot2 = slot0.episodeId and lua_episode.configDict[slot1]
	slot4 = slot0.battleId and lua_battle.configDict[slot3]

	return slot0:getAmountLimit(slot4) or slot4 and slot4.roleNum
end

function slot0.generateTempGroup(slot0, slot1, slot2, slot3)
	slot4 = Season166HeroGroupMO.New()

	if not slot1 and not slot3 then
		slot1 = slot0:getById(slot0._curGroupId)
	end

	if slot1 then
		slot4:setSeasonCardLimit(slot1:getSeasonCardLimit())
	end

	if slot0.battleId and lua_battle.configDict[slot0.battleId] then
		slot6 = {}

		if not string.nilorempty(slot5.aid) then
			slot6 = string.splitToNumber(slot5.aid, "#")
		end

		slot7 = {}

		if not string.nilorempty(slot5.trialHeros) then
			slot7 = GameUtil.splitString2(slot5.trialHeros, true)
		end

		slot4:initWithBattle(slot1 or Season166HeroGroupMO.New(), slot6, slot2 or slot5.roleNum, slot5.playerMax, nil, slot7)

		if slot0.adventure and slot0.episodeId and lua_episode.configDict[slot0.episodeId] then
			slot4:setTempName(GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_name"), {
				slot9.name,
				luaLang("hero_group")
			}))
		end
	else
		logError("临时编队没有战斗配置，永远不该发生")
		slot4:init(slot1)
	end

	slot4:setTemp(true)

	return slot4
end

function slot0.setCurGroupId(slot0, slot1)
	slot0._curGroupId = slot1

	slot0:_setSingleGroup()
end

function slot0._setSingleGroup(slot0)
	if not slot0:getCurGroupMO() then
		slot1 = Season166HeroGroupMO.New()

		if slot0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			slot2 = slot0._curGroupId - 1
		end

		slot1:init({
			groupId = slot2,
			name = GameUtil.getSubPlaceholderLuaLang(luaLang("herogroup_name"), {
				luaLang("hero_group"),
				slot2
			})
		})
		slot0:addAtLast(slot1)
	end

	slot1:clearAidHero()
	Season166HeroSingleGroupModel.instance:setSingleGroup(slot1, true)
end

function slot0.getCommonGroupName(slot0, slot1)
	if string.nilorempty(slot0._commonGroups[slot1 or slot0.curGroupSelectIndex].name) then
		return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(slot1))
	else
		return slot2
	end
end

function slot0.setCommonGroupName(slot0, slot1, slot2)
	if slot2 == slot0:getCommonGroupName(slot1 or slot0.curGroupSelectIndex) then
		return
	end

	slot0._commonGroups[slot1].name = slot2

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function slot0.getCurGroupMO(slot0)
	if SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(slot0.heroGroupType) then
		if SeasonHeroGroupHandler.getSeasonCurrentHeroGroupMO[slot0.heroGroupType] then
			return slot1()
		end
	elseif slot0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
		if slot0.curGroupSelectIndex == 0 then
			return slot0._heroGroupList[1]
		else
			return slot0._commonGroups[slot0.curGroupSelectIndex]
		end
	elseif slot0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
		if slot0.curGroupSelectIndex == 0 then
			return slot0:getMainGroupMo()
		else
			return slot0._commonGroups[slot0.curGroupSelectIndex]
		end
	else
		return slot0:getById(slot0._curGroupId)
	end
end

function slot0.setHeroGroupSelectIndex(slot0, slot1)
	if not slot0.heroGroupTypeCo then
		logError("没有配置。。")

		return
	end

	if slot1 == 0 and slot0.heroGroupTypeCo.saveGroup == 0 then
		logError("无法切到玩法编队")

		return
	end

	if slot0.curGroupSelectIndex == slot1 then
		return
	end

	slot0.curGroupSelectIndex = slot1
	slot2 = slot0.heroGroupTypeCo.id

	if slot0.episodeType > 100 then
		slot2 = slot0.episodeType
	end

	slot0._groupTypeSelect[slot2] = slot1

	slot0:_setSingleGroup()
	HeroGroupRpc.instance:sendChangeHeroGroupSelectRequest(slot2, slot1)

	return true
end

function slot0.getGroupTypeName(slot0)
	if not slot0.heroGroupTypeCo or slot0.heroGroupTypeCo.saveGroup == 0 then
		return
	end

	return slot0.heroGroupTypeCo.name
end

function slot0.getMainGroupMo(slot0)
	return slot0:getById(1)
end

function slot0.saveCurGroupData(slot0, slot1, slot2, slot3)
	if not lua_episode.configDict[slot0.episodeId] then
		return
	end

	if not (slot3 or slot0:getCurGroupMO()) then
		return
	end

	slot3:checkAndPutOffEquip()

	if slot0.heroGroupType == ModuleEnum.HeroGroupType.Season166Base then
		slot3:saveData()

		if slot1 then
			slot1(slot2)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, slot0.heroGroupType, 1)

		if slot3.isHaveTrial then
			return
		end
	end

	if slot0.heroGroupType == ModuleEnum.HeroGroupType.Temp or slot0.heroGroupType == ModuleEnum.HeroGroupType.Default then
		if slot1 then
			slot1(slot2)
		end

		return
	end

	SeasonHeroGroupHandler.setHeroGroupSnapshot(slot3, slot0.heroGroupType, slot0.episodeId, slot1, slot2)
end

function slot0.setHeroGroupSnapshot(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = {
		heroGroupType = slot1,
		episodeId = slot2,
		upload = slot3,
		extendData = slot4
	}

	if not (slot2 and lua_episode.configDict[slot2]) then
		return
	end

	slot9 = 0
	slot10 = 0
	slot11, slot12 = nil

	if SeasonHeroGroupHandler.checkIsSeasonHeroGroupType(slot1) then
		if SeasonHeroGroupHandler.setSeasonSnapShotHandleFunc[slot1] then
			slot9, slot10, slot11, slot12 = slot13(slot7)
		end
	else
		logError("暂不支持此类编队快照 : " .. tostring(slot1))

		return
	end

	if slot11 and slot3 then
		FightParam.initFightGroup(HeroGroupModule_pb.SetHeroGroupSnapshotRequest().fightGroup, slot11.clothId, slot11:getMainList(), slot11:getSubList(), slot11:getAllHeroEquips(), slot12 or slot11:getAllHeroActivity104Equips())
		Season166HeroGroupUtils.buildFightGroupAssistHero(slot1, slot13.fightGroup)
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(slot9, slot10, slot13, slot5, slot6)
	elseif slot5 then
		slot5(slot6)
	end
end

function slot0.replaceSingleGroup(slot0)
	if slot0:getCurGroupMO() then
		slot1:replaceHeroList(Season166HeroSingleGroupModel.instance:getList())
	end
end

function slot0.replaceSingleGroupEquips(slot0)
	slot3, slot4 = nil

	for slot8, slot9 in ipairs(Season166HeroSingleGroupModel.instance:getList()) do
		if HeroModel.instance:getById(slot9.heroUid) and slot3:hasDefaultEquip() then
			slot0:getCurGroupMO():updatePosEquips({
				index = slot8 - 1,
				equipUid = {
					slot3.defaultEquipUid
				}
			})
		end
	end
end

function slot0.replaceCloth(slot0, slot1)
	if slot0:getCurGroupMO() then
		slot2:replaceClothId(slot1)
	end
end

function slot0.replaceEquips(slot0, slot1, slot2)
	if slot2 or slot0:getCurGroupMO() then
		slot3:updatePosEquips(slot1)
	end
end

function slot0.getCurGroupId(slot0)
	return slot0._curGroupId
end

function slot0.isPositionOpen(slot0, slot1)
	return slot1 <= slot0:getMaxHeroCountInGroup()
end

function slot0.positionOpenCount(slot0)
	return slot0:getMaxHeroCountInGroup()
end

function slot0.getHighestLevel(slot0)
	if not Season166HeroSingleGroupModel.instance:getList() then
		return 0
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot7.aid and slot7.aid ~= -1 then
			if lua_monster.configDict[tonumber(slot7.aid)] and 0 < slot8.level then
				slot2 = slot8.level
			end
		elseif slot7.heroUid and HeroModel.instance:getById(slot7.heroUid) and slot2 < slot8.level then
			slot2 = slot8.level
		end
	end

	return slot2
end

function slot0.setHeroGroupItemPos(slot0, slot1)
	slot0._herogroupItemPos = slot1
end

function slot0.getHeroGroupItemPos(slot0)
	return slot0._herogroupItemPos
end

slot0.RestrictType = {
	Rare = 3,
	HeroId = 1,
	Career = 2
}

function slot0.initRestrictHeroData(slot0, slot1)
	slot0.restrictHeroIdList = nil
	slot0.restrictCareerList = nil
	slot0.restrictRareList = nil

	if string.nilorempty(slot1 and slot1.restrictRoles) then
		return
	end

	slot4, slot5 = nil

	for slot9 = 1, #string.split(slot2, "|") do
		slot0.restrictHeroIdList, slot11 = GameUtil.tabletool_fastRemoveValueByPos(string.splitToNumber(slot3[slot9], "#"), 1)

		if slot11 == uv0.RestrictType.HeroId then
			-- Nothing
		elseif slot5 == uv0.RestrictType.Career then
			slot0.restrictCareerList = slot4
		elseif slot5 == uv0.RestrictType.Rare then
			slot0.restrictRareList = slot4
		else
			logError("un support restrict type : " .. tostring(slot5))
		end
	end
end

function slot0.isRestrict(slot0, slot1)
	if not (slot1 and HeroModel.instance:getById(slot1)) then
		return false
	end

	return slot0.restrictHeroIdList and tabletool.indexOf(slot0.restrictHeroIdList, slot2.heroId) or slot0.restrictCareerList and tabletool.indexOf(slot0.restrictCareerList, slot2.config.career) or slot0.restrictRareList and tabletool.indexOf(slot0.restrictRareList, slot2.config.rare)
end

function slot0.getCurrentBattleConfig(slot0)
	return slot0.battleConfig
end

function slot0.buildAidHeroGroup(slot0)
	if Season166Model.instance:getBattleContext() then
		if not Season166Model.instance:getActInfo(slot1.actId) then
			return
		end

		if not slot0.battleConfig or string.nilorempty(slot0.battleConfig.aid) then
			return
		end

		if #string.splitToNumber(slot0.battleConfig.aid, "#") > 0 or slot0.battleConfig.trialLimit > 0 then
			slot0.aidHeroGroupMO = uv0.instance:generateTempGroup(nil, , true)

			slot0.aidHeroGroupMO:setTemp(false)
		end
	end
end

function slot0.getCurrentHeroGroup(slot0)
	if not Season166Model.instance:getBattleContext() then
		return
	end

	if not Season166Model.instance:getActInfo(slot1.actId) then
		return
	end

	if slot0.battleConfig and not string.nilorempty(slot0.battleConfig.aid) then
		return slot0.aidHeroGroupMO
	end

	if slot0:isSeason166BaseSpotEpisode(slot1.episodeId) then
		return slot2.spotHeroGroupSnapshot[slot1.baseId]
	elseif slot0:isSeason166TrainEpisode(slot1.episodeId) then
		return slot2.trainHeroGroupSnapshot[1]
	else
		logError("关卡类型异常或教学关卡trial或trialLimit试用角色为空，请检查关卡id： " .. slot1.episodeId)

		return slot2.trainHeroGroupSnapshot[1]
	end
end

function slot0.isSeason166BaseSpotEpisode(slot0, slot1)
	return slot0:getEpisodeType(slot1) == DungeonEnum.EpisodeType.Season166Base
end

function slot0.isSeason166TrainEpisode(slot0, slot1)
	return slot0:getEpisodeType(slot1) == DungeonEnum.EpisodeType.Season166Train
end

function slot0.isSeason166TeachEpisode(slot0, slot1)
	return slot0:getEpisodeType(slot1) == DungeonEnum.EpisodeType.Season166Teach
end

function slot0.getEpisodeType(slot0, slot1)
	return DungeonConfig.instance:getEpisodeCO(slot1 or slot0.episodeId) and slot2.type
end

function slot0.isSeason166Episode(slot0, slot1)
	return slot0:isSeason166BaseSpotEpisode(slot1) or slot0:isSeason166TrainEpisode(slot1) or slot0:isSeason166TeachEpisode(slot1)
end

function slot0.getMaxHeroCountInGroup(slot0)
	if not Season166Model.instance:getBattleContext(true) then
		return ModuleEnum.MaxHeroCountInGroup
	end

	if not (slot0.episodeId and lua_episode.configDict[slot0.episodeId]) then
		logError("episodeId or config in lua_episode is null")

		return ModuleEnum.MaxHeroCountInGroup
	end

	if ({
		[DungeonEnum.ChapterType.Season166Base] = Season166Controller.getMaxHeroGroupCount,
		[DungeonEnum.ChapterType.Season166Train] = Season166Controller.getMaxHeroGroupCount,
		[DungeonEnum.ChapterType.Season166Teach] = Season166Controller.getMaxHeroGroupCount
	})[DungeonEnum.ChapterType.Season166Base] then
		return slot4()
	else
		return ModuleEnum.MaxHeroCountInGroup
	end
end

function slot0.getEpisodeConfigId(slot0, slot1)
	if not Season166Model.instance:getBattleContext(true) then
		return 0
	end

	if slot0:isSeason166BaseSpotEpisode(slot1) then
		return slot2.baseId
	elseif slot0:isSeason166TrainEpisode(slot1) then
		return slot2.trainId
	elseif slot0:isSeason166TeachEpisode(slot1) then
		return slot2.teachId
	end

	return 0
end

function slot0.getTrailHeroGroupList(slot0)
	return slot0._heroGroupList[slot0._curGroupId]
end

function slot0.isHaveTrialCo(slot0)
	return slot0.battleConfig and slot0.battleConfig.trialLimit > 0
end

function slot0.fixHeroGroupList(slot0)
	slot1 = slot0:getMaxHeroCountInGroup()

	if not slot0:getCurGroupMO().heroList then
		return
	end

	for slot6 = 1, slot1 do
		if not slot2.heroList[slot6] then
			slot2.heroList[slot6] = "0"
		end
	end
end

function slot0.cleanAssistData(slot0)
	if slot0:getCurGroupMO() then
		for slot5, slot6 in ipairs(slot1.heroList) do
			if tonumber(slot6) > 0 and not slot0:checkAndGetSelfHero(slot6) then
				slot1.heroList[slot5] = "0"
			end
		end
	end

	Season166HeroSingleGroupModel.instance.assistMO = nil

	Season166Controller.instance:dispatchEvent(Season166Event.CleanAssistData)
end

function slot0.checkAndGetSelfHero(slot0, slot1)
	return HeroModel.instance:getById(slot1)
end

function slot0.setCurGroupMaxPlayerCount(slot0, slot1)
	slot0:getCurGroupMO():setMaxHeroCount(slot1)
end

slot0.instance = slot0.New()

return slot0
