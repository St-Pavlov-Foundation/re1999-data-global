module("modules.logic.fight.fightcomponent.FightObjItemListItem", package.seeall)

local var_0_0 = class("FightObjItemListItem", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.dataList = {}
	arg_1_0.modelGameObject = arg_1_1
	arg_1_0.objClass = arg_1_2
	arg_1_0.parentObject = arg_1_3 or arg_1_0.modelGameObject.transform.parent.gameObject

	gohelper.setActive(arg_1_0.modelGameObject, false)
end

function var_0_0.setDataList(arg_2_0, arg_2_1)
	for iter_2_0 = #arg_2_0.dataList, 1, -1 do
		arg_2_0:removeIndex(iter_2_0)
	end

	local var_2_0 = #arg_2_1

	for iter_2_1 = 1, var_2_0 do
		arg_2_0:addIndex(iter_2_1, arg_2_1[iter_2_1])
	end
end

function var_0_0.addIndex(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:newItem()

	table.insert(arg_3_0.dataList, arg_3_1, arg_3_2)
	table.insert(arg_3_0, arg_3_1, var_3_0)

	if var_3_0.onRefreshItemData then
		var_3_0:onRefreshItemData(arg_3_2)
	end

	return var_3_0
end

function var_0_0.removeIndex(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0[arg_4_1]

	if var_4_0 then
		table.remove(arg_4_0.dataList, arg_4_1)
		table.remove(arg_4_0, arg_4_1)
		var_4_0:disposeSelf()
	end
end

function var_0_0.getIndex(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0) do
		if iter_5_1 == arg_5_1 then
			return iter_5_0
		end
	end

	logError("获取下标失败")

	return 0
end

function var_0_0.addHead(arg_6_0, arg_6_1)
	return arg_6_0:addIndex(1, arg_6_1)
end

function var_0_0.addLast(arg_7_0, arg_7_1)
	return arg_7_0:addIndex(#arg_7_0 + 1, arg_7_1)
end

function var_0_0.getHead(arg_8_0)
	return arg_8_0[1]
end

function var_0_0.getLast(arg_9_0)
	return arg_9_0[#arg_9_0]
end

function var_0_0.removeHead(arg_10_0)
	return arg_10_0:removeIndex(1)
end

function var_0_0.removeLast(arg_11_0)
	return arg_11_0:removeIndex(#arg_11_0)
end

function var_0_0.removeItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getIndex(arg_12_1)

	if var_12_0 == 0 then
		logError("删除失败，未找到该item")

		return
	end

	return arg_12_0:removeIndex(var_12_0)
end

function var_0_0.swap(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0[arg_13_2], arg_13_0[arg_13_1] = arg_13_0[arg_13_1], arg_13_0[arg_13_2]

	local var_13_0 = arg_13_0.dataList[arg_13_1]
	local var_13_1 = arg_13_0.dataList[arg_13_2]

	arg_13_0.dataList[arg_13_1] = var_13_1
	arg_13_0.dataList[arg_13_2] = var_13_0
end

function var_0_0.newItem(arg_14_0)
	local var_14_0 = gohelper.clone(arg_14_0.modelGameObject, arg_14_0.parentObject)
	local var_14_1 = arg_14_0:newClass(arg_14_0.objClass, var_14_0)

	var_14_1.GAMEOBJECT = var_14_0
	var_14_1.ITEM_LIST_MGR = arg_14_0
	var_14_1.getSelfIndex = var_0_0.getSelfIndex
	var_14_1.getPreItem = var_0_0.getPreItem
	var_14_1.getNextItem = var_0_0.getNextItem
	var_14_1.removeSelf = var_0_0.removeSelf

	return var_14_1
end

function var_0_0.getSelfIndex(arg_15_0)
	return arg_15_0.PARENT_ROOT_OBJECT:getIndex(arg_15_0)
end

function var_0_0.getPreItem(arg_16_0)
	local var_16_0 = arg_16_0:getSelfIndex()

	return arg_16_0.ITEM_LIST_MGR[var_16_0 - 1]
end

function var_0_0.getNextItem(arg_17_0)
	local var_17_0 = arg_17_0:getSelfIndex()

	return arg_17_0.ITEM_LIST_MGR[var_17_0 + 1]
end

function var_0_0.removeSelf(arg_18_0)
	return arg_18_0.PARENT_ROOT_OBJECT:removeItem(arg_18_0)
end

function var_0_0.onDestructor(arg_19_0)
	return
end

return var_0_0
