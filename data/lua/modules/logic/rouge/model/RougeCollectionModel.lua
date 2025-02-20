module("modules.logic.rouge.model.RougeCollectionModel", package.seeall)

slot0 = class("RougeCollectionModel", BaseModel)

function slot0.ctor(slot0)
	slot0:init()
end

function slot0.init(slot0)
	slot0._slotCellStateMap = {}
	slot0._collectionPlaceMap = {}
	slot0._collectionIdMap = {}
	slot0._collectionRareMap = {}
	slot0._enchants = {}
	slot0._curSlotAreaSize = nil
	slot0._slotCollections = BaseModel.New()
	slot0._bagCollections = BaseModel.New()
	slot0._allCollections = BaseModel.New()
	slot0._effectTriggerTab = {}
	slot0._tempCollectionAttrMap = nil
end

function slot0.getAllCollections(slot0)
	return slot0._allCollections:getList()
end

function slot0.getAllCollectionCount(slot0)
	return slot0._allCollections:getCount()
end

function slot0.onReceiveNewInfo2Slot(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	for slot7, slot8 in ipairs(slot1) do
		slot9 = RougeCollectionHelper.buildNewCollectionSlotMO(slot8)

		table.insert({}, slot9.id)
		slot0:tryAddCollection2SlotArea(slot9)
	end

	if RougeCollectionHelper.isNewGetCollection(slot2) then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.GetNewCollections, slot3, slot2, RougeEnum.CollectionPlaceArea.SlotArea)
	end
end

