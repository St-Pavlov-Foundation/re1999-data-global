module("modules.logic.versionactivity.model.VersionActivity112Model", package.seeall)

local var_0_0 = class("VersionActivity112Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0.infosDic = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0._lastActId = arg_3_1.activityId
	arg_3_0.infosDic[arg_3_1.activityId] = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.infos) do
		arg_3_0.infosDic[arg_3_1.activityId][iter_3_1.id] = iter_3_1
	end

	VersionActivity112TaskListModel.instance:refreshAlllTaskInfo(arg_3_1.activityId, arg_3_1.act112Tasks)
	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112Update)
end

function var_0_0.updateRewardState(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.infosDic[arg_4_1][arg_4_2].state = 1

	VersionActivityController.instance:dispatchEvent(VersionActivityEvent.VersionActivity112Update)
end

function var_0_0.getRewardState(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.infosDic[arg_5_1] and arg_5_0.infosDic[arg_5_1][arg_5_2] then
		return arg_5_0.infosDic[arg_5_1][arg_5_2].state
	end

	return 0
end

function var_0_0.hasGetReward(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2 = arg_6_2 or arg_6_0._lastActId

	if arg_6_0.infosDic[arg_6_2] and arg_6_0.infosDic[arg_6_2][arg_6_1] then
		return arg_6_0.infosDic[arg_6_2][arg_6_1].state == 1
	end

	return false
end

function var_0_0.getRewardList(arg_7_0, arg_7_1)
	arg_7_1 = arg_7_1 or arg_7_0._lastActId

	local var_7_0 = VersionActivityConfig.instance:getAct112Config(arg_7_1)
	local var_7_1 = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		table.insert(var_7_1, iter_7_1)
	end

	return var_7_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
