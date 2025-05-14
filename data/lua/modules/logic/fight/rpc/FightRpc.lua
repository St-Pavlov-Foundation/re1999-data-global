﻿module("modules.logic.fight.rpc.FightRpc", package.seeall)

local var_0_0 = class("FightRpc", BaseRpc)

function var_0_0.sendBeginFightRequest(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = FightModule_pb.BeginFightRequest()

	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		table.insert(var_1_0.heroList, iter_1_1)
	end

	if arg_1_2 then
		for iter_1_2, iter_1_3 in ipairs(arg_1_2) do
			table.insert(var_1_0.subHeroList, iter_1_3)
		end
	end

	arg_1_0:sendMsg(var_1_0)
end

function var_0_0.onReceiveBeginFightReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == 0 then
		FightMgr.instance:startFight(arg_2_2.fight)
		FightModel.instance:updateFight(arg_2_2.fight)
		FightModel.instance:updateFightRound(arg_2_2.round)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		FightModel.instance:setFightParam(nil)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFightFail)
	end
end

function var_0_0.sendTestFightRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = FightModule_pb.TestFightRequest()

	arg_3_1:setReqFightGroup(var_3_0)

	for iter_3_0, iter_3_1 in ipairs(arg_3_2) do
		table.insert(var_3_0.groupIds, iter_3_1)
	end

	var_3_0.fightActType = arg_3_3 or FightEnum.FightActType.Normal

	arg_3_0:sendMsg(var_3_0)
end

function var_0_0.onReceiveTestFightReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		FightMgr.instance:startFight(arg_4_2.fight)
		FightModel.instance:updateFight(arg_4_2.fight)
		FightModel.instance:refreshBattleId(arg_4_2.fight)
		FightModel.instance:updateFightRound(arg_4_2.round)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		FightController.instance:dispatchEvent(FightEvent.RespBeginFightFail)
	end
end

function var_0_0.sendTestFightIdRequest(arg_5_0, arg_5_1)
	local var_5_0 = FightModule_pb.TestFightIdRequest()

	arg_5_1:setReqFightGroup(var_5_0)

	var_5_0.fightId = arg_5_1.battleId
	var_5_0.fightActType = arg_5_1.fightActType or FightEnum.FightActType.Normal

	arg_5_0:sendMsg(var_5_0)
end

function var_0_0.onReceiveTestFightIdReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		FightMgr.instance:startFight(arg_6_2.fight)
		FightModel.instance:updateFight(arg_6_2.fight)
		FightModel.instance:updateFightRound(arg_6_2.round)
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		FightController.instance:dispatchEvent(FightEvent.RespBeginFightFail)
	end
end

function var_0_0.sendResetRoundRequest(arg_7_0)
	local var_7_0 = FightModule_pb.ResetRoundRequest()

	arg_7_0:sendMsg(var_7_0)
end

function var_0_0.onReceiveResetRoundReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		if arg_8_2:HasField("fight") then
			FightModel.instance:updateFight(arg_8_2.fight)
		end

		if arg_8_2:HasField("round") then
			FightModel.instance:updateFightRound(arg_8_2.round)

			FightCardModel.instance:getCardMO().actPoint = arg_8_2.round.actPoint
		end

		local var_8_0 = FightCardModel.instance:getCardOps()

		if #arg_8_2.cards > 0 then
			local var_8_1 = FightHelper.buildInfoMOs(arg_8_2.cards, FightCardInfoMO)

			FightCardModel.instance:clearCardOps()
			FightCardModel.instance:coverCard(var_8_1)

			local var_8_2 = FightCardModel.instance:getCardMO().cardGroup

			FightController.instance:dispatchEvent(FightEvent.UpdateHandCards, var_8_2)
		end

		FightMgr.instance:cancelOperation()
		FightController.instance:dispatchEvent(FightEvent.ResetCard, var_8_0)
	end
end

