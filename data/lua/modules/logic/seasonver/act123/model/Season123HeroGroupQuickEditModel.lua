module("modules.logic.seasonver.act123.model.Season123HeroGroupQuickEditModel", package.seeall)

slot0 = class("Season123HeroGroupQuickEditModel", ListScrollModel)

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.activityId = slot1
	slot0.layer = slot2
	slot0.episodeId = slot3
	slot0.episodeCO = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
	slot0.stage = slot4
end

function slot0.copyQuickEditCardList(slot0)
	if Season123Model.instance:getAssistData(slot0.activityId, slot0.stage) and Season123Controller.isEpisodeFromSeason123(slot0.episodeId) and Season123HeroGroupModel.instance:isEpisodeSeason123() then
		table.insert(tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList()), slot2)
	end

	slot4 = {}
	slot0._inTeamHeroUidMap = {}
	slot0._inTeamHeroUidList = {}
	slot0._originalHeroUidList = {}
	slot0._selectUid = nil

	for slot9, slot10 in ipairs(HeroGroupModel.instance:getCurGroupMO().heroList) do
		slot11 = HeroGroupModel.instance:isPositionOpen(slot9)

		if slot10 ~= "0" and not slot4[slot10] and slot0:checkSeasonBox(Season123HeroUtils.getHeroMO(slot0.activityId, slot10, slot0.stage)) then
			table.insert({}, slot12)

			if slot11 then
				slot0._inTeamHeroUidMap[slot10] = 1
			end

			slot4[slot10] = true
		end

		if slot11 then
			table.insert(slot0._inTeamHeroUidList, slot10)
			table.insert(slot0._originalHeroUidList, slot10)
		end
	end

	slot6 = {}

	for slot10, slot11 in ipairs(slot1) do
		if not slot4[slot11.uid] and slot0:checkSeasonBox(slot11) then
			slot4[slot11.uid] = true

			table.insert(slot3, slot11)
		end
	end

	if slot0.adventure then
		tabletool.addValues(slot3, slot6)
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		slot0.sortIndexMap = {}

		for slot10, slot11 in ipairs(slot3) do
			slot0.sortIndexMap[slot11] = slot10
		end

		table.sort(slot3, uv0.sortDead)
	end

	slot0:setList(slot3)
end

function slot0.sortDead(slot0, slot1)
	if uv0.instance:getHeroIsDead(slot0) ~= uv0.instance:getHeroIsDead(slot1) then
		return slot3
	else
		return Season123HeroGroupEditModel.instance.sortIndexMap[slot0] < Season123HeroGroupEditModel.instance.sortIndexMap[slot1]
	end
end

function slot0.getHeroIsDead(slot0, slot1)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		slot2 = false

		if Season123Model.instance:getSeasonHeroMO(slot0.activityId, slot0.stage, slot0.layer, slot1.uid) ~= nil then
			slot2 = slot6.hpRate <= 0
		end

		return slot2
	end

	return false
end

function slot0.checkSeasonBox(slot0, slot1)
	if slot0.episodeCO then
		if slot0.episodeCO.type == DungeonEnum.EpisodeType.Season123 then
			return Season123Model.instance:getSeasonHeroMO(slot0.activityId, slot0.stage, slot0.layer, slot1.uid)
		else
			return true
		end
	end

	return false
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
		if slot0._inTeamHeroUidList[slot4] == "0" and HeroGroupModel.instance:isPositionOpen(slot4) then
			return false
		end
	end

	return true
end

function slot0.setParam(slot0, slot1)
	slot0.adventure = slot1
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
