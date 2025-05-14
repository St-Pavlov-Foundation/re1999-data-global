module("modules.logic.rouge.dlc.101.model.rpcmo.RougeLimiterClientMO", package.seeall)

local var_0_0 = pureTable("RougeLimiterClientMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:_onGetLimitIds(arg_1_1.limitIds)
	arg_1_0:_onGetLimitBuffIds(arg_1_1.limitBuffIds)
end

function var_0_0._onGetLimitIds(arg_2_0, arg_2_1)
	arg_2_0._limitIds = {}
	arg_2_0._limitIdMap = {}
	arg_2_0._limitGroupMap = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0:_onGetLimitId(iter_2_1)
	end
end

function var_0_0._onGetLimitId(arg_3_0, arg_3_1)
	if not arg_3_0._limitIdMap[arg_3_1] then
		local var_3_0 = RougeDLCConfig101.instance:getLimiterCo(arg_3_1)
		local var_3_1 = var_3_0 and var_3_0.group

		arg_3_0._limitIdMap[arg_3_1] = true
		arg_3_0._limitGroupMap[var_3_1] = arg_3_1

		table.insert(arg_3_0._limitIds, arg_3_1)
	end
end

function var_0_0._onRemoveLimitId(arg_4_0, arg_4_1)
	if arg_4_0._limitIdMap[arg_4_1] then
		local var_4_0 = RougeDLCConfig101.instance:getLimiterCo(arg_4_1)
		local var_4_1 = var_4_0 and var_4_0.group

		arg_4_0._limitIdMap[arg_4_1] = nil
		arg_4_0._limitGroupMap[var_4_1] = nil

		tabletool.removeValue(arg_4_0._limitIds, arg_4_1)
	end
end

function var_0_0._onGetLimitBuffIds(arg_5_0, arg_5_1)
	arg_5_0._limitBuffIds = {}
	arg_5_0._limitBuffIdMap = {}
	arg_5_0._limitBuffTypeMap = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0:_onGetLimitBuffId(iter_5_1)
	end
end

function var_0_0._onGetLimitBuffId(arg_6_0, arg_6_1)
	if not arg_6_0._limitBuffIdMap[arg_6_1] then
		local var_6_0 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_6_1).buffType

		arg_6_0:removeLimitBuffByType(var_6_0)

		arg_6_0._limitBuffIdMap[arg_6_1] = true
		arg_6_0._limitBuffTypeMap[var_6_0] = arg_6_1

		table.insert(arg_6_0._limitBuffIds, arg_6_1)
	end
end

function var_0_0._onRemoveLimitBuffId(arg_7_0, arg_7_1)
	if arg_7_0._limitBuffIdMap[arg_7_1] then
		local var_7_0 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_7_1).buffType

		arg_7_0._limitBuffIdMap[arg_7_1] = nil
		arg_7_0._limitBuffTypeMap[var_7_0] = nil

		tabletool.removeValue(arg_7_0._limitBuffIds, arg_7_1)
	end
end

function var_0_0.removeLimitBuffByType(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getLimitBuffIdByType(arg_8_1)

	arg_8_0:_onRemoveLimitBuffId(var_8_0)
end

function var_0_0.getLimitBuffIdByType(arg_9_0, arg_9_1)
	return arg_9_0._limitBuffTypeMap and arg_9_0._limitBuffTypeMap[arg_9_1]
end

function var_0_0.getLimitBuffIds(arg_10_0)
	return arg_10_0._limitBuffIds
end

function var_0_0.getLimitBuffIdsAndSortByType(arg_11_0)
	local var_11_0 = {}

	tabletool.addValues(var_11_0, arg_11_0._limitBuffIds)
	table.sort(var_11_0, var_0_0._sortLimitBuffIdByType)

	return var_11_0
end

function var_0_0._sortLimitBuffIdByType(arg_12_0, arg_12_1)
	local var_12_0 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_12_0)
	local var_12_1 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_12_1)

	if var_12_0 and var_12_1 and var_12_0.buffType ~= var_12_1.buffType then
		return var_12_0.buffType < var_12_1.buffType
	end

	return var_12_0.id < var_12_1.id
end

function var_0_0.getLimitBuffIdMap(arg_13_0)
	return arg_13_0._limitBuffIdMap
end

function var_0_0.getLimitIds(arg_14_0)
	return arg_14_0._limitIds
end

function var_0_0.getLimitIdMap(arg_15_0)
	return arg_15_0._limitIdMap
end

function var_0_0.getLimitIdInGroup(arg_16_0, arg_16_1)
	return arg_16_0._limitGroupMap and arg_16_0._limitGroupMap[arg_16_1]
end

function var_0_0.isSelectBuff(arg_17_0, arg_17_1)
	return arg_17_0._limitBuffIdMap and arg_17_0._limitBuffIdMap[arg_17_1] ~= nil
end

function var_0_0.isSelectDebuff(arg_18_0, arg_18_1)
	return arg_18_0._limitIdMap and arg_18_0._limitIdMap[arg_18_1] ~= nil
end

function var_0_0.selectLimit(arg_19_0, arg_19_1, arg_19_2)
	if not RougeDLCConfig101.instance:getLimiterCo(arg_19_1) then
		return
	end

	if arg_19_2 then
		arg_19_0:_onGetLimitId(arg_19_1)
	else
		arg_19_0:_onRemoveLimitId(arg_19_1)
	end
end

function var_0_0.selectLimitBuff(arg_20_0, arg_20_1, arg_20_2)
	if not RougeDLCConfig101.instance:getLimiterBuffCo(arg_20_1) then
		return
	end

	if arg_20_2 then
		arg_20_0:_onGetLimitBuffId(arg_20_1)
	else
		arg_20_0:_onRemoveLimitBuffId(arg_20_1)
	end
end

function var_0_0.clearAllLimitIds(arg_21_0)
	arg_21_0:_onGetLimitIds({})
end

function var_0_0.clearAllLimitBuffIds(arg_22_0)
	arg_22_0:_onGetLimitBuffIds({})
end

return var_0_0
