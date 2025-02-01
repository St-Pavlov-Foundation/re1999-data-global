module("modules.logic.versionactivity1_5.aizila.rpc.Activity144Rpc", package.seeall)

slot0 = class("Activity144Rpc", BaseRpc)

function slot0.sendGet144InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity144Module_pb.Get144InfosRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet144InfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		AiZiLaController.instance:getInfosReply(slot2)
	end
end

function slot0.sendAct144EnterEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity144Module_pb.Act144EnterEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct144EnterEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		AiZiLaController.instance:enterEpisodeReply(slot2)
	end
end

function slot0.sendAct144SelectOptionRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity144Module_pb.Act144SelectOptionRequest()
	slot5.activityId = slot1
	slot5.option = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct144SelectOptionReply(slot0, slot1, slot2)
	if slot1 == 0 then
		AiZiLaController.instance:selectOptionReply(slot2)
	end
end

function slot0.sendAct144NextDayRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity144Module_pb.Act144NextDayRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct144NextDayReply(slot0, slot1, slot2)
	if slot1 == 0 then
		AiZiLaController.instance:nextDayReply(slot2)
	end
end

function slot0.sendAct144SettleEpisodeRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity144Module_pb.Act144SettleEpisodeRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveAct144SettleEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		AiZiLaController.instance:settleEpisodeReply(slot2)
	end
end

function slot0.onReceiveAct144SettlePush(slot0, slot1, slot2)
	if slot1 == 0 then
		AiZiLaController.instance:settlePush(slot2)
	end
end

function slot0.sendAct144UpgradeEquipRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity144Module_pb.Act144UpgradeEquipRequest()
	slot5.activityId = slot1
	slot5.equipId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct144UpgradeEquipReply(slot0, slot1, slot2)
	if slot1 == 0 then
		AiZiLaController.instance:upgradeEquipReply(slot2)
	end
end

function slot0.onReceiveAct144EpisodePush(slot0, slot1, slot2)
	if slot1 == 0 then
		AiZiLaController.instance:episodePush(slot2)
	end
end

function slot0.onReceiveAct144ItemChangePush(slot0, slot1, slot2)
	if slot1 == 0 then
		AiZiLaController.instance:itemChangePush(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
