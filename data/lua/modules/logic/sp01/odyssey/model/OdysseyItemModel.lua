module("modules.logic.sp01.odyssey.model.OdysseyItemModel", package.seeall)

local var_0_0 = class("OdysseyItemModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.itemMoMap = {}
	arg_2_0.itemMoUidMap = {}
	arg_2_0.itemMoList = {}
	arg_2_0.itemSuitCountDic = {}
	arg_2_0.taskItemCount = 0
	arg_2_0.equipItemCount = 0
	arg_2_0.reddotShowMap = {}
	arg_2_0.hasClickItemMap = {}
	arg_2_0.addOuterItemMap = {}
end

function var_0_0.updateBagInfo(arg_3_0, arg_3_1)
	arg_3_0:updateItemInfo(arg_3_1.items)
end

function var_0_0.updateItemInfo(arg_4_0, arg_4_1, arg_4_2)
	tabletool.clear(arg_4_0.itemMoList)
	tabletool.clear(arg_4_0.itemSuitCountDic)

	arg_4_0.taskItemCount = 0
	arg_4_0.equipItemCount = 0
	arg_4_0.reddotShowMap = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = arg_4_0.itemMoMap[iter_4_1.id]

		if not var_4_0 then
			var_4_0 = {}
			arg_4_0.itemMoMap[iter_4_1.id] = var_4_0
		end

		local var_4_1 = var_4_0[iter_4_1.uid]

		if not var_4_1 then
			var_4_1 = OdysseyItemMo.New()

			var_4_1:init(iter_4_1.id)

			var_4_0[iter_4_1.uid] = var_4_1
			arg_4_0.itemMoUidMap[iter_4_1.uid] = var_4_1
		end

		var_4_1:updateInfo(iter_4_1, arg_4_2)

		if var_4_1.config.type == OdysseyEnum.ItemType.Item then
			arg_4_0.taskItemCount = arg_4_0.taskItemCount + iter_4_1.count
		elseif var_4_1.config.type == OdysseyEnum.ItemType.Equip then
			arg_4_0.equipItemCount = arg_4_0.equipItemCount + iter_4_1.count
		end

		table.insert(arg_4_0.itemMoList, var_4_1)

		local var_4_2 = OdysseyConfig.instance:getItemConfig(iter_4_1.id)

		if not arg_4_0.itemSuitCountDic[var_4_2.suitId] then
			arg_4_0.itemSuitCountDic[var_4_2.suitId] = 1
		else
			arg_4_0.itemSuitCountDic[var_4_2.suitId] = arg_4_0.itemSuitCountDic[var_4_2.suitId] + 1
		end

		arg_4_0:buildReddotShowInfo(var_4_1)
	end
end

function var_0_0.buildReddotShowInfo(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.reddotShowMap[arg_5_1.config.type] or {}

	if arg_5_1:isNew() then
		var_5_0[arg_5_1.uid] = arg_5_1
	else
		var_5_0[arg_5_1.uid] = nil
	end

	arg_5_0.reddotShowMap[arg_5_1.config.type] = var_5_0
end

function var_0_0.refreshItemInfo(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = arg_6_0.itemMoUidMap[iter_6_1.uid]

		if var_6_0 then
			var_6_0:updateInfo(iter_6_1)
		end
	end

	for iter_6_2, iter_6_3 in pairs(arg_6_0.itemMoUidMap) do
		arg_6_0:buildReddotShowInfo(iter_6_3)
	end
end

function var_0_0.getItemCount(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.itemMoMap[arg_7_1]

	if not var_7_0 then
		return 0
	end

	local var_7_1 = 0

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		var_7_1 = var_7_1 + iter_7_1.count
	end

	return var_7_1
end

function var_0_0.getItemMoUidMap(arg_8_0)
	return arg_8_0.itemMoUidMap
end

function var_0_0.getItemMoByUid(arg_9_0, arg_9_1)
	return arg_9_0.itemMoUidMap[arg_9_1]
end

function var_0_0.cleanAllAddCount(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.itemMoUidMap) do
		iter_10_1:cleanAddCount()
	end

	arg_10_0.addOuterItemMap = {}
end

function var_0_0.getItemMoList(arg_11_0)
	return arg_11_0.itemMoList
end

function var_0_0.haveSuitItem(arg_12_0, arg_12_1)
	return arg_12_0.itemSuitCountDic[arg_12_1] and arg_12_0.itemSuitCountDic[arg_12_1] > 0
end

function var_0_0.haveTaskItem(arg_13_0)
	return arg_13_0.taskItemCount and arg_13_0.taskItemCount > 0
end

function var_0_0.haveEquipItem(arg_14_0)
	return arg_14_0.equipItemCount and arg_14_0.equipItemCount > 0
end

function var_0_0.checkIsItemNewFlag(arg_15_0, arg_15_1)
	if arg_15_1 then
		local var_15_0 = arg_15_0.reddotShowMap[arg_15_1]

		if var_15_0 and next(var_15_0) then
			return true, var_15_0 or {}
		end

		return false
	else
		for iter_15_0 = OdysseyEnum.ItemType.Item, OdysseyEnum.ItemType.Equip do
			local var_15_1 = arg_15_0.reddotShowMap[iter_15_0]

			if var_15_1 and next(var_15_1) then
				return true, var_15_1 or {}
			end
		end
	end

	return false
end

function var_0_0.setHasClickItem(arg_16_0, arg_16_1)
	arg_16_0.hasClickItemMap[arg_16_1] = arg_16_1
end

function var_0_0.isHasClickItem(arg_17_0, arg_17_1)
	return arg_17_0.hasClickItemMap[arg_17_1]
end

function var_0_0.cleanHasClickItemState(arg_18_0)
	arg_18_0.hasClickItemMap = {}
end

function var_0_0.checkBagTagShowReddot(arg_19_0, arg_19_1)
	local var_19_0, var_19_1 = arg_19_0:checkIsItemNewFlag(arg_19_1)
	local var_19_2 = var_19_0
	local var_19_3 = false

	if var_19_0 then
		for iter_19_0, iter_19_1 in pairs(var_19_1) do
			if not arg_19_0:isHasClickItem(iter_19_0) then
				var_19_3 = true

				break
			end
		end
	end

	return var_19_2 and var_19_3
end

function var_0_0.getHasClickItemList(arg_20_0)
	local var_20_0 = {}

	for iter_20_0, iter_20_1 in pairs(arg_20_0.hasClickItemMap) do
		if arg_20_0:getItemMoByUid(iter_20_0):isNew() then
			table.insert(var_20_0, iter_20_0)
		end
	end

	return var_20_0
end

function var_0_0.setAddOuterItem(arg_21_0, arg_21_1)
	arg_21_0.addOuterItemMap = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		local var_21_0 = arg_21_0.addOuterItemMap[iter_21_1.materilId]

		if not var_21_0 then
			var_21_0 = OdysseyOuterItemMo.New()
			arg_21_0.addOuterItemMap[iter_21_1.materilId] = var_21_0
		end

		var_21_0:updateInfo(iter_21_1)
	end
end

function var_0_0.getAddOuterItemList(arg_22_0)
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs(arg_22_0.addOuterItemMap) do
		if iter_22_1.addCount > 0 then
			table.insert(var_22_0, iter_22_1)
		end
	end

	return var_22_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
