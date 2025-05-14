module("modules.logic.tower.rpc.TowerRpc", package.seeall)

local var_0_0 = class("TowerRpc", BaseRpc)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.sendGetTowerInfoRequest(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = TowerModule_pb.GetTowerInfoRequest()

	return arg_3_0:sendMsg(var_3_0, arg_3_1, arg_3_2)
end

function var_0_0.onReceiveGetTowerInfoReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == 0 then
		TowerModel.instance:onReceiveGetTowerInfoReply(arg_4_2)
		TowerController.instance:dispatchEvent(TowerEvent.TowerUpdate)
	end
end

function var_0_0.sendTowerMopUpRequest(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = TowerModule_pb.TowerMopUpRequest()

	var_5_0.times = arg_5_1

	return arg_5_0:sendMsg(var_5_0, arg_5_2, arg_5_3)
end

function var_0_0.onReceiveTowerMopUpReply(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == 0 then
		TowerModel.instance:updateMopUpTimes(arg_6_2.mopUpTimes)
		TowerController.instance:dispatchEvent(TowerEvent.TowerMopUp, arg_6_2.mopUpTimes)
	end
end

function var_0_0.sendTowerActiveTalentRequest(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = TowerModule_pb.TowerActiveTalentRequest()

	var_7_0.bossId = arg_7_1
	var_7_0.talentId = arg_7_2

	return arg_7_0:sendMsg(var_7_0, arg_7_3, arg_7_4)
end

function var_0_0.onReceiveTowerActiveTalentReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == 0 then
		TowerAssistBossModel.instance:onTowerActiveTalent(arg_8_2)
		TowerController.instance:dispatchEvent(TowerEvent.ActiveTalent, arg_8_2.talentId)
	end
end

function var_0_0.sendTowerResetTalentRequest(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = TowerModule_pb.TowerResetTalentRequest()

	var_9_0.bossId = arg_9_1
	var_9_0.talentId = arg_9_2

	return arg_9_0:sendMsg(var_9_0, arg_9_3, arg_9_4)
end

function var_0_0.onReceiveTowerResetTalentReply(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == 0 then
		TowerAssistBossModel.instance:onTowerResetTalent(arg_10_2)
		TowerController.instance:dispatchEvent(TowerEvent.ResetTalent, arg_10_2.talentId)
	end
end

function var_0_0.sendTowerResetSubEpisodeRequest(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	local var_11_0 = TowerModule_pb.TowerResetSubEpisodeRequest()

	var_11_0.towerType = arg_11_1
	var_11_0.towerId = arg_11_2
	var_11_0.layerId = arg_11_3
	var_11_0.subEpisode = arg_11_4

	return arg_11_0:sendMsg(var_11_0, arg_11_5, arg_11_6)
end

function var_0_0.onReceiveTowerResetSubEpisodeReply(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == 0 then
		TowerModel.instance:resetTowerSubEpisode(arg_12_2)
		TowerController.instance:dispatchEvent(TowerEvent.OnTowerResetSubEpisode, arg_12_2)
	end
end

function var_0_0.sendStartTowerBattleRequest(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = TowerModule_pb.StartTowerBattleRequest()
	local var_13_1 = TowerModel.instance:getRecordFightParam()

	var_13_0.type = var_13_1.towerType
	var_13_0.towerId = var_13_1.towerId or 0
	var_13_0.layerId = var_13_1.layerId or 0
	var_13_0.difficulty = var_13_1.difficulty or 0

	arg_13_0:packStartTowerBattleRequest(var_13_0, arg_13_1)

	return arg_13_0:sendMsg(var_13_0, arg_13_2, arg_13_3)
end

function var_0_0.onReceiveStartTowerBattleReply(arg_14_0, arg_14_1, arg_14_2)
	FightRpc.instance:onReceiveTestFightReply(arg_14_1, arg_14_2 and arg_14_2.startDungeonReply)
end

function var_0_0.packStartTowerBattleRequest(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1.startDungeonRequest
	local var_15_1 = arg_15_2.fightParam

	var_15_0.chapterId = arg_15_2.chapterId
	var_15_0.episodeId = arg_15_2.episodeId
	var_15_0.isRestart = arg_15_2.isRestart and true or false
	var_15_0.isBalance = HeroGroupBalanceHelper.getIsBalanceMode()
	var_15_0.multiplication = arg_15_2.multiplication or 1
	var_15_0.useRecord = arg_15_2.useRecord and true or false

	if var_15_1 then
		var_15_1:setReqFightGroup(var_15_0)
		FightModel.instance:recordFightGroup(var_15_0.fightGroup)
	end
end

function var_0_0.onReceiveTowerBattleFinishPush(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == 0 then
		TowerModel.instance:onReceiveTowerBattleFinishPush(arg_16_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
