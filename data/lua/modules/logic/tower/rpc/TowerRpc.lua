module("modules.logic.tower.rpc.TowerRpc", package.seeall)

slot0 = class("TowerRpc", BaseRpc)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.sendGetTowerInfoRequest(slot0, slot1, slot2)
	return slot0:sendMsg(TowerModule_pb.GetTowerInfoRequest(), slot1, slot2)
end

function slot0.onReceiveGetTowerInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TowerModel.instance:onReceiveGetTowerInfoReply(slot2)
		TowerController.instance:dispatchEvent(TowerEvent.TowerUpdate)
	end
end

function slot0.sendTowerMopUpRequest(slot0, slot1, slot2, slot3)
	slot4 = TowerModule_pb.TowerMopUpRequest()
	slot4.times = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveTowerMopUpReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TowerModel.instance:updateMopUpTimes(slot2.mopUpTimes)
		TowerController.instance:dispatchEvent(TowerEvent.TowerMopUp, slot2.mopUpTimes)
	end
end

function slot0.sendTowerActiveTalentRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = TowerModule_pb.TowerActiveTalentRequest()
	slot5.bossId = slot1
	slot5.talentId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveTowerActiveTalentReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TowerAssistBossModel.instance:onTowerActiveTalent(slot2)
		TowerController.instance:dispatchEvent(TowerEvent.ActiveTalent, slot2.talentId)
	end
end

function slot0.sendTowerResetTalentRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = TowerModule_pb.TowerResetTalentRequest()
	slot5.bossId = slot1
	slot5.talentId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveTowerResetTalentReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TowerAssistBossModel.instance:onTowerResetTalent(slot2)
		TowerController.instance:dispatchEvent(TowerEvent.ResetTalent, slot2.talentId)
	end
end

function slot0.sendTowerResetSubEpisodeRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = TowerModule_pb.TowerResetSubEpisodeRequest()
	slot7.towerType = slot1
	slot7.towerId = slot2
	slot7.layerId = slot3
	slot7.subEpisode = slot4

	return slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveTowerResetSubEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		TowerModel.instance:resetTowerSubEpisode(slot2)
		TowerController.instance:dispatchEvent(TowerEvent.OnTowerResetSubEpisode, slot2)
	end
end

function slot0.sendStartTowerBattleRequest(slot0, slot1, slot2, slot3)
	slot5 = TowerModel.instance:getRecordFightParam()
	TowerModule_pb.StartTowerBattleRequest().type = slot5.towerType
	slot4.towerId = slot5.towerId or 0
	slot4.layerId = slot5.layerId or 0
	slot4.difficulty = slot5.difficulty or 0

	slot0:packStartTowerBattleRequest(slot4, slot1)

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveStartTowerBattleReply(slot0, slot1, slot2)
	FightRpc.instance:onReceiveTestFightReply(slot1, slot2 and slot2.startDungeonReply)
end

function slot0.packStartTowerBattleRequest(slot0, slot1, slot2)
	slot3 = slot1.startDungeonRequest
	slot3.chapterId = slot2.chapterId
	slot3.episodeId = slot2.episodeId
	slot3.isRestart = slot2.isRestart and true or false
	slot3.isBalance = HeroGroupBalanceHelper.getIsBalanceMode()
	slot3.multiplication = slot2.multiplication or 1
	slot3.useRecord = slot2.useRecord and true or false

	if slot2.fightParam then
		slot4:setReqFightGroup(slot3)
		FightModel.instance:recordFightGroup(slot3.fightGroup)
	end
end

function slot0.onReceiveTowerBattleFinishPush(slot0, slot1, slot2)
	if slot1 == 0 then
		TowerModel.instance:onReceiveTowerBattleFinishPush(slot2)
	end
end

slot0.instance = slot0.New()

return slot0
