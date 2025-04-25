module("modules.logic.act201.controller.Activity201Controller", package.seeall)

slot0 = class("Activity201Controller", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
end

function slot0.getInvitationInfo(slot0, slot1, slot2, slot3)
	Activity201Rpc.instance:sendGet201InfoRequest(slot1, slot2, slot3)
end

function slot0.openMainView(slot0, slot1)
	slot0:getInvitationInfo(slot1, slot0._openMainView, slot0)
end

function slot0._openMainView(slot0, slot1, slot2)
	if slot1 == 0 then
		ViewMgr.instance:openView(ViewName.TurnBackFullView, slot2.activityId, true)
	end
end

slot0.instance = slot0.New()

return slot0
