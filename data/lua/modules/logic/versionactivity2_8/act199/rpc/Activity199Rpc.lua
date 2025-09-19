module("modules.logic.versionactivity2_8.act199.rpc.Activity199Rpc", package.seeall)

local var_0_0 = class("Activity199Rpc", BaseRpc)

function var_0_0.sendGet199InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity199Module_pb.Get199InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet199InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	Activity199Model.instance:setActInfo(arg_2_2)
end

function var_0_0.sendAct199GainRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = Activity199Module_pb.Act199GainRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.heroId = arg_3_2

	arg_3_0:sendMsg(var_3_0, arg_3_3, arg_3_4)
end

function var_0_0.onReceiveAct199GainReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	local var_4_0 = arg_4_2.heroId

	Activity199Model.instance:updateHeroId(var_4_0)
	V2a8_SelfSelectSix_PickChoiceController.instance:dispatchEvent(V2a8_SelfSelectSix_PickChoiceEvent.GetHero)
end

var_0_0.instance = var_0_0.New()

return var_0_0
