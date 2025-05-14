module("modules.logic.versionactivity2_5.challenge.model.Act183ReportListModel", package.seeall)

local var_0_0 = class("Act183ReportListModel", MixScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._activityId = arg_1_1

	table.sort(arg_1_2, arg_1_0._recordSortFunc)
	arg_1_0:setList(arg_1_2)
end

function var_0_0._recordSortFunc(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getFinishedTime()
	local var_2_1 = arg_2_1:getFinishedTime()

	if var_2_0 ~= var_2_1 then
		return var_2_1 < var_2_0
	end

	return arg_2_0:getGroupId() < arg_2_1:getGroupId()
end

function var_0_0.getActivityId(arg_3_0)
	return arg_3_0._activityId
end

var_0_0.instance = var_0_0.New()

return var_0_0
