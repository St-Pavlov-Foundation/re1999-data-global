module("modules.logic.critter.model.CritterSummonModel", package.seeall)

local var_0_0 = class("CritterSummonModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	return
end

function var_0_0.initSummonPools(arg_5_0, arg_5_1)
	local var_5_0 = {}

	if arg_5_1 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			local var_5_1 = arg_5_0:getById(iter_5_1.poolId) or CritterSummonMO.New()

			var_5_1:init(iter_5_1)
			table.insert(var_5_0, var_5_1)
		end
	end

	arg_5_0:setList(var_5_0)
end

function var_0_0.setSummonPoolList(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getById(arg_6_1)

	if var_6_0 then
		RoomSummonPoolCritterListModel.instance:setDataList(var_6_0.critterMos)
	end
end

function var_0_0.onSummon(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:getById(arg_7_1):onRefresh(arg_7_2)
end

function var_0_0.getSummonPoolId(arg_8_0)
	return 1
end

function var_0_0.getSummonCount(arg_9_0)
	return 1
end

function var_0_0.isMaxCritterCount(arg_10_0)
	local var_10_0 = #CritterModel.instance:getAllCritters() or 0
	local var_10_1 = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.CritterBackpackCapacity) or 0

	return var_10_0 >= tonumber(var_10_1)
end

function var_0_0.isCanSummon(arg_11_0, arg_11_1)
	if arg_11_0:isMaxCritterCount() then
		return false, ToastEnum.RoomCritterMaxCount
	end

	if not arg_11_0:isNullPool(arg_11_1) then
		return true
	end

	return false, ToastEnum.RoomCritterPoolEmpty
end

function var_0_0.isNullPool(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getById(arg_12_1)

	if var_12_0 then
		for iter_12_0, iter_12_1 in pairs(var_12_0.critterMos) do
			if iter_12_1:getPoolCount() > 0 then
				return false
			end
		end
	end

	return true
end

function var_0_0.isFullPool(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getById(arg_13_1)

	if var_13_0 then
		for iter_13_0, iter_13_1 in pairs(var_13_0.critterMos) do
			if not iter_13_1:isFullPool() then
				return false
			end
		end
	end

	return true
end

function var_0_0.getPoolCritterCount(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getById(arg_14_1)

	if var_14_0 then
		return var_14_0:getCritterCount()
	end

	return 0
end

function var_0_0.getPoolCurrency(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_1 then
		return
	end

	local var_15_0 = CritterConfig.instance:getCritterSummonCfg(arg_15_1).cost

	return arg_15_0:getCostInfo(var_15_0, arg_15_2)
end

function var_0_0.notSummonToast(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0, var_16_1 = arg_16_0:isCanSummon(arg_16_1)
	local var_16_2, var_16_3, var_16_4, var_16_5 = arg_16_0:getPoolCurrency(arg_16_1, arg_16_2)

	if not var_16_0 then
		return var_16_1
	elseif not var_16_4 then
		return ToastEnum.RoomCritterNotEnough, var_16_5
	end

	return ""
end

function var_0_0.getCostInfo(arg_17_0, arg_17_1, arg_17_2)
	if string.nilorempty(arg_17_1) then
		return
	end

	local var_17_0 = 1

	if arg_17_2 then
		var_17_0 = math.max(1, tonumber(arg_17_2))
	end

	local var_17_1, var_17_2, var_17_3 = SummonMainModel.getCostByConfig(arg_17_1)
	local var_17_4, var_17_5 = ItemModel.instance:getItemConfigAndIcon(var_17_1, var_17_2)
	local var_17_6 = ItemModel.instance:getItemQuantity(var_17_1, var_17_2) >= var_17_3 * var_17_0
	local var_17_7 = luaLang("multiple") .. var_17_3 * var_17_0

	return var_17_5, var_17_7, var_17_6, var_17_4.name
end

function var_0_0.getCostCurrency(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(lua_critter_summon.configList) do
		if not string.nilorempty(iter_18_1.cost) then
			local var_18_2 = string.split(iter_18_1.cost, "#")

			if var_18_2[1] and var_18_2[2] then
				local var_18_3 = var_18_2[1] .. "#" .. var_18_2[2]

				if not LuaUtil.tableContains(var_18_0, var_18_3) then
					table.insert(var_18_0, var_18_3)
				end
			end
		end
	end

	for iter_18_2, iter_18_3 in ipairs(var_18_0) do
		local var_18_4 = string.split(iter_18_3, "#")

		if var_18_4[1] and var_18_4[2] then
			local var_18_5 = tonumber(var_18_4[1])
			local var_18_6 = tonumber(var_18_4[2])

			if var_18_5 == MaterialEnum.MaterialType.Item then
				local var_18_7 = {
					isIcon = true,
					type = var_18_5,
					id = var_18_6,
					jumpFunc = SummonMainModel.jumpToSummonCostShop
				}

				if not LuaUtil.tableContains(var_18_1, var_18_7) then
					table.insert(var_18_1, var_18_7)
				end
			elseif var_18_5 == MaterialEnum.MaterialType.Currency and not LuaUtil.tableContains(var_18_1, var_18_6) then
				table.insert(var_18_1, var_18_6)
			end
		end
	end

	return var_18_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
