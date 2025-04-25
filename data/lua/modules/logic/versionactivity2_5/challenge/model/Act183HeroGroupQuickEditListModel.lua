module("modules.logic.versionactivity2_5.challenge.model.Act183HeroGroupQuickEditListModel", package.seeall)

slot0 = class("Act183HeroGroupQuickEditListModel", MixScrollModel)

function slot0.init(slot0, slot1, slot2)
	slot0.activityId = slot1
	slot0.episodeId = slot2
	slot0.episodeCo = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
	slot0.challengeEpisodeCo = Act183Config.instance:getEpisodeCo(slot0.episodeId)
	slot0.groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(slot0.challengeEpisodeCo.groupId)
	slot0.groupEpisodeType = slot0.groupEpisodeMo and slot0.groupEpisodeMo:getGroupType()
end

function slot0.copyQuickEditCardList(slot0)
	slot1 = nil
	slot1 = (not HeroGroupTrialModel.instance:isOnlyUseTrial() or {}) and CharacterBackpackCardListModel.instance:getCharacterCardList()
	slot3 = {}
	slot0._inTeamHeroUidMap = {}
	slot0._inTeamHeroUidList = {}
	slot0._originalHeroUidList = {}
	slot0._selectUid = nil

	for slot8, slot9 in ipairs(HeroSingleGroupModel.instance:getList()) do
		if tonumber(slot9.heroUid) > 0 and not slot3[slot11] then
			table.insert({}, HeroModel.instance:getById(slot11))

			if Act183Helper.isHeroGroupPositionOpen(slot0.episodeId, slot8) then
				slot0._inTeamHeroUidMap[slot11] = 1
			end

			slot3[slot11] = true
		elseif HeroSingleGroupModel.instance:getByIndex(slot8).trial then
			table.insert(slot2, HeroGroupTrialModel.instance:getById(slot11))

			if slot10 then
				slot0._inTeamHeroUidMap[slot11] = 1
			end

			slot3[slot11] = true
		end

		if slot10 then
			table.insert(slot0._inTeamHeroUidList, slot11)
			table.insert(slot0._originalHeroUidList, slot11)
		end
	end

	for slot9, slot10 in ipairs(HeroGroupTrialModel.instance:getFilterList()) do
		if not slot3[slot10.uid] then
			table.insert(slot2, slot10)
		end
	end

	slot6 = slot0.isTowerBattle

	for slot11, slot12 in ipairs(slot1) do
		if not slot3[slot12.uid] then
			slot3[slot12.uid] = true

			if slot0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(slot12.heroId) > 0 then
					table.insert({}, slot12)
				else
					table.insert(slot2, slot12)
				end
			elseif slot6 then
				if TowerModel.instance:isHeroBan(slot12.heroId) then
					table.insert(slot7, slot12)
				else
					table.insert(slot2, slot12)
				end
			else
				table.insert(slot2, slot12)
			end
		end
	end

	if slot0.adventure or slot6 then
		tabletool.addValues(slot2, slot7)
	end

	slot0.sortIndexMap = {}

	for slot11, slot12 in ipairs(slot2) do
		slot0.sortIndexMap[slot12] = slot11
	end

	table.sort(slot2, slot0.indexMapSortFunc)
	slot0:setList(slot2)
end

function slot0.indexMapSortFunc(slot0, slot1)
	slot2 = uv0.instance.episodeId

	if Act183Model.instance:isHeroRepressInPreEpisode(slot2, slot0.heroId) ~= Act183Model.instance:isHeroRepressInPreEpisode(slot2, slot1.heroId) then
		return not slot3
	end

	return uv0.instance.sortIndexMap[slot0] < uv0.instance.sortIndexMap[slot1]
end

function slot0.keepSelect(slot0, slot1)
	slot0._selectIndex = slot1
	slot2 = slot0:getList()

	if #slot0._scrollViews > 0 then
		for slot6, slot7 in ipairs(slot0._scrollViews) do
			slot7:selectCell(slot1, true)
		end

		if slot2[slot1] then
			return slot2[slot1]
		end
	end
end

function slot0.isInTeamHero(slot0, slot1)
	return slot0._inTeamHeroUidMap and slot0._inTeamHeroUidMap[slot1]
end

