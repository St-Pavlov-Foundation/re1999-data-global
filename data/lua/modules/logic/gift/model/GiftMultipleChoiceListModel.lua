module("modules.logic.gift.model.GiftMultipleChoiceListModel", package.seeall)

slot0 = class("GiftMultipleChoiceListModel", ListScrollModel)

function slot0.setPropList(slot0, slot1)
	slot0._moList = slot1 and slot1 or {}

	slot0:setList(slot0._moList)
end

function slot0.getOptionalGiftIdList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in pairs(ItemModel.instance:getOptionalGiftMaterialSubTypeList(slot1)) do
		table.insert(slot2, slot8)
	end

	return slot2
end

function slot0.getOptionalGiftInfo(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(slot0:getOptionalGiftIdList(slot1)) do
		table.insert(slot3, {
			1,
			slot8,
			1
		})
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
