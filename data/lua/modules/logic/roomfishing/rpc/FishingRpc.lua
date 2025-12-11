module("modules.logic.roomfishing.rpc.FishingRpc", package.seeall)

local var_0_0 = class("FishingRpc", BaseRpc)

function var_0_0.sendGetFishingInfoRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = FishingModule_pb.GetFishingInfoRequest()

	arg_1_0:sendMsg(var_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onReceiveGetFishingInfoReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	FishingController.instance:updateFishingInfo(nil, arg_2_2.fishingPoolInfo)
end

function var_0_0.sendGetOtherFishingInfoRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = FishingModule_pb.GetOtherFishingInfoRequest()

	var_3_0.userId = arg_3_1

	arg_3_0:sendMsg(var_3_0, arg_3_2, arg_3_3)
end

function var_0_0.onReceiveGetOtherFishingInfoReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	FishingController.instance:updateFishingInfo(arg_4_2.userId, arg_4_2.fishingPoolInfo, arg_4_2.friendInfo)
end

function var_0_0.sendFishingRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0 = FishingModule_pb.FishingRequest()

	var_5_0.poolUserId = arg_5_1
	var_5_0.fishTimes = arg_5_2

	arg_5_0:sendMsg(var_5_0, arg_5_3, arg_5_4)
end

function var_0_0.onReceiveFishingReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end

	FishingController.instance:onFishing(arg_6_2.poolUserId, arg_6_2.fishTimes, arg_6_2.progress)
end

function var_0_0.sendGetFishingBonusRequest(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = FishingModule_pb.GetFishingBonusRequest()

	arg_7_0:sendMsg(var_7_0, arg_7_1, arg_7_2)
end

function var_0_0.onReceiveGetFishingBonusReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end

	FishingController.instance:onGetFishingBonus(arg_8_2)
end

function var_0_0.sendChangeFishingCurrencyRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = FishingModule_pb.ChangeFishingCurrencyRequest()

	var_9_0.count = arg_9_1

	arg_9_0:sendMsg(var_9_0, arg_9_2, arg_9_3)
end

function var_0_0.onReceiveChangeFishingCurrencyReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end

	FishingController.instance:onExchangeFishingCurrency(arg_10_2.count, arg_10_2.exchangedCount)
end

function var_0_0.sendGetFishingFriendsRequest(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = FishingModule_pb.GetFishingFriendsRequest()

	arg_11_0:sendMsg(var_11_0, arg_11_1, arg_11_2)
end

function var_0_0.onReceiveGetFishingFriendsReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end

	FishingController.instance:updateFriendListInfo(arg_12_2.notFishingFriendInfo, true)
end

var_0_0.instance = var_0_0.New()

return var_0_0
