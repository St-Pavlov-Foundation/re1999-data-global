module("modules.logic.versionactivity1_4.act133.model.Activity133Model", package.seeall)

local var_0_0 = class("Activity133Model", BaseModel)

function var_0_0.ctor(arg_1_0)
	arg_1_0.super:ctor()

	arg_1_0.serverTaskModel = BaseModel.New()
end

function var_0_0.setActivityInfo(arg_2_0, arg_2_1)
	arg_2_0.actId = arg_2_1.activityId
	arg_2_0.hasGetBonusIds = arg_2_1.hasGetBonusIds

	arg_2_0:setTasksInfo(arg_2_1.tasks)
end

function var_0_0.getTasksInfo(arg_3_0)
	return arg_3_0.serverTaskModel:getList()
end

function var_0_0.setTasksInfo(arg_4_0, arg_4_1)
	local var_4_0

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = arg_4_0.serverTaskModel:getById(iter_4_1.id)

		if var_4_1 then
			var_4_1:update(iter_4_1)
		else
			local var_4_2 = Activity133Config.instance:getTaskCo(iter_4_1.id)

			if var_4_2 then
				local var_4_3 = TaskMo.New()

				var_4_3:init(iter_4_1, var_4_2)
				arg_4_0.serverTaskModel:addAtLast(var_4_3)
			end
		end

		var_4_0 = true
	end

	if var_4_0 then
		arg_4_0:sortList()
	end

	return var_4_0
end

function var_0_0.deleteInfo(arg_5_0, arg_5_1)
	local var_5_0 = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		local var_5_1 = arg_5_0.serverTaskModel:getById(iter_5_1)

		if var_5_1 then
			var_5_0[iter_5_1] = var_5_1
		end
	end

	for iter_5_2, iter_5_3 in pairs(var_5_0) do
		arg_5_0.serverTaskModel:remove(iter_5_3)
	end

	local var_5_2 = next(var_5_0) and true or false

	if var_5_2 then
		arg_5_0:sortList()
	end

	return var_5_2
end

function var_0_0.sortList(arg_6_0)
	arg_6_0.serverTaskModel:sort(function(arg_7_0, arg_7_1)
		local var_7_0 = arg_7_0.finishCount > 0 and 3 or arg_7_0.progress >= arg_7_0.config.maxProgress and 1 or 2
		local var_7_1 = arg_7_1.finishCount > 0 and 3 or arg_7_1.progress >= arg_7_1.config.maxProgress and 1 or 2

		if var_7_0 ~= var_7_1 then
			return var_7_0 < var_7_1
		else
			return arg_7_0.config.id < arg_7_1.config.id
		end
	end)
end

function var_0_0.checkBonusReceived(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.hasGetBonusIds) do
		if iter_8_1 == arg_8_1 then
			return true
		end
	end

	return false
end

function var_0_0.getFixedNum(arg_9_0)
	if arg_9_0.hasGetBonusIds then
		return #arg_9_0.hasGetBonusIds
	end

	return 0
end

function var_0_0.setSelectID(arg_10_0, arg_10_1)
	if not arg_10_0._selectid then
		arg_10_0._selectid = arg_10_1
	end

	arg_10_0._selectid = arg_10_1
end

function var_0_0.getSelectID(arg_11_0)
	return arg_11_0._selectid
end

var_0_0.instance = var_0_0.New()

return var_0_0
