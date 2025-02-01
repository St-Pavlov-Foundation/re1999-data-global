module("modules.logic.explore.model.ExploreBackpackModel", package.seeall)

slot0 = class("ExploreBackpackModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
	slot0.stackableDic = {}

	slot0:clear()
end

function slot0.refresh(slot0)
	slot0:clear()
	BackpackModel.instance:setBackpackItemList(BackpackModel.instance:getBackpackList())

	slot2 = {}

	for slot6, slot7 in pairs(BackpackModel.instance:getBackpackItemList()) do
		if slot7.subType == 15 then
			table.insert(slot2, slot7)
		end
	end

	slot0:setList(slot2)

	return slot2
end

function slot0.updateItems(slot0, slot1, slot2)
	if slot2 or not slot0.stackableDic then
		slot0:clear()

		slot0.stackableDic = {}
	end

	slot3 = false
	slot4 = slot0:getList()

	for slot8, slot9 in ipairs(slot1) do
		slot10 = slot0:getById(slot9.uid)

		if ExploreConfig.instance:isStackableItem(slot9.itemId) then
			slot10 = slot0.stackableDic[slot9.itemId]
		end

		if not slot10 then
			if slot9.quantity > 0 then
				slot12 = ExploreBackpackItemMO.New()

				slot12:init(slot9)

				slot12.quantity = slot9.quantity

				table.insert(slot4, slot12)

				slot0.stackableDic[slot12.itemId] = slot12
			end
		else
			if slot11 then
				slot10:updateStackable(slot9)
			else
				slot10.quantity = slot9.quantity
				slot10.status = slot9.status
			end

			if slot10.quantity == 0 then
				slot0:removeItem(slot10)
			end

			if slot10.itemEffect == ExploreEnum.ItemEffect.Active then
				slot3 = true
			end
		end

		ExploreSimpleModel.instance:setShowBag()
	end

	slot5 = ExploreController.instance:getMap()

	if slot3 and slot5 then
		slot5:checkAllRuneTrigger()
	end

	slot0:setList(slot4)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnItemChange, slot0._mo)
end

function slot0.getItemMoByEffect(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.itemEffect == slot1 then
			return slot7
		end
	end
end

function slot0.addItem(slot0, slot1, slot2, slot3)
	slot0:addAtLast({
		type = slot1,
		id = slot2,
		num = slot3
	})
	ExploreController.instance:dispatchEvent(ExploreEvent.OnItemChange, slot0._mo)
end

function slot0.removeItem(slot0, slot1)
	slot0.stackableDic[slot1.itemId] = nil

	slot0:remove(slot1)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnItemChange, slot0._mo)
end

function slot0.getItem(slot0, slot1)
	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.itemId == slot1 then
			return slot7
		end
	end
end

slot0.instance = slot0.New()

return slot0
