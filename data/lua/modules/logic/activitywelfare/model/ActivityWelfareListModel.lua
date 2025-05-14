module("modules.logic.activitywelfare.model.ActivityWelfareListModel", package.seeall)

local var_0_0 = class("ActivityWelfareListModel", ListScrollModel)

function var_0_0.setCategoryList(arg_1_0, arg_1_1)
	arg_1_0._moList = arg_1_1 and arg_1_1 or {}

	table.sort(arg_1_0._moList, var_0_0._sort)
	arg_1_0:setList(arg_1_0._moList)
	arg_1_0.checkTargetCategory(arg_1_0._moList)
end

function var_0_0.checkTargetCategory(arg_2_0)
	if ActivityModel.instance:getCurTargetActivityCategoryId() > 0 or not arg_2_0 or #arg_2_0 <= 0 then
		return
	end

	table.sort(arg_2_0, var_0_0._sort)
	ActivityModel.instance:setTargetActivityCategoryId(arg_2_0[1].co.id)
end

function var_0_0._sort(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.co.id
	local var_3_1 = arg_3_1.co.id
	local var_3_2 = arg_3_0.co.defaultPriority
	local var_3_3 = arg_3_1.co.defaultPriority

	if var_3_2 == var_3_3 then
		return var_3_1 < var_3_0
	end

	return var_3_3 < var_3_2
end

function var_0_0.setOpenViewTime(arg_4_0)
	arg_4_0.openViewTime = Time.realtimeSinceStartup
end

var_0_0.instance = var_0_0.New()

return var_0_0
