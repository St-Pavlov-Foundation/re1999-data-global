module("modules.logic.herogroup.model.HeroGroupEditListModel", package.seeall)

slot0 = class("HeroGroupEditListModel", ListScrollModel)

function slot0.setMoveHeroId(slot0, slot1)
	slot0._moveHeroId = slot1
end

function slot0.getMoveHeroIndex(slot0)
	return slot0._moveHeroIndex
end

function slot0.copyCharacterCardList(slot0, slot1)
	slot2 = nil
	slot2 = (not HeroGroupTrialModel.instance:isOnlyUseTrial() or {}) and CharacterBackpackCardListModel.instance:getCharacterCardList()
	slot4 = {}
	slot0._inTeamHeroUids = {}
	slot5 = 1
	slot6 = 1

	for slot11, slot12 in ipairs(HeroSingleGroupModel.instance:getList()) do
		if slot12.trial or not slot12.aid and tonumber(slot12.heroUid) > 0 and not slot4[slot12.heroUid] then
			if slot12.trial then
				table.insert({}, HeroGroupTrialModel.instance:getById(slot12.heroUid))
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

	for slot12, slot13 in ipairs(HeroGroupTrialModel.instance:getFilterList()) do
		if not slot4[slot13.uid] then
			table.insert(slot3, slot13)
		end
	end

	for slot12, slot13 in ipairs(slot3) do
		if slot0._moveHeroId and slot13.heroId == slot0._moveHeroId then
			slot0._moveHeroId = nil
			slot0._moveHeroIndex = slot12

			break
		end
	end

	slot9 = #slot3
	slot10 = slot0.isTowerBattle

	for slot15, slot16 in ipairs(slot2) do
		if not slot4[slot16.uid] then
			slot4[slot16.uid] = true

			if slot0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(slot16.heroId) > 0 then
					table.insert({}, slot16)
				else
					table.insert(slot3, slot16)
				end
			elseif slot10 then
				if TowerModel.instance:isHeroBan(slot16.heroId) then
					table.insert(slot11, slot16)
				else
					table.insert(slot3, slot16)
				end
			elseif slot0._moveHeroId and slot16.heroId == slot0._moveHeroId then
				slot0._moveHeroId = nil
				slot0._moveHeroIndex = slot9 + 1

				table.insert(slot3, slot0._moveHeroIndex, slot16)
			else
				table.insert(slot3, slot16)
			end
		end
	end

	if slot0.adventure or slot10 then
		tabletool.addValues(slot3, slot11)
	end

	slot0:setList(slot3)

	if slot1 and #slot3 > 0 and slot5 > 0 and #slot0._scrollViews > 0 then
		for slot15, slot16 in ipairs(slot0._scrollViews) do
			slot16:selectCell(slot5, true)
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

function slot0.setParam(slot0, slot1, slot2, slot3)
	slot0.specialHero = slot1
	slot0.adventure = slot2
	slot0.isTowerBattle = slot3
end

slot0.instance = slot0.New()

return slot0
