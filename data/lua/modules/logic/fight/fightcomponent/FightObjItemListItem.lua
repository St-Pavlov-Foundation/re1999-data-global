module("modules.logic.fight.fightcomponent.FightObjItemListItem", package.seeall)

slot0 = class("FightObjItemListItem", FightBaseClass)

function slot0.onInitialization(slot0, slot1, slot2, slot3, slot4)
	slot0.AUTO_SET_SIBLING = true
	slot0.SIBLING_OFFSET = 0
	slot0._modelGameObject = slot1
	slot0._class = slot2
	slot0._parentObject = slot3 or slot0._modelGameObject.transform.parent.gameObject
	slot0.funcNameAfterRefreshData = slot4
	slot0._standbyList = {}

	gohelper.setActive(slot0._modelGameObject, false)
end

function slot0.lockAutoSetSibling(slot0)
	slot0.AUTO_SET_SIBLING = false
end

function slot0.invokeRefreshFunc(slot0, slot1, slot2)
	if slot0.funcNameAfterRefreshData then
		gohelper.setActive(slot1.keyword_gameObject, true)
		xpcall(slot1[slot0.funcNameAfterRefreshData], __G__TRACKBACK__, slot1, slot2)
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

function slot0.releaseAsync(slot0, slot1)
	slot1:com_lockMsg()
	slot1:com_releaseAllTimer()
	slot1:com_releaseAllFlow()
	slot1:com_releaseAllWork()
end

function slot0.reuseItem(slot0, slot1)
	slot1:com_unlockMsg()
end

function slot0.setDataList(slot0, slot1)
	for slot5 = 1, #slot1 do
		if not slot0[slot5] then
			slot0:insertIndex(slot5, slot1[slot5])
		else
			slot0:releaseAsync(slot7)
			slot0:reuseItem(slot7)
			slot0:invokeRefreshFunc(slot7, slot6)
		end
	end

	for slot5 = #slot1 + 1, #slot0 do
		slot0:removeIndex(slot5)
	end
end

function slot0.insertIndex(slot0, slot1, slot2)
	slot3 = slot0:getItem()

	table.insert(slot0, slot1, slot3)
	slot0:invokeRefreshFunc(slot3, slot2)

	if slot0.AUTO_SET_SIBLING then
		gohelper.setSibling(slot0.keyword_gameObject, slot1 - 1 + slot0.SIBLING_OFFSET)
	end

	return slot3
end

function slot0.getItem(slot0)
	if not table.remove(slot0._standbyList, #slot0._standbyList) then
		slot1 = slot0:newItem()
	else
		slot0:releaseAsync(slot1)
		slot0:reuseItem(slot1)
	end

	return slot1
end

function slot0.removeIndex(slot0, slot1)
	if slot0[slot1] then
		table.insert(slot0._standbyList, table.remove(slot0, slot1))
	else
		table.insert(slot0._standbyList, slot0:newItem())
	end

	slot0:releaseAsync(slot2)
	gohelper.setActive(slot2.keyword_gameObject, false)

	return slot2
end

function slot0.removeIndexDelayRecycle(slot0, slot1, slot2)
	slot3 = (not slot0[slot1] or table.remove(slot0, slot1)) and slot0:newItem()

	slot0:releaseAsync(slot3)
	slot0:com_registTimer(slot0._delayRecycleItem, slot2, slot3)

	return slot3
end

function slot0._delayRecycleItem(slot0, slot1)
	gohelper.setActive(slot1.keyword_gameObject, false)
	table.insert(slot0._standbyList, slot1)
end

function slot0.newItem(slot0)
	slot1 = slot0:createItem()
	slot1.getItemIndex = uv0.getItemIndex
	slot1.getItemParent = uv0.getItemParent

	return slot1
end

function slot0.getItemIndex(slot0)
	return slot0.PARENTROOTCLASS:getIndex(slot0)
end

function slot0.getItemParent(slot0)
	return slot0.PARENTROOTCLASS.PARENTROOTCLASS.PARENTROOTCLASS
end

function slot0.createItem(slot0)
	slot1 = gohelper.clone(slot0._modelGameObject, slot0._parentObject)
	slot2 = slot0:registClass(slot0._class, slot1)
	slot2.keyword_gameObject = slot1
	slot2.ITEM_LIST_MGR = slot0

	return slot2
end

function slot0.onDestructor(slot0)
end

return slot0
