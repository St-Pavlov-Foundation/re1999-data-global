module("modules.logic.seasonver.act166.model.Season166HeroGroupQuickEditModel", package.seeall)

slot0 = class("Season166HeroGroupQuickEditModel", ListScrollModel)

function slot0.init(slot0, slot1, slot2)
	slot0.activityId = slot1
	slot0.episodeId = slot2
	slot0.episodeCO = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
end

function slot0.copyQuickEditCardList(slot0)
	slot1 = nil
	slot1 = (not HeroGroupTrialModel.instance:isOnlyUseTrial() or {}) and tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	slot3 = {}
	slot0._inTeamHeroUidMap = {}
	slot0._inTeamHeroUidList = {}
	slot0._originalHeroUidList = {}
	slot0._selectUid = nil

	for slot8, slot9 in ipairs(Season166HeroGroupModel.instance:getCurGroupMO().heroList) do
		if tonumber(slot9) > 0 and not slot3[slot9] then
			table.insert({}, slot0:getHeroMO(slot9))

			if Season166HeroGroupModel.instance:isPositionOpen(slot8) then
				slot0._inTeamHeroUidMap[slot9] = 1
			end

			slot3[slot9] = true
		elseif Season166HeroSingleGroupModel.instance:getByIndex(slot8) and slot11.trial then
			table.insert(slot2, HeroGroupTrialModel.instance:getById(slot9))

			if slot10 then
				slot0._inTeamHeroUidMap[slot9] = 1
			end

			slot3[slot9] = true
		end

		if slot10 then
			table.insert(slot0._inTeamHeroUidList, slot9)
			table.insert(slot0._originalHeroUidList, slot9)
		end
	end

	for slot9, slot10 in ipairs(HeroGroupTrialModel.instance:getFilterList()) do
		if not slot3[slot10.uid] then
			table.insert(slot2, slot10)
		end
	end

	for slot9, slot10 in ipairs(slot1) do
		if not slot3[slot10.uid] then
			slot3[slot10.uid] = true

			table.insert(slot2, slot10)
		end
	end

	if Season166HeroGroupModel.instance:isSeason166Episode() then
		slot0.sortIndexMap = {}

		for slot9, slot10 in ipairs(slot2) do
			slot0.sortIndexMap[slot10] = slot9
		end

		table.sort(slot2, uv0.indexMapSortFunc)
	end

	slot0:setList(slot2)
end

function slot0.indexMapSortFunc(slot0, slot1)
	return uv0.instance.sortIndexMap[slot0] < uv0.instance.sortIndexMap[slot1]
end

function slot0.getHeroMO(slot0, slot1)
	if not HeroModel.instance:getById(slot1) and Season166HeroGroupModel.instance:isSeason166TrainEpisode(slot0.episodeId) then
		if Season166HeroSingleGroupModel.instance.assistMO and slot4.heroUid == slot1 then
			return slot4:getHeroMO()
		end
	else
		return slot2
	end
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
		for slot5, slot6 in ipairs(slot0._inTeamHeroUidList) do
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
		if slot0:getById(slot6) and slot7.heroId == slot1 and slot2 ~= slot7.uid then
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

	return HeroGroupTrialModel.instance:getLimitNum() <= slot1
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
	for slot4 = 1, #slot0._inTeamHeroUidList do
		if slot0._inTeamHeroUidList[slot4] == "0" then
			return false
		end
	end

	return true
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
