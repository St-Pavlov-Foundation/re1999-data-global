module("modules.logic.room.model.common.RoomThemeItemListModel", package.seeall)

local var_0_0 = class("RoomThemeItemListModel", ListScrollModel)

var_0_0.SwitchType = {
	Source = 2,
	Collect = 1
}

function var_0_0.setItemShowType(arg_1_0, arg_1_1)
	arg_1_0._showType = arg_1_1

	arg_1_0:onModelUpdate()
end

function var_0_0.getItemShowType(arg_2_0)
	return arg_2_0._showType or var_0_0.SwitchType.Collect
end

function var_0_0.setThemeId(arg_3_0, arg_3_1)
	local var_3_0 = RoomModel.instance:getThemeItemMOListById(arg_3_1)
	local var_3_1 = {}

	tabletool.addValues(var_3_1, var_3_0)
	table.sort(var_3_1, var_0_0.sortMOFunc)
	arg_3_0:setList(var_3_1)
	arg_3_0:onModelUpdate()
end

function var_0_0.sortMOFunc(arg_4_0, arg_4_1)
	local var_4_0 = var_0_0._getFinishIndex(arg_4_0)
	local var_4_1 = var_0_0._getFinishIndex(arg_4_1)

	if var_4_0 ~= var_4_1 then
		return var_4_0 < var_4_1
	end

	local var_4_2 = var_0_0._getTypeIndex(arg_4_0.materialType)
	local var_4_3 = var_0_0._getTypeIndex(arg_4_1.materialType)

	if var_4_2 ~= var_4_3 then
		return var_4_2 < var_4_3
	end

	if arg_4_0.id ~= arg_4_1.id then
		return arg_4_0.id < arg_4_1.id
	end
end

function var_0_0._getSourcesTypeIndex(arg_5_0)
	local var_5_0 = arg_5_0:getItemConfig()

	if var_5_0 and not string.nilorempty(var_5_0.sourcesType) then
		local var_5_1 = string.splitToNumber(var_5_0.sourcesType, "#")
		local var_5_2 = 9999

		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			local var_5_3 = RoomConfig.instance:getSourcesTypeConfig(iter_5_1)

			if var_5_3 and var_5_2 > var_5_3.order then
				var_5_2 = var_5_3.order
			end
		end

		return var_5_2
	end

	return 99999
end

function var_0_0._getTypeIndex(arg_6_0)
	if arg_6_0 == MaterialEnum.MaterialType.BlockPackage then
		return 1
	elseif arg_6_0 == MaterialEnum.MaterialType.Building then
		return 2
	end

	return 99999
end

function var_0_0._getFinishIndex(arg_7_0)
	if arg_7_0:getItemQuantity() < arg_7_0.itemNum then
		return 1
	end

	return 99999
end

var_0_0.instance = var_0_0.New()

return var_0_0
