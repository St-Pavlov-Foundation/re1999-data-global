module("modules.logic.sp01.assassin2.rpc.AssassinSceneRpc", package.seeall)

local var_0_0 = class("AssassinSceneRpc", BaseRpc)

function var_0_0.sendEnterAssassinSceneRequest(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	local var_1_0 = AssassinSceneModule_pb.EnterAssassinSceneRequest()

	var_1_0.questId = arg_1_1

	for iter_1_0, iter_1_1 in ipairs(arg_1_2) do
		table.insert(var_1_0.heroIds, iter_1_1)
	end

	arg_1_0:sendMsg(var_1_0, arg_1_3, arg_1_4)
end

function var_0_0.onReceiveEnterAssassinSceneReply(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 ~= 0 then
		return
	end
end

function var_0_0.sendHeroMoveRequest(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = AssassinSceneModule_pb.HeroMoveRequest()

	var_3_0.uid = arg_3_1
	var_3_0.actId = arg_3_2
	var_3_0.param = arg_3_3

	arg_3_0:sendMsg(var_3_0, arg_3_4, arg_3_5)
end

function var_0_0.onReceiveHeroMoveReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= 0 then
		return
	end
end

function var_0_0.sendHeroAttackRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = AssassinSceneModule_pb.HeroAttackRequest()

	var_5_0.uid = arg_5_1
	var_5_0.actId = arg_5_2
	var_5_0.targetId = arg_5_3

	arg_5_0:sendMsg(var_5_0, arg_5_4, arg_5_5)
end

function var_0_0.onReceiveHeroAttackReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= 0 then
		return
	end
end

function var_0_0.sendHeroAssassinRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = AssassinSceneModule_pb.HeroAssassinRequest()

	var_7_0.uid = arg_7_1
	var_7_0.actId = arg_7_2
	var_7_0.param = arg_7_3

	arg_7_0:sendMsg(var_7_0, arg_7_4, arg_7_5)
end

function var_0_0.onReceiveHeroAssassinReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 ~= 0 then
		return
	end
end

function var_0_0.sendHeroInteractiveRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = AssassinSceneModule_pb.HeroInteractiveRequest()

	var_9_0.uid = arg_9_1
	var_9_0.interactiveId = arg_9_2

	arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveHeroInteractiveReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 ~= 0 then
		return
	end
end

function var_0_0.sendFinishUserTurnRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = AssassinSceneModule_pb.FinishUserTurnRequest()

	var_11_0.round = arg_11_1

	arg_11_0:sendMsg(var_11_0, arg_11_2, arg_11_3)
end

function var_0_0.onReceiveFinishUserTurnReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 ~= 0 then
		return
	end
end

function var_0_0.sendNextRoundRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = AssassinSceneModule_pb.NextRoundRequest()

	var_13_0.round = arg_13_1

	arg_13_0:sendMsg(var_13_0, arg_13_2, arg_13_3)
end

function var_0_0.onReceiveNextRoundReply(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_1 ~= 0 then
		return
	end
end

function var_0_0.sendFinishMissionRequest(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = AssassinSceneModule_pb.FinishMissionRequest()

	var_15_0.missionId = arg_15_1

	arg_15_0:sendMsg(var_15_0, arg_15_2, arg_15_3)
end

function var_0_0.onReceiveFinishMissionReply(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 ~= 0 then
		return
	end
end

function var_0_0.sendReturnAssassinSceneRequest(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = AssassinSceneModule_pb.ReturnAssassinSceneRequest()

	var_17_0.mapId = arg_17_1

	arg_17_0:sendMsg(var_17_0, arg_17_2, arg_17_3)
end

function var_0_0.onReceiveReturnAssassinSceneReply(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 ~= 0 then
		return
	end
end

function var_0_0.sendRecoverSceneRequest(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = AssassinSceneModule_pb.RecoverSceneRequest()

	var_19_0.mapId = arg_19_1

	arg_19_0:sendMsg(var_19_0, arg_19_2, arg_19_3)
end

function var_0_0.onReceiveRecoverSceneReply(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_1 ~= 0 then
		return
	end
end

function var_0_0.sendUseAssassinItemRequest(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4, arg_21_5)
	local var_21_0 = AssassinSceneModule_pb.UseAssassinItemRequest()

	var_21_0.uid = arg_21_1
	var_21_0.itemId = arg_21_2
	var_21_0.targetId = arg_21_3

	arg_21_0:sendMsg(var_21_0, arg_21_4, arg_21_5)
end

function var_0_0.onReceiveUseAssassinItemReply(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 ~= 0 then
		return
	end
end

function var_0_0.sendAssassinUseSkillRequest(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = AssassinSceneModule_pb.AssassinUseSkillRequest()

	var_23_0.uid = arg_23_1
	var_23_0.targetId = arg_23_2

	arg_23_0:sendMsg(var_23_0, arg_23_3, arg_23_4)
end

function var_0_0.onReceiveAssassinUseSkillReply(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 ~= 0 then
		return
	end
end

function var_0_0.sendRestartAssassinSceneRequest(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = AssassinSceneModule_pb.RestartAssassinSceneRequest()

	var_25_0.mapId = arg_25_1

	arg_25_0:sendMsg(var_25_0, arg_25_2, arg_25_3)
end

function var_0_0.onReceiveRestartAssassinSceneReply(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 ~= 0 then
		return
	end
end

function var_0_0.sendGiveUpAssassinSceneRequest(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = AssassinSceneModule_pb.GiveUpAssassinSceneRequest()

	var_27_0.mapId = arg_27_1

	arg_27_0:sendMsg(var_27_0, arg_27_2, arg_27_3)
end

function var_0_0.onReceiveGiveUpAssassinSceneReply(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 ~= 0 then
		return
	end
end

function var_0_0.sendAssassinChangeMapRequest(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = AssassinSceneModule_pb.AssassinChangeMapRequest()

	var_29_0.mapId = arg_29_1

	arg_29_0:sendMsg(var_29_0, arg_29_2, arg_29_3)
end

function var_0_0.onReceiveAssassinChangeMapReply(arg_30_0, arg_30_1, arg_30_2)
	if arg_30_1 ~= 0 then
		return
	end
end

function var_0_0.sendEnterBattleGridRequest(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	local var_31_0 = AssassinSceneModule_pb.EnterBattleGridRequest()

	var_31_0.battleGridId = arg_31_1

	arg_31_0:sendMsg(var_31_0, arg_31_2, arg_31_3)
end

function var_0_0.onReceiveEnterBattleGridReply(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 ~= 0 then
		return
	end
end

function var_0_0.onReceiveSummonMonsterPush(arg_33_0, arg_33_1, arg_33_2)
	if arg_33_1 ~= 0 then
		return
	end

	AssassinStealthGameController.instance:enemyBornByList(arg_33_2.summons)
end

function var_0_0.onReceiveMonsterUpdatePush(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_1 ~= 0 then
		return
	end

	AssassinStealthGameController.instance:updateEnemies(arg_34_2.monsters)
end

function var_0_0.onReceiveNewInteractivePush(arg_35_0, arg_35_1, arg_35_2)
	if arg_35_1 ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:setInteractiveList(arg_35_2.interactiveIds)
	AssassinStealthGameEntityMgr.instance:refreshAllGrid()
	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.OnQTEInteractUpdate)
end

function var_0_0.onReceiveMissionUpdatePush(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_1 ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:setMissionData(arg_36_2.mission)
	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.OnMissionUpdate)
end

function var_0_0.onReceiveGameStatePush(arg_37_0, arg_37_1, arg_37_2)
	if arg_37_1 ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:setGameState(arg_37_2.gameState)

	if arg_37_2.gameState == AssassinEnum.GameState.Win then
		AssassinController.instance:onFinishQuest(arg_37_2.questId)
	end

	if AssassinStealthGameModel.instance:isPlayerTurn() then
		AssassinStealthGameController.instance:checkGameState()
	end
end

function var_0_0.onReceiveGainItemPush(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 ~= 0 then
		return
	end

	local var_38_0 = {}
	local var_38_1 = {}
	local var_38_2 = arg_38_2.uid

	for iter_38_0, iter_38_1 in ipairs(arg_38_2.items) do
		local var_38_3 = iter_38_1.itemId
		local var_38_4 = iter_38_1.count
		local var_38_5 = AssassinStealthGameModel.instance:getHeroMo(var_38_2, true)

		if var_38_5 then
			if var_38_5:getItemCount(var_38_3) <= 0 then
				var_38_1[var_38_3] = true
			end

			var_38_5:AddItem(var_38_3, var_38_4)
		end

		local var_38_6 = {
			itemId = var_38_3,
			count = var_38_4
		}

		var_38_0[#var_38_0 + 1] = var_38_6
	end

	AssassinController.instance:openAssassinStealthGameGetItemView(var_38_0)
	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.OnHeroGetItem, var_38_2, var_38_1)
end

function var_0_0.onReceiveAssassinChangingMapPush(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_1 ~= 0 then
		return
	end

	AssassinStealthGameModel.instance:setGameRequestData()
	AssassinStealthGameController.instance:changeMap(arg_39_2.mapId)
end

function var_0_0.onReceiveHeroUpdatePush(arg_40_0, arg_40_1, arg_40_2)
	if arg_40_1 ~= 0 then
		return
	end

	AssassinStealthGameController.instance:updateHeroes(arg_40_2.hero)
end

var_0_0.instance = var_0_0.New()

return var_0_0
