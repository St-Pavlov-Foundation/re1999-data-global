module("modules.logic.turnback.invitation.controller.TurnBackInvitationController", package.seeall)

slot0 = class("TurnBackInvitationController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.getInvitationInfo(slot0, slot1, slot2, slot3)
	TurnBackInvitationRpc.instance:sendGet171InfoRequest(slot1, slot2, slot3)
end

function slot0.openMainView(slot0, slot1)
	slot0:getInvitationInfo(slot1, slot0.onReceiveMsg, slot0)
end

function slot0.onReceiveMsg(slot0, slot1, slot2)
	if slot1 == 0 then
		ViewMgr.instance:openView(ViewName.TurnBackInvitationMainView, slot2.activityId, true)
	end
end

slot0.instance = slot0.New()

return slot0