function slot0.tryAddCollection2SlotArea(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0._slotCollections:getById(slot1.id) then
		slot0:tryRemoveSlotCollection(slot2)
	end

	slot0._slotCollections:addAtLast(slot1)
	slot0._allCollections:addAtLast(slot1)
	slot0:markCollection2IdMap(slot1)
	slot0:markCollection2RareMap(slot1)
	slot0:markCollectionSlotArea(slot1)
	slot0:tryMarkCollection2EnchantList(slot1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.PlaceCollection2SlotArea, slot1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionAttr, slot2)
end

function slot0.tryMarkCollection2EnchantList(slot0, slot1)
	if not slot1 then
		return
	end

	if not RougeCollectionConfig.instance:getCollectionCfg(slot1.cfgId) then
		return
	end

	if slot3.type == RougeEnum.CollectionType.Enchant then
		table.insert(slot0._enchants, slot1)
	end
end

function slot0.tryRemoveCollectionEnchantList(slot0, slot1)
	if not slot0._enchants then
		return
	end

	for slot5 = #slot0._enchants, 1, -1 do
		if slot0._enchants[slot5] and slot0._enchants[slot5].id == slot1 then
			slot0._enchants[slot5] = nil

			return
		end
	end
end

function slot0.markCollection2IdMap(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._collectionIdMap[slot1.cfgId] then
		slot0._collectionIdMap[slot2] = {}
	end

	table.insert(slot0._collectionIdMap[slot2], slot1)
end

function slot0.removeCollectionIdMap(slot0, slot1, slot2)
	if not slot0._collectionIdMap[slot2] then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		if slot8.id == slot1 then
			table.remove(slot3, slot7)

			return
		end
	end
end

function slot0.markCollection2RareMap(slot0, slot1)
	if not slot1 then
		return
	end

	if not slot0._collectionRareMap[RougeCollectionConfig.instance:getCollectionCfg(slot1.cfgId) and slot3.showRare or 0] then
		slot0._collectionRareMap[slot4] = {}
	end

	slot0._collectionRareMap[slot4][slot1.id] = slot1
end

function slot0.removeCollectionRareMap(slot0, slot1, slot2)
	if not slot0._collectionRareMap[RougeCollectionConfig.instance:getCollectionCfg(slot2) and slot3.showRare or 0] then
		return
	end

	slot0._collectionRareMap[slot4][slot1] = nil
end

function slot0.getCollectionRareMap(slot0)
	return slot0._collectionRareMap
end

function slot0.markCollectionSlotArea(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot1:getLeftTopPos()
	slot4 = slot1.id

	if RougeCollectionConfig.instance:getShapeMatrix(slot1.cfgId, slot1:getRotation()) then
		for slot9, slot10 in ipairs(slot5) do
			for slot14, slot15 in ipairs(slot10) do
				if slot15 and slot15 > 0 then
					slot0:markCollectionSlotCellState(slot4, slot2.x + slot14 - 1, slot2.y + slot9 - 1, true)
				end
			end
		end
	end
end

function slot0.markCollectionSlotCellState(slot0, slot1, slot2, slot3, slot4)
	slot0._slotCellStateMap = slot0._slotCellStateMap or {}
	slot0._slotCellStateMap[slot2] = slot0._slotCellStateMap[slot2] or {}

	if slot0._slotCellStateMap[slot2][slot3] and slot5 > 0 and slot5 ~= slot1 then
		return
	end

	slot0._slotCellStateMap[slot2][slot3] = slot4 and slot1 or 0
	slot0._collectionPlaceMap[slot1] = slot0._collectionPlaceMap[slot1] or {}
	slot0._collectionPlaceMap[slot1][slot2] = slot0._collectionPlaceMap[slot1][slot2] or {}
	slot0._collectionPlaceMap[slot1][slot2][slot3] = slot4
end

function slot0.tryRemoveSlotCollection(slot0, slot1)
	if not slot0._slotCollections:getById(slot1) then
		return
	end

	slot0._slotCollections:remove(slot2)
	slot0._allCollections:remove(slot2)
	slot0:removeCollectionIdMap(slot2.id, slot2.cfgId)
	slot0:removeCollectionRareMap(slot2.id, slot2.cfgId)
	slot0:tryRemoveCollectionEnchantList(slot2.id)
	slot0:releasePlaceCellState(slot1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.DeleteSlotCollection, slot1)
end

function slot0.onReceiveNewInfo2Bag(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	for slot7, slot8 in ipairs(slot1) do
		slot9 = RougeCollectionHelper.buildNewBagCollectionMO(slot8)

		table.insert({}, slot9.id)
		slot0:tryAddCollection2BagArea(slot9)
	end

	if RougeCollectionHelper.isNewGetCollection(slot2) then
		RougeCollectionChessController.instance:dispatchEvent(RougeEvent.GetNewCollections, slot3, slot2, RougeEnum.CollectionPlaceArea.BagArea)
	end
end

function slot0.tryAddCollection2BagArea(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot1.id

	slot0:tryRemoveBagCollection(slot2)
	slot0._bagCollections:addAtLast(slot1)
	slot0._allCollections:addAtLast(slot1)
	slot0:markCollection2IdMap(slot1)
	slot0:markCollection2RareMap(slot1)
	slot0:tryMarkCollection2EnchantList(slot1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionBag)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionAttr, slot2)
end

function slot0.tryRemoveBagCollection(slot0, slot1)
	if not slot0._allCollections:getById(slot1) then
		return
	end

	if slot0:isCollectionPlaceInSlotArea(slot1) then
		slot0:tryRemoveSlotCollection(slot1)
	else
		slot0._bagCollections:remove(slot2)
	end

	slot0._allCollections:remove(slot2)
	slot0:tryRemoveCollectionEnchantList(slot2.id)
	slot0:removeCollectionIdMap(slot2.id, slot2.cfgId)
	slot0:removeCollectionRareMap(slot2.id, slot2.cfgId)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionBag)
end

function slot0.isSlotHasFilled(slot0, slot1, slot2)
	return slot0:getSlotFilledCollectionId(slot1, slot2) and slot3 > 0
end

function slot0.getSlotFilledCollectionId(slot0, slot1, slot2)
	slot4 = 0

	if slot0._slotCellStateMap and slot0._slotCellStateMap[slot1] and slot3[slot2] then
		slot4 = slot3[slot2] or 0
	end

	return slot4 or 0
end

function slot0.getCollectionByUid(slot0, slot1)
	return slot0._allCollections:getById(slot1)
end

function slot0.getEnchants(slot0)
	return slot0._enchants
end

function slot0.getSlotAreaCollection(slot0)
	return slot0._slotCollections:getList()
end

function slot0.getBagAreaCollection(slot0)
	return slot0._bagCollections:getList()
end

function slot0.getBagAreaCollectionCount(slot0)
	if slot0._bagCollections then
		return slot0._bagCollections:getCount()
	end

	return 0
end

function slot0.getSlotAreaCollectionCount(slot0)
	if slot0._slotCollections then
		return slot0._slotCollections:getCount()
	end

	return 0
end

function slot0.releasePlaceCellState(slot0, slot1)
	if slot0._collectionPlaceMap[slot1] then
		for slot5, slot6 in pairs(slot0._collectionPlaceMap[slot1]) do
			for slot10, slot11 in pairs(slot6) do
				slot0:markCollectionSlotCellState(slot1, slot5, slot10, false)
			end
		end
	end
end

function slot0.getCollectionCountById(slot0, slot1)
	slot2 = slot0._collectionIdMap and slot0._collectionIdMap[slot1]

	return slot2 and tabletool.len(slot2) or 0
end

function slot0.getCollectionByCfgId(slot0, slot1)
	return slot0._collectionIdMap and slot0._collectionIdMap[slot1]
end

function slot0.rougeInlay(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot0:getCollectionByUid(tonumber(slot1.id)):updateInfo(slot1)

	if tonumber(slot2.id) > 0 then
		slot0:getCollectionByUid(slot6):updateInfo(slot2)
	end

	RougeCollectionEnchantController.instance:onRougeInlayInfoUpdate(slot4, slot6)
end

function slot0.rougeDemount(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot3 = tonumber(slot1.id)

	slot0:getCollectionByUid(slot3):updateInfo(slot1)
	RougeCollectionEnchantController.instance:onRougeInlayInfoUpdate(slot3)
end

function slot0.deleteSomeCollectionFromWarehouse(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:tryRemoveBagCollection(tonumber(slot6))
	end
end

function slot0.deleteSomeCollectionFromSlot(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:tryRemoveSlotCollection(tonumber(slot6))
	end
end

function slot0.isCollectionExist(slot0, slot1)
	return slot0._allCollections:getById(slot1) ~= nil
end

function slot0.isCollectionPlaceInBag(slot0, slot1)
	return slot0._bagCollections:getById(slot1) ~= nil
end

function slot0.isCollectionPlaceInSlotArea(slot0, slot1)
	return slot0._slotCollections:getById(slot1) ~= nil
end

function slot0.getCollectionPlaceArea(slot0, slot1)
	if slot0:isCollectionPlaceInBag(slot1) then
		return RougeEnum.CollectionPlaceArea.BagArea
	end

	if slot0:isCollectionPlaceInSlotArea(slot1) then
		return RougeEnum.CollectionPlaceArea.SlotArea
	end
end

function slot0.oneKeyPlace2SlotArea(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:onReceiveNewInfo2Slot(slot1)
	RougeCollectionChessController.instance:dispatchEvent(RougeEvent.UpdateCollectionBag)
end

function slot0.onKeyClearSlotArea(slot0)
	if not slot0._slotCollections then
		return
	end

	for slot5 = #slot0._slotCollections:getList(), 1, -1 do
		slot0:tryRemoveSlotCollection(slot1[slot5].id)
	end

	slot0._slotCollections:clear()
end

function slot0.getCurSlotAreaSize(slot0)
	if not slot0._curSlotAreaSize then
		slot0._curSlotAreaSize = {
			col = RougeCollectionConfig.instance:getCollectionInitialBagSize(RougeController.instance:getStyleConfig() and slot1.layoutId) and slot3.col,
			row = slot3 and slot3.row
		}
	end

	return slot0._curSlotAreaSize
end

function slot0.getCollectionActiveEffects(slot0, slot1)
	if slot0:getCollectionByUid(slot1) and slot0:isCollectionPlaceInSlotArea(slot1) then
		return slot2:getBaseEffects()
	end
end

function slot0.getCollectionActiveEffectMap(slot0, slot1)
	if slot0:getCollectionActiveEffects(slot1) then
		for slot7, slot8 in ipairs(slot2) do
			-- Nothing
		end

		return {
			[slot8] = true
		}
	end
end

function slot0.checkIsCanCompositeCollection(slot0, slot1)
	if not RougeCollectionConfig.instance:getCollectionCompositeIds(slot1) or #slot2 <= 0 then
		return false
	end

	slot3 = {}

	for slot7, slot8 in ipairs(slot2) do
		if slot0:getCollectionCountById(slot8) < (slot3[slot8] or 0) + RougeEnum.CompositeCollectionCostCount then
			return false
		end

		slot3[slot8] = slot10 + RougeEnum.CompositeCollectionCostCount
	end

	return true
end

function slot0.saveTmpCollectionTriggerEffectInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._effectTriggerMap = slot0._effectTriggerMap or {}

	if slot0._effectTriggerMap[slot1.id] then
		for slot9 = #slot0._effectTriggerTab, 1, -1 do
			if slot0._effectTriggerTab[slot9].id == slot1.id then
				slot0._effectTriggerTab[slot9] = nil
				slot0._effectTriggerMap[slot1.id] = nil
			end
		end
	end

	slot6 = {
		trigger = slot1,
		removeCollections = slot2,
		add2SlotCollectionIds = slot3,
		add2BagCollectionIds = slot4,
		showType = slot5,
		removeCollectionMap = {}
	}

	if slot2 then
		for slot10, slot11 in ipairs(slot2) do
			slot6.removeCollectionMap[slot11.id] = slot11
		end
	end

	slot0._effectTriggerMap[slot1.id] = true
	slot0._effectTriggerTab = slot0._effectTriggerTab or {}

	table.insert(slot0._effectTriggerTab, slot6)
end

function slot0.getTmpCollectionTriggerEffectInfo(slot0)
	return slot0._effectTriggerTab
end

function slot0.clearTmpCollectionTriggerEffectInfo(slot0)
	if slot0._effectTriggerTab then
		tabletool.clear(slot0._effectTriggerTab)
	end
end

function slot0.checkHasTmpTriggerEffectInfo(slot0)
	return slot0._effectTriggerTab and #slot0._effectTriggerTab > 0
end

function slot0.updateCollectionItems(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = tonumber(slot6.id)

		if slot0:isCollectionPlaceInSlotArea(slot7) then
			slot0:getCollectionByUid(slot7):updateInfo(slot6)
		else
			slot0:tryAddCollection2BagArea(RougeCollectionHelper.buildNewBagCollectionMO(slot6))
		end
	end
end

function slot0.switchCollectionInfoType(slot0)
	slot0._curInfoType = slot0:getCurCollectionInfoType() == RougeEnum.CollectionInfoType.Complex and RougeEnum.CollectionInfoType.Simple or RougeEnum.CollectionInfoType.Complex

	RougeController.instance:dispatchEvent(RougeEvent.SwitchCollectionInfoType)
	slot0:_saveCollectionInfoType(slot0._curInfoType)
end

function slot0.getCurCollectionInfoType(slot0)
	if not slot0._curInfoType then
		slot0._curInfoType = tonumber(PlayerPrefsHelper.getNumber(slot0:_getCollectionInfoTypeSaveKey(), RougeEnum.DefaultCollectionInfoType))
	end

	return slot0._curInfoType
end

function slot0._saveCollectionInfoType(slot0, slot1)
	PlayerPrefsHelper.setNumber(slot0:_getCollectionInfoTypeSaveKey(), slot1 or RougeEnum.DefaultCollectionInfoType)
end

function slot0._getCollectionInfoTypeSaveKey(slot0)
	return string.format("%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RougeCollectionInfoType)
end

slot0.instance = slot0.New()

return slot0
