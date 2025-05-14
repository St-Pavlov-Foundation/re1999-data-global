module("modules.logic.room.model.map.RoomBlockPackageMO", package.seeall)

local var_0_0 = pureTable("RoomBlockPackageMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1.id
	arg_1_0._blockModel = arg_1_0:_clearOrCreateModel(arg_1_0._blockModel)
	arg_1_0._useBlockModel = arg_1_0:_clearOrCreateModel(arg_1_0._useBlockModel)
	arg_1_0._unUseBlockModel = arg_1_0:_clearOrCreateModel(arg_1_0._unUseBlockModel)
	arg_1_0._useCount = 0

	local var_1_0 = RoomConfig.instance:getBlockListByPackageId(arg_1_0.id) or {}
	local var_1_1 = {}

	arg_1_0._resIdDic = {}
	arg_1_0._resIdList = {}
	arg_1_2 = arg_1_2 or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if iter_1_1.ownType ~= RoomBlockEnum.OwnType.Special or tabletool.indexOf(arg_1_2, iter_1_1.blockId) then
			local var_1_2 = arg_1_0:_createBlockMOByCfg(iter_1_1)

			table.insert(var_1_1, var_1_2)
		end

		if not arg_1_0._resIdDic[iter_1_1.mainRes] then
			arg_1_0._resIdDic[iter_1_1.mainRes] = true

			table.insert(arg_1_0._resIdList, iter_1_1.mainRes)
		end
	end

	arg_1_0._blockModel:setList(var_1_1)
	arg_1_0._unUseBlockModel:setList(var_1_1)

	if #arg_1_0._resIdList > 1 then
		table.sort(arg_1_0._resIdList, function(arg_2_0, arg_2_1)
			if arg_2_0 ~= arg_2_1 then
				return arg_2_0 < arg_2_1
			end
		end)
	end
end

function var_0_0._clearModel(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_1:clear()
	end
end

function var_0_0._clearOrCreateModel(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_1:clear()
	else
		arg_4_1 = BaseModel.New()
	end

	return arg_4_1
end

function var_0_0._sumCount(arg_5_0, arg_5_1)
	return arg_5_1:getCount()
end

function var_0_0._sumCountByResId(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_1:getList()
	local var_6_1 = 0

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1:getMainRes() == arg_6_2 then
			var_6_1 = var_6_1 + 1
		end
	end

	return var_6_1
end

function var_0_0._getBlockMOByResId(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1:getList()

	for iter_7_0 = 1, #var_7_0 do
		local var_7_1 = var_7_0[iter_7_0]

		if var_7_1:getMainRes() == arg_7_2 then
			return var_7_1
		end
	end
end

function var_0_0._createBlockMOByCfg(arg_8_0, arg_8_1)
	local var_8_0 = RoomBlockMO.New()

	var_8_0.blockState = RoomBlockEnum.BlockState.Inventory

	var_8_0:init(arg_8_1)

	if var_8_0.defineId == RoomBlockEnum.EmptyDefineId then
		var_8_0.rotate = math.random(0, 6)
	end

	return var_8_0
end

function var_0_0.getUnUseBlockMOByResId(arg_9_0, arg_9_1)
	return arg_9_0:_getBlockMOByResId(arg_9_0._unUseBlockModel, arg_9_1)
end

function var_0_0.getResIdList(arg_10_0)
	return arg_10_0._resIdList
end

function var_0_0.getBlockMOById(arg_11_0, arg_11_1)
	return arg_11_0._blockModel:getById(arg_11_1)
end

function var_0_0.getUnUseBlockMOById(arg_12_0, arg_12_1)
	return arg_12_0._unUseBlockModel:getById(arg_12_1)
end

function var_0_0.getCount(arg_13_0)
	return arg_13_0:_sumCount(arg_13_0._blockModel)
end

function var_0_0.getUseCount(arg_14_0)
	return arg_14_0:_sumCount(arg_14_0._uselockModel)
end

function var_0_0.getUnUseCount(arg_15_0)
	return arg_15_0:_sumCount(arg_15_0._unUseBlockModel)
end

function var_0_0.getCountByResId(arg_16_0, arg_16_1)
	return arg_16_0:_sumCountByResId(arg_16_0._blockModel, arg_16_1)
end

function var_0_0.getUseCountByResId(arg_17_0, arg_17_1)
	return arg_17_0:_sumCountByResId(arg_17_0._uselockModel, arg_17_1)
end

function var_0_0.getUnUseCountByResId(arg_18_0, arg_18_1)
	return arg_18_0:_sumCountByResId(arg_18_0._unUseBlockModel, arg_18_1)
end

function var_0_0.getUseBlockMOById(arg_19_0, arg_19_1)
	return arg_19_0._useBlockModel:getById(arg_19_1)
end

function var_0_0.getBlockMOList(arg_20_0)
	return arg_20_0._blockModel:getList()
end

function var_0_0.getUseBlockMOList(arg_21_0)
	return arg_21_0._useBlockModel:getList()
end

function var_0_0.getUnUseBlockMOList(arg_22_0)
	return arg_22_0._unUseBlockModel:getList()
end

function var_0_0.addBlockIdList(arg_23_0, arg_23_1)
	for iter_23_0 = 1, #arg_23_1 do
		arg_23_0:addBlockById(arg_23_1[iter_23_0])
	end
end

function var_0_0.addBlockById(arg_24_0, arg_24_1)
	if arg_24_0._blockModel:getById(arg_24_1) then
		return
	end

	local var_24_0 = RoomConfig.instance:getBlock(arg_24_1)

	if var_24_0 and var_24_0.packageId == arg_24_0.id then
		local var_24_1 = arg_24_0:_createBlockMOByCfg(var_24_0)

		arg_24_0._blockModel:addAtLast(var_24_1)
		arg_24_0._unUseBlockModel:addAtLast(var_24_1)
	end
end

function var_0_0.useBlockId(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0._unUseBlockModel:getById(arg_25_1)

	if var_25_0 then
		var_25_0.blockState = RoomBlockEnum.BlockState.Map

		arg_25_0._unUseBlockModel:remove(var_25_0)
		arg_25_0._useBlockModel:addAtLast(var_25_0)
	end
end

function var_0_0.useBlockIds(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
		arg_26_0:useBlockId(iter_26_1)
	end
end

function var_0_0.unUseBlockId(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._useBlockModel:getById(arg_27_1)

	if var_27_0 then
		var_27_0.blockState = RoomBlockEnum.BlockState.Inventory

		arg_27_0._useBlockModel:remove(var_27_0)
		arg_27_0._unUseBlockModel:addAtLast(var_27_0)
	end
end

function var_0_0.unUseBlockIds(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		arg_28_0:unUseBlockId(iter_28_1)
	end
end

function var_0_0.reset(arg_29_0)
	local var_29_0 = arg_29_0._useBlockModel:getList()

	for iter_29_0, iter_29_1 in ipairs(var_29_0) do
		iter_29_1.blockState = RoomBlockEnum.BlockState.Inventory
	end

	arg_29_0:_clearModel(arg_29_0._useBlockModel)
	arg_29_0:_clearModel(arg_29_0._unUseBlockModel)
	arg_29_0._unUseBlockModel:setList(arg_29_0._blockModel:getList())
end

function var_0_0.clear(arg_30_0)
	arg_30_0:_clearModel(arg_30_0._blockModel)
	arg_30_0:_clearModel(arg_30_0._useBlockModel)
	arg_30_0:_clearModel(arg_30_0._unUseBlockModel)
end

function var_0_0.sortBlock(arg_31_0, arg_31_1)
	if arg_31_0.packageOrder ~= arg_31_1.packageOrder then
		return arg_31_0.packageOrder > arg_31_1.packageOrder
	end
end

return var_0_0
