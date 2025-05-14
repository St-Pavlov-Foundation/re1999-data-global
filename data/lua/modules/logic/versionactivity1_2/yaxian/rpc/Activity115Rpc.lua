module("modules.logic.versionactivity1_2.yaxian.rpc.Activity115Rpc", package.seeall)

local var_0_0 = class("Activity115Rpc", BaseRpc)

function var_0_0.sendGetAct115InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity115Module_pb.GetAct115InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct115InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		YaXianModel.instance:updateInfo(arg_2_2)
	end
end

function var_0_0.sendAct115StartEpisodeRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity115Module_pb.Act115StartEpisodeRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.id = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct115StartEpisodeReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		YaXianGameController.instance:initMapByMapMsg(arg_4_2.activityId, arg_4_2.map)
	end
end

function var_0_0.sendAct115BeginRoundRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity115Module_pb.Act115BeginRoundRequest()

	var_5_0.activityId = arg_5_1

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		local var_5_1 = var_5_0.operations:add()

		var_5_1.id = iter_5_1.id
		var_5_1.moveDirection = iter_5_1.dir
	end

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct115BeginRoundReply(arg_6_0, arg_6_1, arg_6_2)
	return
end

function var_0_0.onReceiveAct115StepPush(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 and YaXianGameEnum.ActivityId == arg_7_2.activityId then
		local var_7_0 = YaXianGameController.instance.stepMgr

		if var_7_0 then
			var_7_0:insertStepList(arg_7_2.steps)
		end
	end
end

function var_0_0.sendAct115EventEndRequest(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = Activity115Module_pb.Act115EventEndRequest()

	var_8_0.activityId = arg_8_1

	arg_8_0:sendMsg(var_8_0, arg_8_2, arg_8_3)
end

function var_0_0.onReceiveAct115EventEndReply(arg_9_0, arg_9_1, arg_9_2)
	return
end

function var_0_0.sendAct115AbortRequest(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = Activity115Module_pb.Act115AbortRequest()

	var_10_0.activityId = arg_10_1

	arg_10_0:sendMsg(var_10_0, arg_10_2, arg_10_3)
end

function var_0_0.onReceiveAct115AbortReply(arg_11_0)
	return
end

function var_0_0.sendAct115BonusRequest(arg_12_0, arg_12_1)
	local var_12_0 = Activity115Module_pb.Act115BonusRequest()

	var_12_0.activityId = arg_12_1 or YaXianEnum.ActivityId

	arg_12_0:sendMsg(var_12_0)
end

function var_0_0.onReceiveAct115BonusReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		YaXianModel.instance:updateGetBonusId(arg_13_2.hasGetBonusIds)
	end
end

function var_0_0.sendAct115UseSkillRequest(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = Activity115Module_pb.Act115UseSkillRequest()

	var_14_0.activityId = arg_14_1
	var_14_0.skillId = arg_14_2

	arg_14_0:sendMsg(var_14_0, arg_14_3, arg_14_4)
end

function var_0_0.onReceiveAct115UseSkillReply(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1 == 0 then
		local var_15_0 = cjson.decode(arg_15_2.interactObject.data)

		if YaXianGameModel.instance:updateSkillInfoAndCheckHasChange(var_15_0.skills) then
			YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateSkillInfo)
		end

		if YaXianGameModel.instance:updateEffectsAndCheckHasChange(var_15_0.effects) then
			YaXianGameController.instance:dispatchEvent(YaXianEvent.OnUpdateEffectInfo)
		end
	end
end

function var_0_0.sendAct115RevertRequest(arg_16_0, arg_16_1)
	local var_16_0 = Activity115Module_pb.Act115RevertRequest()

	var_16_0.activityId = arg_16_1

	arg_16_0:sendMsg(var_16_0)
end

function var_0_0.onReceiveAct115RevertReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		YaXianGameModel.instance:initServerDataByServerData(arg_17_2.map)
		YaXianGameController.instance.state:setCurEvent(arg_17_2.map.currentEvent)
		YaXianGameController.instance:stopRunningStep()
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnRevert)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
