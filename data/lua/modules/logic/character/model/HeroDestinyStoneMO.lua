module("modules.logic.character.model.HeroDestinyStoneMO", package.seeall)

slot0 = class("HeroDestinyStoneMO")

function slot0.ctor(slot0, slot1)
	slot0.rank = 0
	slot0.level = 0
	slot0.curUseStoneId = 0
	slot0.unlockStoneIds = nil
	slot0.stoneMoList = nil
	slot0.heroId = slot1
	slot0.maxRank = 0
	slot0.maxLevel = {}

	if CharacterDestinyConfig.instance:getDestinySlotCosByHeroId(slot1) then
		for slot6, slot7 in ipairs(slot2) do
			slot0.maxRank = math.max(slot6, slot0.maxRank)
			slot0.maxLevel[slot6] = tabletool.len(slot7)
		end
	end
end

function slot0.refreshMo(slot0, slot1, slot2, slot3, slot4)
	slot0.rank = slot1
	slot0.level = slot2
	slot0.curUseStoneId = slot3
	slot0.unlockStoneIds = slot4 or {}

	slot0:setStoneMo()
end

function slot0.isUnlockSlot(slot0)
	return slot0.rank > 0
end

function slot0.isCanUpSlotRank(slot0)
	return slot0:getNextDestinySlotCo() and slot1.node == 1
end

function slot0.isSlotMaxLevel(slot0)
	return not slot0:getNextDestinySlotCo()
end

function slot0.setStoneMo(slot0)
	slot1 = CharacterDestinyConfig.instance:getFacetIdsByHeroId(slot0.heroId)

	if not slot0.stoneMoList then
		slot0.stoneMoList = {}
	end

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			if not slot0.stoneMoList[slot6] then
				slot7 = DestinyStoneMO.New()

				slot7:initMo(slot6)

				slot0.stoneMoList[slot6] = slot7
			end

			slot7:refresUnlock(LuaUtil.tableContains(slot0.unlockStoneIds, slot6))
			slot7:refreshUse(slot6 == slot0.curUseStoneId)
		end
	end
end

function slot0.getStoneMo(slot0, slot1)
	return slot0.stoneMoList and slot0.stoneMoList[slot1]
end

function slot0.refreshUseStone(slot0)
	for slot4, slot5 in ipairs(slot0.stoneMoList) do
		slot5:refreshUse(slot4 == slot0.curUseStoneId)
	end
end

function slot0.getCurUseStoneCo(slot0)
	if slot0.curUseStoneId ~= 0 then
		return CharacterDestinyConfig.instance:getDestinyFacets(slot0.curUseStoneId, slot0.rank)
	end
end

function slot0.getAddAttrValues(slot0)
	return slot0:getAddAttrValueByLevel(slot0.rank, slot0.level)
end

function slot0.getAddAttrValueByLevel(slot0, slot1, slot2)
	return CharacterDestinyConfig.instance:getCurDestinySlotAddAttr(slot0.heroId, slot1, slot2)
end

function slot0.getAddValueByAttrId(slot0, slot1, slot2)
	if not (slot1 or slot0:getAddAttrValues())[slot2] then
		if CharacterDestinyEnum.DestinyUpBaseParseAttr[slot2] then
			return slot1[slot2] or 0
		end
	else
		return slot3
	end

	return 0
end

function slot0.getRankLevelCount(slot0)
	return slot0.maxLevel[slot0.rank] or 0
end

function slot0.getNextDestinySlotCo(slot0)
	return CharacterDestinyConfig.instance:getNextDestinySlotCo(slot0.heroId, slot0.rank, slot0.level)
end

function slot0.getCurStoneNameAndIcon(slot0)
	if slot0.curUseStoneId == 0 then
		return
	end

	return slot0:getStoneMo(slot0.curUseStoneId):getNameAndIcon()
end

function slot0.isCanPlayAttrUnlockAnim(slot0, slot1, slot2)
	if not slot0:isUnlockSlot() then
		return
	end

	if slot0.rank < slot2 then
		return
	end

	if not slot0:getStoneMo(slot1) then
		return
	end

	if not slot3.isUnlock then
		return
	end

	if GameUtil.playerPrefsGetNumberByUserId("HeroDestinyStoneMO_isCanPlayAttrUnlockAnim_" .. slot0.heroId .. "_" .. slot2 .. "_" .. slot1, 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(slot4, 1)

		return true
	end
end

function slot0._replaceSkill(slot0, slot1)
	if slot1 and slot0:getCurUseStoneCo() and not string.nilorempty(slot2.exchangeSkills) then
		slot4 = GameUtil.splitString2(slot3, true)

		for slot8 = 1, #slot1 do
			for slot12, slot13 in ipairs(slot4) do
				if slot1[slot8] == slot13[1] then
					slot1[slot8] = slot13[2]
				end
			end
		end
	end

	return slot1
end

function slot0.setRedDot(slot0, slot1)
	slot0.reddot = slot1
end

function slot0.getRedDot(slot0)
	return slot0.reddot or 0
end

function slot0.setTrial(slot0)
	if slot0.maxLevel and slot0.maxRank then
		slot0.level = slot0.maxLevel[slot0.maxRank] or 1
	end
end

return slot0