function var_0_0.sendBeginRoundRequest(arg_9_0, arg_9_1)
	for iter_9_0 = #arg_9_1, 1, -1 do
		if arg_9_1[iter_9_0]:isSimulateDissolveCard() then
			table.remove(arg_9_1, iter_9_0)
		end
	end

	arg_9_0._beginRoundOps = arg_9_1

	local var_9_0 = FightModule_pb.BeginRoundRequest()

	for iter_9_1, iter_9_2 in ipairs(arg_9_1) do
		local var_9_1 = FightDef_pb.BeginRoundOper()

		var_9_1.operType = iter_9_2.operType
		var_9_1.param1 = iter_9_2.param1

		if iter_9_2.param2 then
			var_9_1.param2 = iter_9_2.param2
		end

		if iter_9_2.toId then
			var_9_1.toId = iter_9_2.toId
		end

		table.insert(var_9_0.opers, var_9_1)
	end

	arg_9_0:sendMsg(var_9_0)
end

function var_0_0.onReceiveBeginRoundReply(arg_10_0, arg_10_1, arg_10_2)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.FightStateType.sendOperation2Server)
	FightCardModel.instance:clearCardOps()
	FightDataHelper.paTaMgr:resetOp()

	if arg_10_1 == 0 then
		if arg_10_2:HasField("round") then
			arg_10_0._beginRoundOps = nil

			FightModel.instance:updateFightRound(arg_10_2.round)
			FightSystem.instance:startRound()
			FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
		else
			var_0_0.instance:sendEndFightRequest(false)
		end
	else
		if not FightModel.instance:isFinish() then
			GameFacade.showMessageBox(MessageBoxIdDefine.FightException, MsgBoxEnum.BoxType.Yes_No, function()
				if arg_10_0._beginRoundOps then
					var_0_0.instance:sendBeginRoundRequest(arg_10_0._beginRoundOps)
				else
					logError("回合操作步骤不存在")
				end
			end)
		end

		FightController.instance:dispatchEvent(FightEvent.RespBeginRoundFail)
	end
end

function var_0_0.sendChangeSubHeroRequest(arg_12_0, arg_12_1, arg_12_2)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)

	local var_12_0 = FightModule_pb.ChangeSubHeroRequest()

	var_12_0.subHeroId = arg_12_1
	var_12_0.changeHeroId = arg_12_2

	arg_12_0:sendMsg(var_12_0)
end

function var_0_0.onReceiveChangeSubHeroReply(arg_13_0, arg_13_1, arg_13_2)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)
	FightController.instance:dispatchEvent(FightEvent.ReceiveChangeSubHeroReply, arg_13_1)

	if arg_13_1 == 0 and arg_13_2:HasField("round") then
		FightModel.instance:updateFightRound(arg_13_2.round)
		FightSystem.instance:startRound()
		FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
	end
end

function var_0_0.sendChangeSubHeroExSkillRequest(arg_14_0, arg_14_1)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)

	local var_14_0 = FightModule_pb.ChangeSubHeroExSkillRequest()

	var_14_0.exSkillTarget = arg_14_1

	arg_14_0:sendMsg(var_14_0)
end

function var_0_0.onReceiveChangeSubHeroExSkillReply(arg_15_0, arg_15_1, arg_15_2)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)
	FightController.instance:dispatchEvent(FightEvent.ChangeSubHeroExSkillReply, arg_15_1)

	if arg_15_1 == 0 and arg_15_2:HasField("round") then
		FightModel.instance:updateFightRound(arg_15_2.round)
		FightSystem.instance:startRound()
		FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
	end
end

