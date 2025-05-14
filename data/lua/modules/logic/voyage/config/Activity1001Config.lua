module("modules.logic.voyage.config.Activity1001Config", package.seeall)

local var_0_0 = class("Activity1001Config", BaseConfig)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.__activityId = arg_1_1
end

function var_0_0.checkActivityId(arg_2_0, arg_2_1)
	return arg_2_0.__activityId == arg_2_1
end

function var_0_0.getActivityId(arg_3_0)
	return arg_3_0.__activityId
end

function var_0_0.reqConfigNames(arg_4_0)
	return {
		"activity1001",
		"activity1001_ext",
		"mail"
	}
end

local function var_0_1(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_2 then
		return lua_activity1001_ext.configDict[arg_5_0][arg_5_1]
	end

	local var_5_0 = lua_activity1001_ext.configDict[arg_5_0]

	return var_5_0 and var_5_0[arg_5_1] or nil
end

local function var_0_2(arg_6_0, arg_6_1)
	return lua_activity1001.configDict[arg_6_0][arg_6_1]
end

function var_0_0.getCO(arg_7_0, arg_7_1)
	return var_0_1(arg_7_0.__activityId, arg_7_1, true) or var_0_2(arg_7_0.__activityId, arg_7_1)
end

function var_0_0.getRewardStr(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getCO(arg_8_1)

	if var_8_0.mailId then
		return lua_mail.configDict[var_8_0.mailId].attachment
	else
		return var_8_0.rewards
	end
end

function var_0_0.getTitle(arg_9_0)
	local var_9_0 = lua_activity1001_ext.configDict[arg_9_0.__activityId]

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if not string.nilorempty(iter_9_1.title) then
			return iter_9_1.title
		end
	end

	return ""
end

function var_0_0._createOrGetShowTaskList(arg_10_0)
	if arg_10_0.__taskList then
		return arg_10_0.__taskList
	end

	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(lua_activity1001.configList) do
		if iter_10_1.activityId == arg_10_0.__activityId then
			table.insert(var_10_0, iter_10_1)
		end
	end

	for iter_10_2, iter_10_3 in ipairs(lua_activity1001_ext.configList) do
		if iter_10_3.activityId == arg_10_0.__activityId then
			table.insert(var_10_0, iter_10_3)
		end
	end

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		if arg_11_0.sort ~= arg_11_1.sort then
			return arg_11_0.sort < arg_11_1.sort
		end

		return arg_11_0.id < arg_11_1.id
	end)

	arg_10_0.__taskList = var_10_0

	return var_10_0
end

return var_0_0
