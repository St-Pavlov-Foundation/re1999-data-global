module("modules.logic.room.model.common.RoomReportTypeListModel", package.seeall)

local var_0_0 = class("RoomReportTypeListModel", ListScrollModel)

function var_0_0.sortFunc(arg_1_0, arg_1_1)
	return arg_1_0.id < arg_1_1.id
end

function var_0_0.initType(arg_2_0, arg_2_1)
	table.sort(arg_2_1, arg_2_0.sortFunc)
	arg_2_0:setList(arg_2_1)
end

function var_0_0.setSelectId(arg_3_0, arg_3_1)
	if arg_3_0.selectId == arg_3_1 then
		return
	end

	arg_3_0._selectId = arg_3_1

	arg_3_0:_refreshSelect()
end

function var_0_0.isSelect(arg_4_0, arg_4_1)
	return arg_4_0._selectId == arg_4_1
end

function var_0_0.getSelectId(arg_5_0)
	return arg_5_0._selectId
end

function var_0_0.clearSelect(arg_6_0)
	arg_6_0._selectId = nil
end

function var_0_0._refreshSelect(arg_7_0)
	local var_7_0 = arg_7_0:getById(arg_7_0._selectId)

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._scrollViews) do
		iter_7_1:setSelect(var_7_0)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
