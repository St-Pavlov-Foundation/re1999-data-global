module("modules.logic.room.model.debug.RoomDebugThemeFilterListModel", package.seeall)

local var_0_0 = class("RoomDebugThemeFilterListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	arg_4_0:_clearSelectData()
end

function var_0_0._clearSelectData(arg_5_0)
	arg_5_0._selectIdList = {}
	arg_5_0._isAll = false
end

function var_0_0.init(arg_6_0)
	arg_6_0:_clearData()

	local var_6_0 = RoomConfig.instance:getThemeConfigList()
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_2 = RoomThemeMO.New()

		var_6_2:init(iter_6_1.id, iter_6_1)
		table.insert(var_6_1, var_6_2)
	end

	table.sort(var_6_1, var_0_0.sortMOFunc)
	arg_6_0:setList(var_6_1)
end

function var_0_0.sortMOFunc(arg_7_0, arg_7_1)
	if arg_7_0.id ~= arg_7_1.id then
		return arg_7_0.id > arg_7_1.id
	end
end

function var_0_0.clearFilterData(arg_8_0)
	arg_8_0:_clearSelectData()
	arg_8_0:onModelUpdate()
end

function var_0_0.getIsAll(arg_9_0)
	return arg_9_0._isAll
end

function var_0_0.getSelectCount(arg_10_0)
	if arg_10_0._selectIdList then
		return #arg_10_0._selectIdList
	end

	return 0
end

function var_0_0.isSelectById(arg_11_0, arg_11_1)
	if arg_11_0._isAll then
		return true
	end

	if tabletool.indexOf(arg_11_0._selectIdList, arg_11_1) then
		return true
	end

	return false
end

function var_0_0.selectAll(arg_12_0)
	if arg_12_0._isAll == true then
		return
	end

	arg_12_0._selectIdList = {}

	local var_12_0 = arg_12_0:getList()

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		table.insert(arg_12_0._selectIdList, iter_12_1.id)
	end

	arg_12_0:_checkAll()
	arg_12_0:onModelUpdate()
end

function var_0_0.setSelectById(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_0:getById(arg_13_1) then
		return
	end

	if arg_13_2 == true then
		if not tabletool.indexOf(arg_13_0._selectIdList, arg_13_1) then
			table.insert(arg_13_0._selectIdList, arg_13_1)
			arg_13_0:_checkAll()
			arg_13_0:onModelUpdate()
		end
	elseif arg_13_2 == false then
		local var_13_0 = tabletool.indexOf(arg_13_0._selectIdList, arg_13_1)

		if var_13_0 then
			table.remove(arg_13_0._selectIdList, var_13_0)
			arg_13_0:_checkAll()
			arg_13_0:onModelUpdate()
		end
	end
end

function var_0_0._checkAll(arg_14_0)
	local var_14_0 = true

	if #arg_14_0:getList() > #arg_14_0._selectIdList then
		var_14_0 = false
	end

	arg_14_0._isAll = var_14_0
end

function var_0_0.checkSelectByItem(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0:getIsAll() and arg_15_0:getSelectCount() > 0 then
		local var_15_0 = RoomConfig.instance:getThemeIdByItem(arg_15_1, arg_15_2)

		if not arg_15_0:isSelectById(var_15_0) then
			return false
		end
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
