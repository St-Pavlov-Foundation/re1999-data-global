module("modules.logic.season.model.Activity104EquipCountModel", package.seeall)

local var_0_0 = class("Activity104EquipCountModel", BaseModel)

var_0_0.DefaultId = -1

function var_0_0.clear(arg_1_0)
	arg_1_0._desc2IdMap = nil
	arg_1_0._optionsList = nil
	arg_1_0._curId = nil
	arg_1_0._itemCountDict = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._curId = var_0_0.DefaultId
	arg_2_0.activityId = arg_2_1
end

function var_0_0.refreshData(arg_3_0, arg_3_1)
	arg_3_0._index2IdMap = {}
	arg_3_0._optionsList = {}

	local var_3_0 = {}

	if arg_3_1 then
		for iter_3_0, iter_3_1 in pairs(arg_3_1) do
			if not var_3_0[iter_3_1.itemId] then
				var_3_0[iter_3_1.itemId] = 0
			end

			var_3_0[iter_3_1.itemId] = var_3_0[iter_3_1.itemId] + 1
		end
	end

	arg_3_0._itemCountDict = var_3_0

	local var_3_1 = {}

	for iter_3_2, iter_3_3 in pairs(var_3_0) do
		if not var_3_1[iter_3_3] then
			var_3_1[iter_3_3] = {}
		end

		var_3_1[iter_3_3][iter_3_2] = true
	end

	local var_3_2 = {}

	for iter_3_4, iter_3_5 in pairs(var_3_1) do
		table.insert(var_3_2, iter_3_4)
	end

	table.sort(var_3_2, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)

	local var_3_3 = 0

	for iter_3_6 = 4, 1, -1 do
		local var_3_4 = iter_3_6

		arg_3_0._index2IdMap[var_3_3] = var_3_4

		table.insert(arg_3_0._optionsList, arg_3_0:getOptionTxt(var_3_4))

		var_3_3 = var_3_3 + 1
	end

	local var_3_5 = var_0_0.DefaultId
	local var_3_6 = arg_3_0:getOptionTxt(var_3_5)

	arg_3_0._index2IdMap[var_3_3] = var_3_5

	table.insert(arg_3_0._optionsList, var_3_6)
end

function var_0_0.getOptionTxt(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == var_0_0.DefaultId then
		return luaLang("common_all")
	end

	local var_5_0 = tostring(arg_5_1)

	if arg_5_2 then
		var_5_0 = string.format("<color=%s>%s</color>", arg_5_2, var_5_0)
	end

	return formatLuaLang("season104_compose_filter_txt", var_5_0)
end

function var_0_0.getOptions(arg_6_0)
	return arg_6_0._optionsList
end

function var_0_0.getSelectIdByIndex(arg_7_0, arg_7_1)
	return arg_7_0._index2IdMap[arg_7_1]
end

function var_0_0.isCardNeedShow(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._curId == var_0_0.DefaultId or not arg_8_0._curId then
		return true
	end

	return arg_8_2 < (arg_8_0._itemCountDict[arg_8_1] or 0) - arg_8_0._curId
end

function var_0_0.selectIndex(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getSelectIdByIndex(arg_9_1)

	if var_9_0 ~= nil then
		arg_9_0._curId = var_9_0
	end
end

function var_0_0.getCurId(arg_10_0)
	return arg_10_0._curId
end

return var_0_0
