module("modules.logic.versionactivity2_5.act182.rpc.Activity182Rpc", package.seeall)

slot0 = class("Activity182Rpc", BaseRpc)

function slot0.sendGetAct182InfoRequest(slot0, slot1)
	slot2 = Activity182Module_pb.GetAct182InfoRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetAct182InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity182Model.instance:setActInfo(slot2.act182Info)
end

function slot0.onReceiveAct182InfoPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity182Model.instance:setActInfo(slot2.act182Info)
end

function slot0.sendGetAct182RandomMasterRequest(slot0, slot1)
	slot2 = Activity182Module_pb.GetAct182RandomMasterRequest()
	slot2.activityId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetAct182RandomMasterReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity182Model.instance:getActMo(slot2.activityId):updateMasterIdBox(slot2.masterId)
	Activity182Controller.instance:dispatchEvent(Activity182Event.RandomMasterReply)
end

function slot0.sendAct182RefreshMasterRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity182Module_pb.Act182RefreshMasterRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct182RefreshMasterReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity182Model.instance:getActMo(slot2.activityId):updateMasterIdBox(slot2.masterId, true)
end

slot0.instance = slot0.New()

return slot0
