module("modules.logic.activity.model.ActivityBeginnerCategoryListModel", package.seeall)

local var_0_0 = class("ActivityBeginnerCategoryListModel", ListScrollModel)

function var_0_0.setSortInfos(arg_1_0, arg_1_1)
	arg_1_0._sortInfos = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_0 = iter_1_1.co.id
		local var_1_1 = ActivityBeginnerController.instance:showRedDot(var_1_0)

		arg_1_0._sortInfos[var_1_0] = var_1_1
	end
end

function var_0_0.checkTargetCategory(arg_2_0, arg_2_1)
	if ActivityModel.instance:getCurTargetActivityCategoryId() > 0 or not arg_2_1 or #arg_2_1 <= 0 then
		return
	end

	table.sort(arg_2_1, var_0_0._sort)
	ActivityModel.instance:setTargetActivityCategoryId(arg_2_1[1].co.id)
end

function var_0_0.setCategoryList(arg_3_0, arg_3_1)
	arg_3_0._moList = arg_3_1 and arg_3_1 or {}

	table.sort(arg_3_0._moList, var_0_0._sort)
	arg_3_0:setList(arg_3_0._moList)
end

function var_0_0._sort(arg_4_0, arg_4_1)
	local var_4_0 = var_0_0.instance._sortInfos
	local var_4_1 = arg_4_0.co.id
	local var_4_2 = arg_4_1.co.id
	local var_4_3 = var_4_0[var_4_1] and arg_4_0.co.hintPriority or arg_4_0.co.defaultPriority
	local var_4_4 = var_4_0[var_4_2] and arg_4_1.co.hintPriority or arg_4_1.co.defaultPriority

	if var_4_3 == var_4_4 then
		return var_4_2 < var_4_1
	end

	return var_4_4 < var_4_3
end

function var_0_0.setOpenViewTime(arg_5_0)
	arg_5_0.openViewTime = Time.realtimeSinceStartup
end

var_0_0.instance = var_0_0.New()

return var_0_0
