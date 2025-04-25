module("modules.logic.versionactivity1_6.act147.model.FurnaceTreasureModel", package.seeall)

slot0 = class("FurnaceTreasureModel", BaseModel)

function slot0.onInit(slot0)
	slot0:resetData()
end

function slot0.reInit(slot0)
	slot0:resetData()
end

function slot0._checkServerData(slot0, slot1)
	slot2 = false

	if slot1 then
		slot2 = slot0:_checkActId(slot1.activityId)
	end

	return slot2
end

function slot0._checkActId(slot0, slot1)
	slot2 = false

	if slot1 then
		slot2 = slot1 == slot0:getActId()
	end

	return slot2
end

function slot0.getActId(slot0)
	return ActivityModel.instance:getOnlineActIdByType(ActivityEnum.ActivityTypeID.Act147) and slot1[1]
end

function slot0.isActivityOpen(slot0)
	return ActivityModel.instance:isActOnLine(slot0:getActId())
end

function slot0._checkGoodsData(slot0, slot1, slot2)
	if not slot1 or not slot2 and not slot0:isActivityOpen() then
		return false
	end

	if slot0._store2GoodsData[slot1] and slot0._store2GoodsData[slot1][slot2] then
		slot3 = true
	else
		logError(string.format("FurnaceTreasureModel:_checkGoodsData error,data is nil, storeId:%s, goodsId:%s", slot1, slot2))
	end

	return slot3
end

function slot0.getGoodsPoolId(slot0, slot1, slot2)
	if not slot0:_checkGoodsData(slot1, slot2) then
		return 0
	end

	return slot0._store2GoodsData[slot1][slot2].poolId
end

function slot0.getGoodsRemainCount(slot0, slot1, slot2)
	if not slot0:_checkGoodsData(slot1, slot2) then
		return 0
	end

	return slot0._store2GoodsData[slot1][slot2].remainCount
end

function slot0.getGoodsListByStoreId(slot0, slot1)
	slot2 = {}

	if slot1 and slot0:isActivityOpen() and slot0._store2GoodsData[slot1] then
		for slot7, slot8 in pairs(slot0._store2GoodsData[slot1]) do
			slot2[#slot2 + 1] = slot7
		end
	end

	return slot2
end

function slot0.getCostItem(slot0, slot1)
	if not FurnaceTreasureEnum.StoreId2CostItem[slot1] then
		logError(string.format("FurnaceTreasureModel:getCostItem error, no store cost item, storeId:%s", slot1))
	end

	return slot2
end

function slot0.getTotalRemainCount(slot0)
	return slot0._totalRemainCount
end

function slot0.getSpinePlayData(slot0, slot1)
	if slot1 and FurnaceTreasureEnum.Pool2SpinePlayData[slot1] then
		-- Nothing
	end

	return {
		motion = FurnaceTreasureEnum.BeginnerViewSpinePlayData,
		motion = FurnaceTreasureEnum.Pool2SpinePlayData[slot1]
	}
end

function slot0.setServerData(slot0, slot1, slot2)
	if not slot0:_checkServerData(slot1) then
		return
	end

	if slot2 then
		slot0:resetData()
	end

	if slot1.act147Goods then
		for slot7, slot8 in ipairs(slot1.act147Goods) do
			slot0:setGoodsData(slot8)
		end
	end

	slot0:setTotalRemainCount(slot1.totalRemainCount)
	FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
end

function slot0.setGoodsData(slot0, slot1)
	slot3 = slot1.id
	slot4 = slot1.remainCount
	slot5 = slot1.poolId

	if not slot0._store2GoodsData[slot1.belongStoreId] then
		slot0._store2GoodsData[slot2] = {}
	end

	if not slot6[slot3] then
		slot6[slot3] = {
			poolId = slot5
		}
	end

	slot0:setGoodsRemainCount(slot2, slot3, slot4)
end

function slot0.updateGoodsData(slot0, slot1)
	if not slot0:_checkActId(slot1.activityId) then
		return
	end

	slot0:setGoodsRemainCount(slot1.storeId, slot1.goodsId, slot1.remainCount)
	FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
end

function slot0.setGoodsRemainCount(slot0, slot1, slot2, slot3)
	if not (slot0._store2GoodsData[slot1] and slot4[slot2] or nil) then
		return
	end

	slot5.remainCount = slot3
end

function slot0.setTotalRemainCount(slot0, slot1)
	slot0._totalRemainCount = slot1 or 0
end

function slot0.decreaseTotalRemainCount(slot0, slot1)
	if slot0:_checkActId(slot1) then
		slot0:setTotalRemainCount(slot0:getTotalRemainCount(slot0:getActId()) - 1)
		FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
	end
end

function slot0.resetData(slot0, slot1)
	slot0._store2GoodsData = {}

	slot0:setTotalRemainCount()

	if slot1 then
		FurnaceTreasureController.instance:dispatchEvent(FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate)
	end
end

slot0.instance = slot0.New()

return slot0
