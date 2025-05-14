module("modules.logic.signin.rpc.SignInRpc", package.seeall)

local var_0_0 = class("SignInRpc", BaseRpc)

function var_0_0.sendGetSignInInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = SignInModule_pb.GetSignInInfoRequest()

	arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetSignInInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		SignInModel.instance:setSignInInfo(arg_2_2)
		SignInController.instance:dispatchEvent(SignInEvent.GetSignInInfo)
	end
end

function var_0_0.sendSignInRequest(arg_3_0)
	local var_3_0 = SignInModule_pb.SignInRequest()

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveSignInReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		SignInModel.instance:setSignDayRewardGet(arg_4_2)
		SignInController.instance:dispatchEvent(SignInEvent.GetSignInReply)
		ChargeRpc.instance:sendGetMonthCardInfoRequest()
	end
end

function var_0_0.sendSignInAddupRequest(arg_5_0, arg_5_1)
	local var_5_0 = SignInModule_pb.SignInAddupRequest()

	var_5_0.id = arg_5_1

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveSignInAddupReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		SignInModel.instance:setSignTotalRewardGet(arg_6_2.id)
		SignInController.instance:dispatchEvent(SignInEvent.GetSignInAddUp)
	end
end

function var_0_0.sendSignInHistoryRequest(arg_7_0, arg_7_1)
	local var_7_0 = SignInModule_pb.SignInHistoryRequest()

	var_7_0.month = arg_7_1

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveSignInHistoryReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		SignInModel.instance:setSignInHistory(arg_8_2)
		SignInController.instance:dispatchEvent(SignInEvent.GetHistorySignInSuccess, arg_8_2.month)
	end
end

function var_0_0.sendGetHeroBirthdayRequest(arg_9_0, arg_9_1)
	local var_9_0 = SignInModule_pb.GetHeroBirthdayRequest()

	var_9_0.heroId = arg_9_1

	arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveGetHeroBirthdayReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		SignInModel.instance:setHeroBirthdayGet(arg_10_2.heroId)
		SignInModel.instance:addSignInBirthdayCount(arg_10_2.heroId)
		SignInController.instance:dispatchEvent(SignInEvent.GetHeroBirthday)
	end
end

function var_0_0.sendSignInTotalRewardRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = SignInModule_pb.SignInTotalRewardRequest()

	var_11_0.id = arg_11_1

	return arg_11_0:sendMsg(var_11_0, arg_11_2, arg_11_3)
end

function var_0_0.onReceiveSignInTotalRewardReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		SignInModel.instance:onReceiveSignInTotalRewardReply(arg_12_2)
		SignInController.instance:dispatchEvent(SignInEvent.OnSignInTotalRewardReply, arg_12_2.id)
	end
end

function var_0_0.sendSignInTotalRewardAllRequest(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = SignInModule_pb.SignInTotalRewardAllRequest()

	return arg_13_0:sendMsg(var_13_0, arg_13_1, arg_13_2)
end

function var_0_0.onReceiveSignInTotalRewardAllReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 == 0 then
		SignInModel.instance:onReceiveSignInTotalRewardAllReply(arg_14_2)
		SignInController.instance:dispatchEvent(SignInEvent.OnReceiveSignInTotalRewardAllReply)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
