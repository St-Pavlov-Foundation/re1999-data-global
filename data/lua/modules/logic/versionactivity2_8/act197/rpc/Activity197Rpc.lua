module("modules.logic.versionactivity2_8.act197.rpc.Activity197Rpc", package.seeall)

local var_0_0 = class("Activity197Rpc", BaseRpc)

function var_0_0.sendGet197InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity197Module_pb.Get197InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet197InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity197Model.instance:setActInfo(arg_2_2)
end

function var_0_0.sendAct197RummageRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity197Module_pb.Act197RummageRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.poolId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct197RummageReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.activityId
	local var_4_1 = arg_4_2.poolId
	local var_4_2 = arg_4_2.id

	Activity197Model.instance:_initCurrency()
	Activity197Model.instance:updatePool(var_4_1, var_4_2)
end

function var_0_0.sendAct197ExploreReqvest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = Activity197Module_pb.Act197ExploreRequest()

	var_5_0.activityId = arg_5_1
	var_5_0.type = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveAct197ExploreReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	Activity197Model.instance:_initCurrency()
	Activity197Controller.instance:dispatchEvent(Activity197Event.onReceiveAct197Explore)
end

var_0_0.instance = var_0_0.New()

return var_0_0
