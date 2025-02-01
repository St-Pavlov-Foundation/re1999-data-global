module("modules.logic.versionactivity1_2.trade.rpc.Activity117Rpc", package.seeall)

slot0 = class("Activity117Rpc", BaseRpc)

function slot0.sendAct117InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity117Module_pb.Act117InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct117InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity117Model.instance:onReceiveInfos(slot2)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveInfos, slot2.activityId)
	end
end

function slot0.sendAct117NegotiateRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity117Module_pb.Act117NegotiateRequest()
	slot6.activityId = slot1
	slot6.orderId = slot2
	slot6.userDealScore = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct117NegotiateReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity117Model.instance:onNegotiateResult(slot2)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveNegotiate, slot2.activityId)
	end
end

function slot0.sendAct117DealRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity117Module_pb.Act117DealRequest()
	slot5.activityId = slot1
	slot5.orderId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct117DealReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity117Model.instance:onDealSuccess(slot2)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveDeal, slot2.activityId)
	end
end

function slot0.sendAct117GetBonusRequest(slot0, slot1, slot2, slot3, slot4)
	Activity117Module_pb.Act117GetBonusRequest().activityId = slot1

	if slot2 then
		for slot9, slot10 in ipairs(slot2) do
			table.insert(slot5.bonusIds, slot10)
		end
	end

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct117GetBonusReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity117Model.instance:updateRewardDatas(slot2)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveGetBonus, slot2.activityId, slot2.bonusIds)
	end
end

function slot0.onReceiveAct117OrderPush(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity117Model.instance:onOrderPush(slot2)
		Activity117Controller.instance:dispatchEvent(Activity117Event.ReceiveOrderPush, slot2.activityId)
	end
end

slot0.instance = slot0.New()

return slot0
