module("modules.logic.room.model.common.RoomStoreItemListModel", package.seeall)

slot0 = class("RoomStoreItemListModel", ListScrollModel)

function slot0.setStoreGoodsMO(slot0, slot1)
	slot0.storeGoodsMO = slot1
	slot2 = slot1.config
	slot3, slot4 = slot1:getAllCostInfo()
	slot5 = {
		slot3,
		slot4
	}
	slot0._costsId = 1
	slot6 = GameUtil.splitString2(slot2.product, true)
	slot8 = {}
	slot9 = {}

	for slot13, slot14 in ipairs(string.splitToNumber(slot2.reduction, "#")) do
		slot15 = StoreConfig.instance:getGoodsConfig(slot14)
		slot18 = GameUtil.splitString2(slot15.product, true)[1]
		slot9[slot19] = slot9[slot18[1]] or {}
		slot9[slot19][slot18[2]] = {
			GameUtil.splitString2(slot15.cost, true)[1][3],
			GameUtil.splitString2(slot15.cost2, true)[1][3]
		}
	end

	for slot13 = 1, #slot6 do
		slot14 = slot6[slot13]
		slot16 = {}
		slot20 = slot14[2]
		slot21 = slot14[1]

		RoomStoreItemMO.New():init(slot20, slot21, slot14[3], slot0._costId, slot1)

		for slot20, slot21 in ipairs(slot5) do
			if slot21 then
				slot23 = slot21[1][3]

				if slot9[slot14[1]] and slot9[slot14[1]][slot14[2]] then
					slot23 = slot9[slot14[1]][slot14[2]][slot20]
				end

				slot15:addCost(slot20, slot22[2], slot22[1], slot23)
			end
		end

		table.insert(slot8, slot15)
	end

	slot0:setList(slot8)
	slot0:onModelUpdate()
end

function slot0.getCostId(slot0)
	return slot0._costsId or 1
end

function slot0.setCostId(slot0, slot1)
	if slot1 == 1 or slot1 == 2 then
		slot0._costsId = slot1

		slot0:onModelUpdate()
	end
end

function slot0.getTotalPriceByCostId(slot0, slot1)
	slot2 = slot0:getList()

	for slot7 = 1, #slot2 do
		slot3 = 0 + slot2[slot7]:getTotalPriceByCostId(slot1 or slot0._costsId)
	end

	return slot3
end

function slot0.getRoomStoreItemMOHasTheme(slot0)
	for slot5 = 1, #slot0:getList() do
		if slot1[slot5].themeId then
			return slot6
		end
	end

	return nil
end

function slot0.setIsSelectCurrency(slot0, slot1)
	slot0.isSelectCurrency = slot1
end

function slot0.getIsSelectCurrency(slot0)
	return slot0.isSelectCurrency
end

slot0.instance = slot0.New()

return slot0
