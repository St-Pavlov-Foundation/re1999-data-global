module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotHeroGroupModel", package.seeall)

slot0 = class("V1a6_CachotHeroGroupModel", ListScrollModel)

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
end

function slot0.onGetHeroGroupList(slot0, slot1)
	slot0.curGroupSelectIndex = nil
	slot2 = {}
	slot3 = nil

	for slot7 = 1, #slot1 do
		slot3 = HeroGroupMO.New()

		slot3:init(slot1[slot7])
		table.insert(slot2, slot3)
	end

	slot0:setList(slot2)
end

function slot0.onGetCommonGroupList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.heroGroupCommons) do
		slot0._commonGroups[slot6.groupId] = HeroGroupMO.New()

		slot0._commonGroups[slot6.groupId]:init(slot6)
	end

	for slot5 = 1, 4 do
		if not slot0._commonGroups[slot5] then
			slot0._commonGroups[slot5] = HeroGroupMO.New()

			slot0._commonGroups[slot5]:init(HeroGroupMO.New())
		end
	end

	for slot5, slot6 in ipairs(slot1.heroGourpTypes) do
		slot0._groupTypeSelect[slot6.id] = slot6.currentSelect

		if slot6.id ~= ModuleEnum.HeroGroupServerType.Main and slot6:HasField("groupInfo") then
			slot0._groupTypeCustom[slot6.id] = HeroGroupMO.New()

			slot0._groupTypeCustom[slot6.id]:init(slot6.groupInfo)
		end
	end
end

function slot0.getCustomHeroGroupMo(slot0, slot1, slot2)
	if not slot0._groupTypeCustom[slot1] then
		if slot2 then
			return slot0:getMainGroupMo()
		end

		slot3 = HeroGroupMO.New()

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
		slot2 = HeroGroupMO.New()

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
	slot0.battleId = slot1
	slot0.episodeId = slot2
	slot0.adventure = slot3
	slot5 = slot1 and lua_battle.configDict[slot1]
	slot6 = slot2 and lua_episode.configDict[slot2]
	slot7 = slot6 and lua_chapter.configDict[slot6.chapterId]
	slot0.battleConfig = slot5
	slot0.heroGroupTypeCo = slot6 and HeroConfig.instance:getHeroGroupTypeCo(slot6.chapterId)
	slot0._episodeType = slot6 and slot6.type or 0
	slot8 = slot0:getAmountLimit(slot5)
	slot0.weekwalk = slot7 and slot7.type == DungeonEnum.ChapterType.WeekWalk
	slot9 = false

	if slot7 and (slot7.type == DungeonEnum.ChapterType.Normal or slot7.type == DungeonEnum.ChapterType.Hard) then
		slot0.heroGroupTypeCo = lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Main]
	end

	if slot0.heroGroupTypeCo then
		slot11 = slot0.heroGroupTypeCo.id

		if slot0._episodeType > 100 then
			slot11 = slot0._episodeType
		end

		slot0.curGroupSelectIndex = slot0._groupTypeSelect[slot11]

		if not slot0.curGroupSelectIndex then
			slot0.curGroupSelectIndex = slot0.heroGroupTypeCo.saveGroup == 1 and 0 or 1
		end
	else
		slot0.curGroupSelectIndex = 1
	end

	slot0.curGroupSelectIndex = V1a6_CachotModel.instance:getTeamInfo().groupIdx
	slot11 = {}

	if slot5 and not string.nilorempty(slot5.aid) then
		slot11 = string.splitToNumber(slot5.aid, "#")
	end

	if slot5 and (slot5.trialLimit > 0 or not string.nilorempty(slot5.trialEquips)) then
		slot13 = nil
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Trial
		slot0._curGroupId = 1
		slot14 = nil

		if string.nilorempty((not Activity104Model.instance:isSeasonChapter() or PlayerPrefsHelper.getString(PlayerPrefsKey.SeasonHeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()), "")) and PlayerPrefsHelper.getString(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. slot5.id, "")) then
			if slot0.curGroupSelectIndex > 0 then
				slot14 = slot0:generateTempGroup(slot0._commonGroups[slot0.curGroupSelectIndex], slot8, slot5 and slot5.useTemp == 2)
			else
				slot14 = slot0.heroGroupTypeCo and slot0:getCustomHeroGroupMo(slot0.heroGroupTypeCo.id, true) or slot0:generateTempGroup(nil, slot8, slot5 and slot5.useTemp == 2)
			end
		else
			HeroGroupMO.New():initByLocalData(cjson.decode(slot13))
		end

		slot14:setTrials(slot4)

		slot0._heroGroupList = {
			slot14
		}
	elseif slot7 and Activity104Model.instance:isSeasonChapter() then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Season

		Activity104Model.instance:buildHeroGroup(slot4)
	elseif slot7 and slot5 and slot5.useTemp ~= 0 or slot8 or #slot11 > 0 then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		slot0._heroGroupList = {}
		slot12 = nil

		if slot7 and slot7.saveHeroGroup and (not slot5 or slot5.useTemp ~= 2) then
			slot12 = (slot0.curGroupSelectIndex <= 0 or slot0:generateTempGroup(slot0._commonGroups[slot0.curGroupSelectIndex], slot8, slot5 and slot5.useTemp == 2)) and (slot0.heroGroupTypeCo and slot0:getCustomHeroGroupMo(slot0.heroGroupTypeCo.id, true) or slot0:generateTempGroup(nil, slot8, slot5 and slot5.useTemp == 2))
		end

		table.insert(slot0._heroGroupList, slot0:generateTempGroup(slot12, slot8, slot5 and slot5.useTemp == 2))

		slot0._curGroupId = 1
	elseif not slot10 and slot7 then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Resources
		slot0._heroGroupList = {}
		slot0._curGroupId = 1

		if not slot0._groupTypeCustom[slot0.heroGroupTypeCo.id] then
			slot9 = true
		end

		table.insert(slot0._heroGroupList, slot0.heroGroupTypeCo and slot0:getCustomHeroGroupMo(slot0.heroGroupTypeCo.id) or slot0._commonGroups[1])
	elseif slot10 then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.NormalFb
		slot0._heroGroupList = {}
		slot0._curGroupId = 1

		if slot0:getCurGroupMO() and slot12.aidDict then
			slot12.aidDict = nil
		end
	else
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Default
		slot0._heroGroupList = {}
		slot0._curGroupId = 1
	end

	slot0:_setSingleGroup()
	slot0:initRestrictHeroData(slot5)

	if slot9 then
		slot0:saveCurGroupData()
	end
