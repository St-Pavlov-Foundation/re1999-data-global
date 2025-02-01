module("modules.logic.turnback.invitation.rpc.TurnBackInvitationRpc", package.seeall)

slot0 = class("TurnBackInvitationRpc", BaseRpc)
slot0.instance = slot0.New()

function slot0.sendGet171InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity171Module_pb.Get171InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet171InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TurnBackInvitationModel.instance:setActivityInfo(slot2)
		TurnBackInvitationController.instance:dispatchEvent(TurnBackInvitationEvent.OnGetInfoSuccess)
	end
end

return slot0
