module("modules.logic.store.model.StorePackageGoodsItemListModel", package.seeall)

slot0 = class("StorePackageGoodsItemListModel", ListScrollModel)

function slot0.setMOList(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot5 = {
		[slot10.config.preGoodsId] = true
	}
	slot0._moList = {}

	for slot9, slot10 in pairs(slot2 or {}) do
		if slot10.config.preGoodsId then
			-- Nothing
		end

		if slot0:checkShow(slot10, true) then
			table.insert(slot4, slot10)
		end
	end

	if slot1 then
		for slot10, slot11 in pairs(slot1:getGoodsList()) do
			if slot11.config.preGoodsId then
				slot5[slot11.config.preGoodsId] = true
			end

			if slot0:checkShow(slot11) then
				slot12 = StorePackageGoodsMO.New()

				slot12:init(slot1.id, slot11.goodsId, slot11.buyCount, slot11.offlineTime)
				table.insert(slot4, slot12)
			end
		end
	end

	slot6 = {}

	if slot3 then
		for slot10, slot11 in ipairs(slot3) do
			slot6[slot11.goodsId] = true
		end
	end

	for slot10, slot11 in ipairs(slot4) do
		if not slot6[slot11.goodsId] and (slot5[slot11.goodsId] ~= true or (slot11.buyLevel > 0 and slot11:isSoldOut()) == false) then
			table.insert(slot0._moList, slot11)
		end
	end

	table.sort(slot0._moList, slot0._sortFunction)

	if #slot0._moList == 0 and StoreModel.instance:getCurBuyPackageId() == nil then
		StoreController.instance:dispatchEvent(StoreEvent.CurPackageListEmpty)
	end

	StoreController.instance:dispatchEvent(StoreEvent.BeforeUpdatePackageStore)
	slot0:setList(slot0._moList)
	StoreController.instance:dispatchEvent(StoreEvent.AfterUpdatePackageStore)
end

function slot0.checkShow(slot0, slot1, slot2)
	slot2 = slot2 or false
	slot3 = true

	if slot1:isSoldOut() then
		if slot2 and slot1.refreshTime == StoreEnum.ChargeRefreshTime.Forever then
			slot3 = false
		end

		if slot2 == false and slot1.config.refreshTime == StoreEnum.RefreshTime.Forever then
			slot3 = false
		end
	end

	if slot1.isChargeGoods == false then
		slot3 = slot3 and slot0:checkPreGoodsId(slot1.config.preGoodsId)
	end

	return slot3
end

function slot0.checkPreGoodsId(slot0, slot1)
	if slot1 == 0 then
		return true
	end

	return StoreModel.instance:getGoodsMO(slot1) and slot2:isSoldOut()
end

function slot0._sortFunction(slot0, slot1)
	slot2 = slot0.config
	slot3 = slot1.config

	if slot0:isSoldOut() ~= slot1:isSoldOut() then
		return slot5
	end

	if slot0.goodsId == StoreEnum.MonthCardGoodsId ~= (slot1.goodsId == StoreEnum.MonthCardGoodsId) and StoreModel.instance:IsMonthCardDaysEnough() then
		return slot7
	end

	if slot0:isLevelOpen() ~= slot1:isLevelOpen() then
		return slot8
	end

	if slot0:checkPreGoodsSoldOut() ~= slot1:checkPreGoodsSoldOut() then
		return slot10
	end

	if slot2.order ~= slot3.order then
		return slot2.order < slot3.order
	end

	return slot2.id < slot3.id
end

slot0.instance = slot0.New()

return slot0
