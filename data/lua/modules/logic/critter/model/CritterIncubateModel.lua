module("modules.logic.critter.model.CritterIncubateModel", package.seeall)

local var_0_0 = class("CritterIncubateModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._selectParentCrittersIds = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._selectParentCrittersIds = {}
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	return
end

function var_0_0.getCanSelectCount(arg_5_0)
	return 2
end

function var_0_0._getNullSelect(arg_6_0)
	for iter_6_0 = 1, arg_6_0:getCanSelectCount() do
		if not arg_6_0._selectParentCrittersIds[iter_6_0] then
			return iter_6_0
		end
	end
end

function var_0_0.addSelectParentCritter(arg_7_0, arg_7_1)
	if not arg_7_0._selectParentCrittersIds then
		arg_7_0._selectParentCrittersIds = {}
	end

	local var_7_0 = arg_7_0:_getNullSelect()

	if var_7_0 then
		arg_7_0._selectParentCrittersIds[var_7_0] = arg_7_1

		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onSelectParentCritter, var_7_0, arg_7_1)
	end
end

function var_0_0.removeSelectParentCritter(arg_8_0, arg_8_1)
	if not arg_8_0._selectParentCrittersIds then
		arg_8_0._selectParentCrittersIds = {}
	end

	local var_8_0 = tabletool.indexOf(arg_8_0._selectParentCrittersIds, arg_8_1)

	if var_8_0 then
		arg_8_0._selectParentCrittersIds[var_8_0] = nil

		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onRemoveParentCritter, var_8_0, arg_8_1)
	end
end

function var_0_0.isSelectParentCritter(arg_9_0, arg_9_1)
	return LuaUtil.tableContains(arg_9_0._selectParentCrittersIds, arg_9_1)
end

function var_0_0.getSelectParentCritterUIdByIndex(arg_10_0, arg_10_1)
	if not arg_10_0._selectParentCrittersIds then
		return
	end

	local var_10_0 = arg_10_0._selectParentCrittersIds[arg_10_1]

	if var_10_0 and CritterModel.instance:getCritterMOByUid(var_10_0) then
		return var_10_0
	end

	arg_10_0._selectParentCrittersIds[arg_10_1] = nil
end

function var_0_0.getSelectParentCritterMoByid(arg_11_0, arg_11_1)
	if not arg_11_0._selectParentCrittersIds then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._selectParentCrittersIds) do
		local var_11_0 = CritterModel.instance:getCritterMOByUid(iter_11_1)

		if var_11_0.defineId == arg_11_1 then
			return var_11_0
		end
	end
end

function var_0_0.getSelectParentCritterCount(arg_12_0)
	return arg_12_0._selectParentCrittersIds and tabletool.len(arg_12_0._selectParentCrittersIds) or 0, arg_12_0:getCanSelectCount()
end

function var_0_0.getChildMOList(arg_13_0)
	return arg_13_0._previewChildCritters or {}
end

function var_0_0.setCritterPreviewInfo(arg_14_0, arg_14_1)
	arg_14_0._previewChildCritters = {}

	if arg_14_1 then
		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			local var_14_0 = arg_14_0:getById(iter_14_1.uid) or CritterMO.New()

			var_14_0:init(iter_14_1)
			table.insert(arg_14_0._previewChildCritters, var_14_0)
		end
	end
end

function var_0_0.getCritterMOByUid(arg_15_0, arg_15_1)
	if not arg_15_0._previewChildCritters then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._previewChildCritters) do
		if iter_15_1.uid == arg_15_1 then
			return iter_15_1
		end
	end
end

function var_0_0.notSummonToast(arg_16_0)
	local var_16_0, var_16_1, var_16_2, var_16_3 = arg_16_0:getPoolCurrency()

	if CritterSummonModel.instance:isMaxCritterCount() then
		return ToastEnum.RoomCritterMaxCount
	end

	if not var_16_2 then
		return ToastEnum.RoomCritterNotEnough, var_16_3
	end

	local var_16_4, var_16_5 = arg_16_0:getSelectParentCritterCount()

	if var_16_4 < var_16_5 then
		return ToastEnum.RoomCritteNeedTwo
	end

	return ""
end

function var_0_0.getPoolCurrency(arg_17_0)
	local var_17_0 = 3

	if arg_17_0._selectParentCrittersIds then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._selectParentCrittersIds) do
			local var_17_1 = CritterModel.instance:getCritterMOByUid(iter_17_1)

			if var_17_1 then
				local var_17_2 = var_17_1:getDefineCfg().rare

				var_17_0 = math.max(var_17_0, var_17_2)
			end
		end
	end

	local var_17_3 = CritterConfig.instance:getCritterRareCfg(var_17_0)

	if var_17_3 then
		return CritterSummonModel.instance:getCostInfo(var_17_3.incubateCost)
	end
end

function var_0_0.getCostCurrency(arg_18_0)
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(lua_critter_rare.configList) do
		if not string.nilorempty(iter_18_1.incubateCost) then
			local var_18_2 = string.split(iter_18_1.incubateCost, "#")

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

function var_0_0.setSortType(arg_19_0, arg_19_1)
	arg_19_0._selectSortType = arg_19_1
end

function var_0_0.getSortType(arg_20_0)
	return arg_20_0._selectSortType or CritterEnum.AttributeType.Efficiency
end

function var_0_0.setSortWay(arg_21_0, arg_21_1)
	arg_21_0._selectSortWay = arg_21_1
end

function var_0_0.getSortWay(arg_22_0)
	return arg_22_0._selectSortWay
end

var_0_0.instance = var_0_0.New()

return var_0_0
