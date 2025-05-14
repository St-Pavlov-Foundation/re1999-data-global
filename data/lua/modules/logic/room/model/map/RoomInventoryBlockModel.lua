module("modules.logic.room.model.map.RoomInventoryBlockModel", package.seeall)

local var_0_0 = class("RoomInventoryBlockModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._selectPackageIds = {}

	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._selectPackageIds = {}
	arg_2_0._unUseBlockList = {}

	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	if arg_4_0._blockPackageModel then
		local var_4_0 = arg_4_0._blockPackageModel:getList()

		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			iter_4_1:clear()
		end

		arg_4_0._blockPackageModel:clear()
	end

	arg_4_0._blockPackageModel = BaseModel.New()
	arg_4_0._unUseBlockList = arg_4_0._unUseBlockList or {}
end

function var_0_0.initInventory(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0:_clearData()

	local var_5_0 = {}

	tabletool.addValues(var_5_0, arg_5_1)

	arg_5_2 = arg_5_2 or {}

	local var_5_1 = arg_5_0:_getSpercialMaps(arg_5_4)

	for iter_5_0 = 1, #var_5_0 do
		local var_5_2 = var_5_0[iter_5_0]

		if not var_5_1[var_5_2] then
			var_5_1[var_5_2] = {}
		end
	end

	for iter_5_1, iter_5_2 in pairs(var_5_1) do
		local var_5_3 = RoomBlockPackageMO.New()

		var_5_3:init({
			id = iter_5_1
		}, iter_5_2)
		arg_5_0._blockPackageModel:addAtLast(var_5_3)
	end

	arg_5_0:addBlockPackageList(arg_5_2)

	arg_5_3 = arg_5_3 or {}

	for iter_5_3 = 1, #arg_5_3 do
		arg_5_0:placeBlock(arg_5_3[iter_5_3].blockId)
	end

	if not arg_5_0:getCurPackageMO() and arg_5_0._blockPackageModel:getCount() > 0 then
		local var_5_4 = arg_5_0:_findHasUnUsePackageMO() or arg_5_0._blockPackageModel:getByIndex(1)

		arg_5_0:setSelectBlockPackageIds({
			var_5_4.id
		})
		RoomHelper.hideBlockPackageReddot(var_5_4.id)
	end
end

function var_0_0.addSpecialBlockIds(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:_getSpercialMaps(arg_6_1)

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_1 = arg_6_0._blockPackageModel:getById(iter_6_0)

		if var_6_1 then
			var_6_1:addBlockIdList(iter_6_1)
		else
			local var_6_2 = RoomBlockPackageMO.New()

			var_6_2:init({
				id = iter_6_0
			}, iter_6_1)
			arg_6_0._blockPackageModel:addAtLast(var_6_2)
		end
	end
end

function var_0_0._getSpercialMaps(arg_7_0, arg_7_1)
	local var_7_0 = {}

	arg_7_1 = arg_7_1 or {}

	local var_7_1 = RoomConfig.instance

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_2 = var_7_1:getBlock(iter_7_1)

		if var_7_2 then
			local var_7_3 = var_7_0[var_7_2.packageId]

			if not var_7_3 then
				var_7_3 = {}
				var_7_0[var_7_2.packageId] = var_7_3
			end

			table.insert(var_7_3, iter_7_1)
		end
	end

	return var_7_0
end

function var_0_0._findHasUnUsePackageMO(arg_8_0)
	local var_8_0 = arg_8_0._blockPackageModel:getList()

	for iter_8_0 = 1, #var_8_0 do
		if var_8_0[iter_8_0]:getUnUseCount() > 0 then
			return var_8_0[iter_8_0]
		end
	end
end

function var_0_0.addBlockPackageList(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	for iter_9_0 = 1, #arg_9_1 do
		local var_9_0 = arg_9_1[iter_9_0]
		local var_9_1 = var_9_0.blockPackageId
		local var_9_2 = arg_9_0._blockPackageModel:getById(var_9_1)

		if not var_9_2 then
			var_9_2 = RoomBlockPackageMO.New()

			var_9_2:init({
				id = var_9_1
			})
			arg_9_0._blockPackageModel:addAtLast(var_9_2)
		end

		var_9_2:reset()
		var_9_2:useBlockIds(var_9_0.useBlockIds)
	end
end

function var_0_0.setSelectBlockPackageIds(arg_10_0, arg_10_1)
	arg_10_0._selectPackageIds = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		table.insert(arg_10_0._selectPackageIds, iter_10_1)
	end
end

function var_0_0.isSelectBlockPackageById(arg_11_0, arg_11_1)
	return tabletool.indexOf(arg_11_0._selectPackageIds, arg_11_1) and true or false
end

function var_0_0.rotateFirst(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getSelectInventoryBlockMO()

	if var_12_0 then
		var_12_0.rotate = arg_12_1
	end
end

function var_0_0.placeBlock(arg_13_0, arg_13_1)
	if arg_13_0._selectInventoryBlockId == arg_13_1 then
		arg_13_0._selectInventoryBlockId = nil
	end

	local var_13_0 = RoomConfig.instance:getBlock(arg_13_1)

	if var_13_0 then
		local var_13_1 = arg_13_0._blockPackageModel:getById(var_13_0.packageId)

		if var_13_1 then
			var_13_1:useBlockId(arg_13_1)
		end

		tabletool.removeValue(arg_13_0._unUseBlockList, arg_13_1)
	else
		logError(string.format("地块配置中找不到地块. can not find blockCfg for BlockConfig : [blockId:%s]", arg_13_1 or "nil"))
	end
end

function var_0_0.blackBlocksByIds(arg_14_0, arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		arg_14_0:blackBlockById(iter_14_1)
	end
end

function var_0_0.blackBlockById(arg_15_0, arg_15_1)
	local var_15_0 = RoomConfig.instance:getBlock(arg_15_1)

	if var_15_0 then
		local var_15_1 = arg_15_0._blockPackageModel:getById(var_15_0.packageId)

		if var_15_1 then
			var_15_1:unUseBlockId(arg_15_1)
			table.insert(arg_15_0._unUseBlockList, arg_15_1)
		else
			logError("还没获得对应的资源包：" .. var_15_0.packageId)
		end
	end
end

function var_0_0.findFristUnUseBlockMO(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_0._blockPackageModel:getById(arg_16_1)

	if not var_16_0 then
		return nil
	end

	local var_16_1 = arg_16_0._unUseBlockList or {}

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		local var_16_2 = var_16_0:getUnUseBlockMOById(iter_16_1)

		if var_16_2 and var_16_2:getMainRes() == arg_16_2 then
			return var_16_2
		end
	end

	return var_16_0:getUnUseBlockMOByResId(arg_16_2)
end

function var_0_0.getCurPackageMO(arg_17_0)
	local var_17_0
	local var_17_1 = arg_17_0._blockPackageModel:getList()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._selectPackageIds) do
		local var_17_2 = arg_17_0._blockPackageModel:getById(iter_17_1)

		if var_17_2 and var_17_2:getUnUseCount() > 0 then
			return var_17_2
		elseif var_17_0 == nil then
			var_17_0 = var_17_2
		end
	end

	return var_17_0
end

function var_0_0.getPackageMOById(arg_18_0, arg_18_1)
	return arg_18_0._blockPackageModel:getById(arg_18_1)
end

function var_0_0.openSelectOp(arg_19_0)
	return true
end

function var_0_0.setSelectInventoryBlockId(arg_20_0, arg_20_1)
	arg_20_0._selectInventoryBlockId = arg_20_1
end

function var_0_0.getSelectInventoryBlockId(arg_21_0)
	return arg_21_0._selectInventoryBlockId
end

function var_0_0.setSelectResId(arg_22_0, arg_22_1)
	arg_22_0._selectResId = arg_22_1
end

function var_0_0.getSelectResId(arg_23_0)
	return arg_23_0._selectResId
end

function var_0_0.getSelectInventoryBlockMO(arg_24_0)
	return arg_24_0:getInventoryBlockMOById(arg_24_0._selectInventoryBlockId)
end

function var_0_0.getInventoryBlockCount(arg_25_0)
	return 0
end

function var_0_0.getInventoryBlockMOById(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._blockPackageModel:getList()
	local var_26_1

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_2 = iter_26_1:getBlockMOById(arg_26_1)

		if var_26_2 then
			return var_26_2
		end
	end

	return nil
end

function var_0_0.getInventoryBlockPackageMOList(arg_27_0)
	return arg_27_0._blockPackageModel:getList()
end

function var_0_0.isMaxNum(arg_28_0)
	local var_28_0 = RoomMapBlockModel.instance

	return var_28_0:getConfirmBlockCount() >= var_28_0:getMaxBlockCount()
end

function var_0_0.getBlockSortIndex(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = #arg_29_0._unUseBlockList + 1
	local var_29_1 = tabletool.indexOf(arg_29_0._unUseBlockList, arg_29_2)

	if var_29_1 then
		return var_29_0 - var_29_1
	end

	return var_29_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
