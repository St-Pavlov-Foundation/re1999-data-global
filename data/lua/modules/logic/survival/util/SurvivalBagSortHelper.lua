module("modules.logic.survival.util.SurvivalBagSortHelper", package.seeall)

local var_0_0 = class("SurvivalBagSortHelper")

function var_0_0.sortByInDict(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_2[arg_1_0.uid] ~= arg_1_2[arg_1_1.uid] then
		return arg_1_2[arg_1_1.uid] and true or false
	end
end

function var_0_0.sortByChange(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0.co and not string.nilorempty(arg_2_0.co.exchange) or false
	local var_2_1 = arg_2_1.co and not string.nilorempty(arg_2_1.co.exchange) or false

	if var_2_0 ~= var_2_1 then
		return var_2_1
	end
end

function var_0_0.sortByMass(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.co.mass
	local var_3_1 = arg_3_1.co.mass

	if var_3_0 ~= var_3_1 then
		return var_3_0 < var_3_1
	end
end

function var_0_0.sortByWorth(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.co.worth
	local var_4_1 = arg_4_1.co.worth

	if var_4_0 ~= var_4_1 then
		return var_4_0 < var_4_1
	end
end

function var_0_0.sortByType(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.co.type
	local var_5_1 = arg_5_1.co.type

	if var_5_0 ~= var_5_1 then
		return var_5_0 < var_5_1
	end
end

local var_0_1 = {
	[SurvivalEnum.ItemType.Equip] = -3,
	[SurvivalEnum.ItemType.Material] = -2,
	[SurvivalEnum.ItemType.Quick] = -1
}

function var_0_0.sortByCustomType(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.co.type
	local var_6_1 = arg_6_1.co.type

	var_6_0 = var_0_1[var_6_0] or var_6_0
	var_6_1 = var_0_1[var_6_1] or var_6_1

	if var_6_0 ~= var_6_1 then
		return var_6_1 < var_6_0
	end
end

function var_0_0.sortByRare(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.co.rare
	local var_7_1 = arg_7_1.co.rare

	if var_7_0 ~= var_7_1 then
		return var_7_0 < var_7_1
	end
end

function var_0_0.sortById(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.co.id
	local var_8_1 = arg_8_1.co.id

	if var_8_0 ~= var_8_1 then
		return var_8_0 < var_8_1
	end
end

function var_0_0.sortByTime(arg_9_0, arg_9_1)
	local var_9_0 = tonumber(arg_9_0.uid) or 0
	local var_9_1 = tonumber(arg_9_1.uid) or 0

	if var_9_0 ~= var_9_1 then
		return var_9_0 < var_9_1
	end
end

function var_0_0.sortByEquipTag(arg_10_0, arg_10_1)
	if not arg_10_0.equipCo or not arg_10_1.equipCo then
		return
	end

	local var_10_0 = var_0_0.getFirstEquipTag(arg_10_0)
	local var_10_1 = var_0_0.getFirstEquipTag(arg_10_1)

	if var_10_0 ~= var_10_1 then
		return var_10_0 < var_10_1
	end
end

function var_0_0.sortByNPCItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:isNPCRecommendItem()

	if var_11_0 ~= arg_11_1:isNPCRecommendItem() then
		return var_11_0
	end
end

function var_0_0.getFirstEquipTag(arg_12_0)
	local var_12_0 = arg_12_0.equipCo.tag
	local var_12_1 = string.match(var_12_0, "^([0-9]+)")

	return tonumber(var_12_1) or 0
end

function var_0_0.filterItemMo(arg_13_0, arg_13_1)
	if not arg_13_1 or arg_13_1:isEmpty() then
		return false
	end

	if not next(arg_13_0) then
		return true
	end

	local var_13_0 = arg_13_1.co.type

	for iter_13_0, iter_13_1 in pairs(arg_13_0) do
		if iter_13_1.type == SurvivalEnum.ItemFilterType.Material and var_13_0 == SurvivalEnum.ItemType.Material then
			return true
		end

		if iter_13_1.type == SurvivalEnum.ItemFilterType.Equip and var_13_0 == SurvivalEnum.ItemType.Equip then
			return true
		end

		if iter_13_1.type == SurvivalEnum.ItemFilterType.Consume and var_13_0 == SurvivalEnum.ItemType.Quick then
			return true
		end
	end
end

function var_0_0.filterEquipMo(arg_14_0, arg_14_1)
	if not arg_14_1 or arg_14_1:isEmpty() or not arg_14_1.equipCo then
		return false
	end

	if not next(arg_14_0) then
		return true
	end

	local var_14_0 = string.splitToNumber(arg_14_1.equipCo.tag, "#") or {}

	for iter_14_0, iter_14_1 in pairs(arg_14_0) do
		if tabletool.indexOf(var_14_0, iter_14_1.type) then
			return true
		end
	end
end

function var_0_0.filterNpc(arg_15_0, arg_15_1)
	if not arg_15_1 or not arg_15_1.co then
		return false
	end

	if not arg_15_0 or not next(arg_15_0) then
		return true
	end

	if string.nilorempty(arg_15_1.co.tag) then
		return false
	end

	local var_15_0 = string.splitToNumber(arg_15_1.co.tag, "#")
	local var_15_1 = {}

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_2 = lua_survival_tag.configDict[iter_15_1]

		if var_15_2 then
			var_15_1[var_15_2.tagType] = true
		end
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_0) do
		if var_15_1[iter_15_3.type] then
			return true
		end
	end

	return false
end

local var_0_2 = {
	[SurvivalEnum.ItemSortType.EquipTag] = {
		var_0_0.sortByEquipTag,
		var_0_0.sortByRare,
		var_0_0.sortByWorth,
		var_0_0.sortByMass,
		var_0_0.sortByTime,
		var_0_0.sortById
	},
	[SurvivalEnum.ItemSortType.Type] = {
		var_0_0.sortByType,
		var_0_0.sortByEquipTag,
		var_0_0.sortByRare,
		var_0_0.sortByWorth,
		var_0_0.sortByMass,
		var_0_0.sortByTime,
		var_0_0.sortById
	},
	[SurvivalEnum.ItemSortType.Worth] = {
		var_0_0.sortByWorth,
		var_0_0.sortByRare,
		var_0_0.sortByType,
		var_0_0.sortByEquipTag,
		var_0_0.sortByMass,
		var_0_0.sortByTime,
		var_0_0.sortById
	},
	[SurvivalEnum.ItemSortType.Mass] = {
		var_0_0.sortByMass,
		var_0_0.sortByRare,
		var_0_0.sortByType,
		var_0_0.sortByEquipTag,
		var_0_0.sortByWorth,
		var_0_0.sortByTime,
		var_0_0.sortById
	},
	[SurvivalEnum.ItemSortType.Time] = {
		var_0_0.sortByTime,
		var_0_0.sortByType,
		var_0_0.sortByEquipTag,
		var_0_0.sortByRare,
		var_0_0.sortByWorth,
		var_0_0.sortByMass,
		var_0_0.sortById
	},
	[SurvivalEnum.ItemSortType.NPC] = {
		var_0_0.sortByTime,
		var_0_0.sortById
	},
	[SurvivalEnum.ItemSortType.Result] = {
		var_0_0.sortByChange,
		var_0_0.sortByRare,
		var_0_0.sortByType,
		var_0_0.sortById
	},
	[SurvivalEnum.ItemSortType.ItemReward] = {
		var_0_0.sortByRare,
		var_0_0.sortByCustomType,
		var_0_0.sortById
	}
}
local var_0_3
local var_0_4
local var_0_5

function var_0_0.sortItems(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	var_0_3 = var_0_2[arg_16_1]
	var_0_4 = arg_16_2
	var_0_5 = arg_16_3

	if not var_0_3 then
		return
	end

	table.sort(arg_16_0, var_0_0.sortFunc)

	var_0_3 = nil
	var_0_4 = nil
	var_0_5 = nil
end

function var_0_0.sortFunc(arg_17_0, arg_17_1)
	if var_0_5 and var_0_5.isCheckNPCItem then
		local var_17_0 = var_0_0.sortByNPCItem(arg_17_0, arg_17_1)

		if var_17_0 ~= nil then
			return var_17_0
		end
	end

	for iter_17_0, iter_17_1 in ipairs(var_0_3) do
		local var_17_1 = iter_17_1(arg_17_0, arg_17_1, var_0_5)

		if var_17_1 ~= nil then
			if var_0_4 then
				var_17_1 = not var_17_1
			end

			return var_17_1
		end
	end

	return false
end

return var_0_0
