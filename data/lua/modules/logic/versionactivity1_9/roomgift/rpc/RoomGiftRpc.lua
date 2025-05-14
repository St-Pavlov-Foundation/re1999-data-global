module("modules.logic.versionactivity1_9.roomgift.rpc.RoomGiftRpc", package.seeall)

local var_0_0 = class("RoomGiftRpc", BaseRpc)

function var_0_0.sendGet159InfosRequest(arg_1_0, arg_1_1)
	if not arg_1_1 then
		return
	end

	local var_1_0 = Activity159Module_pb.Get159InfosRequest()

	var_1_0.activityId = arg_1_1

	return arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveGet159InfosReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end

	RoomGiftModel.instance:setActivityInfo(arg_2_2)
	RoomGiftController.instance:dispatchEvent(RoomGiftEvent.UpdateActInfo)
end

function var_0_0.sendGet159BonusRequest(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return
	end

	local var_3_0 = Activity159Module_pb.Get159BonusRequest()

	var_3_0.activityId = arg_3_1

	return arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveGet159BonusReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end

	RoomGiftModel.instance:setHasGotBonus(true)
	RoomGiftController.instance:dispatchEvent(RoomGiftEvent.GetBonus)
end

var_0_0.instance = var_0_0.New()

return var_0_0
