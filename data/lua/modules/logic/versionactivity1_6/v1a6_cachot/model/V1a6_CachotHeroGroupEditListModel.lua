module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotHeroGroupEditListModel", package.seeall)

slot0 = class("V1a6_CachotHeroGroupEditListModel", ListScrollModel)

function slot0.setMoveHeroId(slot0, slot1)
	slot0._moveHeroId = slot1
end

function slot0.getMoveHeroIndex(slot0)
	return slot0._moveHeroIndex
end

function slot0.setHeroGroupEditType(slot0, slot1)
	slot0._heroGroupEditType = slot1
end

function slot0.getHeroGroupEditType(slot0)
	return slot0._heroGroupEditType
end

function slot0.setSeatLevel(slot0, slot1)
	slot0._seatLevel = slot1
end

function slot0.getSeatLevel(slot0)
	return slot0._seatLevel
end

function slot0.copyCharacterCardList(slot0, slot1)
	slot2 = CharacterBackpackCardListModel.instance:getCharacterCardList()

	if slot0._heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Fight then
		slot5 = {}
		slot6 = {}

		for slot10, slot11 in ipairs(slot2) do
			if V1a6_CachotModel.instance:getTeamInfo():getAllHeroIdsMap()[slot11.heroId] then
				if slot3:getHeroHp(slot11.heroId).life > 0 then
					table.insert(slot5, slot11)
				else
					table.insert(slot6, slot11)
				end
			end
		end

		tabletool.addValues(slot5, slot6)

		slot2 = slot5
	end

	slot3 = {}
	slot4 = {}
	slot0._inTeamHeroUids = {}
	slot5 = 1
	slot6 = 1

	for slot11, slot12 in ipairs(V1a6_CachotHeroSingleGroupModel.instance:getList()) do
		if slot12.trial or not slot12.aid and tonumber(slot12.heroUid) > 0 and not slot4[slot12.heroUid] then
			if slot12.trial then
				table.insert(slot3, HeroGroupTrialModel.instance:getById(slot12.heroUid))
			else
				table.insert(slot3, HeroModel.instance:getById(slot12.heroUid))
			end

			if slot0.specialHero == slot12.heroUid then
				slot0._inTeamHeroUids[slot12.heroUid] = 2
				slot5 = slot6
			else
				slot0._inTeamHeroUids[slot12.heroUid] = 1
				slot6 = slot6 + 1
			end

			slot4[slot12.heroUid] = true
		end
	end

	for slot11, slot12 in ipairs(slot3) do
		if slot0._moveHeroId and slot12.heroId == slot0._moveHeroId then
			slot0._moveHeroId = nil
			slot0._moveHeroIndex = slot11

			break
		end
	end

	slot8 = #slot3

	for slot13, slot14 in ipairs(slot2) do
		if not slot4[slot14.uid] then
			slot4[slot14.uid] = true

			if slot0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(slot14.heroId) > 0 then
					table.insert({}, slot14)
				else
					table.insert(slot3, slot14)
				end
			elseif slot0._moveHeroId and slot14.heroId == slot0._moveHeroId then
				slot0._moveHeroId = nil
				slot0._moveHeroIndex = slot8 + 1

				table.insert(slot3, slot0._moveHeroIndex, slot14)
			elseif slot0._heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
				table.insert(slot3, #slot3 - slot8 + 1, slot14)
			else
				table.insert(slot3, slot14)
			end
		end
	end

	if slot0.adventure then
		tabletool.addValues(slot3, slot9)
	end

	slot0:setList(slot3)

	if slot0._heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event and #V1a6_CachotModel.instance:getRogueInfo().teamInfo:getFightHeros() == #slot3 then
		slot5 = 0
	end

	if slot1 and #slot3 > 0 and slot5 > 0 and #slot0._scrollViews > 0 then
		for slot13, slot14 in ipairs(slot0._scrollViews) do
			slot14:selectCell(slot5, true)
		end

		if slot3[slot5] then
			return slot3[slot5]
		end
	end
end

function slot0.isRepeatHero(slot0, slot1, slot2)
	if not slot0._inTeamHeroUids then
		return false
	end

	for slot6 in pairs(slot0._inTeamHeroUids) do
		if slot0:getById(slot6).heroId == slot1 and slot2 ~= slot7.uid then
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

function slot0.setParam(slot0, slot1, slot2)
	slot0.specialHero = slot1
	slot0.adventure = slot2
end

slot0.instance = slot0.New()

return slot0
