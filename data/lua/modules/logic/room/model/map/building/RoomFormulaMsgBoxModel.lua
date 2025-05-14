module("modules.logic.room.model.map.building.RoomFormulaMsgBoxModel", package.seeall)

local var_0_0 = class("RoomFormulaMsgBoxModel", ListScrollModel)

function var_0_0.setCostItemList(arg_1_0, arg_1_1)
	table.sort(arg_1_1, function(arg_2_0, arg_2_1)
		if arg_2_0.type ~= arg_2_1.type then
			return arg_2_1.type == MaterialEnum.MaterialType.Currency
		end

		local var_2_0 = ItemModel.instance:getItemConfig(arg_2_0.type, arg_2_0.id)
		local var_2_1 = ItemModel.instance:getItemConfig(arg_2_1.type, arg_2_1.id)

		if var_2_0.rare ~= var_2_1.rare then
			return var_2_0.rare > var_2_1.rare
		elseif arg_2_0.id ~= arg_2_1.id then
			return arg_2_0.id < arg_2_1.id
		end
	end)
	arg_1_0:setList(arg_1_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