end

function slot0.updateGroupIndex(slot0)
	slot0.curGroupSelectIndex = V1a6_CachotModel.instance:getTeamInfo().groupIdx
end

function slot0.setReplayParam(slot0, slot1)
	slot0._replayParam = slot1

	if slot1 then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Temp
		slot0._heroGroupList = {
			[slot1.id] = slot1
		}
		slot0._curGroupId = slot1.id

		slot0:_setSingleGroup()
	end
end

function slot0.getReplayParam(slot0)
	return slot0._replayParam
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
	slot4 = HeroGroupMO.New()

	if not slot1 and not slot3 then
		slot1 = slot0:getById(slot0._curGroupId)
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

		slot4:initWithBattle(slot1 or HeroGroupMO.New(), slot6, slot2 or slot5.roleNum, slot5.playerMax, nil, slot7)

		if slot0.adventure and slot0.episodeId and lua_episode.configDict[slot0.episodeId] then
			-- Nothing
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
		slot1 = HeroGroupMO.New()

		if slot0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			slot2 = slot0._curGroupId - 1
		end

		slot1:init({
			groupId = slot2
		})
		slot0:addAtLast(slot1)
	end

	V1a6_CachotHeroSingleGroupModel.instance:setSingleGroup(slot1)

	for slot6 = 1, #V1a6_CachotHeroSingleGroupModel.instance:getList() do
		slot2[slot6]:setAid(slot1.aidDict and slot1.aidDict[slot6])

		if slot1.trialDict and slot1.trialDict[slot6] then
			slot2[slot6]:setTrial(unpack(slot1.trialDict[slot6]))
		else
			slot2[slot6]:setTrial()
		end
	end
