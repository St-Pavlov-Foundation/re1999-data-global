module("modules.logic.fight.rpc.FightRpc", package.seeall)

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
		local var_2_0 = FightData.New(arg_2_2.fight)

		FightMgr.instance:startFight(var_2_0)
		FightModel.instance:updateFight(var_2_0)
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
		local var_4_0 = FightData.New(arg_4_2.fight)

		FightMgr.instance:startFight(var_4_0)
		FightModel.instance:updateFight(var_4_0)
		FightModel.instance:refreshBattleId(var_4_0)
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
		local var_6_0 = FightData.New(arg_6_2.fight)

		FightMgr.instance:startFight(var_6_0)
		FightModel.instance:updateFight(var_6_0)
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
		local var_8_0 = FightDataHelper.operationDataMgr:getOpList()

		FightMgr.instance:cancelOperation()
		FightController.instance:dispatchEvent(FightEvent.ResetCard, var_8_0)
	end
end

function var_0_0.sendBeginRoundRequest(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:buildBeginRoundOper(arg_9_1)

	arg_9_0._beginRoundOps = arg_9_1

	local var_9_1 = FightModule_pb.BeginRoundRequest()

	tabletool.addValues(var_9_1.opers, var_9_0)
	arg_9_0:sendMsg(var_9_1)
end

function var_0_0.buildBeginRoundOper(arg_10_0, arg_10_1)
	arg_10_1 = tabletool.copy(arg_10_1)

	for iter_10_0 = #arg_10_1, 1, -1 do
		if arg_10_1[iter_10_0]:isSimulateDissolveCard() then
			table.remove(arg_10_1, iter_10_0)
		end
	end

	local var_10_0 = {}

	for iter_10_1, iter_10_2 in ipairs(arg_10_1) do
		local var_10_1 = FightDef_pb.BeginRoundOper()

		var_10_1.operType = iter_10_2.operType

		if iter_10_2.toId then
			var_10_1.toId = iter_10_2.toId
		end

		var_10_1.param1 = iter_10_2.param1

		if iter_10_2.param2 then
			var_10_1.param2 = iter_10_2.param2
		end

		if iter_10_2.param3 then
			var_10_1.param3 = iter_10_2.param3
		end

		table.insert(var_10_0, var_10_1)
	end

	return var_10_0
end

function var_0_0.onReceiveBeginRoundReply(arg_11_0, arg_11_1, arg_11_2)
	FightDataHelper.stageMgr:exitOperateState(FightStageMgr.FightStateType.sendOperation2Server)
	FightDataHelper.paTaMgr:resetOp()

	if arg_11_1 == 0 then
		if arg_11_2:HasField("round") then
			arg_11_0._beginRoundOps = nil

			FightModel.instance:updateFightRound(arg_11_2.round)
			FightGameMgr.playMgr:playShow()
			FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
		else
			var_0_0.instance:sendEndFightRequest(false)
		end
	else
		if not FightModel.instance:isFinish() then
			GameFacade.showMessageBox(MessageBoxIdDefine.FightException, MsgBoxEnum.BoxType.Yes_No, function()
				if arg_11_0._beginRoundOps then
					var_0_0.instance:sendBeginRoundRequest(arg_11_0._beginRoundOps)
				else
					logError("回合操作步骤不存在")
				end
			end)
		end

		FightController.instance:dispatchEvent(FightEvent.RespBeginRoundFail)
	end
end

function var_0_0.sendChangeSubHeroRequest(arg_13_0, arg_13_1, arg_13_2)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)

	local var_13_0 = FightModule_pb.ChangeSubHeroRequest()

	var_13_0.subHeroId = arg_13_1
	var_13_0.changeHeroId = arg_13_2

	arg_13_0:sendMsg(var_13_0)
end

function var_0_0.onReceiveChangeSubHeroReply(arg_14_0, arg_14_1, arg_14_2)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)
	FightController.instance:dispatchEvent(FightEvent.ReceiveChangeSubHeroReply, arg_14_1)

	if arg_14_1 == 0 and arg_14_2:HasField("round") then
		FightModel.instance:updateFightRound(arg_14_2.round)
		FightGameMgr.playMgr:playShow()
		FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
	end
end

function var_0_0.sendChangeSubHeroExSkillRequest(arg_15_0, arg_15_1)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)

	local var_15_0 = FightModule_pb.ChangeSubHeroExSkillRequest()

	var_15_0.exSkillTarget = arg_15_1

	arg_15_0:sendMsg(var_15_0)
