module("modules.logic.common.rpc.CommonRpc", package.seeall)

slot0 = class("CommonRpc", BaseRpc)

function slot0.sendGetServerTimeRequest(slot0, slot1, slot2)
	return slot0:sendMsg(CommonModule_pb.GetServerTimeRequest(), slot1, slot2)
end

function slot0.onReceiveGetServerTimeReply(slot0, slot1, slot2)
	ServerTime.init(math.floor(tonumber(slot2.offsetTime) / 1000))
	ServerTime.update(math.floor(tonumber(slot2.serverTime) / 1000))
end

slot0.instance = slot0.New()

return slot0
