module("modules.logic.toughbattle.rpc.SiegeBattleRpc", package.seeall)

slot0 = class("SiegeBattleRpc", BaseRpc)

function slot0.sendGetSiegeBattleInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(SiegeBattleModule_pb.GetSiegeBattleInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetSiegeBattleInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ToughBattleModel.instance:onGetStoryInfo(slot2.info)
	end
end

function slot0.sendStartSiegeBattleRequest(slot0, slot1, slot2)
	return slot0:sendMsg(SiegeBattleModule_pb.StartSiegeBattleRequest(), slot1, slot2)
end

function slot0.onReceiveStartSiegeBattleReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ToughBattleModel.instance:onGetStoryInfo(slot2.info)
	end
end

function slot0.sendAbandonSiegeBattleRequest(slot0, slot1, slot2)
	return slot0:sendMsg(SiegeBattleModule_pb.AbandonSiegeBattleRequest(), slot1, slot2)
end

function slot0.onReceiveAbandonSiegeBattleReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ToughBattleModel.instance:onGetStoryInfo(slot2.info)
	end
end

slot0.instance = slot0.New()

return slot0