function slot0.getHeroTeamPos(slot0, slot1)
	if slot0._inTeamHeroUidList then
		for slot5, slot6 in pairs(slot0._inTeamHeroUidList) do
			if slot6 == slot1 then
				return slot5
			end
		end
	end

	return 0
end

function slot0.selectHero(slot0, slot1)
	if slot0:getHeroTeamPos(slot1) ~= 0 then
		slot0._inTeamHeroUidList[slot2] = "0"
		slot0._inTeamHeroUidMap[slot1] = nil

		slot0:onModelUpdate()

		slot0._selectUid = nil

		return true
	else
		if slot0:isTeamFull() then
			return false
		end

		slot3 = 0

		for slot7 = 1, #slot0._inTeamHeroUidList do
			if slot0._inTeamHeroUidList[slot7] == 0 or slot8 == "0" then
				slot0._inTeamHeroUidList[slot7] = slot1
				slot0._inTeamHeroUidMap[slot1] = 1

				slot0:onModelUpdate()

				return true
			end
		end

		slot0._selectUid = slot1
	end

	return false
end

function slot0.isRepeatHero(slot0, slot1, slot2)
	if not slot0._inTeamHeroUidMap then
		return false
	end

	for slot6 in pairs(slot0._inTeamHeroUidMap) do
		if slot0:getById(slot6).heroId == slot1 and slot2 ~= slot7.uid then
			return true
		end
	end

	return false
end

function slot0.isTrialLimit(slot0)
	if not slot0._inTeamHeroUidMap then
		return false
	end

	for slot5 in pairs(slot0._inTeamHeroUidMap) do
		if slot0:getById(slot5):isTrial() then
			slot1 = 0 + 1
		end
	end

	return (slot0.episodeCo and slot0.episodeCo.roleNum or ModuleEnum.MaxHeroCountInGroup) <= slot1
end

function slot0.inInTeam(slot0, slot1)
	if not slot0._inTeamHeroUidMap then
		return false
	end

	return slot0._inTeamHeroUidMap[slot1] and true or false
end

function slot0.getHeroUids(slot0)
	return slot0._inTeamHeroUidList
end

function slot0.getHeroUidByPos(slot0, slot1)
	return slot0._inTeamHeroUidList[slot1]
end

function slot0.getIsDirty(slot0)
	for slot4 = 1, #slot0._inTeamHeroUidList do
		if slot0._inTeamHeroUidList[slot4] ~= slot0._originalHeroUidList[slot4] then
			return true
		end
	end

	return false
end

function slot0.cancelAllSelected(slot0)
	if slot0._scrollViews then
		for slot4, slot5 in ipairs(slot0._scrollViews) do
			slot5:selectCell(slot0:getIndex(slot5:getFirstSelect()), false)
		end
	end
end

function slot0.isTeamFull(slot0)
	slot5 = #slot0._inTeamHeroUidList

	for slot5 = 1, math.min(HeroGroupModel.instance:getBattleRoleNum() or 0, slot5) do
		if slot0._inTeamHeroUidList[slot5] == "0" and Act183Helper.isHeroGroupPositionOpen(slot0.episodeId, slot5) then
			return false
		end
	end

	return true
end

function slot0.checkHeroIsError(slot0, slot1)
	if not slot1 or tonumber(slot1) < 0 then
		return
	end

	if not HeroModel.instance:getById(slot1) then
		return
	end

	if slot0.adventure then
		if WeekWalkModel.instance:getCurMapHeroCd(slot2.heroId) > 0 then
			return true
		end
	elseif slot0.isTowerBattle and TowerModel.instance:isHeroBan(slot2.heroId) then
		return true
	end
end

function slot0.cancelAllErrorSelected(slot0)
	slot1 = false

	for slot5, slot6 in pairs(slot0._inTeamHeroUidList) do
		if slot0:checkHeroIsError(slot6) then
			slot1 = true

			break
		end
	end

	if slot1 then
		slot0._inTeamHeroUidList = {}
	end
end

function slot0.setParam(slot0, slot1, slot2)
	slot0.adventure = slot1
	slot0.isTowerBattle = slot2
end

function slot0.clear(slot0)
	slot0._inTeamHeroUidMap = nil
	slot0._inTeamHeroUidList = nil
	slot0._originalHeroUidList = nil
	slot0._selectIndex = nil
	slot0._selectUid = nil

	uv0.super.clear(slot0)
end

slot0.instance = slot0.New()

return slot0
