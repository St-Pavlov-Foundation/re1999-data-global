module("modules.logic.equip.model.EquipModel", package.seeall)

slot0 = class("EquipModel", BaseModel)

function slot0.onInit(slot0)
	slot0.strengthenPrompt = nil
	slot0._equipQualityDic = {}
end

function slot0.reInit(slot0)
	slot0._equipList = nil
	slot0._equipDic = nil
	slot0._equipQualityDic = {}
	slot0.strengthenPrompt = nil
end

function slot0.getEquips(slot0)
	return slot0._equipList
end

function slot0.getEquip(slot0, slot1)
	return slot1 and slot0._equipDic[slot1]
end

function slot0.haveEquip(slot0, slot1)
	return slot0._equipQualityDic[slot1] and slot0._equipQualityDic[slot1] > 0
end

function slot0.getEquipQuantity(slot0, slot1)
	return slot0._equipQualityDic[slot1] or 0
end

function slot0.addEquips(slot0, slot1)
	slot0._equipList = slot0._equipList or {}
	slot0._equipDic = slot0._equipDic or {}

	for slot5, slot6 in ipairs(slot1) do
		slot8 = false

		if not slot0._equipDic[slot6.uid] then
			slot7 = EquipMO.New()

			table.insert(slot0._equipList, slot7)

			slot0._equipDic[slot6.uid] = slot7
			slot8 = true
		end

		slot7:init(slot6)

		if not slot7.config then
			logError("equipId " .. slot7.equipId .. " not found config")
		else
			slot0._equipQualityDic[slot7.config.id] = slot0._equipQualityDic[slot7.config.id] or 0

			if slot7.config.isExpEquip == 1 then
				slot0._equipQualityDic[slot7.config.id] = slot7.count
			elseif slot8 then
				slot0._equipQualityDic[slot7.config.id] = slot0._equipQualityDic[slot7.config.id] + 1
			end
		end
	end

	EquipController.instance:dispatchEvent(EquipEvent.onUpdateEquip)
end

function slot0.removeEquips(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0._equipDic[slot6].config.isExpEquip == 1 then
			slot0._equipQualityDic[slot7.config.id] = 0
		else
			slot0._equipQualityDic[slot7.config.id] = slot0._equipQualityDic[slot7.config.id] - 1
		end

		slot0._equipDic[slot6] = nil
	end

	slot2 = 1
	slot3 = #slot0._equipList

	for slot7, slot8 in pairs(slot0._equipDic) do
		slot0._equipList[slot2] = slot8
		slot2 = slot2 + 1
	end

	for slot7 = slot2, slot3 do
		slot0._equipList[slot7] = nil
	end

	EquipController.instance:dispatchEvent(EquipEvent.onDeleteEquip, slot1)
end

function slot0.canShowVfx(slot0)
	return slot0 ~= nil and slot0.rare >= 4
end

function slot0.isLimit(slot0, slot1)
	return EquipConfig.instance:getEquipCo(slot1).upperLimit >= 1
end

function slot0.isLimitAndAlreadyHas(slot0, slot1)
	if EquipConfig.instance:getEquipCo(slot1).upperLimit == 0 then
		return false
	end

	return slot2.upperLimit <= slot0:getEquipQuantity(slot1)
end

slot0.instance = slot0.New()

return slot0
