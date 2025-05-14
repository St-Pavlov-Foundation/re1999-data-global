module("modules.logic.seasonver.act123.model.Season123EquipTagModel", package.seeall)

local var_0_0 = class("Season123EquipTagModel", BaseModel)

var_0_0.NoTagId = -1

function var_0_0.clear(arg_1_0)
	arg_1_0._desc2IdMap = nil
	arg_1_0._optionsList = nil
	arg_1_0._curTag = nil
	arg_1_0._curTagStr = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._curTag = var_0_0.NoTagId
	arg_2_0._curTagStr = tostring(arg_2_0._curTag)
	arg_2_0.activityId = arg_2_1

	arg_2_0:initConfig()
end

function var_0_0.initConfig(arg_3_0)
	local var_3_0 = Season123Model.instance:getCurSeasonId()

	if not var_3_0 then
		return
	end

	local var_3_1 = Season123Config.instance:getSeasonTagDesc(var_3_0)

	arg_3_0._index2IdMap = {}
	arg_3_0._optionsList = {}

	local var_3_2 = luaLang("common_all")

	arg_3_0._index2IdMap[0] = var_0_0.NoTagId

	table.insert(arg_3_0._optionsList, var_3_2)

	local var_3_3 = {}

	if var_3_1 then
		for iter_3_0, iter_3_1 in pairs(var_3_1) do
			table.insert(var_3_3, iter_3_1)
		end
	end

	table.sort(var_3_3, function(arg_4_0, arg_4_1)
		return arg_4_0.order < arg_4_1.order
	end)

	local var_3_4 = 1

	for iter_3_2, iter_3_3 in ipairs(var_3_3) do
		arg_3_0._index2IdMap[var_3_4] = iter_3_3.id

		table.insert(arg_3_0._optionsList, iter_3_3.desc)

		var_3_4 = var_3_4 + 1
	end
end

function var_0_0.getOptions(arg_5_0)
	return arg_5_0._optionsList
end

function var_0_0.getSelectIdByIndex(arg_6_0, arg_6_1)
	return arg_6_0._index2IdMap[arg_6_1]
end

function var_0_0.isCardNeedShow(arg_7_0, arg_7_1)
	if arg_7_0._curTag == var_0_0.NoTagId or not arg_7_0._curTag then
		return true
	end

	local var_7_0 = string.split(arg_7_1, "#")

	for iter_7_0, iter_7_1 in pairs(var_7_0) do
		if arg_7_0._curTagStr == iter_7_1 then
			return true
		end
	end

	return false
end

function var_0_0.selectTagIndex(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getSelectIdByIndex(arg_8_1)

	if var_8_0 ~= nil then
		arg_8_0._curTag = var_8_0
		arg_8_0._curTagStr = tostring(arg_8_0._curTag)
	else
		logNormal("tagIndex = " .. tostring(arg_8_1) .. " not found!")
	end
end

function var_0_0.getCurTagId(arg_9_0)
	return arg_9_0._curTag
end

return var_0_0
