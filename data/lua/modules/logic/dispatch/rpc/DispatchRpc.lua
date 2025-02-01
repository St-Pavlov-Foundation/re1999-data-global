module("modules.logic.dispatch.rpc.DispatchRpc", package.seeall)

slot0 = class("DispatchRpc", BaseRpc)

function slot0.sendGetDispatchInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(DispatchModule_pb.GetDispatchInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetDispatchInfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	DispatchModel.instance:initDispatchInfos(slot2.dispatchInfos)
end

function slot0.sendDispatchRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = DispatchModule_pb.DispatchRequest()
	slot6.elementId = slot1
	slot6.dispatchId = slot2

	if slot3 then
		for slot10, slot11 in ipairs(slot3) do
			slot6.heroIds:append(slot11)
		end
	end

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveDispatchReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	ServerTime.update(math.floor(tonumber(slot2.startTime) / 1000))
	DispatchModel.instance:addDispatch(slot2)
end

function slot0.sendInterruptDispatchRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = DispatchModule_pb.InterruptDispatchRequest()
	slot5.elementId = slot1
	slot5.dispatchId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveInterruptDispatchReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	DispatchModel.instance:removeDispatch(slot2)
end

slot0.instance = slot0.New()

return slot0
