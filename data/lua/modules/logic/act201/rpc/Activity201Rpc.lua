module("modules.logic.act201.rpc.Activity201Rpc", package.seeall)

slot0 = class("Activity201Rpc", BaseRpc)

function slot0.sendGet201InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity201Module_pb.Get201InfoRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet201InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity201Model.instance:setActivityInfo(slot2)
		Activity201Controller.instance:dispatchEvent(Activity201Event.OnGetInfoSuccess)
	end
end

slot0.instance = slot0.New()

return slot0
