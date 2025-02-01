module("modules.logic.room.model.common.RoomStoreOrderMO", package.seeall)

slot0 = pureTable("RoomStoreOrderMO")

function slot0.ctor(slot0)
	slot0._materialDateMOList = {}
	slot0._poolList = {}
end

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.goodsId = slot1
	slot0.themeId = slot2

	slot0:clear()
end

function slot0.addValue(slot0, slot1, slot2, slot3)
	if not slot0:getMaterialDateMO(slot1, slot2) then
		slot4 = slot0:_popMaterialDateMO() or MaterialDataMO.New()

		slot4:initValue(slot1, slot2, slot3)

		slot4.tempCount = 0

		table.insert(slot0._materialDateMOList, slot4)
	else
		slot4.quantity = slot4.quantity + slot3
	end
end

function slot0.getMaterialDateMO(slot0, slot1, slot2)
	for slot7 = 1, #slot0._materialDateMOList do
		if slot3[slot7].materilId == slot2 and slot8.materilType == slot1 then
			return slot8
		end
	end

	return nil
end

function slot0.isSameValue(slot0, slot1)
	slot0:_resetListTempCountValue()

	slot2 = true

	for slot6 = 1, #slot1 do
		slot7 = slot1[slot6]

		if slot0:getMaterialDateMO(slot7.materilType, slot7.materilId) then
			slot8.tempCount = slot8.tempCount + slot7.quantity
		else
			slot2 = false

			break
		end
	end

	if slot2 then
		for slot7 = 1, #slot0._materialDateMOList do
			slot8 = slot3[slot7]

			if slot8.quantity ~= slot8.tempCount then
				slot2 = false

				break
			end
		end
	end

	slot0:_resetListTempCountValue()

	return slot2
end

function slot0._resetListTempCountValue(slot0)
	for slot5 = 1, #slot0._materialDateMOList do
		slot1[slot5].tempCount = 0
	end
end

function slot0._popMaterialDateMO(slot0)
	if #slot0._poolList > 0 then
		slot2 = slot0._poolList[slot1]
		slot2.quantity = 0
		slot2.tempCount = 0

		table.remove(slot0._poolList, slot1)

		return slot2
	end
end

function slot0.clear(slot0)
	if #slot0._materialDateMOList > 0 then
		tabletool.addArray(slot0._poolList, slot0._materialDateMOList)

		slot0._materialDateMOList = {}
	end
end

return slot0
