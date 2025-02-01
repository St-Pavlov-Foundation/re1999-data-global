module("modules.logic.gift.model.GiftModel", package.seeall)

slot0 = class("GiftModel", BaseModel)

function slot0.onInit(slot0)
	slot0._multipleChoiceIndex = 0
	slot0._multipleChoiceId = 0
	slot0._needProps = {}
end

function slot0.reset(slot0)
	slot0._multipleChoiceIndex = 0
	slot0._multipleChoiceId = 0
	slot0._needProps = {}
end

function slot0.setMultipleChoiceIndex(slot0, slot1)
	slot0._multipleChoiceIndex = slot1
end

function slot0.getMultipleChoiceIndex(slot0)
	return slot0._multipleChoiceIndex
end

function slot0.setMultipleChoiceId(slot0, slot1)
	slot0._multipleChoiceId = slot1
end

function slot0.getMultipleChoiceId(slot0)
	return slot0._multipleChoiceId
end

function slot0.setNeedGift(slot0, slot1)
	table.insert(slot0._needProps, slot1)
end

function slot0.isGiftNeed(slot0, slot1)
	for slot5, slot6 in pairs(slot0._needProps) do
		if slot6 == slot1 then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
