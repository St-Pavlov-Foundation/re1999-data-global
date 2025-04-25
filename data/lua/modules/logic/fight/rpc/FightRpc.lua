module("modules.logic.fight.rpc.FightRpc", package.seeall)

slot0 = class("FightRpc", BaseRpc)

function slot0.sendBeginFightRequest(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot1) do
		table.insert(FightModule_pb.BeginFightRequest().heroList, slot8)
	end

	if slot2 then
		for slot7, slot8 in ipairs(slot2) do
			table.insert(slot3.subHeroList, slot8)
		end
	end

	slot0:sendMsg(slot3)
end

function slot0.onReceiveBeginFightReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightMgr.instance:startFight(slot2.fight)
		FightModel.instance:updateFight(slot2.fight)
		FightModel.instance:updateFightRound(slot2.round)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		FightModel.instance:setFightParam(nil)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFightFail)
	end
end

function slot0.sendTestFightRequest(slot0, slot1, slot2, slot3)
	slot1:setReqFightGroup(FightModule_pb.TestFightRequest())

	for slot8, slot9 in ipairs(slot2) do
		table.insert(slot4.groupIds, slot9)
	end

	slot4.fightActType = slot3 or FightEnum.FightActType.Normal

	slot0:sendMsg(slot4)
end

function slot0.onReceiveTestFightReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightMgr.instance:startFight(slot2.fight)
		FightModel.instance:updateFight(slot2.fight)
		FightModel.instance:refreshBattleId(slot2.fight)
		FightModel.instance:updateFightRound(slot2.round)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		FightController.instance:dispatchEvent(FightEvent.RespBeginFightFail)
	end
end

function slot0.sendTestFightIdRequest(slot0, slot1)
	slot2 = FightModule_pb.TestFightIdRequest()

	slot1:setReqFightGroup(slot2)

	slot2.fightId = slot1.battleId
	slot2.fightActType = slot1.fightActType or FightEnum.FightActType.Normal

	slot0:sendMsg(slot2)
end

function slot0.onReceiveTestFightIdReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightMgr.instance:startFight(slot2.fight)
		FightModel.instance:updateFight(slot2.fight)
		FightModel.instance:updateFightRound(slot2.round)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		FightController.instance:dispatchEvent(FightEvent.RespBeginFightFail)
	end
end

function slot0.sendResetRoundRequest(slot0)
	slot0:sendMsg(FightModule_pb.ResetRoundRequest())
end

function slot0.onReceiveResetRoundReply(slot0, slot1, slot2)
	if slot1 == 0 then
		if slot2:HasField("fight") then
			FightModel.instance:updateFight(slot2.fight)
		end

		if slot2:HasField("round") then
			FightModel.instance:updateFightRound(slot2.round)

			FightCardModel.instance:getCardMO().actPoint = slot2.round.actPoint
		end

		slot3 = FightCardModel.instance:getCardOps()

		if #slot2.cards > 0 then
			FightCardModel.instance:clearCardOps()
			FightCardModel.instance:coverCard(FightHelper.buildInfoMOs(slot2.cards, FightCardInfoMO))
			FightController.instance:dispatchEvent(FightEvent.UpdateHandCards, FightCardModel.instance:getCardMO().cardGroup)
		end

		FightMgr.instance:cancelOperation()
		FightController.instance:dispatchEvent(FightEvent.ResetCard, slot3)
	end
end

function slot0.sendBeginRoundRequest(slot0, slot1)
	for slot5 = #slot1, 1, -1 do
		if slot1[slot5]:isSimulateDissolveCard() then
			table.remove(slot1, slot5)
		end
	end

	slot0._beginRoundOps = slot1
	slot2 = FightModule_pb.BeginRoundRequest()

	for slot6, slot7 in ipairs(slot1) do
		slot8 = FightDef_pb.BeginRoundOper()
		slot8.operType = slot7.operType
		slot8.param1 = slot7.param1

		if slot7.param2 then
			slot8.param2 = slot7.param2
		end

		if slot7.toId then
			slot8.toId = slot7.toId
		end

		table.insert(slot2.opers, slot8)
	end

	slot0:sendMsg(slot2)
