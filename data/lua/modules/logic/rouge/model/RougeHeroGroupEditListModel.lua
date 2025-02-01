module("modules.logic.rouge.model.RougeHeroGroupEditListModel", package.seeall)

slot0 = class("RougeHeroGroupEditListModel", ListScrollModel)

function slot0.setMoveHeroId(slot0, slot1)
	slot0._moveHeroId = slot1
end

function slot0.getMoveHeroIndex(slot0)
	return slot0._moveHeroIndex
end

function slot0.setHeroGroupEditType(slot0, slot1)
	slot0._heroGroupEditType = slot1
	slot0._skipAssitType = slot0._heroGroupEditType == RougeEnum.HeroGroupEditType.Init or slot0._heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero
end

function slot0.setCapacityInfo(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0._selectHeroCapacity = slot1
	slot0._curCapacity = slot2
	slot0._totalCapacity = slot3
	slot0._assistCapacity = slot4 or 0
	slot0._assistPos = slot5
	slot0._assistHeroId = slot6
end

function slot0.getAssistHeroId(slot0)
	return slot0._assistHeroId
end

function slot0.getAssistCapacity(slot0)
	return slot0._assistCapacity
end

function slot0.getAssistPos(slot0)
	return slot0._assistPos
end

function slot0.getTotalCapacity(slot0)
	return slot0._totalCapacity
end

function slot0.canAddCapacity(slot0, slot1, slot2)
	if not slot0._curCapacity or not slot0._totalCapacity then
		return false
	end

	return slot0:calcTotalCapacity(slot1, slot2) <= slot0._totalCapacity
end

function slot0.calcTotalCapacity(slot0, slot1, slot2)
	slot3 = 0
	slot5 = {}

	for slot9, slot10 in ipairs(RougeHeroSingleGroupModel.instance:getList()) do
		if slot10:getHeroMO() == slot2 then
			slot11 = nil
		end

		if slot9 == slot1 then
			slot11 = slot2
		end

		if RougeEnum.FightTeamNormalHeroNum < slot9 and not slot0._skipAssitType and not slot5[slot9 - RougeEnum.FightTeamNormalHeroNum] then
			slot11 = nil
		end

		slot5[slot9] = slot11
	end

	for slot9, slot10 in pairs(slot5) do
		slot3 = slot3 + RougeController.instance:getRoleStyleCapacity(slot10, RougeEnum.FightTeamNormalHeroNum < slot9 and not slot0._skipAssitType)
	end

	return slot3 + slot0._assistCapacity
end

function slot0.getHeroGroupEditType(slot0)
	return slot0._heroGroupEditType
end

function slot0.getTeamNoSortedList(slot0)
	slot3 = {}
	slot4 = {}

	for slot8, slot9 in pairs(RougeModel.instance:getTeamInfo().heroLifeMap) do
		table.insert(slot3, HeroModel.instance:getByHeroId(slot9.heroId))
	end

	return slot3
end

function slot0.getTeamList(slot0, slot1)
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot1) do
		if RougeModel.instance:getTeamInfo().heroLifeMap[slot10.heroId] then
			if slot11.life > 0 then
				table.insert(slot4, HeroModel.instance:getByHeroId(slot11.heroId))
			else
				table.insert(slot5, slot12)
			end
		end
	end

	tabletool.addValues(slot4, slot5)

	return slot4
end

function slot0.getSelectHeroList(slot0, slot1)
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if not RougeModel.instance:getTeamInfo().heroLifeMap[slot9.heroId] then
			table.insert(slot4, slot9)
		end
	end

	return slot4
end

function slot0.copyCharacterCardList(slot0, slot1)
	if slot0._heroGroupEditType == RougeEnum.HeroGroupEditType.Fight or slot0._heroGroupEditType == RougeEnum.HeroGroupEditType.FightAssit then
		slot2 = slot0:getTeamList(CharacterBackpackCardListModel.instance:getCharacterCardList())
	elseif slot0._heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		slot2 = slot0:getSelectHeroList(slot2)
	end

	slot3 = {}
	slot4 = {}
	slot0._inTeamHeroUids = {}
	slot0._heroTeamPosIndex = {}
	slot5 = 1
	slot6 = 1

	for slot11, slot12 in ipairs(RougeHeroSingleGroupModel.instance:getList()) do
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
			slot0._heroTeamPosIndex[slot12.heroUid] = slot11
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
			elseif slot14.heroId ~= slot0._assistHeroId then
				table.insert(slot3, slot14)
			end
		end
	end

	if slot0.adventure then
		tabletool.addValues(slot3, slot9)
	end

	slot0:setList(slot3)

	if (slot0._heroGroupEditType == RougeEnum.HeroGroupEditType.Init or slot0._heroGroupEditType == RougeEnum.HeroGroupEditType.FightAssit or slot0._heroGroupEditType == RougeEnum.HeroGroupEditType.Fight) and (slot0._selectHeroCapacity or 0) <= 0 then
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

function slot0.getTeamPosIndex(slot0, slot1)
	return slot0._heroTeamPosIndex[slot1]
end

function slot0.setParam(slot0, slot1, slot2)
	slot0.specialHero = slot1
	slot0.adventure = slot2
end

slot0.instance = slot0.New()

return slot0
