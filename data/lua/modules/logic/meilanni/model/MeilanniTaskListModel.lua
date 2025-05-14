module("modules.logic.meilanni.model.MeilanniTaskListModel", package.seeall)

local var_0_0 = class("MeilanniTaskListModel", ListScrollModel)

function var_0_0.setTaskRewardList(arg_1_0, arg_1_1)
	arg_1_0._rewardList = arg_1_1
end

function var_0_0.getTaskRewardList(arg_2_0)
	return arg_2_0._rewardList
end

function var_0_0.showTaskList(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = false

	for iter_3_0, iter_3_1 in ipairs(lua_activity108_grade.configList) do
		local var_3_2, var_3_3 = var_0_0._getTaskStatus(iter_3_1)

		if var_3_2 == 0 and var_3_3 == 0 then
			var_3_1 = true
		end

		table.insert(var_3_0, iter_3_1)
	end

	table.sort(var_3_0, var_0_0._sort)

	if var_3_1 then
		table.insert(var_3_0, 1, {
			id = 0,
			isGetAll = true
		})
	end

	arg_3_0:setList(var_3_0)
end

function var_0_0._sort(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = var_0_0._getTaskStatus(arg_4_0)
	local var_4_2, var_4_3 = var_0_0._getTaskStatus(arg_4_1)

	if var_4_0 ~= var_4_2 then
		return var_4_0 < var_4_2
	end

	if var_4_1 ~= var_4_3 then
		return var_4_1 < var_4_3
	end

	return arg_4_0.id < arg_4_1.id
end

function var_0_0._getTaskStatus(arg_5_0)
	local var_5_0, var_5_1 = var_0_0.getTaskStatus(arg_5_0)

	return var_5_0 and 1 or 0, var_5_1 and 0 or 1
end

function var_0_0.getTaskStatus(arg_6_0)
	local var_6_0 = MeilanniModel.instance:getMapInfo(arg_6_0.mapId)
	local var_6_1 = var_6_0 and var_6_0:getMaxScore() or 0
	local var_6_2 = arg_6_0.score
	local var_6_3 = var_6_0 and var_6_0:isGetReward(arg_6_0.id)
	local var_6_4 = var_6_2 <= var_6_1

	return var_6_3, var_6_4
end

var_0_0.instance = var_0_0.New()

return var_0_0
