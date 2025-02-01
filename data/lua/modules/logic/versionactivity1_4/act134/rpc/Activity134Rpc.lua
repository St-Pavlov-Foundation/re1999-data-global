module("modules.logic.versionactivity1_4.act134.rpc.Activity134Rpc", package.seeall)

slot0 = class("Activity134Rpc", BaseRpc)

function slot0.sendGet134InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity134Module_pb.Get134InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet134InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity134Model.instance:onInitMo(slot2)
	Activity134Controller.instance:dispatchEvent(Activity134Event.OnUpdateInfo, slot2)
end

function slot0.sendGet134BonusRequest(slot0, slot1, slot2)
	slot3 = Activity134Module_pb.Act134BonusRequest()
	slot3.activityId = slot1
	slot3.id = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveAct134BonusReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity134Model.instance:onReceiveBonus(slot2.id)
	Activity134Controller.instance:dispatchEvent(Activity134Event.OnGetBonus, slot2)
end

slot0.instance = slot0.New()

return slot0
