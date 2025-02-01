module("modules.logic.versionactivity2_2.eliminate.model.mo.WarChessCharacterMO", package.seeall)

slot0 = class("WarChessCharacterMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.slotIds = {}
	slot0.diamonds = {}
	slot0.addDiamonds = {}
	slot0.removeDiamonds = {}
	slot0.powerMax = slot1.powerMax
	slot0.hpInjury = 0

	slot0:updateInfo(slot1)
	slot0:updateSlotInfo(slot1.slotBox)
end

function slot0.updateInfo(slot0, slot1)
	slot0.hp = slot1.hp
	slot0.power = slot1.power
	slot0.forecastBehavior = tabletool.copy(slot1.forecastBehavior)

	slot0:updateDiamondBox(slot1.diamondBox)
end

function slot0.updateSlotInfo(slot0, slot1)
	if slot1 then
		slot0.slotIds = tabletool.copy(slot1.pieceId)
	end
end

function slot0.updateDiamondBox(slot0, slot1)
	if slot1 and slot1.diamond then
		tabletool.clear(slot0.diamonds)

		for slot5, slot6 in ipairs(slot1.diamond) do
			slot0.diamonds[slot6.type] = slot6.count
		end
	end
end

function slot0.updateHp(slot0, slot1)
	if slot1 < 0 then
		slot0.hpInjury = slot0.hpInjury + math.abs(slot1)
	end

	slot0.hp = slot0.hp + slot1

	if slot0.hp < 0 then
		slot0.hp = 0
	end
end

function slot0.updatePower(slot0, slot1)
	slot0.power = slot0.power + slot1
end

function slot0.updateForecastBehavior(slot0, slot1)
	slot0.forecastBehavior = tabletool.copy(slot1)
end

function slot0.updateDiamondInfo(slot0, slot1, slot2)
	if slot0.diamonds[slot1] == nil then
		slot0.diamonds[slot1] = slot2
	else
		slot0.diamonds[slot1] = slot0.diamonds[slot1] + slot2
	end

	if slot2 > 0 then
		slot0.addDiamonds[slot1] = (slot0.addDiamonds[slot1] or 0) + slot2
	else
		slot0.removeDiamonds[slot1] = (slot0.removeDiamonds[slot1] or 0) + math.abs(slot2)
	end
end

function slot0.diamondsIsEnough(slot0, slot1, slot2)
	if not slot0.diamonds or not slot0.diamonds[slot1] then
		return false
	end

	return slot2 <= slot0.diamonds[slot1]
end

function slot0.diffData(slot0, slot1)
	slot2 = true

	if slot0.id ~= slot1.id then
		slot2 = false
	end

	if slot0.power ~= slot1.power then
		slot2 = false
	end

	if slot0.hp ~= slot1.hp then
		slot2 = false
	end

	if slot0.diamonds and slot1.diamonds then
		for slot6, slot7 in pairs(slot0.diamonds) do
			if slot7 ~= slot1.diamonds[slot6] then
				slot2 = false
			end
		end
	end

	if slot0.slotIds and slot1.slotIds then
		for slot6, slot7 in ipairs(slot0.slotIds) do
			if slot7 ~= slot1.slotIds[slot6] then
				slot2 = false
			end
		end
	end

	return slot2
end

return slot0
