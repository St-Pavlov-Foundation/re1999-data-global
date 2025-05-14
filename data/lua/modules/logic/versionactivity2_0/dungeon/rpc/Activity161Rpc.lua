module("modules.logic.versionactivity2_0.dungeon.rpc.Activity161Rpc", package.seeall)

local var_0_0 = class("Activity161Rpc", BaseRpc)

function var_0_0.sendAct161GetInfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity161Module_pb.Act161GetInfoRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveAct161GetInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		Activity161Model.instance:setGraffitiInfo(arg_2_2)
		Activity161Controller.instance:checkGraffitiCdInfo()
	end
end

function var_0_0.sendAct161RefreshElementsRequest(arg_3_0, arg_3_1)
	local var_3_0 = Activity161Module_pb.Act161RefreshElementsRequest()

	var_3_0.activityId = arg_3_1

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveAct161RefreshElementsReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		Activity161Controller.instance:dispatchEvent(Activity161Event.RefreshGraffitiView)

		if Activity161Model.instance.isNeedRefreshNewElement then
			DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnInitElements)
		end
	end
end

function var_0_0.sendAct161GainMilestoneRewardRequest(arg_5_0, arg_5_1)
	local var_5_0 = Activity161Module_pb.Act161GainMilestoneRewardRequest()

	var_5_0.activityId = arg_5_1

	return arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveAct161GainMilestoneRewardReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		Activity161Model.instance:setRewardInfo(arg_6_2)
		Activity161Controller.instance:dispatchEvent(Activity161Event.GetGraffitiReward)
	end
end

function var_0_0.onReceiveAct161CdBeginPush(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == 0 then
		Activity161Model.instance:setGraffitiInfo(arg_7_2)
		Activity161Controller.instance:checkGraffitiCdInfo()
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
