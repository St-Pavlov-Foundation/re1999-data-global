module("modules.logic.room.model.critter.RoomCritterFoodListModel", package.seeall)

local var_0_0 = class("RoomCritterFoodListModel", ListScrollModel)

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0 and arg_1_0.id
	local var_1_1 = arg_1_1 and arg_1_1.id

	if not var_1_0 or not var_1_1 then
		return false
	end

	local var_1_2 = arg_1_0.isFavorite

	if var_1_2 ~= arg_1_1.isFavorite then
		return var_1_2
	end

	local var_1_3 = ItemModel.instance:getItemCount(var_1_0)
	local var_1_4 = ItemModel.instance:getItemCount(var_1_1)

	if var_1_3 ~= var_1_4 then
		return var_1_4 < var_1_3
	end

	local var_1_5 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, var_1_0)
	local var_1_6 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, var_1_1)

	if var_1_5.rare ~= var_1_6.rare then
		return var_1_5.rare > var_1_6.rare
	end

	return var_1_0 < var_1_1
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:clear()
	arg_2_0:clearData()
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:clearData()
end

function var_0_0.clearData(arg_4_0)
	return
end

function var_0_0.setCritterFoodList(arg_5_0, arg_5_1)
	local var_5_0 = ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.CritterFood)
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_2 = iter_5_1.id
		local var_5_3 = CritterConfig.instance:isFavoriteFood(arg_5_1, var_5_2)

		var_5_1[iter_5_0] = {
			id = var_5_2,
			isFavorite = var_5_3
		}
	end

	table.sort(var_5_1, var_0_1)
	arg_5_0:setList(var_5_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
