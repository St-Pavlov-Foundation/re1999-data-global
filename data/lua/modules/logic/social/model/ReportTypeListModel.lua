module("modules.logic.social.model.ReportTypeListModel", package.seeall)

local var_0_0 = class("ReportTypeListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.reportTypeList = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.reportTypeList = {}
end

function var_0_0.sortFunc(arg_3_0, arg_3_1)
	return arg_3_0.id < arg_3_1.id
end

function var_0_0.initType(arg_4_0, arg_4_1)
	local var_4_0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = {
			id = iter_4_1.id,
			desc = iter_4_1.desc
		}

		table.insert(arg_4_0.reportTypeList, var_4_1)
	end

	table.sort(arg_4_1, arg_4_0.sortFunc)
end

function var_0_0.initDone(arg_5_0)
	return arg_5_0.reportTypeList and #arg_5_0.reportTypeList > 0
end

function var_0_0.refreshData(arg_6_0)
	arg_6_0:setList(arg_6_0.reportTypeList)
end

function var_0_0.setSelectReportItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.selectReportItem

	if arg_7_0:isSelect(arg_7_1) then
		arg_7_0.selectReportItem = nil
	else
		arg_7_0.selectReportItem = arg_7_1
	end

	if var_7_0 then
		var_7_0:refreshSelect()
	end

	arg_7_1:refreshSelect()
end

function var_0_0.isSelect(arg_8_0, arg_8_1)
	return arg_8_0.selectReportItem and arg_8_0.selectReportItem:getMo().id == arg_8_1:getMo().id
end

function var_0_0.getSelectReportId(arg_9_0)
	return arg_9_0.selectReportItem and arg_9_0.selectReportItem:getMo().id
end

function var_0_0.clearSelectReportItem(arg_10_0)
	arg_10_0.selectReportItem = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
