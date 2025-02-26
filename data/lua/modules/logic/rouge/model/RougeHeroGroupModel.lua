module("modules.logic.rouge.model.RougeHeroGroupModel", package.seeall)

slot0 = class("RougeHeroGroupModel", ListScrollModel)

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

		if not slot0.curGroupSelectIndex then
			slot0.curGroupSelectIndex = slot0.heroGroupTypeCo.saveGroup == 1 and 0 or 1
		end
	else
		slot0.curGroupSelectIndex = 1
	end

	slot11 = {}

	if slot5 and not string.nilorempty(slot5.aid) then
		slot11 = string.splitToNumber(slot5.aid, "#")
	end

	if slot5 and (slot5.trialLimit > 0 or not string.nilorempty(slot5.trialEquips)) then
		slot13 = nil
		slot13 = (not Activity104Model.instance:isSeasonChapter() or PlayerPrefsHelper.getString(Activity104Model.instance:getSeasonTrialPrefsKey(), "")) and PlayerPrefsHelper.getString(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. slot5.id, "")
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Trial
		slot0._curGroupId = 1
		slot14 = nil

		if slot5.trialLimit > 0 and slot5.onlyTrial == 1 then
			slot14 = slot0:generateTempGroup(nil, , true)
		elseif string.nilorempty(slot13) then
			if slot0.curGroupSelectIndex > 0 then
				slot14 = slot0:generateTempGroup(slot0._commonGroups[slot0.curGroupSelectIndex], slot8, slot5 and slot5.useTemp == 2)
			else
				slot14 = slot0.heroGroupTypeCo and slot0:getCustomHeroGroupMo(slot0.heroGroupTypeCo.id, true) or slot0:generateTempGroup(nil, slot8, slot5 and slot5.useTemp == 2)
			end
		else
			slot15 = cjson.decode(slot13)

			GameUtil.removeJsonNull(slot15)
			slot0:generateTempGroup(nil, , true):initByLocalData(slot15)
		end

		slot14:setTrials(slot4)

		slot0._heroGroupList = {
			slot14
		}
	elseif slot7 and Activity104Model.instance:isSeasonChapter() then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Season

		Activity104Model.instance:buildHeroGroup(slot4)
	elseif slot7 and slot0._episodeType == DungeonEnum.EpisodeType.Season123 then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Season123

		Season123HeroGroupModel.instance:buildAidHeroGroup()
	elseif slot7 and slot0._episodeType == DungeonEnum.EpisodeType.Season123Retail then
		slot0.heroGroupType = ModuleEnum.HeroGroupType.Season123Retail

		Season123HeroGroupModel.instance:buildAidHeroGroup()
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

function slot0.setReplayParam(slot0, slot1)
	slot0._replayParam = slot1

	if slot1 then
		if slot1.replay_hero_data then
			for slot5, slot6 in pairs(slot1.replay_hero_data) do
				if HeroModel.instance:getById(slot5) and slot7.skin > 0 then
					slot6.skin = slot7.skin
				end
			end
		end

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

		slot4:initWithBattle(slot1 or HeroGroupMO.New(), slot6, slot2 or slot5.roleNum, slot5.playerMax, nil, slot7)

		if slot0.adventure and slot0.episodeId and lua_episode.configDict[slot0.episodeId] then
			slot4:setTempName(string.format("%s%s", slot9.name, "hero_group"))
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
			groupId = slot2,
			name = string.format("%s%d", "hero_group", slot2)
		})
		slot0:addAtLast(slot1)
	end

	slot1:clearAidHero()
	RougeHeroSingleGroupModel.instance:setSingleGroup(slot1, true)
end

function slot0.getCommonGroupName(slot0, slot1)
	return formatLuaLang("herogroup_common_name", GameUtil.getNum2Chinese(slot1 or slot0.curGroupSelectIndex))
end

function slot0.setCommonGroupName(slot0, slot1, slot2)
	if slot2 == slot0:getCommonGroupName(slot1 or slot0.curGroupSelectIndex) then
		return
	end

	slot0._commonGroups[slot1].name = slot2

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupName)
end

function slot0.getCurGroupMO(slot0)
	if slot0.curGroupSelectIndex and slot0.curGroupSelectIndex > 0 then
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

