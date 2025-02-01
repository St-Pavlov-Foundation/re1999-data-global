module("modules.logic.seasonver.act123.model.Season123HeroGroupEditModel", package.seeall)

slot0 = class("Season123HeroGroupEditModel", ListScrollModel)

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.activityId = slot1
	slot0.layer = slot2
	slot0.episodeId = slot3
	slot0.episodeCO = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
	slot0.stage = slot4
end

function slot0.setMoveHeroId(slot0, slot1)
	slot0._moveHeroId = slot1
end

function slot0.getMoveHeroIndex(slot0)
	return slot0._moveHeroIndex
end

function slot0.copyCharacterCardList(slot0, slot1)
	if Season123Model.instance:getAssistData(slot0.activityId, slot0.stage) and Season123Controller.isEpisodeFromSeason123(slot0.episodeId) and Season123HeroGroupModel.instance:isEpisodeSeason123() then
		table.insert(tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList()), slot3)
	end

	slot4 = {}
	slot5 = {}
	slot0._inTeamHeroUids = {}
	slot6 = 0

	for slot12, slot13 in ipairs(HeroSingleGroupModel.instance:getList()) do
		slot14 = slot13.heroUid

		if not slot13.aid and tonumber(slot14) > 0 and not slot5[slot14] and slot0:checkSeasonBox(Season123HeroUtils.getHeroMO(slot0.activityId, slot14, slot0.stage)) then
			table.insert(slot4, slot15)

			if slot0.specialHero == slot14 then
				slot0._inTeamHeroUids[slot14] = 2
				slot6 = 1
			else
				slot0._inTeamHeroUids[slot14] = 1
				slot7 = slot7 + 1
			end

			slot5[slot14] = true
		end
	end

	for slot12, slot13 in ipairs(slot4) do
		if slot0._moveHeroId and slot13.heroId == slot0._moveHeroId then
			slot0._moveHeroId = nil
			slot0._moveHeroIndex = slot12

			break
		end
	end

	for slot13, slot14 in ipairs(slot2) do
		if not slot5[slot14.uid] and slot0:checkSeasonBox(slot14) then
			slot5[slot14.uid] = true

			if slot0._moveHeroId and slot14.heroId == slot0._moveHeroId then
				slot0._moveHeroId = nil
				slot0._moveHeroIndex = #slot4 + 1

				table.insert(slot4, slot0._moveHeroIndex, slot14)
			else
				table.insert(slot4, slot14)
			end
		end
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		slot0.sortIndexMap = {}

		for slot13, slot14 in ipairs(slot4) do
			slot0.sortIndexMap[slot14] = slot13
		end

		table.sort(slot4, uv0.sortDead)
	end

	slot0:setList(slot4)

	if slot1 and #slot4 > 0 and slot6 > 0 and #slot0._scrollViews > 0 then
		for slot13, slot14 in ipairs(slot0._scrollViews) do
			slot14:selectCell(slot6, true)
		end

		if slot4[slot6] then
			return slot4[slot6]
		end
	end
end

function slot0.sortDead(slot0, slot1)
	if uv0.instance:getHeroIsDead(slot0) ~= uv0.instance:getHeroIsDead(slot1) then
		return slot3
	else
		return uv0.instance.sortIndexMap[slot0] < uv0.instance.sortIndexMap[slot1]
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

function slot0.cancelAllSelected(slot0)
	if slot0._scrollViews then
		for slot4, slot5 in ipairs(slot0._scrollViews) do
			slot5:selectCell(slot0:getIndex(slot5:getFirstSelect()), false)
		end
	end
end

function slot0.isInTeamHero(slot0, slot1)
	return slot0._inTeamHeroUids and slot0._inTeamHeroUids[slot1]
end

function slot0.setParam(slot0, slot1)
	slot0.specialHero = slot1
end

function slot0.getEquipMOByHeroUid(slot0, slot1)
	if not HeroGroupModel.instance:getCurGroupMO() then
		return
	end

	if tabletool.indexOf(slot2.heroList, slot1) and slot2:getPosEquips(slot3 - 1) and slot4.equipUid and #slot4.equipUid > 0 and slot4.equipUid[1] and slot5 ~= Activity123Enum.EmptyUid then
		return EquipModel.instance:getEquip(slot5)
	end
end

function slot0.getAssistHeroList(slot0)
	slot1 = {}

	if Season123Model.instance:getAssistData(slot0.activityId, slot0.stage) and Season123Controller.isEpisodeFromSeason123(slot0.episodeId) then
		table.insert(slot1, slot2)
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
