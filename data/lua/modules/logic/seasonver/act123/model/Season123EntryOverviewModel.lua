module("modules.logic.seasonver.act123.model.Season123EntryOverviewModel", package.seeall)

local var_0_0 = class("Season123EntryOverviewModel", BaseModel)

function var_0_0.release(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.activityId = arg_2_1
end

function var_0_0.getActId(arg_3_0)
	return arg_3_0.activityId
end

function var_0_0.getStageMO(arg_4_0, arg_4_1)
	local var_4_0 = Season123Model.instance:getActInfo(arg_4_0.activityId)

	if not var_4_0 then
		return nil
	end

	return var_4_0:getStageMO(arg_4_1)
end

function var_0_0.stageIsPassed(arg_5_0, arg_5_1)
	local var_5_0 = Season123Model.instance:getActInfo(arg_5_0.activityId)

	if not var_5_0 then
		return false
	end

	local var_5_1 = var_5_0.stageMap[arg_5_1]

	return var_5_1 and var_5_1.isPass
end

var_0_0.instance = var_0_0.New()

return var_0_0
