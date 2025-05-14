module("modules.logic.versionactivity1_5.aizila.model.AiZiLaGamePackListModel", package.seeall)

local var_0_0 = class("AiZiLaGamePackListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	local var_1_0 = {}

	tabletool.addValues(var_1_0, AiZiLaGameModel.instance:getItemList())

	if #var_1_0 > 1 then
		table.sort(var_1_0, var_0_0.sortFunc)
	end

	arg_1_0:setList(var_1_0)
end

function var_0_0.sortFunc(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getConfig()
	local var_2_1 = arg_2_1:getConfig()

	if var_2_0.rare ~= var_2_1.rare then
		return var_2_0.rare > var_2_1.rare
	end

	local var_2_2 = arg_2_0:getQuantity()
	local var_2_3 = arg_2_1:getQuantity()

	if var_2_2 ~= var_2_3 then
		return var_2_3 < var_2_2
	end

	if arg_2_0.itemId ~= arg_2_1.itemId then
		return arg_2_0.itemId < arg_2_1.itemId
	end
end

function var_0_0._refreshSelect(arg_3_0)
	local var_3_0 = arg_3_0:getById(arg_3_0._selectItemId)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._scrollViews) do
		iter_3_1:setSelect(var_3_0)
	end
end

function var_0_0.setSelect(arg_4_0, arg_4_1)
	arg_4_0._selectItemId = arg_4_1

	arg_4_0:_refreshSelect()
end

function var_0_0.getSelect(arg_5_0)
	return arg_5_0._selectItemId
end

function var_0_0.getSelectMO(arg_6_0)
	return arg_6_0:getById(arg_6_0._selectItemId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
