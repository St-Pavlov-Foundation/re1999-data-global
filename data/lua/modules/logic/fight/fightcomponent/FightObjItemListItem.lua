module("modules.logic.fight.fightcomponent.FightObjItemListItem", package.seeall)

local var_0_0 = class("FightObjItemListItem", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.autoSetSibling = false
	arg_1_0.siblingOffset = 0
	arg_1_0.recycle = false
	arg_1_0.dataList = {}
	arg_1_0._modelGameObject = arg_1_1
	arg_1_0._class = arg_1_2
	arg_1_0._parentObject = arg_1_3 or arg_1_0._modelGameObject.transform.parent.gameObject
	arg_1_0._standbyList = {}
	arg_1_0._gameObjectStandbyList = {}

	gohelper.setActive(arg_1_0._modelGameObject, false)
end

function var_0_0.setFuncNames(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.funcNameOfRefreshItemData = arg_2_1
	arg_2_0.funcNameOfItemRemoved = arg_2_2
	arg_2_0.funcNameOfItemReused = arg_2_3
end

function var_0_0.setFuncNameOfRefreshItemData(arg_3_0, arg_3_1)
	arg_3_0.funcNameOfRefreshItemData = arg_3_1
end

function var_0_0.setFuncNameOfItemRemoved(arg_4_0, arg_4_1)
	arg_4_0.funcNameOfItemRemoved = arg_4_1
end

function var_0_0.setFuncNameOfItemReused(arg_5_0, arg_5_1)
	arg_5_0.funcNameOfItemReused = arg_5_1
end

function var_0_0.invokeRefreshFunc(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1.keyword_itemData = arg_6_2

	if arg_6_0.funcNameOfRefreshItemData then
		gohelper.setActive(arg_6_1.keyword_gameObject, true)
		xpcall(arg_6_1[arg_6_0.funcNameOfRefreshItemData], __G__TRACKBACK__, arg_6_1, arg_6_2)
	end
end

function var_0_0.onRemoveItem(arg_7_0, arg_7_1)
	if arg_7_0.funcNameOfItemRemoved then
		xpcall(arg_7_1[arg_7_0.funcNameOfItemRemoved], __G__TRACKBACK__, arg_7_1)
	end
end

function var_0_0.onReuseItem(arg_8_0, arg_8_1)
	if arg_8_0.funcNameOfItemReused then
		xpcall(arg_8_1[arg_8_0.funcNameOfItemReused], __G__TRACKBACK__, arg_8_1)
	end
end

function var_0_0.refreshSibling(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0) do
		gohelper.setSibling(iter_9_1.keyword_gameObject, iter_9_0 - 1 + arg_9_0.siblingOffset)
	end
end

function var_0_0.swap(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0[arg_10_1]
	local var_10_1 = arg_10_0[arg_10_2]

	arg_10_0[arg_10_1] = var_10_1
	arg_10_0[arg_10_2] = var_10_0

	local var_10_2 = arg_10_0.dataList[arg_10_1]
	local var_10_3 = arg_10_0.dataList[arg_10_2]

	arg_10_0.dataList[arg_10_1] = var_10_3
	arg_10_0.dataList[arg_10_2] = var_10_2

	if arg_10_0.autoSetSibling then
		gohelper.setSibling(var_10_0.keyword_gameObject, arg_10_2 - 1 + arg_10_0.siblingOffset)
		gohelper.setSibling(var_10_1.keyword_gameObject, arg_10_1 - 1 + arg_10_0.siblingOffset)
	end
end

function var_0_0.getIndex(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		if iter_11_1 == arg_11_1 then
			return iter_11_0
		end
	end

	logError("获取下标失败")

	return 0
end

function var_0_0.setDataList(arg_12_0, arg_12_1)
	tabletool.clear(arg_12_0.dataList)
	tabletool.addValues(arg_12_0.dataList, arg_12_1)

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.dataList) do
		local var_12_0 = arg_12_0[iter_12_0]

		if not var_12_0 then
			arg_12_0:addItemAtIndex(iter_12_0, iter_12_1)
		else
			arg_12_0:onReuseItem(var_12_0)
			arg_12_0:invokeRefreshFunc(var_12_0, iter_12_1)
		end
	end

	for iter_12_2 = #arg_12_0, #arg_12_0.dataList + 1, -1 do
		arg_12_0:removeIndex(iter_12_2)
	end

	if arg_12_0.autoSetSibling then
		arg_12_0:refreshSibling()
	end
end

function var_0_0.addIndex(arg_13_0, arg_13_1, arg_13_2)
	table.insert(arg_13_0.dataList, arg_13_1, arg_13_2)

	return (arg_13_0:addItemAtIndex(arg_13_1, arg_13_2))
end

function var_0_0.addItemAtIndex(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_0:getItem()

	table.insert(arg_14_0, arg_14_1, var_14_0)
	arg_14_0:invokeRefreshFunc(var_14_0, arg_14_2)

	if arg_14_0.autoSetSibling then
		gohelper.setSibling(arg_14_0.keyword_gameObject, arg_14_1 - 1 + arg_14_0.siblingOffset)
	end

	return var_14_0
end

function var_0_0.addHead(arg_15_0, arg_15_1)
	return arg_15_0:addIndex(1, arg_15_1)
end

function var_0_0.addLast(arg_16_0, arg_16_1)
	return arg_16_0:addIndex(#arg_16_0 + 1, arg_16_1)
end

function var_0_0.getItem(arg_17_0)
	local var_17_0 = table.remove(arg_17_0._standbyList, #arg_17_0._standbyList)

	if not var_17_0 then
		var_17_0 = arg_17_0:newItem()
	else
		arg_17_0:onReuseItem(var_17_0)
	end

	return var_17_0
end

function var_0_0.getHead(arg_18_0)
	return arg_18_0[1]
end

function var_0_0.getLast(arg_19_0)
	return arg_19_0[#arg_19_0]
end

function var_0_0.removeHead(arg_20_0)
	return arg_20_0:removeIndex(1)
end

function var_0_0.removeLast(arg_21_0)
	return arg_21_0:removeIndex(#arg_21_0)
end

function var_0_0.removeItem(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1:getItemIndex()

	return arg_22_0:removeIndex(var_22_0)
end

function var_0_0.removeIndex(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:_removeIndex(arg_23_1)

	arg_23_0:_recycleItem(var_23_0)

	return var_23_0
end

function var_0_0.removeIndexDelayRecycle(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:_removeIndex(arg_24_1)

	arg_24_0:com_registTimer(arg_24_0._recycleItem, arg_24_2, var_24_0)

	return var_24_0
end

function var_0_0._removeIndex(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0[arg_25_1]

	if var_25_0 then
		table.remove(arg_25_0.dataList, arg_25_1)

		var_25_0 = table.remove(arg_25_0, arg_25_1)

		arg_25_0:onRemoveItem(var_25_0)
	end

	return var_25_0
end

function var_0_0._recycleItem(arg_26_0, arg_26_1)
	if arg_26_0.recycle then
		local var_26_0 = arg_26_1.keyword_gameObject

		table.insert(arg_26_0._standbyList, arg_26_1)
		gohelper.setActive(var_26_0, false)

		if arg_26_0.autoSetSibling then
			gohelper.setSibling(var_26_0, #arg_26_0 + arg_26_0.siblingOffset)
		end
	else
		arg_26_1:disposeSelf()
	end
end

function var_0_0.newItem(arg_27_0)
	local var_27_0 = arg_27_0:createItem()

	var_27_0.getItemIndex = var_0_0.getItemIndex
	var_27_0.getItemParent = var_0_0.getItemParent
	var_27_0.getPreItem = var_0_0.getPreItem
	var_27_0.getNextItem = var_0_0.getNextItem
	var_27_0.getDataListCount = var_0_0.getDataListCount
	var_27_0.getItemListMgr = var_0_0.getItemListMgr

	return var_27_0
end

function var_0_0.getItemIndex(arg_28_0)
	return arg_28_0.PARENT_ROOT_CLASS:getIndex(arg_28_0)
end

function var_0_0.getDataListCount(arg_29_0)
	return #arg_29_0.PARENT_ROOT_CLASS.dataList
end

function var_0_0.getItemListMgr(arg_30_0)
	return arg_30_0.ITEM_LIST_MGR
end

function var_0_0.getPreItem(arg_31_0)
	local var_31_0 = arg_31_0:getItemIndex()

	return arg_31_0.ITEM_LIST_MGR[var_31_0 - 1]
end

function var_0_0.getNextItem(arg_32_0)
	local var_32_0 = arg_32_0:getItemIndex()

	return arg_32_0.ITEM_LIST_MGR[var_32_0 + 1]
end

function var_0_0.getItemParent(arg_33_0)
	return arg_33_0.PARENT_ROOT_CLASS.PARENT_ROOT_CLASS.PARENT_ROOT_CLASS
end

function var_0_0.createItem(arg_34_0)
	local var_34_0 = #arg_34_0._gameObjectStandbyList > 0 and table.remove(arg_34_0._gameObjectStandbyList) or gohelper.clone(arg_34_0._modelGameObject, arg_34_0._parentObject)
	local var_34_1 = arg_34_0:newClass(arg_34_0._class, var_34_0)

	var_34_1.keyword_gameObject = var_34_0
	var_34_1.ITEM_LIST_MGR = arg_34_0

	return var_34_1
end

function var_0_0.cloneGameObject2Standby(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_2 then
		arg_35_0:com_registRepeatTimer(arg_35_0.delaycloneGameObject2Standby, arg_35_2, arg_35_1)
	else
		for iter_35_0 = 1, arg_35_1 do
			local var_35_0 = gohelper.clone(arg_35_0._modelGameObject, arg_35_0._parentObject)

			table.insert(arg_35_0._gameObjectStandbyList, var_35_0)
		end
	end
end

function var_0_0.delaycloneGameObject2Standby(arg_36_0)
	local var_36_0 = gohelper.clone(arg_36_0._modelGameObject, arg_36_0._parentObject)

	table.insert(arg_36_0._gameObjectStandbyList, var_36_0)
end

function var_0_0.onDestructor(arg_37_0)
	return
end

return var_0_0
