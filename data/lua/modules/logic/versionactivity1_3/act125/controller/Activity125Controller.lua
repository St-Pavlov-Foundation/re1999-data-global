module("modules.logic.versionactivity1_3.act125.controller.Activity125Controller", package.seeall)

local var_0_0 = class("Activity125Controller", BaseController)

function var_0_0.getAct125InfoFromServer(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or ActivityEnum.Activity.VersionActivity1_3Radio

	if ActivityModel.instance:isActOnLine(arg_1_1) then
		local var_1_0 = ActivityModel.instance:getRemainTimeSec(arg_1_1)

		if var_1_0 and var_1_0 > 0 then
			Activity125Rpc.instance:sendGetAct125InfosRequest(arg_1_1)
		end
	end
end

function var_0_0.onFinishActEpisode(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	Activity125Rpc.instance:sendFinishAct125EpisodeRequest(arg_2_1, arg_2_2, arg_2_3)
end

function var_0_0.isActFirstEnterToday(arg_3_0, arg_3_1)
	local var_3_0 = string.format("%s#%s#", PlayerPrefsKey.FirstEnterAct125Today, arg_3_1, PlayerModel.instance:getPlayinfo().userId)
	local var_3_1 = TimeUtil.timestampToString1(ServerTime.now() - 18000)

	return PlayerPrefsHelper.getString(var_3_0) ~= var_3_1
end

function var_0_0.saveEnterActDateInfo(arg_4_0, arg_4_1)
	local var_4_0 = string.format("%s#%s#", PlayerPrefsKey.FirstEnterAct125Today, arg_4_1, PlayerModel.instance:getPlayinfo().userId)
	local var_4_1 = TimeUtil.timestampToString1(ServerTime.now() - 18000)

	PlayerPrefsHelper.setString(var_4_0, var_4_1)
end

function var_0_0.checkActRed(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:isActFirstEnterToday(arg_5_1)
	local var_5_1 = Activity125Model.instance:isAllEpisodeFinish(arg_5_1)
	local var_5_2 = Activity125Model.instance:isHasEpisodeCanReceiveReward(arg_5_1)

	return not var_5_1 and (var_5_0 or var_5_2)
end

function var_0_0.checkActRed1(arg_6_0, arg_6_1)
	local var_6_0 = Activity125Model.instance:hasEpisodeCanCheck(arg_6_1)
	local var_6_1 = Activity125Model.instance:hasEpisodeCanGetReward(arg_6_1)

	return var_6_0 or var_6_1
end

function var_0_0.checkActRed2(arg_7_0, arg_7_1)
	return (Activity125Model.instance:hasRedDot(arg_7_1))
end

function var_0_0.sendGetTaskInfoRequest(arg_8_0, arg_8_1, arg_8_2)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity125
	}, arg_8_1, arg_8_2)
end

function var_0_0.sendFinishAllTaskRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity125, nil, nil, arg_9_2, arg_9_3, arg_9_1)
end

local var_0_1 = PlayerEnum.SimpleProperty.V2a4_WarmUp_sum_help_npc

function var_0_0.set_V2a4_WarmUp_sum_help_npc(arg_10_0, arg_10_1)
	arg_10_1 = arg_10_1 or 0

	local var_10_0 = tostring(arg_10_1)

	PlayerModel.instance:forceSetSimpleProperty(var_0_1, var_10_0)
	PlayerRpc.instance:sendSetSimplePropertyRequest(var_0_1, var_10_0)
end

function var_0_0.get_V2a4_WarmUp_sum_help_npc(arg_11_0, arg_11_1)
	arg_11_1 = arg_11_1 or 0

	local var_11_0 = PlayerModel.instance:getSimpleProperty(var_0_1)

	return tonumber(var_11_0) or arg_11_1
end

function var_0_0.checkRed_Task(arg_12_0)
	local var_12_0 = RedDotEnum.DotNode.Activity125Task

	return RedDotModel.instance:isDotShow(var_12_0, 0)
end

function var_0_0.checkActRed3(arg_13_0, arg_13_1)
	if ActivityBeginnerController.instance:checkRedDot(arg_13_1) then
		return true
	end

	if arg_13_0:checkActRed2(arg_13_1) then
		return true
	end

	return arg_13_0:checkRed_Task()
end

var_0_0.instance = var_0_0.New()

return var_0_0