end

function slot0.onReceiveBeginRoundReply(slot0, slot1, slot2)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.FightStateType.sendOperation2Server)
	FightCardModel.instance:clearCardOps()
	FightDataHelper.paTaMgr:resetOp()

	if slot1 == 0 then
		if slot2:HasField("round") then
			slot0._beginRoundOps = nil

			FightModel.instance:updateFightRound(slot2.round)
			FightSystem.instance:startRound()
			FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
		else
			uv0.instance:sendEndFightRequest(false)
		end
	else
		if not FightModel.instance:isFinish() then
			GameFacade.showMessageBox(MessageBoxIdDefine.FightException, MsgBoxEnum.BoxType.Yes_No, function ()
				if uv0._beginRoundOps then
					uv1.instance:sendBeginRoundRequest(uv0._beginRoundOps)
				else
					logError("回合操作步骤不存在")
				end
			end)
		end

		FightController.instance:dispatchEvent(FightEvent.RespBeginRoundFail)
	end
end

function slot0.sendChangeSubHeroRequest(slot0, slot1, slot2)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)

	slot3 = FightModule_pb.ChangeSubHeroRequest()
	slot3.subHeroId = slot1
	slot3.changeHeroId = slot2

	slot0:sendMsg(slot3)
end

function slot0.onReceiveChangeSubHeroReply(slot0, slot1, slot2)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)
	FightController.instance:dispatchEvent(FightEvent.ReceiveChangeSubHeroReply, slot1)

	if slot1 == 0 and slot2:HasField("round") then
		FightModel.instance:updateFightRound(slot2.round)
		FightSystem.instance:startRound()
		FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
	end
end

function slot0.sendChangeSubHeroExSkillRequest(slot0, slot1)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)

	slot2 = FightModule_pb.ChangeSubHeroExSkillRequest()
	slot2.exSkillTarget = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveChangeSubHeroExSkillReply(slot0, slot1, slot2)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)
	FightController.instance:dispatchEvent(FightEvent.ChangeSubHeroExSkillReply, slot1)

	if slot1 == 0 and slot2:HasField("round") then
		FightModel.instance:updateFightRound(slot2.round)
		FightSystem.instance:startRound()
		FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
	end
end

function slot0.sendReconnectFightRequest(slot0, slot1, slot2)
	return slot0:sendMsg(FightModule_pb.ReconnectFightRequest(), slot1, slot2)
end

function slot0.onReceiveReconnectFightReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightModel.instance.needFightReconnect = slot2:HasField("fight")

		if FightModel.instance.needFightReconnect then
			FightMgr.instance:startFight(slot2.fight)
			FightModel.instance:updateFight(slot2.fight)
			FightModel.instance:updateFightRound(slot2.lastRound)
			FightModel.instance:updateFightReason(slot2.fightReason)
			FightModel.instance:recordFightGroup(slot2.fightGroup)
		end

		FightController.instance:dispatchEvent(FightEvent.RespReconnectFight)
	end
end

function slot0.onReceiveCardInfoPush(slot0, slot1, slot2)
	FightLocalDataMgr.instance.handCardMgr:updateHandCardByProto(slot2.cardGroup)
	FightLocalDataMgr.instance.fieldMgr:dealCardInfoPush(slot2)

	slot0._lastCardInfoPushMsg = slot2

	if slot2.isGm then
		slot0:dealCardInfoPushData()
	end
end

function slot0.dealCardInfoPushData(slot0)
	if slot0._lastCardInfoPushMsg then
		FightDataMgr.instance.handCardMgr:updateHandCardByProto(slot0._lastCardInfoPushMsg.cardGroup)
		FightDataMgr.instance.fieldMgr:dealCardInfoPush(slot0._lastCardInfoPushMsg)
		FightCardModel.instance:updateCard(slot0._lastCardInfoPushMsg)
		FightController.instance:dispatchEvent(FightEvent.PushCardInfo)

		slot0._lastCardInfoPushMsg = nil
	end
end