function var_0_0.sendReconnectFightRequest(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = FightModule_pb.ReconnectFightRequest()

	return arg_16_0:sendMsg(var_16_0, arg_16_1, arg_16_2)
end

function var_0_0.onReceiveReconnectFightReply(arg_17_0, arg_17_1, arg_17_2)
	if arg_17_1 == 0 then
		FightModel.instance.needFightReconnect = arg_17_2:HasField("fight")

		if FightModel.instance.needFightReconnect then
			FightMgr.instance:startFight(arg_17_2.fight)
			FightModel.instance:updateFight(arg_17_2.fight)
			FightModel.instance:updateFightRound(arg_17_2.lastRound)
			FightModel.instance:updateFightReason(arg_17_2.fightReason)
			FightModel.instance:recordFightGroup(arg_17_2.fightGroup)
		end

		FightController.instance:dispatchEvent(FightEvent.RespReconnectFight)
	end
end

function var_0_0.onReceiveCardInfoPush(arg_18_0, arg_18_1, arg_18_2)
	FightLocalDataMgr.instance.handCardMgr:updateHandCardByProto(arg_18_2.cardGroup)
	FightLocalDataMgr.instance.fieldMgr:dealCardInfoPush(arg_18_2)

	arg_18_0._lastCardInfoPushMsg = arg_18_2

	if arg_18_2.isGm then
		arg_18_0:dealCardInfoPushData()
	end
end

function var_0_0.dealCardInfoPushData(arg_19_0)
	if arg_19_0._lastCardInfoPushMsg then
		FightDataMgr.instance.handCardMgr:updateHandCardByProto(arg_19_0._lastCardInfoPushMsg.cardGroup)
		FightDataMgr.instance.fieldMgr:dealCardInfoPush(arg_19_0._lastCardInfoPushMsg)
		FightCardModel.instance:updateCard(arg_19_0._lastCardInfoPushMsg)
		FightController.instance:dispatchEvent(FightEvent.PushCardInfo)

		arg_19_0._lastCardInfoPushMsg = nil
	end
end

function var_0_0.onReceiveTeamInfoPush(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = GameSceneMgr.instance:getCurSceneType() == SceneType.Fight
	local var_20_1 = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr

	FightLocalDataMgr.instance:updateFightData(arg_20_2.fight)
	FightDataMgr.instance:updateFightData(arg_20_2.fight)

	if var_20_0 then
		var_20_1:compareUpdate(arg_20_2.fight)
	else
		FightModel.instance:updateFight(arg_20_2.fight)
	end

	FightController.instance:dispatchEvent(FightEvent.PushTeamInfo)
end

function var_0_0.sendEndFightRequest(arg_21_0, arg_21_1)
	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		var_0_0.instance:sendGetFightRecordAllRequest()
	end

	local var_21_0 = FightModule_pb.EndFightRequest()

	var_21_0.isAbort = arg_21_1

	arg_21_0:sendMsg(var_21_0)
	FightController.instance:dispatchEvent(FightEvent.OnReqEndFight)
end

function var_0_0.onReceiveEndFightReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 == 0 then
		FightController.instance:dispatchEvent(FightEvent.RespEndFight)
	else
		FightController.instance:dispatchEvent(FightEvent.RespEndFightFail)
		FightController.instance:errorAndEnterMainScene()
	end
end

function var_0_0.onReceiveEndFightPush(arg_23_0, arg_23_1, arg_23_2)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	FightDataHelper.lastFightResult = arg_23_2.record.fightResult

	FightMgr.instance:enterStage(FightStageMgr.StageType.End)

	FightModel.instance.needFightReconnect = false

	FightModel.instance:updateRecord(arg_23_2.record)
	FightModel.instance:updateMySide(arg_23_2.fightGroupA)
	FightModel.instance:recordFightGroup(arg_23_2.fightGroupA)
	FightModel.instance:onEndFight()
	FightModel.instance:recordPassModel(arg_23_2)
	FightCardModel.instance:clearCardOps()
	FightController.instance:dispatchEvent(FightEvent.PushEndFight)
end

function var_0_0.onReceiveFightWavePush(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 == 0 then
		FightDataHelper.cacheFightWavePush(arg_24_2)
	end

	FightModel.instance:setNextWaveMsg(arg_24_2)
	FightController.instance:dispatchEvent(FightEvent.PushFightWave)
end

function var_0_0.sendUseClothSkillRequest(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4)
	if arg_25_4 == FightEnum.ClothSkillType.Contract then
		FightModel.instance:setNotifyContractInfo(nil, nil)
	end

	local var_25_0 = FightModule_pb.UseClothSkillRequest()

	var_25_0.skillId = arg_25_1

	if arg_25_2 then
		var_25_0.fromId = arg_25_2
	end

	if arg_25_3 then
		var_25_0.toId = arg_25_3
	end

	var_25_0.type = arg_25_4 or FightEnum.ClothSkillType.ClothSkill

	arg_25_0:sendMsg(var_25_0)
end

function var_0_0.onReceiveUseClothSkillReply(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == 0 then
		FightModel.instance:updateClothSkillRound(arg_26_2.round)
		FightSystem.instance:startClothSkillRound()
	else
		FightController.instance:dispatchEvent(FightEvent.RespUseClothSkillFail)
	end
end

function var_0_0.sendAutoRoundRequest(arg_27_0, arg_27_1)
	arg_27_1 = tabletool.copy(arg_27_1)

	for iter_27_0 = #arg_27_1, 1, -1 do
		if arg_27_1[iter_27_0]:isSimulateDissolveCard() then
			table.remove(arg_27_1, iter_27_0)
		end
	end

	local var_27_0 = FightModule_pb.AutoRoundRequest()

	for iter_27_1, iter_27_2 in ipairs(arg_27_1) do
		local var_27_1 = FightDef_pb.BeginRoundOper()

		var_27_1.operType = iter_27_2.operType
		var_27_1.param1 = iter_27_2.param1

		if iter_27_2.param2 then
			var_27_1.param2 = iter_27_2.param2
		end

		if iter_27_2.toId then
			var_27_1.toId = iter_27_2.toId
		end

		table.insert(var_27_0.opers, var_27_1)
	end

	var_27_0.toId = FightCardModel.instance.curSelectEntityId or "0"

	arg_27_0:sendMsg(var_27_0)
end

function var_0_0.onReceiveAutoRoundReply(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 == 0 then
		FightModel.instance:onAutoRound(arg_28_2.opers)
		FightController.instance:dispatchEvent(FightEvent.AutoPlayCard)
	end
end

function var_0_0.onReceiveRedealCardInfoPush(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 == 0 then
		FightLocalDataMgr.instance.handCardMgr:cacheRedealCard(arg_29_2)
		FightDataMgr.instance.handCardMgr:cacheRedealCard(arg_29_2)
		FightCardModel.instance:clearDistributeQueue()

		local var_29_0 = FightHelper.buildInfoMOs(arg_29_2.dealCardGroup, FightCardInfoMO)

		FightCardModel.instance.redealCardInfoList = var_29_0

		FightController.instance:dispatchEvent(FightEvent.PushRedealCardInfo)
	end
end

function var_0_0.sendGetFightOperRequest(arg_30_0)
	local var_30_0 = FightModule_pb.GetFightOperRequest()

	arg_30_0:sendMsg(var_30_0)
end

function var_0_0.onReceiveGetFightOperReply(arg_31_0, arg_31_1, arg_31_2)
	if arg_31_1 == 0 then
		FightReplayModel.instance:onReceiveGetFightOperReply(arg_31_2)
		FightController.instance:dispatchEvent(FightEvent.RespGetFightOperReplay)
	else
		FightController.instance:dispatchEvent(FightEvent.RespGetFightOperReplayFail)
	end
end

function var_0_0.sendGetFightRecordGroupRequest(arg_32_0, arg_32_1)
	local var_32_0 = FightModule_pb.GetFightRecordGroupRequest()

	var_32_0.episodeId = arg_32_1

	arg_32_0:sendMsg(var_32_0)
end

function var_0_0.onReceiveGetFightRecordGroupReply(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1 == 0 then
		local var_33_0 = HeroGroupMO.New()

		var_33_0:initByFightGroup(arg_33_2.fightGroup)
		FightController.instance:dispatchEvent(FightEvent.RespGetFightRecordGroupReply, var_33_0)
	end
end

function var_0_0.sendEntityInfoRequest(arg_34_0, arg_34_1)
	local var_34_0 = FightModule_pb.EntityInfoRequest()

	var_34_0.uid = arg_34_1

	arg_34_0:sendMsg(var_34_0)
end

function var_0_0.onReceiveEntityInfoReply(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 == 0 then
		FightController.instance:dispatchEvent(FightEvent.onReceiveEntityInfoReply, arg_35_2)
	end

	FightController.instance:dispatchEvent(FightEvent.CountEntityInfoReply, arg_35_1, arg_35_2)
end

function var_0_0.refreshEntityMO(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_1.entityInfo
	local var_36_1 = var_36_0 and FightDataHelper.entityMgr:getById(var_36_0.uid)

	if var_36_1 then
		var_36_1:init(var_36_0, var_36_1.side)
	end
end

function var_0_0.sendGetEntityDetailInfosRequest(arg_37_0)
	local var_37_0 = FightModule_pb.GetEntityDetailInfosRequest()

	arg_37_0:sendMsg(var_37_0)
end

function var_0_0.onReceiveGetEntityDetailInfosReply(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 == 0 then
		GMFightEntityModel.instance:onGetEntityDetailInfos(arg_38_2)
		GMController.instance:dispatchEvent(GMFightEntityView.Evt_OnGetEntityDetailInfos)
	end
end

function var_0_0.sendGetFightRecordAllRequest(arg_39_0)
	local var_39_0 = FightModule_pb.GetFightRecordAllRequest()

	arg_39_0:sendMsg(var_39_0)
end

function var_0_0.onReceiveGetFightRecordAllReply(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1 == 0 then
		GMBattleModel.instance:setGMFightRecord(arg_40_2)
		FightController.instance:dispatchEvent(FightEvent.OnGMFightWithRecordAllReply)
	end
end

function var_0_0.sendFightWithRecordAllRequest(arg_41_0, arg_41_1)
	arg_41_0:sendMsg(arg_41_1)
end

function var_0_0.onReceiveFightWithRecordAllReply(arg_42_0, arg_42_1, arg_42_2)
	if arg_42_1 == 0 then
		var_0_0.instance:onReceiveTestFightReply(arg_42_1, arg_42_2)
	end
end

var_0_0.DeckInfoRequestType = {
	MySide = 0,
	EnemySide = 1
}

function var_0_0.sendGetFightCardDeckInfoRequest(arg_43_0, arg_43_1)
	local var_43_0 = FightModule_pb.GetFightCardDeckInfoRequest()

	var_43_0.type = arg_43_1 or var_0_0.DeckInfoRequestType.MySide

	arg_43_0:sendMsg(var_43_0)
end

function var_0_0.onReceiveGetFightCardDeckInfoReply(arg_44_0, arg_44_1, arg_44_2)
	if arg_44_1 == 0 then
		FightController.instance:dispatchEvent(FightEvent.GetFightCardDeckInfoReply, arg_44_2)
	end
end

function var_0_0.sendGetFightCardDeckDetailInfoRequest(arg_45_0, arg_45_1)
	local var_45_0 = FightModule_pb.GetFightCardDeckDetailInfoRequest()

	var_45_0.type = arg_45_1 or var_0_0.DeckInfoRequestType.MySide

	arg_45_0:sendMsg(var_45_0)
end

function var_0_0.onReceiveGetFightCardDeckDetailInfoReply(arg_46_0, arg_46_1, arg_46_2)
	if arg_46_1 == 0 then
		ViewMgr.instance:openView(ViewName.FightCardDeckGMView, arg_46_2)
	end
end

function var_0_0.onReceiveAct174FightRoundInfo(arg_47_0, arg_47_1, arg_47_2)
	FightMgr.instance:playGMDouQuQu(arg_47_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
