module("modules.logic.fight.fightcomponent.FightObjItemListItem", package.seeall)

slot0 = class("FightObjItemListItem", FightBaseClass)

function slot0.onConstructor(slot0, slot1, slot2, slot3)
	slot0.autoSetSibling = true
	slot0.siblingOffset = 0
	slot0.recycle = true
	slot0.dataList = {}
	slot0._modelGameObject = slot1
	slot0._class = slot2
	slot0._parentObject = slot3 or slot0._modelGameObject.transform.parent.gameObject
	slot0._standbyList = {}
	slot0._gameObjectStandbyList = {}

	gohelper.setActive(slot0._modelGameObject, false)
end

function slot0.setFuncNames(slot0, slot1, slot2, slot3)
	slot0.funcNameOfRefreshItemData = slot1
	slot0.funcNameOfItemRemoved = slot2
	slot0.funcNameOfItemReused = slot3
end

function slot0.setFuncNameOfRefreshItemData(slot0, slot1)
	slot0.funcNameOfRefreshItemData = slot1
end

function slot0.setFuncNameOfItemRemoved(slot0, slot1)
	slot0.funcNameOfItemRemoved = slot1
end

function slot0.setFuncNameOfItemReused(slot0, slot1)
	slot0.funcNameOfItemReused = slot1
end

function slot0.invokeRefreshFunc(slot0, slot1, slot2)
	slot1.keyword_itemData = slot2

	if slot0.funcNameOfRefreshItemData then
		gohelper.setActive(slot1.keyword_gameObject, true)
		xpcall(slot1[slot0.funcNameOfRefreshItemData], __G__TRACKBACK__, slot1, slot2)
	end
end

function slot0.onRemoveItem(slot0, slot1)
	if slot0.funcNameOfItemRemoved then
		xpcall(slot1[slot0.funcNameOfItemRemoved], __G__TRACKBACK__, slot1)
	end
end

function slot0.onReuseItem(slot0, slot1)
	if slot0.funcNameOfItemReused then
		xpcall(slot1[slot0.funcNameOfItemReused], __G__TRACKBACK__, slot1)
	end
end

function slot0.refreshSibling(slot0)
	for slot4, slot5 in ipairs(slot0) do
		gohelper.setSibling(slot5.keyword_gameObject, slot4 - 1 + slot0.siblingOffset)
	end
end

function slot0.swap(slot0, slot1, slot2)
	slot0[slot1] = slot0[slot2]
	slot0[slot2] = slot0[slot1]
	slot0.dataList[slot1] = slot0.dataList[slot2]
	slot0.dataList[slot2] = slot0.dataList[slot1]

	if slot0.autoSetSibling then
		gohelper.setSibling(slot3.keyword_gameObject, slot2 - 1 + slot0.siblingOffset)
		gohelper.setSibling(slot4.keyword_gameObject, slot1 - 1 + slot0.siblingOffset)
	end
end

function slot0.getIndex(slot0, slot1)
	for slot5, slot6 in ipairs(slot0) do
		if slot6 == slot1 then
			return slot5
		end
	end

	logError("获取下标失败")

	return 0
end

function slot0.setDataList(slot0, slot1)
	tabletool.clear(slot0.dataList)
	tabletool.addValues(slot0.dataList, slot1)

	for slot5, slot6 in ipairs(slot0.dataList) do
		if not slot0[slot5] then
			slot0:addItemAtIndex(slot5, slot6)
		else
			slot0:onReuseItem(slot7)
			slot0:invokeRefreshFunc(slot7, slot6)
		end
	end

	for slot5 = #slot0, #slot0.dataList + 1, -1 do
		slot0:removeIndex(slot5)
	end

	if slot0.autoSetSibling then
		slot0:refreshSibling()
	end
end

function slot0.addIndex(slot0, slot1, slot2)
	table.insert(slot0.dataList, slot1, slot2)

	return slot0:addItemAtIndex(slot1, slot2)
end

function slot0.addItemAtIndex(slot0, slot1, slot2)
	slot3 = slot0:getItem()

	table.insert(slot0, slot1, slot3)
	slot0:invokeRefreshFunc(slot3, slot2)

	if slot0.autoSetSibling then
		gohelper.setSibling(slot0.keyword_gameObject, slot1 - 1 + slot0.siblingOffset)
	end

	return slot3