end

function slot0.getCommonGroupName(slot0, slot1)
	return formatLuaLang("cachot_team_name", GameUtil.getNum2Chinese(slot1 or slot0.curGroupSelectIndex))
end

function slot0.setCommonGroupName(slot0, slot1, slot2)
	if slot2 == slot0:getCommonGroupName(slot1 or slot0.curGroupSelectIndex) then
		return
	end

	slot0._commonGroups[slot1].name = slot2

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function slot0.getCurGroupMO(slot0)
	if slot0.curGroupSelectIndex then
		return slot0:getById(slot0.curGroupSelectIndex)
	end

	return slot0:getById(slot0._curGroupId)
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

	if slot0._episodeType > 100 then
		slot2 = slot0._episodeType
	end

	slot0._groupTypeSelect[slot2] = slot1

	slot0:_setSingleGroup()
	RogueRpc.instance:sendRogueGroupIdxChangeRequest(V1a6_CachotEnum.ActivityId, slot1)

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

function slot0.cachotSaveCurGroup(slot0, slot1, slot2)
	slot5 = slot0.curGroupSelectIndex

	RogueRpc.instance:sendRogueGroupChangeRequest(V1a6_CachotEnum.ActivityId, slot5, slot0:_getGroup(slot5, "", {}, {}, 1, V1a6_CachotEnum.HeroCountInGroup), slot1, slot2)
end

function slot0._getGroup(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = {
		id = slot1,
		groupName = slot2
	}
	slot8 = slot0:getCurGroupMO()
	slot9 = {}
	slot10 = {}

	for slot14 = slot5, slot6 do
		slot15 = V1a6_CachotHeroSingleGroupModel.instance:getById(slot14)

		if tonumber(slot8:getPosEquips(slot14 - 1).equipUid[1]) and slot17 > 0 then
			table.insert(slot4, slot17)
		end

		slot19 = HeroModel.instance:getById(slot15.heroUid) and slot18.heroId or 0

		table.insert(slot9, slot19)
		table.insert(slot10, slot16)

		if slot19 > 0 then
			table.insert(slot3, slot19)
		end
	end

	slot7.heroList = slot9
	slot7.equips = slot10
	slot7.clothId = slot8.clothId

	return slot7
end

function slot0.saveCurGroupData(slot0, slot1, slot2, slot3)
end

function slot0.saveCurGroupData2(slot0, slot1, slot2, slot3)
	if not lua_episode.configDict[slot0.episodeId] then
		return
	end

	if not (slot3 or slot0:getCurGroupMO()) then
		return
	end

	if slot0.heroGroupType == ModuleEnum.HeroGroupType.Trial then
		slot3:saveData()

		if slot1 then
			slot1(slot2)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnSnapshotSaveSucc, slot0.heroGroupType, 1)

		return
	end

	if slot0.heroGroupType == ModuleEnum.HeroGroupType.Temp or slot0.heroGroupType == ModuleEnum.HeroGroupType.Default then
		if slot1 then
			slot1(slot2)
		end

		return
	end

	if slot0.heroGroupType == ModuleEnum.HeroGroupType.Season then
		slot0:setHeroGroupSnapshot(slot0.heroGroupType, slot0.episodeId, true, {
			groupIndex = slot3.groupId,
			heroGroup = slot3
		}, slot1, slot2)

		return
	end

	if slot0.curGroupSelectIndex == 0 then
		if slot0.heroGroupType == ModuleEnum.HeroGroupType.NormalFb then
			HeroGroupRpc.instance:sendUpdateHeroGroupRequest(slot3.id, slot3.heroList, slot3.name, slot3.clothId, slot3.equips, nil, slot1, slot2)
		elseif slot0.heroGroupType == ModuleEnum.HeroGroupType.Resources then
			slot6 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

			FightParam.initFightGroup(slot6.fightGroup, slot3.clothId, slot3:getMainList(), slot3:getSubList(), slot3:getAllHeroEquips(), slot3:getAllHeroActivity104Equips())
			HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Resources, slot0.heroGroupTypeCo.id, slot6, slot1, slot2)
		end
	else
		slot6 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()

		FightParam.initFightGroup(slot6.fightGroup, slot3.clothId, slot3:getMainList(), slot3:getSubList(), slot3:getAllHeroEquips(), slot3:getAllHeroActivity104Equips())
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.Common, slot5, slot6, slot1, slot2)
	end
