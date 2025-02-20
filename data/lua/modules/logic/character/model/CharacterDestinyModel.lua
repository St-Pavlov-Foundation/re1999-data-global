module("modules.logic.character.model.CharacterDestinyModel", package.seeall)

slot0 = class("CharacterDestinyModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onRankUp(slot0, slot1)
end

function slot0.getCurSlotAttrInfos(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot5 = {}
	slot6 = {}
	slot7 = CharacterDestinyConfig.instance:getCurDestinySlotAddAttr(slot1, slot2, slot3)
	slot9 = CharacterDestinyConfig.instance:getLockAttr(slot1, slot2)
	slot10 = {}

	if CharacterDestinyConfig.instance:getNextDestinySlotCo(slot1, slot2, slot3) then
		for slot15, slot16 in ipairs(GameUtil.splitString2(slot8.effect, true)) do
			slot10[slot16[1]] = HeroConfig.instance:getHeroAttributeCO(slot16[1]).showType == 1 and slot16[2] * 0.1 or slot16[2]
		end
	end

	if slot2 > 0 then
		if slot7 then
			for slot14, slot15 in pairs(slot7) do
				if LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpBaseAttr, slot14) then
					table.insert(slot4, {
						attrId = slot14,
						curNum = slot7[slot14],
						nextNum = slot10[slot14],
						isSpecial = false
					})
				else
					table.insert(slot5, {
						attrId = slot14,
						curNum = slot7[slot14],
						nextNum = slot10[slot14],
						isSpecial = true
					})
				end
			end

			table.sort(slot4, slot0.sortAttr)
			table.sort(slot5, slot0.sortAttr)
		end
	else
		if not slot6[1] then
			slot6[1] = {}
		end

		for slot14, slot15 in pairs(CharacterDestinyEnum.DestinyUpBaseAttr) do
			table.insert(slot6[1], {
				attrId = slot15,
				curNum = slot10[slot15]
			})
		end
	end

	if slot9 then
		for slot14, slot15 in pairs(slot9) do
			for slot19, slot20 in pairs(slot15) do
				slot21 = {
					attrId = slot19,
					curNum = slot20
				}

				if not slot0:__isHadAttr(slot4, slot19) and not slot0:__isHadAttr(slot5, slot19) and not slot0:_isHadAttr(slot6, slot19) then
					if not slot6[slot14] then
						slot6[slot14] = {}
					end

					table.insert(slot6[slot14], slot21)
				end
			end
		end

		for slot14, slot15 in pairs(slot6) do
			table.sort(slot15, slot0.sortAttr)
		end
	end

	return slot4, slot5, slot6
end

function slot0.sortAttr(slot0, slot1)
	if LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpBaseAttr, slot0.attrId) ~= LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpBaseAttr, slot1.attrId) then
		return slot2
	end

	return slot0.attrId < slot1.attrId
end

function slot0._isHadAttr(slot0, slot1, slot2)
	if slot1 then
		for slot6, slot7 in pairs(slot1) do
			if slot0:__isHadAttr(slot7, slot2) then
				return true
			end
		end
	end
end

function slot0.__isHadAttr(slot0, slot1, slot2)
	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if slot7.attrId == slot2 then
				return true
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