function slot0.onReceiveTeamInfoPush(slot0, slot1, slot2)
	FightLocalDataMgr.instance:updateFightData(slot2.fight)
	FightDataMgr.instance:updateFightData(slot2.fight)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:compareUpdate(slot2.fight)
	else
		FightModel.instance:updateFight(slot2.fight)
	end

	FightController.instance:dispatchEvent(FightEvent.PushTeamInfo)
end

function slot0.sendEndFightRequest(slot0, slot1)
	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		uv0.instance:sendGetFightRecordAllRequest()
	end

	slot2 = FightModule_pb.EndFightRequest()
	slot2.isAbort = slot1

	slot0:sendMsg(slot2)
	FightController.instance:dispatchEvent(FightEvent.OnReqEndFight)
end

function slot0.onReceiveEndFightReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightController.instance:dispatchEvent(FightEvent.RespEndFight)
	else
		FightController.instance:dispatchEvent(FightEvent.RespEndFightFail)
		FightController.instance:errorAndEnterMainScene()
	end
end

function slot0.onReceiveEndFightPush(slot0, slot1, slot2)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	FightDataHelper.lastFightResult = slot2.record.fightResult

	FightMgr.instance:enterStage(FightStageMgr.StageType.End)

	FightModel.instance.needFightReconnect = false

	FightModel.instance:updateRecord(slot2.record)
	FightModel.instance:updateMySide(slot2.fightGroupA)
	FightModel.instance:recordFightGroup(slot2.fightGroupA)
	FightModel.instance:onEndFight()
	FightModel.instance:recordPassModel(slot2)
	FightCardModel.instance:clearCardOps()
	FightController.instance:dispatchEvent(FightEvent.PushEndFight)
end

function slot0.onReceiveFightWavePush(slot0, slot1, slot2)
	if slot1 == 0 then
		FightDataHelper.cacheFightWavePush(slot2)
	end

	FightModel.instance:setNextWaveMsg(slot2)
	FightController.instance:dispatchEvent(FightEvent.PushFightWave)
end

function slot0.sendUseClothSkillRequest(slot0, slot1, slot2, slot3, slot4)
	if slot4 == FightEnum.ClothSkillType.Contract then
		FightModel.instance:setNotifyContractInfo(nil, )
	end

	FightModule_pb.UseClothSkillRequest().skillId = slot1

	if slot2 then
		slot5.fromId = slot2
	end

	if slot3 then
		slot5.toId = slot3
	end

	slot5.type = slot4 or FightEnum.ClothSkillType.ClothSkill

	slot0:sendMsg(slot5)
end

function slot0.onReceiveUseClothSkillReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightModel.instance:updateClothSkillRound(slot2.round)
		FightSystem.instance:startClothSkillRound()
	else
		FightController.instance:dispatchEvent(FightEvent.RespUseClothSkillFail)
	end
end

function slot0.sendAutoRoundRequest(slot0, slot1)
	for slot5 = #tabletool.copy(slot1), 1, -1 do
		if slot1[slot5]:isSimulateDissolveCard() then
			table.remove(slot1, slot5)
		end
	end

	slot2 = FightModule_pb.AutoRoundRequest()

	for slot6, slot7 in ipairs(slot1) do
		slot8 = FightDef_pb.BeginRoundOper()
		slot8.operType = slot7.operType
		slot8.param1 = slot7.param1

		if slot7.param2 then
			slot8.param2 = slot7.param2
		end

		if slot7.toId then
			slot8.toId = slot7.toId
		end

		table.insert(slot2.opers, slot8)
	end

	slot2.toId = FightCardModel.instance.curSelectEntityId or "0"

	slot0:sendMsg(slot2)
end

function slot0.onReceiveAutoRoundReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightModel.instance:onAutoRound(slot2.opers)
		FightController.instance:dispatchEvent(FightEvent.AutoPlayCard)
	end
end

function slot0.onReceiveRedealCardInfoPush(slot0, slot1, slot2)
	if slot1 == 0 then
		FightLocalDataMgr.instance.handCardMgr:cacheRedealCard(slot2)
		FightDataMgr.instance.handCardMgr:cacheRedealCard(slot2)
		FightCardModel.instance:clearDistributeQueue()

		FightCardModel.instance.redealCardInfoList = FightHelper.buildInfoMOs(slot2.dealCardGroup, FightCardInfoMO)

		FightController.instance:dispatchEvent(FightEvent.PushRedealCardInfo)
	end
