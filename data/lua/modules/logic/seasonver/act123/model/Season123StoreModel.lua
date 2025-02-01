module("modules.logic.seasonver.act123.model.Season123StoreModel", package.seeall)

slot0 = class("Season123StoreModel", ListScrollModel)

function slot0.OnInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.storeItemList = {}
end

function slot0.setStoreItemList(slot0, slot1)
	slot0.storeItemList = tabletool.copy(slot1)

	table.sort(slot0.storeItemList, uv0.sortGoods)
	slot0:setList(slot0.storeItemList)
end

function slot0.sortGoods(slot0, slot1)
	if (slot0.maxBuyCount ~= 0 and slot0.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(slot0.activityId, slot0.id) <= 0) ~= (slot1.maxBuyCount ~= 0 and slot1.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(slot1.activityId, slot1.id) <= 0) then
		if slot2 then
			return false
		end

		return true
	end

	return slot0.id < slot1.id
end

slot0.instance = slot0.New()

return slot0