end

function slot0.setHeroGroupSnapshot(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if not (slot2 and lua_episode.configDict[slot2]) then
		return
	end

	slot8 = 0
	slot9 = 0
	slot10 = nil

	if slot1 == ModuleEnum.HeroGroupType.Resources then
		slot8 = ModuleEnum.HeroGroupSnapshotType.Resources
		slot9 = slot7.chapterId
		slot10 = slot0._heroGroupList[1]
	elseif slot1 == ModuleEnum.HeroGroupType.Season then
		slot8 = ModuleEnum.HeroGroupSnapshotType.Season

		if slot4 then
			slot9 = slot4.groupIndex
			slot10 = slot4.heroGroup
		end
	else
		logError("暂不支持此类编队快照")

		return
	end

	if slot10 and slot3 then
		slot11 = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
		slot12 = FightDef_pb.FightGroup()

		FightParam.initFightGroup(slot11.fightGroup, slot10.clothId, slot10:getMainList(), slot10:getSubList(), slot10:getAllHeroEquips(), slot10:getAllHeroActivity104Equips())
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(slot8, slot9, slot11, slot5, slot6)
	elseif slot5 then
		slot5(slot6)
	end
end

function slot0.replaceSingleGroup(slot0)
	if slot0:getCurGroupMO() then
		slot1:replaceHeroList(V1a6_CachotHeroSingleGroupModel.instance:getList())
	end
end

function slot0.replaceSingleGroupEquips(slot0)
	slot3, slot4 = nil

	for slot8, slot9 in ipairs(V1a6_CachotHeroSingleGroupModel.instance:getList()) do
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
	if not lua_open_group.configDict[slot1] then
		return false
	end

	slot3 = slot0.episodeId and lua_episode.configDict[slot0.episodeId]
	slot4 = slot3 and lua_battle.configDict[slot3.battleId]

	if slot3 and slot3.type == DungeonEnum.EpisodeType.Sp and slot1 <= (slot4 and #string.splitToNumber(slot4.aid, "#") or 0) then
		return true
	end

	if slot2.need_level > 0 and PlayerModel.instance:getPlayinfo().level < slot2.need_level then
		return false
	end

	if slot2.need_episode > 0 then
		if not DungeonModel.instance:getEpisodeInfo(slot2.need_episode) or slot6.star <= 0 then
			return false
		end

		if lua_episode.configDict[slot2.need_episode].afterStory and slot7 > 0 and not StoryModel.instance:isStoryFinished(slot7) then
			return false
		end
	end

	if slot2.need_enter_episode > 0 or slot2.need_finish_guide > 0 then
		if slot2.need_enter_episode > 0 and (DungeonModel.instance:getEpisodeInfo(slot2.need_enter_episode) and slot6.star > 0 or slot0.episodeId == slot2.need_enter_episode) then
			return true
		end

		if slot2.need_finish_guide > 0 and GuideModel.instance:isGuideFinish(slot2.need_finish_guide) then
			return true
		end

		return false
	end

	return true
end

function slot0.positionOpenCount(slot0)
	for slot5 = 1, 4 do
		if slot0:isPositionOpen(slot5) then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot0.getPositionLockDesc(slot0, slot1)
	if not lua_open_group.configDict[slot1] or not slot2.need_episode or slot3 == 0 then
		return nil
	end

	return slot2.lock_desc, DungeonConfig.instance:getEpisodeDisplay(slot3)
end

function slot0.getHighestLevel(slot0)
	if not V1a6_CachotHeroSingleGroupModel.instance:getList() then
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

slot0.instance = slot0.New()

return slot0
