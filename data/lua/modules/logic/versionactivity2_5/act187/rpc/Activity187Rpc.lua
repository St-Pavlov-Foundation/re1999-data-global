module("modules.logic.versionactivity2_5.act187.rpc.Activity187Rpc", package.seeall)

local var_0_0 = class("Activity187Rpc", BaseRpc)

function var_0_0.sendGet187InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity187Module_pb.Get187InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet187InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	if not Activity187Model.instance:checkActId(arg_2_2.activityId) then
		return
	end

	Activity187Model.instance:setAct187Info(arg_2_2)
	Activity187Controller.instance:dispatchEvent(Activity187Event.GetAct187Info)
end

function var_0_0.sendAct187FinishGameRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = Activity187Module_pb.Act187FinishGameRequest()

	var_3_0.activityId = arg_3_1

	arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveAct187FinishGameReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	if not Activity187Model.instance:checkActId(arg_4_2.activityId) then
		return
	end

	Activity187Model.instance:setRemainPaintingCount(arg_4_2.haveGameCount)
	Activity187Model.instance:setFinishPaintingIndex(arg_4_2.finishGameCount)
	Activity187Model.instance:setPaintingRewardList(arg_4_2.finishGameCount, arg_4_2.randomBonusList)
	Activity187Controller.instance:dispatchEvent(Activity187Event.FinishPainting, arg_4_2.finishGameCount)
end

function var_0_0.sendAct187AcceptRewardRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = Activity187Module_pb.Act187AcceptRewardRequest()

	var_5_0.activityId = arg_5_1

	arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveAct187AcceptRewardReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	if not Activity187Model.instance:checkActId(arg_6_2.activityId) then
		return
	end

	local var_6_0 = MaterialRpc.receiveMaterial({
		dataList = arg_6_2.fixBonusList
	})

	Activity187Controller.instance:dispatchEvent(Activity187Event.GetAccrueReward, var_6_0)
	Activity187Model.instance:setAccrueRewardIndex(arg_6_2.acceptRewardGameCount)
	Activity187Controller.instance:dispatchEvent(Activity187Event.RefreshAccrueReward)
end

var_0_0.instance = var_0_0.New()

return var_0_0