end

function var_0_0.onReceiveChangeSubHeroExSkillReply(arg_16_0, arg_16_1, arg_16_2)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.PlaySeasonChangeHero)
	FightController.instance:dispatchEvent(FightEvent.ChangeSubHeroExSkillReply, arg_16_1)

	if arg_16_1 == 0 and arg_16_2:HasField("round") then
		FightModel.instance:updateFightRound(arg_16_2.round)
		FightGameMgr.playMgr:playShow()
		FightController.instance:dispatchEvent(FightEvent.RespBeginRound)
	end
end

function var_0_0.sendReconnectFightRequest(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = FightModule_pb.ReconnectFightRequest()

	return arg_17_0:sendMsg(var_17_0, arg_17_1, arg_17_2)
end

function var_0_0.onReceiveReconnectFightReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 then
		FightModel.instance.needFightReconnect = arg_18_2:HasField("fight")

		if FightModel.instance.needFightReconnect then
			local var_18_0 = FightData.New(arg_18_2.fight)

			if var_18_0.version < 1 and arg_18_2.fightReason.type == FightEnum.FightReason.DungeonRecord then
				var_18_0.isRecord = true
			end

			FightMgr.instance:startFight(var_18_0)
			FightModel.instance:updateFight(var_18_0)
			FightModel.instance:updateFightRound(arg_18_2.lastRound)
			FightModel.instance:updateFightReason(arg_18_2.fightReason)
			FightModel.instance:recordFightGroup(arg_18_2.fightGroup)
		end

		FightController.instance:dispatchEvent(FightEvent.RespReconnectFight)
	end
end

function var_0_0.onReceiveCardInfoPush(arg_19_0, arg_19_1, arg_19_2)
	FightLocalDataMgr.instance.handCardMgr:updateHandCardByProto(arg_19_2.cardGroup)
	FightLocalDataMgr.instance.operationDataMgr:dealCardInfoPush(arg_19_2)

	arg_19_0._lastCardInfoPushMsg = arg_19_2

	if arg_19_2.isGm then
		arg_19_0:dealCardInfoPushData()
	end
end

function var_0_0.dealCardInfoPushData(arg_20_0)
	if arg_20_0._lastCardInfoPushMsg then
		FightDataMgr.instance.handCardMgr:updateHandCardByProto(arg_20_0._lastCardInfoPushMsg.cardGroup)
		FightDataMgr.instance.operationDataMgr:dealCardInfoPush(arg_20_0._lastCardInfoPushMsg)
		FightController.instance:dispatchEvent(FightEvent.PushCardInfo)

		arg_20_0._lastCardInfoPushMsg = nil
	end
end

function var_0_0.onReceiveTeamInfoPush(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = GameSceneMgr.instance:getCurSceneType() == SceneType.Fight
	local var_21_1 = GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr
	local var_21_2 = FightData.New(arg_21_2.fight)

	FightLocalDataMgr.instance:updateFightData(var_21_2)
	FightDataMgr.instance:updateFightData(var_21_2)

	if var_21_0 then
		var_21_1:compareUpdate(var_21_2)
	else
		FightModel.instance:updateFight(var_21_2)
	end

	FightController.instance:dispatchEvent(FightEvent.PushTeamInfo)
end

function var_0_0.sendEndFightRequest(arg_22_0, arg_22_1)
	if isDebugBuild and GMBattleModel.instance.enableGMFightRecord then
		var_0_0.instance:sendGetFightRecordAllRequest()
	end

	local var_22_0 = FightModule_pb.EndFightRequest()

	var_22_0.isAbort = arg_22_1

	arg_22_0:sendMsg(var_22_0)
	FightController.instance:dispatchEvent(FightEvent.OnReqEndFight)
end

function var_0_0.onReceiveEndFightReply(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 == 0 then
		FightController.instance:dispatchEvent(FightEvent.RespEndFight)
	else
		FightController.instance:dispatchEvent(FightEvent.RespEndFightFail)
		FightController.instance:errorAndEnterMainScene()
	end
end

function var_0_0.onReceiveEndFightPush(arg_24_0, arg_24_1, arg_24_2)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	FightDataHelper.lastFightResult = arg_24_2.record.fightResult
	FightModel.instance.needFightReconnect = false

	FightModel.instance:updateRecord(arg_24_2.record)
	FightModel.instance:updateMySide(arg_24_2.fightGroupA)
	FightModel.instance:recordFightGroup(arg_24_2.fightGroupA)
	FightModel.instance:onEndFight()
	FightModel.instance:recordPassModel(arg_24_2)
	FightController.instance:dispatchEvent(FightEvent.PushEndFight)
end

function var_0_0.onReceiveFightWavePush(arg_25_0, arg_25_1, arg_25_2)
	if arg_25_1 == 0 then
		local var_25_0 = FightData.New(arg_25_2.fight)

		FightDataHelper.cacheFightWavePush(var_25_0)
	end

	FightModel.instance:setNextWaveMsg(arg_25_2)
	FightController.instance:dispatchEvent(FightEvent.PushFightWave)
end

function var_0_0.sendUseClothSkillRequest(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4)
	if arg_26_4 == FightEnum.ClothSkillType.Contract then
		FightModel.instance:setNotifyContractInfo(nil, nil)
	end

	local var_26_0 = FightModule_pb.UseClothSkillRequest()

	var_26_0.skillId = arg_26_1

	if arg_26_2 then
		var_26_0.fromId = arg_26_2
	end

	if arg_26_3 then
		var_26_0.toId = arg_26_3
	end

	var_26_0.type = arg_26_4 or FightEnum.ClothSkillType.ClothSkill

	arg_26_0:sendMsg(var_26_0)
end

function var_0_0.onReceiveUseClothSkillReply(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == 0 then
		FightModel.instance:updateClothSkillRound(arg_27_2.round)
		FightGameMgr.playMgr:playCloth()
	else
		FightController.instance:dispatchEvent(FightEvent.RespUseClothSkillFail)
	end
end

function var_0_0.sendAutoRoundRequest(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:buildBeginRoundOper(arg_28_1)
	local var_28_1 = FightModule_pb.AutoRoundRequest()

	tabletool.addValues(var_28_1.opers, var_28_0)

	local var_28_2 = FightDataHelper.operationDataMgr.curSelectEntityId

	var_28_1.toId = var_28_2 == 0 and "0" or var_28_2

	arg_28_0:sendMsg(var_28_1)
end

function var_0_0.onReceiveAutoRoundReply(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1 == 0 then
		FightMsgMgr.sendMsg(FightMsgId.AutoRoundReply, arg_29_2)
	else
		FightMsgMgr.sendMsg(FightMsgId.AutoRoundReplyFail)
	end
end

function var_0_0.onReceiveRedealCardInfoPush(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 == 0 then
		FightLocalDataMgr.instance.handCardMgr:cacheRedealCard(arg_30_2)
		FightDataMgr.instance.handCardMgr:cacheRedealCard(arg_30_2)
		FightController.instance:dispatchEvent(FightEvent.PushRedealCardInfo)
	end
end

function var_0_0.sendGetFightOperRequest(arg_31_0)
	local var_31_0 = FightModule_pb.GetFightOperRequest()

	arg_31_0:sendMsg(var_31_0)
end

function var_0_0.onReceiveGetFightOperReply(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 == 0 then
		FightReplayModel.instance:onReceiveGetFightOperReply(arg_32_2)
		FightController.instance:dispatchEvent(FightEvent.RespGetFightOperReplay)
	else
		FightController.instance:dispatchEvent(FightEvent.RespGetFightOperReplayFail)
	end
end

function var_0_0.sendGetFightRecordGroupRequest(arg_33_0, arg_33_1)
	local var_33_0 = FightModule_pb.GetFightRecordGroupRequest()

	var_33_0.episodeId = arg_33_1

	arg_33_0:sendMsg(var_33_0)
end

function var_0_0.onReceiveGetFightRecordGroupReply(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 == 0 then
		local var_34_0 = HeroGroupMO.New()

		var_34_0:initByFightGroup(arg_34_2.fightGroup)
		FightController.instance:dispatchEvent(FightEvent.RespGetFightRecordGroupReply, var_34_0)
	end
end

function var_0_0.sendEntityInfoRequest(arg_35_0, arg_35_1)
	local var_35_0 = FightModule_pb.EntityInfoRequest()

	var_35_0.uid = arg_35_1

	arg_35_0:sendMsg(var_35_0)
end

function var_0_0.onReceiveEntityInfoReply(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 == 0 then
		FightController.instance:dispatchEvent(FightEvent.onReceiveEntityInfoReply, arg_36_2)
	end

	FightController.instance:dispatchEvent(FightEvent.CountEntityInfoReply, arg_36_1, arg_36_2)
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
