module("modules.logic.versionactivity1_4.act132.rpc.Activity132Rpc", package.seeall)

slot0 = class("Activity132Rpc", BaseRpc)

function slot0.sendGet132InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity132Module_pb.Get132InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet132InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity132Model.instance:setActivityInfo(slot2)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnUpdateInfo)
end

function slot0.onReceiveAct132InfoUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity132Model.instance:setActivityInfo(slot2)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnUpdateInfo)
end

function slot0.sendAct132UnlockRequest(slot0, slot1, slot2)
	Activity132Module_pb.Act132UnlockRequest().activityId = slot1

	for slot7, slot8 in ipairs(slot2) do
		table.insert(slot3.contentId, slot8)
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct132UnlockReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity132Model.instance:setContentUnlock(slot2)
	Activity132Controller.instance:dispatchEvent(Activity132Event.OnContentUnlock, slot2.contentId)
end

slot0.instance = slot0.New()

return slot0
