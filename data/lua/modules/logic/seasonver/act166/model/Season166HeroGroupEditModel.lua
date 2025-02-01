module("modules.logic.seasonver.act166.model.Season166HeroGroupEditModel", package.seeall)

slot0 = class("Season166HeroGroupEditModel", ListScrollModel)

function slot0.init(slot0, slot1, slot2)
	slot0.activityId = slot1
	slot0.episodeId = slot2
	slot0.episodeCO = DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
end

function slot0.copyCharacterCardList(slot0, slot1)
	slot2 = nil
	slot2 = (not HeroGroupTrialModel.instance:isOnlyUseTrial() or {}) and tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	slot4 = {}
	slot0._inTeamHeroUids = {}
	slot5 = 1
	slot6 = 1
	slot8 = Season166HeroSingleGroupModel.instance.assistMO

	for slot12, slot13 in ipairs(Season166HeroSingleGroupModel.instance:getList()) do
		if slot13.trial or not slot13.aid and tonumber(slot13.heroUid) > 0 and not slot4[slot13.heroUid] then
			if slot13.trial then
				table.insert({}, HeroGroupTrialModel.instance:getById(slot13.heroUid))
			elseif slot8 and slot13.heroUid == slot8.heroUid then
				table.insert(slot3, slot8:getHeroMO())
			else
				table.insert(slot3, HeroModel.instance:getById(slot13.heroUid))
			end

			if slot0.specialHero == slot13.heroUid then
				slot0._inTeamHeroUids[slot13.heroUid] = 2
				slot5 = slot6
			else
				slot0._inTeamHeroUids[slot13.heroUid] = 1
				slot6 = slot6 + 1
			end

			slot4[slot13.heroUid] = true
		end
	end

	for slot13, slot14 in ipairs(HeroGroupTrialModel.instance:getFilterList()) do
		if not slot4[slot14.uid] then
			table.insert(slot3, slot14)
		end
	end

	slot10 = #slot3

	for slot14, slot15 in ipairs(slot2) do
		if not slot4[slot15.uid] then
			slot4[slot15.uid] = true

			table.insert(slot3, slot15)
		end
	end

	if Season166HeroGroupModel.instance:isSeason166Episode() then
		slot0.sortIndexMap = {}

		for slot14, slot15 in ipairs(slot3) do
			slot0.sortIndexMap[slot15] = slot14
		end

		table.sort(slot3, uv0.indexMapSortFunc)
	end

	slot0:setList(slot3)

	if slot1 and #slot3 > 0 and slot5 > 0 and #slot0._scrollViews > 0 then
		for slot14, slot15 in ipairs(slot0._scrollViews) do
			slot15:selectCell(slot5, true)
		end

		if slot3[slot5] then
			return slot3[slot5]
		end
	end
end

function slot0.indexMapSortFunc(slot0, slot1)
	return uv0.instance.sortIndexMap[slot0] < uv0.instance.sortIndexMap[slot1]
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

function slot0.getEquipMOByHeroUid(slot0, slot1)
	if not Season166HeroGroupModel.instance:getCurGroupMO() then
		return
	end

	if tabletool.indexOf(slot2.heroList, slot1) and slot2:getPosEquips(slot3 - 1) and slot4.equipUid and #slot4.equipUid > 0 and slot4.equipUid[1] and slot5 ~= Season166Enum.EmptyUid then
		return EquipModel.instance:getEquip(slot5)
	end
end

function slot0.getAssistHeroList(slot0)
	slot1 = {}

	if Season166HeroSingleGroupModel.instance.assistMO and Season166HeroGroupModel.instance:isSeason166Episode(slot0.episodeId) then
		table.insert(slot1, slot2:getHeroMO())
	end

	return slot1
end

function slot0.isRepeatHero(slot0, slot1, slot2)
	if not slot0._inTeamHeroUids then
		return false
	end

	for slot6 in pairs(slot0._inTeamHeroUids) do
		if slot0:getById(slot6) and slot7.heroId == slot1 and slot2 ~= slot7.uid then
			return true
		end
	end

	return false
end

function slot0.isTrialLimit(slot0)
	if not slot0._inTeamHeroUids then
		return false
	end

	for slot5 in pairs(slot0._inTeamHeroUids) do
		if slot0:getById(slot5):isTrial() then
			slot1 = 0 + 1
		end
	end

	return HeroGroupTrialModel.instance:getLimitNum() <= slot1
end

function slot0.setParam(slot0, slot1)
	slot0.specialHero = slot1
end

slot0.instance = slot0.New()

return slot0
