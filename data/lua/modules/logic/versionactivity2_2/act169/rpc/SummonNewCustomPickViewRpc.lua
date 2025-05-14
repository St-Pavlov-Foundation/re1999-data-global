module("modules.logic.versionactivity2_2.act169.rpc.SummonNewCustomPickViewRpc", package.seeall)

local var_0_0 = class("SummonNewCustomPickViewRpc", BaseRpc)

function var_0_0.sendGet169InfoRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = Activity169Module_pb.Get169InfoRequest()

	var_1_0.activityId = arg_1_1

	arg_1_0:sendMsg(var_1_0, arg_1_2, arg_1_3)
end

function var_0_0.onReceiveGet169InfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		SummonNewCustomPickViewModel.instance:onGetInfo(arg_2_2.activityId, arg_2_2.heroId)
		SummonNewCustomPickViewController.instance:dispatchEvent(SummonNewCustomPickEvent.OnGetServerInfoReply, arg_2_2.activityId, arg_2_2.heroId)
	end
end

function var_0_0.sendAct169SummonRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Activity169Module_pb.Act169SummonRequest()

	var_3_0.activityId = arg_3_1
	var_3_0.heroId = arg_3_2 or 0

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveAct169SummonReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		if not SummonNewCustomPickChoiceListModel.instance:haveAllRole() then
			SummonNewCustomPickViewController.instance:dispatchEvent(SummonNewCustomPickEvent.OnSummonCustomGet, arg_4_2.activityId, arg_4_2.heroId)
		end

		SummonNewCustomPickViewModel.instance:setReward(arg_4_2.activityId, arg_4_2.heroId)
		SummonNewCustomPickViewModel.instance:setGetRewardFxState(arg_4_2.activityId, true)
		SummonNewCustomPickViewController.instance:dispatchEvent(SummonNewCustomPickEvent.OnGetReward, arg_4_2.activityId, arg_4_2.heroId)
		CharacterModel.instance:setGainHeroViewShowState(false)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
