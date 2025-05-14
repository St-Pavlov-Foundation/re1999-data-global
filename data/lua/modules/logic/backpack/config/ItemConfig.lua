module("modules.logic.backpack.config.ItemConfig", package.seeall)

local var_0_0 = class("ItemConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._itemConfig = nil
	arg_1_0._itemUseConfig = nil
	arg_1_0._itemSpecialConfig = nil
	arg_1_0._itemPowerConfig = nil
	arg_1_0._itemInsightConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"item",
		"item_use",
		"item_specialitem",
		"power_item",
		"item_category_show",
		"insight_item"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "item" then
		arg_3_0._itemConfig = arg_3_2
	elseif arg_3_1 == "item_use" then
		arg_3_0._itemUseConfig = arg_3_2
	elseif arg_3_1 == "item_specialitem" then
		arg_3_0._itemSpecialConfig = arg_3_2
	elseif arg_3_1 == "power_item" then
		arg_3_0._itemPowerConfig = arg_3_2
	elseif arg_3_1 == "item_category_show" then
		arg_3_0._itemCategoryShow = arg_3_2
	elseif arg_3_1 == "insight_item" then
		arg_3_0._itemInsightConfig = arg_3_2
	end
end

function var_0_0.getItemsCo(arg_4_0)
	return arg_4_0._itemConfig.configDict
end

function var_0_0.getItemCo(arg_5_0, arg_5_1)
	return arg_5_0._itemConfig.configDict[arg_5_1]
end

function var_0_0.getItemsUseCo(arg_6_0)
	return arg_6_0._itemUseConfig.configDict
end

function var_0_0.getItemUseCo(arg_7_0, arg_7_1)
	return arg_7_0._itemUseConfig.configDict[arg_7_1]
end

function var_0_0.getItemsSpecialCo(arg_8_0)
	return arg_8_0._itemSpecialConfig.configDict
end

function var_0_0.getItemSpecialCo(arg_9_0, arg_9_1)
	return arg_9_0._itemSpecialConfig.configDict[arg_9_1]
end

function var_0_0.getItemsPowerCo(arg_10_0)
	return arg_10_0._itemPowerConfig.configDict
end

function var_0_0.getPowerItemCo(arg_11_0, arg_11_1)
	return arg_11_0._itemPowerConfig.configDict[arg_11_1]
end

function var_0_0.getItemsInsightCo(arg_12_0)
	return arg_12_0._itemInsightConfig.configDict
end

function var_0_0.getInsightItemCo(arg_13_0, arg_13_1)
	return arg_13_0._itemInsightConfig.configDict[arg_13_1]
end

function var_0_0.getItemNameById(arg_14_0, arg_14_1)
	return arg_14_0._itemConfig.configDict[arg_14_1] and arg_14_0._itemConfig.configDict[arg_14_1].name
end

function var_0_0.getItemIconById(arg_15_0, arg_15_1)
	return arg_15_0._itemConfig.configDict[arg_15_1] and arg_15_0._itemConfig.configDict[arg_15_1].icon
end

function var_0_0.getItemListBySubType(arg_16_0, arg_16_1)
	if not arg_16_0._subTypeDict then
		arg_16_0._subTypeDict = {}

		for iter_16_0, iter_16_1 in ipairs(arg_16_0._itemConfig.configList) do
			local var_16_0 = arg_16_0._subTypeDict[iter_16_1.subType]

			if not var_16_0 then
				var_16_0 = {}
				arg_16_0._subTypeDict[iter_16_1.subType] = var_16_0
			end

			table.insert(var_16_0, iter_16_1)
		end
	end

	return arg_16_0._subTypeDict[arg_16_1]
end

function var_0_0.getStackItemList(arg_17_0, arg_17_1)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_1 = tonumber(iter_17_1[1])
		local var_17_2 = tonumber(iter_17_1[2])
		local var_17_3 = tonumber(iter_17_1[3])

		if ItemModel.instance:getItemConfig(tonumber(iter_17_1[1]), tonumber(iter_17_1[2])) then
			if arg_17_0:isItemStackable(var_17_1, var_17_2) then
				local var_17_4 = {
					var_17_1,
					var_17_2,
					var_17_3
				}

				table.insert(var_17_0, var_17_4)
			else
				for iter_17_2 = 1, var_17_3 do
					local var_17_5 = {
						var_17_1,
						var_17_2
					}

					var_17_5[3] = 1

					table.insert(var_17_0, var_17_5)
				end
			end
		else
			logError(string.format("getStackItemList no config, type: %s, id: %s", var_17_1, var_17_2))
		end
	end

	return var_17_0
end

function var_0_0.isItemStackable(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = true
	local var_18_1 = arg_18_0:getItemConfig(tonumber(arg_18_1), tonumber(arg_18_2))

	if arg_18_1 == MaterialEnum.MaterialType.Item then
		var_18_0 = not var_18_1.isStackable or var_18_1.isStackable == 1
	elseif arg_18_1 == MaterialEnum.MaterialType.Hero or arg_18_1 == MaterialEnum.MaterialType.HeroSkin or arg_18_1 == MaterialEnum.MaterialType.EquipCard or arg_18_1 == MaterialEnum.MaterialType.PlayerCloth or arg_18_1 == MaterialEnum.MaterialType.Season123EquipCard then
		var_18_0 = false
	elseif arg_18_1 == MaterialEnum.MaterialType.Equip then
		var_18_0 = var_18_1.isExpEquip and var_18_1.isExpEquip == 1
	end

	return var_18_0
end

function var_0_0.getItemCategroyShow(arg_19_0, arg_19_1)
	return arg_19_0._itemCategoryShow.configDict[arg_19_1]
end

function var_0_0.getItemConfig(arg_20_0, arg_20_1, arg_20_2)
	arg_20_1 = tonumber(arg_20_1)
	arg_20_2 = tonumber(arg_20_2)

	local var_20_0
	local var_20_1 = ItemConfigGetDefine.instance:getItemConfigFunc(arg_20_1)

	if var_20_1 then
		var_20_0 = var_20_1(arg_20_2)
	else
		var_20_0 = arg_20_0:getItemSpecialCo(arg_20_1)
	end

	return var_20_0
end

function var_0_0.isUniqueByCo(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_1 ~= MaterialEnum.MaterialType.Equip then
		return false
	end

	return arg_21_2.upperLimit and arg_21_2.upperLimit == 1
end

function var_0_0.isUniqueById(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_0:isUniqueByCo(arg_22_1, arg_22_0:getItemConfig(arg_22_1, arg_22_2))
end

function var_0_0.getRewardGroupRateInfoList(arg_23_0, arg_23_1)
	arg_23_1 = tonumber(arg_23_1)

	local var_23_0 = lua_reward.configDict[arg_23_1]
	local var_23_1 = {}
	local var_23_2 = 0

	repeat
		var_23_2 = var_23_2 + 1

		local var_23_3 = var_23_0["rewardGroup" .. var_23_2]

		if string.nilorempty(var_23_3) then
			return var_23_1
		end

		local var_23_4 = string.split(var_23_3, ":")

		if var_23_4 then
			local var_23_5 = var_23_4[1]

			DungeonConfig.instance:_calcRewardGroupRateInfoList(var_23_1, var_23_5)
		end
	until not var_23_4 or #var_23_4 == 0

	return var_23_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
