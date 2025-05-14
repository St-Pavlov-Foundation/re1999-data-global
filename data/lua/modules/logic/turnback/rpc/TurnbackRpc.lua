module("modules.logic.turnback.rpc.TurnbackRpc", package.seeall)

local var_0_0 = class("TurnbackRpc", BaseRpc)

function var_0_0.sendGetTurnbackInfoRequest(arg_1_0)
	local var_1_0 = TurnbackModule_pb.GetTurnbackInfoRequest()

	return arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGetTurnbackInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		TurnbackModel.instance:setTurnbackInfo(arg_2_2.info)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshView)
	end
end

function var_0_0.sendTurnbackFirstShowRequest(arg_3_0, arg_3_1)
	local var_3_0 = TurnbackModule_pb.TurnbackFirstShowRequest()

	var_3_0.id = arg_3_1

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveTurnbackFirstShowReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		-- block empty
	end
end

function var_0_0.sendTurnbackBonusPointRequest(arg_5_0, arg_5_1)
	local var_5_0 = TurnbackModule_pb.TurnbackBonusPointRequest()

	var_5_0.id = arg_5_1.id
	var_5_0.bonusPointId = arg_5_1.bonusPointId

	return arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveTurnbackBonusPointReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		TurnbackModel.instance:updateHasGetTaskBonus(arg_6_2)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshTaskRewardItem)
	end
end

function var_0_0.sendTurnbackOnceBonusRequest(arg_7_0, arg_7_1)
	local var_7_0 = TurnbackModule_pb.TurnbackOnceBonusRequest()

	var_7_0.id = arg_7_1

	return arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveTurnbackOnceBonusReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		TurnbackModel.instance:setOnceBonusGetState()
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshOnceBonusGetState)
	end
end

function var_0_0.sendTurnbackSignInRequest(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = TurnbackModule_pb.TurnbackSignInRequest()

	var_9_0.id = arg_9_1
	var_9_0.day = arg_9_2

	return arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveTurnbackSignInReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		TurnbackSignInModel.instance:updateSignInInfoState(arg_10_2.day, TurnbackEnum.SignInState.HasGet)

		if TurnbackModel.instance:isNewType() and arg_10_2.day ~= 1 then
			TurnbackModel.instance:setLastGetSigninReward(arg_10_2.day)
		end

		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshSignInScroll)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshSignInItem)
	end
end

function var_0_0.onReceiveTurnbackAdditionPush(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == 0 then
		local var_11_0 = TurnbackModel.instance:getCurTurnbackMoWithNilError()

		if var_11_0 and var_11_0.id == arg_11_2.id then
			var_11_0:setRemainAdditionCount(arg_11_2.remainAdditionCount)
		end
	end
end

function var_0_0.sendBuyDoubleBonusRequest(arg_12_0, arg_12_1)
	local var_12_0 = TurnbackModule_pb.BuyDoubleBonusRequest()

	var_12_0.id = arg_12_1

	return arg_12_0:sendMsg(var_12_0)
end

function var_0_0.onReceiveBuyDoubleBonusReply(arg_13_0, arg_13_1, arg_13_2)
	if arg_13_1 == 0 then
		TurnbackController.instance:showPopupView(arg_13_2.doubleBonus)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.AfterBuyDoubleReward)
		var_0_0.instance:sendGetTurnbackInfoRequest()
	end
end

function var_0_0.sendFinishReadTaskRequest(arg_14_0, arg_14_1)
	return TaskRpc.instance:sendFinishReadTaskRequest(arg_14_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
