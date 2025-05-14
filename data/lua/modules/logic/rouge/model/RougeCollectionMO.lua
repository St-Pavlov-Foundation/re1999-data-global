module("modules.logic.rouge.model.RougeCollectionMO", package.seeall)

local var_0_0 = class("RougeCollectionMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:initBaseInfo(arg_1_1)
	arg_1_0:updateAttrValues(arg_1_1.attr)
end

function var_0_0.initBaseInfo(arg_2_0, arg_2_1)
	arg_2_0.id = tonumber(arg_2_1.id)
	arg_2_0.cfgId = tonumber(arg_2_1.itemId)
	arg_2_0.enchantIds = {}

	if arg_2_1.holdIds then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1.holdIds) do
			table.insert(arg_2_0.enchantIds, tonumber(iter_2_1))
		end
	end

	arg_2_0.enchantCfgIds = {}

	if arg_2_1.holdItems then
		for iter_2_2, iter_2_3 in ipairs(arg_2_1.holdItems) do
			table.insert(arg_2_0.enchantCfgIds, tonumber(iter_2_3))
		end
	end
end

function var_0_0.getCollectionCfgId(arg_3_0)
	return arg_3_0.cfgId
end

function var_0_0.getCollectionId(arg_4_0)
	return arg_4_0.id
end

function var_0_0.isEnchant(arg_5_0, arg_5_1)
	return arg_5_0.enchantIds and arg_5_0.enchantIds[arg_5_1] and arg_5_0.enchantIds[arg_5_1] > 0
end

function var_0_0.getEnchantIdAndCfgId(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.enchantIds and arg_6_0.enchantIds[arg_6_1]
	local var_6_1 = arg_6_0.enchantCfgIds and arg_6_0.enchantCfgIds[arg_6_1]

	return var_6_0, var_6_1
end

function var_0_0.getAllEnchantId(arg_7_0)
	return arg_7_0.enchantIds
end

function var_0_0.getEnchantCount(arg_8_0)
	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(arg_8_0.enchantIds) do
		if iter_8_1 and iter_8_1 > 0 then
			var_8_0 = var_8_0 + 1
		end
	end

	return var_8_0
end

function var_0_0.getAllEnchantCfgId(arg_9_0)
	return arg_9_0.enchantCfgIds
end

function var_0_0.updateEnchant(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.enchantIds = arg_10_0.enchantIds or {}
	arg_10_0.enchantIds[arg_10_2] = arg_10_1
end

function var_0_0.updateEnchantTargetId(arg_11_0, arg_11_1)
	arg_11_0.enchantUid = arg_11_1
end

function var_0_0.getEnchantTargetId(arg_12_0)
	return arg_12_0.enchantUid or 0
end

function var_0_0.isEnchant2Collection(arg_13_0)
	return arg_13_0.enchantUid and arg_13_0.enchantUid > 0
end

function var_0_0.getRotation(arg_14_0)
	return RougeEnum.CollectionRotation.Rotation_0
end

function var_0_0.updateInfo(arg_15_0, arg_15_1)
	arg_15_0:init(arg_15_1)
end

function var_0_0.copyOtherCollectionMO(arg_16_0, arg_16_1)
	if not arg_16_1 then
		return
	end

	arg_16_0.id = arg_16_1.id
	arg_16_0.cfgId = arg_16_1.cfgId
	arg_16_0.enchantIds = {}

	if arg_16_1.enchantIds then
		for iter_16_0, iter_16_1 in ipairs(arg_16_1.enchantIds) do
			table.insert(arg_16_0.enchantIds, tonumber(iter_16_1))
		end
	end

	arg_16_0.enchantCfgIds = {}

	if arg_16_1.enchantCfgIds then
		for iter_16_2, iter_16_3 in ipairs(arg_16_1.enchantCfgIds) do
			table.insert(arg_16_0.enchantCfgIds, tonumber(iter_16_3))
		end
	end
end

function var_0_0.updateAttrValues(arg_17_0, arg_17_1)
	arg_17_0.attrValueMap = {}

	if arg_17_1 then
		local var_17_0 = arg_17_1.attrIds
		local var_17_1 = arg_17_1.attrVals

		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			arg_17_0.attrValueMap[iter_17_1] = tonumber(var_17_1[iter_17_0])
		end
	end
end

function var_0_0.isAttrExist(arg_18_0, arg_18_1)
	return arg_18_0.attrValueMap and arg_18_0.attrValueMap[arg_18_1] ~= nil
end

function var_0_0.getAttrValueMap(arg_19_0)
	return arg_19_0.attrValueMap
end

function var_0_0.getLeftTopPos(arg_20_0)
	return Vector2(1000, 1000)
end

return var_0_0
