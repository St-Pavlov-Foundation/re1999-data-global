module("modules.logic.seasonver.act123.rpc.Activity123Rpc", package.seeall)

slot0 = class("Activity123Rpc", BaseRpc)

function slot0.sendGet123InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity123Module_pb.Get123InfosRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGet123InfosReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season123Model.instance:setActInfo(slot2)
	Season123Controller.instance:dispatchEvent(Season123Event.GetActInfo, slot2.activityId)
end

function slot0.onReceiveAct123BattleFinishPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season123Model.instance:updateActInfoBattle(slot2)
	Season123Controller.instance:dispatchEvent(Season123Event.GetActInfoBattleFinish)
end

function slot0.sendAct123EnterStageRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = Activity123Module_pb.Act123EnterStageRequest()
	slot7.activityId = slot1
	slot7.stage = slot2

	for slot11 = 1, #slot3 do
		slot7.heroUids:append(slot3[slot11])
	end

	return slot0:sendMsg(slot7, slot5, slot6)
end

function slot0.onReceiveAct123EnterStageReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season123EpisodeListController.instance:onReceiveEnterStage(slot2.stage)
	Season123Controller.instance:dispatchEvent(Season123Event.EnterStageSuccess)
end

function slot0.sendAct123ChangeFightGroupRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity123Module_pb.Act123ChangeFightGroupRequest()
	slot5.activityId = slot1
	slot5.heroGroupSnapshotSubId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct123ChangeFightGroupReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	if Season123Model.instance:getActInfo(slot2.activityId) then
		slot3.heroGroupSnapshotSubId = slot2.heroGroupSnapshotSubId

		Season123Controller.instance:dispatchEvent(Season123Event.HeroGroupIndexChanged, {
			actId = slot2.activityId,
			groupIndex = slot2.heroGroupSnapshotSubId
		})
	end
end

function slot0.sendAct123EndStageRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity123Module_pb.Act123EndStageRequest()
	slot5.activityId = slot1
	slot5.stage = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct123EndStageReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season123Controller.instance:dispatchEvent(Season123Event.ResetStageFinished, slot2.activityId)
end

function slot0.onReceiveAct123ItemChangePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season123Model.instance:updateItemMap(Season123Model.instance:getCurSeasonId(), slot2.act123Items, slot2.deleteItems)
	Season123Controller.instance:dispatchEvent(Season123Event.OnEquipItemChange)
end

function slot0.sendStartAct123BattleRequest(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11)
	slot12 = Activity123Module_pb.StartAct123BattleRequest()
	slot12.activityId = slot1
	slot12.layer = slot2

	DungeonRpc.instance:packStartDungeonRequest(slot12.startDungeonRequest, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	Season123HeroGroupUtils.processFightGroupAssistHero(ModuleEnum.HeroGroupType.Season123, slot12.startDungeonRequest.fightGroup, slot8)

	return slot0:sendMsg(slot12, slot10, slot11)
end

function slot0.onReceiveStartAct123BattleReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if Season123Model.instance:getBattleContext().actId == slot2.activityId and (slot3.layer == nil or slot3.layer == slot2.layer) and DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and DungeonModel.isBattleEpisode(slot4) then
			DungeonFightController.instance:onReceiveStartDungeonReply(slot1, slot2.startDungeonReply)
		end

		if slot2.updateAct123Stages and #slot2.updateAct123Stages > 0 and Season123Model.instance:getActInfo(slot2.activityId) then
			slot4:updateStages(slot2.updateAct123Stages)
			Season123Controller.instance:dispatchEvent(Season123Event.StageInfoChanged)
		end
	else
		Season123Controller.instance:dispatchEvent(Season123Event.StartFightFailed)
	end
end

function slot0.sendComposeAct123EquipRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity123Module_pb.ComposeAct123EquipRequest()
	slot5.activityId = slot1
	slot5.equipId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveComposeAct123EquipReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season123EquipBookModel.instance:refreshBackpack()
	Season123DecomposeModel.instance:initDatas(slot2.activityId)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnItemChange)
end

function slot0.sendDecomposeAct123EquipRequest(slot0, slot1, slot2, slot3, slot4)
	Activity123Module_pb.DecomposeAct123EquipRequest().activityId = slot1

	for slot9, slot10 in pairs(slot2) do
		table.insert(slot5.equipUids, slot10)
	end

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveDecomposeAct123EquipReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season123DecomposeModel.instance:removeHasDecomposeItems(slot2.equipUids)
	Season123EquipController.instance:checkHeroGroupCardExist(slot2.activityId)
	Season123EquipBookModel.instance:removeDecomposeEquipItem(slot2.equipUids)
	Season123DecomposeModel.instance:initDatas(slot2.activityId)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnItemChange)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.CloseBatchDecomposeEffect)
end

function slot0.sendAct123OpenCardBagRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity123Module_pb.Act123OpenCardBagRequest()
	slot5.activityId = slot1
	slot5.itemId = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct123OpenCardBagReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season123CardPackageModel.instance:initData(slot2.activityId)
	Season123CardPackageModel.instance:setCardItemList(slot2.act123EquipIds)
	Season123Controller.instance:dispatchEvent(Season123Event.OnCardPackageOpen)
end

function slot0.sendAct123ResetOtherStageRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity123Module_pb.Act123ResetOtherStageRequest()
	slot5.activityId = slot1
	slot5.enterStage = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct123ResetOtherStageReply(slot0, slot1, slot2)
	if slot1 == 0 and slot2.updateAct123Stages and #slot2.updateAct123Stages > 0 and Season123Model.instance:getActInfo(slot2.activityId) then
		slot3:updateStages(slot2.updateAct123Stages)
		Season123Controller.instance:dispatchEvent(Season123Event.StageInfoChanged)
	end
end

function slot0.sendAct123ResetHighLayerRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity123Module_pb.Act123ResetHighLayerRequest()
	slot6.activityId = slot1
	slot6.stage = slot2
	slot6.layer = slot3

	return slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct123ResetHighLayerReply(slot0, slot1, slot2)
	if slot1 == 0 and slot2.updateAct123Stages and #slot2.updateAct123Stages > 0 and Season123Model.instance:getActInfo(slot2.activityId) then
		slot3.stage = slot2.stage

		slot3:updateStages(slot2.updateAct123Stages)
		Season123Controller.instance:dispatchEvent(Season123Event.StageInfoChanged)
	end
end

function slot0.sendGetUnlockAct123EquipIdsRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity123Module_pb.GetUnlockAct123EquipIdsRequest()
	slot4.activityId = slot1

	return slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetUnlockAct123EquipIdsReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season123Model.instance:setUnlockAct123EquipIds(slot2)
end

function slot0.sendGetAct123StageRecordRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity123Module_pb.GetAct123StageRecordRequest()
	slot5.activityId = slot1
	slot5.stage = slot2

	return slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveGetAct123StageRecordReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Season123RecordModel.instance:setSeason123ServerRecordData(slot2)
end

slot0.instance = slot0.New()

return slot0
