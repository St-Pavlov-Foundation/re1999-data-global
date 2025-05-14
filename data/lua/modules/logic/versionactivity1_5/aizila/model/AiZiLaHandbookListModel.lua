module("modules.logic.versionactivity1_5.aizila.model.AiZiLaHandbookListModel", package.seeall)

local var_0_0 = class("AiZiLaHandbookListModel", ListScrollModel)

function var_0_0.init(arg_1_0)
	local var_1_0 = {}

	tabletool.addValues(var_1_0, AiZiLaModel.instance:getHandbookMOList())
	table.sort(var_1_0, var_0_0.sortFunc)
	arg_1_0:setList(var_1_0)
end

function var_0_0.sortFunc(arg_2_0, arg_2_1)
	local var_2_0 = var_0_0.getSortIdx(arg_2_0)
	local var_2_1 = var_0_0.getSortIdx(arg_2_1)

	if var_2_0 ~= var_2_1 then
		return var_2_0 < var_2_1
	end

	local var_2_2 = arg_2_0:getConfig()
	local var_2_3 = arg_2_1:getConfig()

	if var_2_2.rare ~= var_2_3.rare then
		return var_2_2.rare > var_2_3.rare
	end

	if arg_2_0.itemId ~= arg_2_1.itemId then
		return arg_2_0.itemId < arg_2_1.itemId
	end
end

function var_0_0.getSortIdx(arg_3_0)
	if AiZiLaModel.instance:isCollectItemId(arg_3_0.itemId) then
		if arg_3_0:getQuantity() > 0 then
			return 1
		end

		return 10
	end

	return 100
end

function var_0_0._refreshSelect(arg_4_0)
	local var_4_0 = arg_4_0:getById(arg_4_0._selectItemId)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._scrollViews) do
		iter_4_1:setSelect(var_4_0)
	end
end

function var_0_0.setSelect(arg_5_0, arg_5_1)
	arg_5_0._selectItemId = arg_5_1

	arg_5_0:_refreshSelect()
end

function var_0_0.getSelect(arg_6_0)
	return arg_6_0._selectItemId
end

function var_0_0.getSelectMO(arg_7_0)
	return arg_7_0:getById(arg_7_0._selectItemId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
