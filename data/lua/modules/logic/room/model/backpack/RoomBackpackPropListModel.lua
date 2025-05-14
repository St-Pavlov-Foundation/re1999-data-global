module("modules.logic.room.model.backpack.RoomBackpackPropListModel", package.seeall)

local var_0_0 = class("RoomBackpackPropListModel", ListScrollModel)

local function var_0_1(arg_1_0, arg_1_1)
	if not arg_1_0 or not arg_1_1 then
		return false
	end

	local var_1_0 = arg_1_0.id
	local var_1_1 = arg_1_1.id
	local var_1_2 = arg_1_0.config
	local var_1_3 = arg_1_1.config

	if var_1_2.rare ~= var_1_3.rare then
		return var_1_2.rare > var_1_3.rare
	end

	return var_1_1 < var_1_0
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

function var_0_0.setBackpackPropList(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = ItemModel.instance:getItemList() or {}

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, iter_5_1.id)
		local var_5_3 = var_5_2 and var_5_2.subType

		if ItemEnum.RoomBackpackPropSubType[var_5_3] then
			local var_5_4 = arg_5_0:_convert2PropItem(iter_5_1)

			if var_5_4 then
				table.insert(var_5_0, var_5_4)
			end
		end
	end

	table.sort(var_5_0, var_0_1)
	arg_5_0:setList(var_5_0)
end

function var_0_0._convert2PropItem(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = arg_6_1 and arg_6_1.id
	local var_6_2 = arg_6_1 and arg_6_1.quantity
	local var_6_3 = ManufactureConfig.instance:getManufactureItemListByItemId(var_6_1)[1]

	if var_6_3 then
		var_6_2 = ManufactureModel.instance:getManufactureItemCount(var_6_3)
	end

	local var_6_4 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, var_6_1)

	if var_6_1 and var_6_2 and var_6_2 > 0 and var_6_4 then
		var_6_0 = {
			type = MaterialEnum.MaterialType.Item,
			id = var_6_1,
			quantity = var_6_2,
			config = var_6_4
		}
	end

	return var_6_0
end

function var_0_0.isBackpackEmpty(arg_7_0)
	return arg_7_0:getCount() <= 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
