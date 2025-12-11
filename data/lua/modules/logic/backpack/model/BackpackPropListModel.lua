module("modules.logic.backpack.model.BackpackPropListModel", package.seeall)

local var_0_0 = class("BackpackPropListModel", ListScrollModel)

function var_0_0.setCategoryPropItemList(arg_1_0, arg_1_1)
	local var_1_0 = {}
	local var_1_1 = 1

	if not arg_1_1 then
		arg_1_0:setList(var_1_0)
	end

	table.sort(arg_1_1, var_0_0._sortProp)

	local function var_1_2(arg_2_0)
		local var_2_0 = {
			id = var_1_1,
			config = arg_2_0
		}

		var_1_1 = var_1_1 + 1

		table.insert(var_1_0, var_2_0)
	end

	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		if iter_1_1.isShow == 1 and iter_1_1.isStackable == 1 then
			var_1_2(iter_1_1)
		end

		if iter_1_1.isShow == 1 and iter_1_1.isStackable == 0 then
			for iter_1_2 = 1, iter_1_1.quantity do
				var_1_2(iter_1_1)
			end
		end
	end

	arg_1_0:setList(var_1_0)
end

function var_0_0.clearList(arg_3_0)
	arg_3_0:clear()
end

function var_0_0._sortProp(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.type

	if var_4_0 == MaterialEnum.MaterialType.Currency then
		var_4_0 = -3
	elseif var_4_0 == MaterialEnum.MaterialType.NewInsight then
		var_4_0 = -2
	elseif var_4_0 == MaterialEnum.MaterialType.PowerPotion then
		var_4_0 = -1

		if arg_4_0.id ~= arg_4_1.id and arg_4_0.id == MaterialEnum.PowerId.OverflowPowerId then
			return false
		end
	end

	local var_4_1 = arg_4_1.type

	if var_4_1 == MaterialEnum.MaterialType.Currency then
		var_4_1 = -3
	elseif var_4_1 == MaterialEnum.MaterialType.NewInsight then
		var_4_1 = -2
	elseif var_4_1 == MaterialEnum.MaterialType.PowerPotion then
		var_4_1 = -1

		if arg_4_0.id ~= arg_4_1.id and arg_4_1.id == MaterialEnum.PowerId.OverflowPowerId then
			return true
		end
	end

	if var_4_0 ~= var_4_1 then
		return var_4_0 < var_4_1
	end

	local var_4_2 = arg_4_0:itemExpireTime()
	local var_4_3 = arg_4_1:itemExpireTime()

	if var_4_2 ~= var_4_3 then
		if var_4_3 == -1 or var_4_2 == -1 then
			return var_4_3 < var_4_2
		else
			return var_4_2 < var_4_3
		end
	end

	local var_4_4 = var_0_0._getSubTypeUseType(arg_4_0.subType)
	local var_4_5 = var_0_0._getSubTypeUseType(arg_4_1.subType)

	if var_4_4 ~= var_4_5 then
		return var_4_5 < var_4_4
	end

	local var_4_6 = ItemModel.instance:getItemConfig(arg_4_0.type, arg_4_0.id)
	local var_4_7 = ItemModel.instance:getItemConfig(arg_4_1.type, arg_4_1.id)

	if var_4_6.subType ~= var_4_7.subType then
		return var_0_0._getSubclassPriority(var_4_6.subType) < var_0_0._getSubclassPriority(var_4_7.subType)
	elseif var_4_6.rare ~= var_4_7.rare then
		return var_4_6.rare > var_4_7.rare
	elseif arg_4_0.id ~= arg_4_1.id then
		return arg_4_0.id > arg_4_1.id
	end
end

function var_0_0._getSubclassPriority(arg_5_0)
	local var_5_0 = BackpackConfig.instance:getSubclassCo()

	if not var_5_0[arg_5_0] then
		return 0
	end

	return var_5_0[arg_5_0].priority
end

function var_0_0._getSubTypeUseType(arg_6_0)
	local var_6_0 = lua_item_use.configDict[arg_6_0]

	if not var_6_0 then
		return 0
	end

	return var_6_0.useType or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
