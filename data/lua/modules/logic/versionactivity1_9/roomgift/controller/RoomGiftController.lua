module("modules.logic.versionactivity1_9.roomgift.controller.RoomGiftController", package.seeall)

slot0 = class("RoomGiftController", BaseController)

function slot0.onInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.getAct159Info(slot0)
	if RoomGiftModel.instance:isActOnLine() then
		RoomGiftRpc.instance:sendGet159InfosRequest(RoomGiftModel.instance:getActId())
	else
		slot0:dispatchEvent(RoomGiftEvent.UpdateActInfo)
	end
end

function slot0.getAct159Bonus(slot0)
	if not RoomGiftModel.instance:isActOnLine(true) then
		return
	end

	RoomGiftRpc.instance:sendGet159BonusRequest(RoomGiftModel.instance:getActId())
end

slot0.instance = slot0.New()

return slot0
