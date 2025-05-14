module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotCollectionEnchantListModel", package.seeall)

local var_0_0 = class("V1a6_CachotCollectionEnchantListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._enchantList = nil
	arg_1_0._curSelectEnchantId = nil
	arg_1_0._enchantIndexMap = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
	arg_2_0:clear()
end

function var_0_0.onInitData(arg_3_0, arg_3_1)
	arg_3_0._enchantList = arg_3_0:buildEnchantDataTab(arg_3_1)

	arg_3_0:setList(arg_3_0._enchantList)
end

function var_0_0.buildEnchantDataTab(arg_4_0, arg_4_1)
	local var_4_0 = V1a6_CachotModel.instance:getRogueInfo()
	local var_4_1 = var_4_0 and var_4_0.enchants
	local var_4_2 = {}
	local var_4_3 = var_4_1 and #var_4_1 or 0
	local var_4_4 = arg_4_0:getList()

	for iter_4_0, iter_4_1 in ipairs(var_4_4) do
		local var_4_5 = arg_4_0:getEnchantIndexById(iter_4_1.id) or iter_4_0
		local var_4_6 = var_4_1 and var_4_1[var_4_5]

		table.insert(var_4_2, var_4_6)
	end

	for iter_4_2 = #var_4_4 + 1, var_4_3 do
		table.insert(var_4_2, var_4_1[iter_4_2])
	end

	if arg_4_1 then
		table.sort(var_4_2, arg_4_0.sortFunc)
	end

	return var_4_2
end

function var_0_0.getEnchantIndexById(arg_5_0, arg_5_1)
	if not arg_5_0._enchantIndexMap then
		arg_5_0._enchantIndexMap = {}

		local var_5_0 = V1a6_CachotModel.instance:getRogueInfo()
		local var_5_1 = var_5_0 and var_5_0.enchants

		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			arg_5_0._enchantIndexMap[iter_5_1.id] = iter_5_0
		end
	end

	return arg_5_0._enchantIndexMap and arg_5_0._enchantIndexMap[arg_5_1]
end

function var_0_0.sortFunc(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:isEnchant()

	if var_6_0 ~= arg_6_1:isEnchant() then
		return not var_6_0
	end

	return arg_6_0.id > arg_6_1.id
end

function var_0_0.isEnchantEmpty(arg_7_0)
	return arg_7_0:getCount() <= 0
end

function var_0_0.selectCell(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._curSelectEnchantId

	if arg_8_1 and arg_8_1 > 0 and arg_8_2 then
		arg_8_0:selectCellInternal(arg_8_1, arg_8_2)
	else
		arg_8_0:selectCellInternal(var_8_0, false)
	end
end

function var_0_0.selectCellInternal(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getById(arg_9_1)
	local var_9_1

	if var_9_0 then
		local var_9_2 = arg_9_0:getIndex(var_9_0)

		var_0_0.super.selectCell(arg_9_0, var_9_2, arg_9_2)

		var_9_1 = arg_9_2 and var_9_0.id
	end

	arg_9_0._curSelectEnchantId = var_9_1
end

function var_0_0.getCurSelectEnchantId(arg_10_0)
	return arg_10_0._curSelectEnchantId
end

var_0_0.instance = var_0_0.New()

return var_0_0
