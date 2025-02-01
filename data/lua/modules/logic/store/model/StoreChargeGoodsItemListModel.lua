module("modules.logic.store.model.StoreChargeGoodsItemListModel", package.seeall)

slot0 = class("StoreChargeGoodsItemListModel", ListScrollModel)

function slot0.setMOList(slot0, slot1)
	slot0._moList = {}

	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			table.insert(slot0._moList, slot6)
		end

		if #slot0._moList > 1 then
			table.sort(slot0._moList, slot0._sortFunction)
		end
	end

	slot0:setList(slot0._moList)
end

function slot0._sortFunction(slot0, slot1)
	if StoreConfig.instance:getChargeGoodsConfig(slot0.id).order ~= StoreConfig.instance:getChargeGoodsConfig(slot1.id).order then
		return slot2.order < slot3.order
	end

	return slot2.id < slot3.id
end

slot0.instance = slot0.New()

return slot0