function slot0.rougeSaveCurGroup(slot0, slot1, slot2)
	slot3 = {}

	for slot8 = 1, RougeEnum.FightTeamNormalHeroNum do
		slot11 = slot0:getCurGroupMO():getPosEquips(slot8 - 1).equipUid[1]
		slot14 = RougeHeroSingleGroupModel.instance:getById(slot8) and HeroModel.instance:getById(slot9.heroUid)
		slot15 = slot14 and slot14.heroId or 0

		if tonumber(slot11) ~= 0 or slot15 ~= 0 then
			slot16 = RougeBattleHeroMO.New()

			table.insert(slot3, slot16)

			slot16.index = slot8
			slot16.heroId = slot15
			slot16.equipUid = EquipModel.instance:getEquip(slot11) and slot13 or 0

			if slot15 ~= 0 then
				slot18 = RougeHeroSingleGroupModel.instance:getById(slot8 + RougeEnum.FightTeamNormalHeroNum) and HeroModel.instance:getById(slot17.heroUid)
				slot19 = slot18 and slot18.heroId or 0
				slot16.supportHeroId = slot19
				slot16.supportHeroSkill = RougeModel.instance:getTeamInfo():getSupportSkillIndex(slot19) or 0
			else
				slot16.supportHeroId = 0
				slot16.supportHeroSkill = 0
			end
		end
	end

	RougeRpc.instance:sendRougeGroupChangeRequest(RougeConfig1.instance:season(), slot3, slot1, slot2)
end

function slot0.saveCurGroupData(slot0, slot1, slot2, slot3)
end

function slot0.saveCurGroupData2(slot0, slot1, slot2, slot3)
	if not lua_episode.configDict[slot0.episodeId] then
		return
	end

	if slot4.type == DungeonEnum.EpisodeType.Cachot then
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

	if slot0.heroGroupType == ModuleEnum.HeroGroupType.Season or slot0.heroGroupType == ModuleEnum.HeroGroupType.Season123 then
		slot0:setHeroGroupSnapshot(slot0.heroGroupType, slot0.episodeId, true, {
			groupIndex = slot3.groupId,
			heroGroup = slot3
		}, slot1, slot2)

		return
	end

	if slot0.heroGroupType == ModuleEnum.HeroGroupType.Season123Retail then
		slot0:setHeroGroupSnapshot(slot0.heroGroupType, slot0.episodeId, true, nil, slot1, slot2)
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
	slot10, slot11 = nil

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
	elseif slot1 == ModuleEnum.HeroGroupType.Season123 then
		slot8 = ModuleEnum.HeroGroupSnapshotType.Season123

		if slot4 then
			slot9 = slot4.groupIndex
			slot10 = slot4.heroGroup
		end

		if slot10 then
			slot11 = Season123HeroGroupUtils.getAllHeroActivity123Equips(slot10)
		end
	elseif slot1 == ModuleEnum.HeroGroupType.Season123Retail then
		slot8 = ModuleEnum.HeroGroupSnapshotType.Season123Retail
		slot9 = 1

		if slot4 then
			slot10 = slot4.heroGroup
		end
	else
		logError("暂不支持此类编队快照 : " .. tostring(slot1))

		return
	end

	if slot10 and slot3 then
		slot13 = FightDef_pb.FightGroup()

		FightParam.initFightGroup(HeroGroupModule_pb.SetHeroGroupSnapshotRequest().fightGroup, slot10.clothId, slot10:getMainList(), slot10:getSubList(), slot10:getAllHeroEquips(), slot11 or slot10:getAllHeroActivity104Equips())
		Season123HeroGroupUtils.processFightGroupAssistHero(slot1, slot12.fightGroup)
		HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(slot8, slot9, slot12, slot5, slot6)
	elseif slot5 then
		slot5(slot6)
	end
end

function slot0.replaceSingleGroup(slot0)
	if slot0:getCurGroupMO() then
		slot1:replaceHeroList(RougeHeroSingleGroupModel.instance:getList())
	end
end

function slot0.replaceSingleGroupEquips(slot0)
	slot3, slot4 = nil

	for slot8, slot9 in ipairs(RougeHeroSingleGroupModel.instance:getList()) do
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
	if not RougeHeroSingleGroupModel.instance:getList() then
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

HeroGroupModel.RestrictType = {
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

		if slot11 == HeroGroupModel.RestrictType.HeroId then
			-- Nothing
		elseif slot5 == HeroGroupModel.RestrictType.Career then
			slot0.restrictCareerList = slot4
		elseif slot5 == HeroGroupModel.RestrictType.Rare then
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
