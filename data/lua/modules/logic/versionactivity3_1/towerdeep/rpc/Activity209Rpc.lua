module("modules.logic.versionactivity3_1.towerdeep.rpc.Activity209Rpc", package.seeall)

local var_0_0 = class("Activity209Rpc", BaseRpc)

var_0_0.instance = var_0_0.New()

function var_0_0.sendGetAct209InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity209Module_pb.GetAct209InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGetAct209InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	TowerDeepOperActModel.instance:setMaxLayer(arg_2_2.maxLayer)
	TowerDeepOperActController.instance:dispatchEvent(TowerDeepOperActEvent.onAct209InfoGet)
end

function var_0_0.onReceiveAct209InfoPush(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= 0 then
		return
	end

	TowerDeepOperActModel.instance:setMaxLayer(arg_3_2.maxLayer)
	TowerDeepOperActController.instance:dispatchEvent(TowerDeepOperActEvent.OnAct209InfoUpdate)
end

return var_0_0
