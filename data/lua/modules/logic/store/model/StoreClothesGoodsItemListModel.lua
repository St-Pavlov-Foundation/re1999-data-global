module("modules.logic.store.model.StoreClothesGoodsItemListModel", package.seeall)

slot0 = class("StoreClothesGoodsItemListModel", StoreNormalGoodsItemListModel)

function slot0.setMOList(slot0, slot1)
	slot0._moList = {}

	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			table.insert(slot0._moList, slot6)
		end

		if #slot0._moList > 1 then
			table.sort(slot0._moList, StoreNormalGoodsItemListModel._sortFunction)
		end

		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, false)
	else
		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, true)
	end

	if next(slot0._moList) then
		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, false)
	else
		StoreController.instance:dispatchEvent(StoreEvent.CheckSkinViewEmpty, true)
	end

	slot0:setList(slot0._moList)
end

slot0.instance = slot0.New()

return slot0
