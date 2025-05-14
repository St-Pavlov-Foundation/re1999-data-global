module("modules.logic.versionactivity1_9.roomgift.controller.RoomGiftController", package.seeall)

local var_0_0 = class("RoomGiftController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.getAct159Info(arg_5_0)
	if RoomGiftModel.instance:isActOnLine() then
		local var_5_0 = RoomGiftModel.instance:getActId()

		RoomGiftRpc.instance:sendGet159InfosRequest(var_5_0)
	else
		arg_5_0:dispatchEvent(RoomGiftEvent.UpdateActInfo)
	end
end

function var_0_0.getAct159Bonus(arg_6_0)
	if not RoomGiftModel.instance:isActOnLine(true) then
		return
	end

	local var_6_0 = RoomGiftModel.instance:getActId()

	RoomGiftRpc.instance:sendGet159BonusRequest(var_6_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