end

function slot0.sendGetFightOperRequest(slot0)
	slot0:sendMsg(FightModule_pb.GetFightOperRequest())
end

function slot0.onReceiveGetFightOperReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightReplayModel.instance:onReceiveGetFightOperReply(slot2)
		FightController.instance:dispatchEvent(FightEvent.RespGetFightOperReplay)
	else
		FightController.instance:dispatchEvent(FightEvent.RespGetFightOperReplayFail)
	end
end

function slot0.sendGetFightRecordGroupRequest(slot0, slot1)
	slot2 = FightModule_pb.GetFightRecordGroupRequest()
	slot2.episodeId = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetFightRecordGroupReply(slot0, slot1, slot2)
	if slot1 == 0 then
		slot3 = HeroGroupMO.New()

		slot3:initByFightGroup(slot2.fightGroup)
		FightController.instance:dispatchEvent(FightEvent.RespGetFightRecordGroupReply, slot3)
	end
end

function slot0.sendEntityInfoRequest(slot0, slot1)
	slot2 = FightModule_pb.EntityInfoRequest()
	slot2.uid = slot1

	slot0:sendMsg(slot2)
end

function slot0.onReceiveEntityInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightController.instance:dispatchEvent(FightEvent.onReceiveEntityInfoReply, slot2)
	end

	FightController.instance:dispatchEvent(FightEvent.CountEntityInfoReply, slot1, slot2)
end

function slot0.refreshEntityMO(slot0, slot1)
	if slot1.entityInfo and FightDataHelper.entityMgr:getById(slot2.uid) then
		slot3:init(slot2, slot3.side)
	end
end

function slot0.sendGetEntityDetailInfosRequest(slot0)
	slot0:sendMsg(FightModule_pb.GetEntityDetailInfosRequest())
end

function slot0.onReceiveGetEntityDetailInfosReply(slot0, slot1, slot2)
	if slot1 == 0 then
		GMFightEntityModel.instance:onGetEntityDetailInfos(slot2)
		GMController.instance:dispatchEvent(GMFightEntityView.Evt_OnGetEntityDetailInfos)
	end
end

function slot0.sendGetFightRecordAllRequest(slot0)
	slot0:sendMsg(FightModule_pb.GetFightRecordAllRequest())
end

function slot0.onReceiveGetFightRecordAllReply(slot0, slot1, slot2)
	if slot1 == 0 then
		GMBattleModel.instance:setGMFightRecord(slot2)
		FightController.instance:dispatchEvent(FightEvent.OnGMFightWithRecordAllReply)
	end
end

function slot0.sendFightWithRecordAllRequest(slot0, slot1)
	slot0:sendMsg(slot1)
end

function slot0.onReceiveFightWithRecordAllReply(slot0, slot1, slot2)
	if slot1 == 0 then
		uv0.instance:onReceiveTestFightReply(slot1, slot2)
	end
end

slot0.DeckInfoRequestType = {
	MySide = 0,
	EnemySide = 1
}

function slot0.sendGetFightCardDeckInfoRequest(slot0, slot1)
	slot2 = FightModule_pb.GetFightCardDeckInfoRequest()
	slot2.type = slot1 or uv0.DeckInfoRequestType.MySide

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetFightCardDeckInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		FightController.instance:dispatchEvent(FightEvent.GetFightCardDeckInfoReply, slot2)
	end
end

function slot0.sendGetFightCardDeckDetailInfoRequest(slot0, slot1)
	slot2 = FightModule_pb.GetFightCardDeckDetailInfoRequest()
	slot2.type = slot1 or uv0.DeckInfoRequestType.MySide

	slot0:sendMsg(slot2)
end

function slot0.onReceiveGetFightCardDeckDetailInfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		ViewMgr.instance:openView(ViewName.FightCardDeckGMView, slot2)
	end
end

function slot0.onReceiveAct174FightRoundInfo(slot0, slot1, slot2)
	FightMgr.instance:playGMDouQuQu(slot2)
end

slot0.instance = slot0.New()

return slot0