end

function slot0.addHead(slot0, slot1)
	return slot0:addIndex(1, slot1)
end

function slot0.addLast(slot0, slot1)
	return slot0:addIndex(#slot0 + 1, slot1)
end

function slot0.getItem(slot0)
	if not table.remove(slot0._standbyList, #slot0._standbyList) then
		slot1 = slot0:newItem()
	else
		slot0:onReuseItem(slot1)
	end

	return slot1
end

function slot0.getHead(slot0)
	return slot0[1]
end

function slot0.getLast(slot0)
	return slot0[#slot0]
end

function slot0.removeHead(slot0)
	return slot0:removeIndex(1)
end

function slot0.removeLast(slot0)
	return slot0:removeIndex(#slot0)
end

function slot0.removeItem(slot0, slot1)
	return slot0:removeIndex(slot1:getItemIndex())
end

function slot0.removeIndex(slot0, slot1)
	slot2 = slot0:_removeIndex(slot1)

	slot0:_recycleItem(slot2)

	return slot2
end

function slot0.removeIndexDelayRecycle(slot0, slot1, slot2)
	slot3 = slot0:_removeIndex(slot1)

	slot0:com_registTimer(slot0._recycleItem, slot2, slot3)

	return slot3
end

function slot0._removeIndex(slot0, slot1)
	if slot0[slot1] then
		table.remove(slot0.dataList, slot1)
		slot0:onRemoveItem(table.remove(slot0, slot1))
	end

	return slot2
end

function slot0._recycleItem(slot0, slot1)
	if slot0.recycle then
		table.insert(slot0._standbyList, slot1)
		gohelper.setActive(slot1.keyword_gameObject, false)

		if slot0.autoSetSibling then
			gohelper.setSibling(slot2, #slot0 + slot0.siblingOffset)
		end
	else
		slot1:disposeSelf()
	end
end

function slot0.newItem(slot0)
	slot1 = slot0:createItem()
	slot1.getItemIndex = uv0.getItemIndex
	slot1.getItemParent = uv0.getItemParent
	slot1.getPreItem = uv0.getPreItem
	slot1.getNextItem = uv0.getNextItem
	slot1.getDataListCount = uv0.getDataListCount
	slot1.getItemListMgr = uv0.getItemListMgr

	return slot1
end

function slot0.getItemIndex(slot0)
	return slot0.PARENT_ROOT_CLASS:getIndex(slot0)
end

function slot0.getDataListCount(slot0)
	return #slot0.PARENT_ROOT_CLASS.dataList
end

function slot0.getItemListMgr(slot0)
	return slot0.ITEM_LIST_MGR
end

function slot0.getPreItem(slot0)
	return slot0.ITEM_LIST_MGR[slot0:getItemIndex() - 1]
end

function slot0.getNextItem(slot0)
	return slot0.ITEM_LIST_MGR[slot0:getItemIndex() + 1]
end

function slot0.getItemParent(slot0)
	return slot0.PARENT_ROOT_CLASS.PARENT_ROOT_CLASS.PARENT_ROOT_CLASS
end

function slot0.createItem(slot0)
	slot1 = #slot0._gameObjectStandbyList > 0 and table.remove(slot0._gameObjectStandbyList) or gohelper.clone(slot0._modelGameObject, slot0._parentObject)
	slot2 = slot0:newClass(slot0._class, slot1)
	slot2.keyword_gameObject = slot1
	slot2.ITEM_LIST_MGR = slot0

	return slot2
end

function slot0.cloneGameObject2Standby(slot0, slot1, slot2)
	if slot2 then
		slot0:com_registRepeatTimer(slot0.delaycloneGameObject2Standby, slot2, slot1)
	else
		for slot6 = 1, slot1 do
			table.insert(slot0._gameObjectStandbyList, gohelper.clone(slot0._modelGameObject, slot0._parentObject))
		end
	end
end

function slot0.delaycloneGameObject2Standby(slot0)
	table.insert(slot0._gameObjectStandbyList, gohelper.clone(slot0._modelGameObject, slot0._parentObject))
end

function slot0.onDestructor(slot0)
end

return slot0
