module("modules.logic.store.model.ActivityStoreModel", package.seeall)

slot0 = class("ActivityStoreModel", BaseModel)

function slot0.onInit(slot0)
	slot0.activityGoodsInfosDict = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initActivityGoodsInfos(slot0, slot1, slot2)
	slot0.activityGoodsInfosDict = slot0.activityGoodsInfosDict or {}
	slot4 = nil

	for slot8, slot9 in ipairs(slot2) do
		ActivityStoreMo.New():init(slot1, slot9)
	end

	slot0.activityGoodsInfosDict[slot1] = {
		[slot4.id] = slot4
	}
end

function slot0.updateActivityGoodsInfos(slot0, slot1, slot2)
	if not slot0.activityGoodsInfosDict[slot1][slot2.id] then
		slot4 = ActivityStoreMo.New()

		slot4:init(slot1, slot2)

		slot3[slot4.id] = slot4
	else
		slot4:updateData(slot2)
	end
end

function slot0.getActivityGoodsBuyCount(slot0, slot1, slot2)
	if not slot0.activityGoodsInfosDict or not slot3[slot1] or not slot3[slot1][slot2] then
		return 0
	end

	return slot3[slot1][slot2].buyCount or 0
end

slot0.instance = slot0.New()

return slot0
