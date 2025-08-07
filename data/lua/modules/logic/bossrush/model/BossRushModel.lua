module("modules.logic.bossrush.model.BossRushModel", package.seeall)

local var_0_0 = class("BossRushModel", Activity128Model)

function var_0_0.reInit(arg_1_0)
	var_0_0.super.reInit(arg_1_0)

	local var_1_0 = BossRushConfig.instance
	local var_1_1 = var_1_0:getActivityId()

	arg_1_0:_internal_set_config(var_1_0)
	arg_1_0:_internal_set_activity(var_1_1)

	arg_1_0._stage2LastTotalPoint = {}
	arg_1_0._fightLastScore = 0
	arg_1_0._fightCurScore = 0
	arg_1_0._infiniteBossDeadSum = 0
	arg_1_0._bossBloodCount = 0
	arg_1_0._bossHP = 0
	arg_1_0._bossIdList = nil
	arg_1_0._fightScoreList = nil
end

function var_0_0.setFightScore(arg_2_0, arg_2_1)
	arg_2_0._fightLastScore = arg_2_0:getFightScore()
	arg_2_0._fightCurScore = arg_2_1
end

function var_0_0.noticeFightScore(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._fightLastScore

	arg_3_1 = arg_3_1 or arg_3_0._fightCurScore

	BossRushController.instance:dispatchEvent(BossRushEvent.OnScoreChange, var_3_0, arg_3_1)
end

function var_0_0.getFightScore(arg_4_0)
	return arg_4_0._fightCurScore or 0
end

function var_0_0.checkIsNewHighestPointRecord(arg_5_0, arg_5_1)
	return arg_5_0:getFightScore() > arg_5_0:getHighestPoint(arg_5_1)
end

function var_0_0.getBossCurHP(arg_6_0)
	return arg_6_0._bossHP or 0
end

function var_0_0.setInfiniteBossDeadSum(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getInfiniteBossDeadSum()

	arg_7_0._infiniteBossDeadSum = arg_7_1

	if var_7_0 ~= arg_7_1 then
		BossRushController.instance:dispatchEvent(BossRushEvent.OnBossDeadSumChange, var_7_0, arg_7_1)
	end
end

function var_0_0.getInfiniteBossDeadSum(arg_8_0)
	return arg_8_0._infiniteBossDeadSum or 0
end

function var_0_0.setBossBloodCount(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getBossBloodCount()

	arg_9_0._bossBloodCount = arg_9_1

	if var_9_0 ~= arg_9_1 then
		BossRushController.instance:dispatchEvent(BossRushEvent.OnBloodCountChange, var_9_0, arg_9_1)
	end
end

function var_0_0.getBossBloodCount(arg_10_0)
	return arg_10_0._bossBloodCount or 0
end

function var_0_0.setBossIdList(arg_11_0, arg_11_1)
	arg_11_0._bossIdList = arg_11_1
end

function var_0_0.getBossIdList(arg_12_0)
	return arg_12_0._bossIdList
end

function var_0_0.getBossBloodMaxCount(arg_13_0)
	if not arg_13_0._bossIdList then
		return 0
	end

	return #arg_13_0._bossIdList
end

function var_0_0.setBossCurHP(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0._bossHP

	if arg_14_1 == var_14_0 then
		return
	end

	arg_14_0._bossHP = arg_14_1

	BossRushController.instance:dispatchEvent(BossRushEvent.OnHpChange, var_14_0, arg_14_1)
end

function var_0_0.getBossCurMaxHP(arg_15_0)
	local var_15_0 = arg_15_0:getBossEntityMO()

	if not var_15_0 then
		return 0
	end

	return var_15_0.attrMO.hp
end

function var_0_0.subBossBlood(arg_16_0)
	arg_16_0:setBossBloodCount(arg_16_0:getBossBloodCount() - 1)
end

function var_0_0.getCurBossIndex(arg_17_0)
	return arg_17_0:getBossBloodMaxCount() - math.max(0, arg_17_0:getBossBloodCount())
end

function var_0_0._isFightBossId(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getBossIdList()

	if not var_18_0 then
		return false
	end

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		if arg_18_1 == iter_18_1 then
			return true
		end
	end

	return false
end

function var_0_0.getBossEntityMO(arg_19_0)
	local var_19_0 = FightDataHelper.entityMgr:getEnemyNormalList()

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_1 = iter_19_1.modelId

		if arg_19_0:_isFightBossId(var_19_1) then
			return iter_19_1
		end
	end
end

function var_0_0.getBossEntityMOByCurBloodCount(arg_20_0)
	if not arg_20_0._bossIdList then
		return arg_20_0:getBossEntityMO()
	end

	local var_20_0 = arg_20_0:getBossBloodMaxCount()
	local var_20_1 = math.max(0, arg_20_0:getBossBloodCount())
	local var_20_2 = var_20_0 - var_20_1
	local var_20_3 = arg_20_0._bossIdList[var_20_2]

	if not var_20_3 then
		logError("[getBossEntityMOByCurBloodCount]: " .. string.format("max=%s, cur=%s, nowMax=%s", var_20_0, var_20_1, #arg_20_0._bossIdList))

		return arg_20_0:getBossEntityMO()
	end

	local var_20_4 = FightDataHelper.entityMgr:getEnemyNormalList()

	for iter_20_0, iter_20_1 in ipairs(var_20_4) do
		if var_20_3 == iter_20_1.modelId then
			return iter_20_1
		end
	end
end

function var_0_0.getMultiHpInfo(arg_21_0)
	return {
		multiHpIdx = arg_21_0:getBossBloodMaxCount() - arg_21_0:getBossBloodCount(),
		multiHpNum = arg_21_0:getBossBloodMaxCount()
	}
end

function var_0_0.inUnlimit(arg_22_0)
	local var_22_0 = arg_22_0:getMultiHpInfo()

	return var_22_0.multiHpNum - var_22_0.multiHpIdx <= 1
end

function var_0_0.setBattleStageAndLayer(arg_23_0, arg_23_1, arg_23_2)
	arg_23_0._battleStageTemp = arg_23_1
	arg_23_0._battleLayerTemp = arg_23_2
end

function var_0_0.getBattleStageAndLayer(arg_24_0)
	local var_24_0 = DungeonModel.instance.curSendEpisodeId

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or not var_24_0 then
		arg_24_0:setBattleStageAndLayer(nil, nil)

		return
	end

	local var_24_1 = arg_24_0:getConfig()

	if not arg_24_0._battleStageTemp then
		arg_24_0:setBattleStageAndLayer(var_24_1:tryGetStageAndLayerByEpisodeId(var_24_0))
	end

	return arg_24_0._battleStageTemp, arg_24_0._battleLayerTemp
end

function var_0_0._onReceiveGet128InfosReply(arg_25_0, arg_25_1)
	arg_25_0:_initStageLastTotalPoint()
	BossRushRedModel.instance:refreshAllStageLayerUnlockState()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveGet128InfosReply)
end

function var_0_0._onReceiveAct128GetTotalRewardsReply(arg_26_0, arg_26_1)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveAct128GetTotalRewardsReply)
end

function var_0_0._onReceiveAct128DoublePointReply(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.doublePoint
	local var_27_1 = arg_27_1.totalPoint

	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveAct128DoublePointRequestReply, var_27_1, var_27_0)
end

function var_0_0._onReceiveAct128InfoUpdatePush(arg_28_0, arg_28_1)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveAct128InfoUpdatePush)
end

function var_0_0.onEndDungeonExtraStr(arg_29_0, arg_29_1)
	local var_29_0 = cjson.decode(arg_29_1)
	local var_29_1 = var_29_0.evaluate
	local var_29_2 = 0

	if not string.nilorempty(var_29_0.score) then
		var_29_2 = tonumber(var_29_0.score)
	end

	arg_29_0:_setEvaluate(var_29_1)
	arg_29_0:setFightScore(var_29_2)
end

function var_0_0._setEvaluate(arg_30_0, arg_30_1)
	arg_30_0._evaluateList = {}

	if not string.nilorempty(arg_30_1) then
		local var_30_0 = string.split(arg_30_1, "#")

		for iter_30_0, iter_30_1 in pairs(var_30_0) do
			table.insert(arg_30_0._evaluateList, tonumber(iter_30_1))
		end
	end

	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveGet128EvaluateReply)
end

function var_0_0._onReceiveAct128SingleRewardReply(arg_31_0, arg_31_1)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveGet128SingleRewardReply, arg_31_1)
end

function var_0_0.getActivityDurationInfo(arg_32_0)
	return {
		st = arg_32_0:getRealStartTimeStamp(),
		ed = arg_32_0:getRealEndTimeStamp()
	}
end

function var_0_0.getStagePointInfo(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:getConfig():getStageCOMaxPoints(arg_33_1)

	return {
		cur = arg_33_0:getTotalPoint(arg_33_1),
		max = var_33_0
	}
end

function var_0_0.getDoubleTimesInfo(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getStageInfo(arg_34_1)
	local var_34_1 = arg_34_0:getConfig():InfiniteDoubleMaxTimes()

	return {
		cur = var_34_0 and var_34_1 - var_34_0.doubleNum or 0,
		max = var_34_1
	}
end

function var_0_0.getStagesInfo(arg_35_0)
	local var_35_0 = {}
	local var_35_1 = arg_35_0:getConfig():getStages()

	for iter_35_0, iter_35_1 in pairs(var_35_1) do
		local var_35_2 = iter_35_1.stage

		var_35_0[#var_35_0 + 1] = {
			stage = var_35_2,
			stageCO = iter_35_1
		}
	end

	table.sort(var_35_0, function(arg_36_0, arg_36_1)
		return arg_36_0.stage < arg_36_1.stage
	end)

	return var_35_0
end

function var_0_0.getStageLayerInfo(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0:getStagesInfo()

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		if iter_37_1.stage == arg_37_1 then
			iter_37_1.selectedIndex = arg_37_0:layer2Index(arg_37_1, arg_37_2)

			return iter_37_1
		end
	end
end

function var_0_0.getStageLayersInfo(arg_38_0, arg_38_1)
	local var_38_0 = {}
	local var_38_1 = arg_38_0:getConfig()
	local var_38_2 = var_38_1:getEpisodeStages(arg_38_1)

	for iter_38_0, iter_38_1 in pairs(var_38_2) do
		local var_38_3 = iter_38_1.layer

		var_38_0[#var_38_0 + 1] = {
			layer = var_38_3,
			layerCO = iter_38_1,
			isInfinite = var_38_1:isInfinite(arg_38_1, var_38_3),
			isOpen = arg_38_0:isBossLayerOpen(arg_38_1, var_38_3)
		}
	end

	table.sort(var_38_0, function(arg_39_0, arg_39_1)
		local var_39_0 = arg_39_0.layer
		local var_39_1 = arg_39_1.layer

		if var_39_0 ~= var_39_1 then
			return var_39_0 < var_39_1
		end
	end)

	return var_38_0
end

function var_0_0.getTaskMoListByStage(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getConfig()
	local var_40_1 = arg_40_0:getTaskMoList()
	local var_40_2 = {}

	for iter_40_0, iter_40_1 in ipairs(var_40_1) do
		local var_40_3 = iter_40_1.id
		local var_40_4 = var_40_0:getTaskCO(var_40_3)
		local var_40_5 = var_40_4.listenerParam

		if var_40_4.listenerType == BossRushEnum.TaskListenerType.highestPoint then
			local var_40_6 = string.split(var_40_5, "#")

			if arg_40_1 == tonumber(var_40_6[1]) then
				var_40_2[#var_40_2 + 1] = iter_40_1
			end
		end
	end

	return var_40_2
end

function var_0_0.getLayer4RewardMoListByStage(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getConfig()
	local var_41_1 = arg_41_0:getTaskMoList()
	local var_41_2 = {}

	for iter_41_0, iter_41_1 in ipairs(var_41_1) do
		local var_41_3 = iter_41_1.id
		local var_41_4 = var_41_0:getTaskCO(var_41_3)
		local var_41_5 = var_41_4.listenerParam

		if var_41_4.listenerType == BossRushEnum.TaskListenerType.layer4Reward then
			local var_41_6 = string.split(var_41_5, "#")

			if arg_41_1 == tonumber(var_41_6[1]) then
				var_41_2[#var_41_2 + 1] = iter_41_1
			end
		end
	end

	return var_41_2
end

function var_0_0.getMoListByStageAndType(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = arg_42_0:getConfig()
	local var_42_1 = arg_42_0:getTaskMoList()
	local var_42_2 = {}

	for iter_42_0, iter_42_1 in ipairs(var_42_1) do
		local var_42_3 = iter_42_1.id
		local var_42_4 = var_42_0:getTaskCO(var_42_3)
		local var_42_5 = var_42_4.listenerParam

		iter_42_1.ScoreDesc = arg_42_3

		if var_42_4.listenerType == arg_42_2 then
			local var_42_6 = string.split(var_42_5, "#")

			if arg_42_1 == tonumber(var_42_6[1]) then
				var_42_2[#var_42_2 + 1] = iter_42_1
			end
		end
	end

	return var_42_2
end

function var_0_0.getScheduleViewRewardList(arg_43_0, arg_43_1)
	local var_43_0 = {}
	local var_43_1 = BossRushConfig.instance:getStageRewardList(arg_43_1)

	for iter_43_0, iter_43_1 in ipairs(var_43_1) do
		local var_43_2 = iter_43_1.id
		local var_43_3 = arg_43_0:hasGetBonusIds(arg_43_1, var_43_2)

		var_43_0[#var_43_0 + 1] = {
			isGot = var_43_3,
			stageRewardCO = iter_43_1
		}
	end

	return var_43_0
end

function var_0_0.getSpecialScheduleViewRewardList(arg_44_0, arg_44_1)
	local var_44_0 = {}
	local var_44_1 = BossRushConfig.instance:getActLayer4rewards(arg_44_1)
	local var_44_2 = arg_44_0:getLayer4CurScore(arg_44_1)

	for iter_44_0, iter_44_1 in ipairs(var_44_1) do
		local var_44_3 = var_44_2 >= iter_44_1.maxProgress

		var_44_0[#var_44_0 + 1] = {
			isGot = var_44_3,
			config = iter_44_1
		}
	end

	return var_44_0
end

function var_0_0.checkAnyRewardClaim(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0:getStageInfo(arg_45_1)
	local var_45_1 = var_45_0 and var_45_0.totalPoint or 0

	return arg_45_0:calcRewardClaim(arg_45_1, var_45_1, true)
end

function var_0_0.calcRewardClaim(arg_46_0, arg_46_1, arg_46_2, arg_46_3)
	local var_46_0 = BossRushConfig.instance:getStageRewardList(arg_46_1)
	local var_46_1 = false
	local var_46_2 = 0

	for iter_46_0, iter_46_1 in ipairs(var_46_0) do
		local var_46_3 = iter_46_1.id
		local var_46_4 = iter_46_1.rewardPointNum

		if arg_46_0:hasGetBonusIds(arg_46_1, var_46_3) then
			var_46_2 = iter_46_0
		elseif var_46_4 <= arg_46_2 then
			var_46_1 = true
			var_46_2 = iter_46_0

			if arg_46_3 then
				break
			end
		end
	end

	return var_46_1, var_46_2
end

function var_0_0.getScheduleViewRewardNoGotIndex(arg_47_0, arg_47_1)
	local var_47_0 = BossRushConfig.instance:getStageRewardList(arg_47_1)
	local var_47_1 = #var_47_0

	for iter_47_0, iter_47_1 in ipairs(var_47_0) do
		local var_47_2 = iter_47_1.id

		if not arg_47_0:hasGetBonusIds(arg_47_1, var_47_2) then
			return true, iter_47_0
		end
	end

	return false, var_47_1
end

function var_0_0.getResultPanelProgressBarPointList(arg_48_0, arg_48_1, arg_48_2)
	arg_48_2 = arg_48_2 or 0

	local var_48_0 = BossRushConfig.instance:getStageRewardList(arg_48_1)
	local var_48_1 = {}

	for iter_48_0, iter_48_1 in ipairs(var_48_0) do
		local var_48_2 = arg_48_2 < iter_48_1.rewardPointNum

		var_48_1[#var_48_1 + 1] = {
			isGray = var_48_2,
			stageRewardCO = iter_48_1
		}
	end

	return var_48_1
end

function var_0_0.clearStageScore(arg_49_0)
	arg_49_0._fightScoreList = nil
end

function var_0_0.snapShotFightScore(arg_50_0, arg_50_1)
	if not arg_50_0._fightScoreList then
		arg_50_0._fightScoreList = {}
	end

	local var_50_0 = arg_50_0._fightScoreList

	if arg_50_0:getBossBloodCount() <= 1 then
		return
	end

	table.insert(var_50_0, arg_50_1)
end

function var_0_0.getStageScore(arg_51_0)
	if not arg_51_0._fightScoreList then
		return {
			arg_51_0:getFightScore()
		}
	end

	local var_51_0 = {}
	local var_51_1 = arg_51_0._fightScoreList
	local var_51_2 = arg_51_0:getBossBloodMaxCount()
	local var_51_3 = 0
	local var_51_4 = math.min(#var_51_1 + 1, var_51_2)

	for iter_51_0 = 1, var_51_4 - 1 do
		local var_51_5 = var_51_1[iter_51_0] - (var_51_1[iter_51_0 - 1] or 0)

		var_51_0[#var_51_0 + 1] = var_51_5
		var_51_3 = var_51_3 + var_51_5
	end

	if var_51_4 > 1 then
		local var_51_6 = arg_51_0:getFightScore()

		var_51_0[#var_51_0 + 1] = var_51_6 - var_51_3
	end

	if var_51_4 < var_51_2 then
		for iter_51_1 = var_51_4 + 1, var_51_2 do
			var_51_0[#var_51_0 + 1] = 0
		end
	end

	return var_51_0
end

function var_0_0.getUnlimitedHpColor(arg_52_0)
	return {
		[BossRushEnum.HpColor.Red] = "#B33E2D",
		[BossRushEnum.HpColor.Orange] = "#D9852B",
		[BossRushEnum.HpColor.Yellow] = "#B3A574",
		[BossRushEnum.HpColor.Green] = "#69995E",
		[BossRushEnum.HpColor.Blue] = "#4C8699",
		[BossRushEnum.HpColor.Purple] = "#86568F"
	}
end

function var_0_0.getUnlimitedTopAndBotHpColor(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0:getUnlimitedHpColor()
	local var_53_1 = arg_53_1 % #var_53_0 + 1
	local var_53_2 = var_53_1 + 1 > #var_53_0 and 1 or var_53_1 + 1
	local var_53_3 = var_53_0[BossRushEnum.HpColor.Red]
	local var_53_4 = var_53_0[var_53_1]
	local var_53_5 = string.nilorempty(var_53_4) and var_53_3 or var_53_4
	local var_53_6 = var_53_0[var_53_2]
	local var_53_7 = string.nilorempty(var_53_6) and var_53_3 or var_53_6
	local var_53_8 = string.nilorempty(var_53_4) and BossRushEnum.HpColor.Red or var_53_1

	return var_53_5, var_53_7, var_53_8
end

function var_0_0.syncUnlimitedHp(arg_54_0, arg_54_1, arg_54_2)
	if not arg_54_0._unlimitHp then
		arg_54_0._unlimitHp = {}
	end

	arg_54_0._unlimitHp.fillAmount = arg_54_2

	if arg_54_1 then
		arg_54_0._unlimitHp.index = arg_54_1
	end
end

function var_0_0.resetUnlimitedHp(arg_55_0)
	arg_55_0._unlimitHp = nil
end

function var_0_0.setStageLastTotalPoint(arg_56_0, arg_56_1, arg_56_2)
	arg_56_0._stage2LastTotalPoint[arg_56_1] = tonumber(arg_56_2)
end

function var_0_0._getStageLastTotalPoint(arg_57_0, arg_57_1)
	return arg_57_0._stage2LastTotalPoint[arg_57_1] or 0
end

function var_0_0._initStageLastTotalPoint(arg_58_0)
	if next(arg_58_0._stage2LastTotalPoint) then
		return
	end

	local var_58_0 = BossRushConfig.instance:getStages()

	for iter_58_0, iter_58_1 in pairs(var_58_0) do
		local var_58_1 = iter_58_1.stage
		local var_58_2 = arg_58_0:getStageInfo(var_58_1)

		arg_58_0:setStageLastTotalPoint(var_58_1, var_58_2 and var_58_2.totalPoint or 0)
	end
end

function var_0_0.getLastPointInfo(arg_59_0, arg_59_1)
	local var_59_0 = arg_59_0:getStagePointInfo(arg_59_1)

	var_59_0.last = arg_59_0:_getStageLastTotalPoint(arg_59_1)

	return var_59_0
end

local var_0_1 = "Version1_4_BossRushSelectedLayer_"

function var_0_0.setLastMarkSelectedLayer(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0 = arg_60_0:_getSelectedLayerKey(arg_60_1)

	if not tonumber(arg_60_2) then
		return
	end

	GameUtil.playerPrefsSetNumberByUserId(var_60_0, arg_60_2)
end

function var_0_0.getLastMarkSelectedLayer(arg_61_0, arg_61_1)
	local var_61_0 = arg_61_0:_getSelectedLayerKey(arg_61_1)

	return GameUtil.playerPrefsGetNumberByUserId(var_61_0, 1)
end

function var_0_0._getSelectedLayerKey(arg_62_0, arg_62_1)
	return (string.format("%s_%s_%s", var_0_1, BossRushConfig.instance:getActivityId(), arg_62_1))
end

function var_0_0.layer2Index(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_0:getConfig():getEpisodeStages(arg_63_1)

	for iter_63_0, iter_63_1 in pairs(var_63_0) do
		if arg_63_2 == iter_63_1.layer then
			return iter_63_0
		end
	end

	return 1
end

function var_0_0.getEvaluateList(arg_64_0)
	return arg_64_0._evaluateList
end

function var_0_0.getActivityMo(arg_65_0)
	local var_65_0 = BossRushConfig.instance:getActivityId()

	if var_65_0 then
		local var_65_1 = ActivityModel.instance:getActivityInfo()

		return var_65_1 and var_65_1[var_65_0]
	end
end

function var_0_0.isSpecialActivity(arg_66_0)
	local var_66_0 = BossRushConfig.instance:getStages()

	for iter_66_0, iter_66_1 in pairs(var_66_0) do
		local var_66_1 = iter_66_1.stage

		if #BossRushConfig.instance:getEpisodeStages(var_66_1) > 3 then
			return true
		end
	end
end

function var_0_0.isEnhanceRole(arg_67_0, arg_67_1, arg_67_2)
	if not arg_67_1 or not arg_67_2 then
		return false
	end

	local var_67_0 = BossRushConfig.instance:getEpisodeCO(arg_67_1, arg_67_2)

	if not var_67_0 then
		return false
	end

	return var_67_0.enhanceRole == 1
end

function var_0_0.getLayer4MaxRewardScore(arg_68_0, arg_68_1)
	local var_68_0 = BossRushConfig.instance:getActLayer4rewards(arg_68_1)
	local var_68_1 = 0

	for iter_68_0, iter_68_1 in pairs(var_68_0) do
		var_68_1 = iter_68_1.maxProgress
	end

	return var_68_1
end

function var_0_0.isSpecialLayerCurBattle(arg_69_0)
	if BossRushController.instance:isInBossRushFight() then
		local var_69_0, var_69_1 = arg_69_0:getBattleStageAndLayer()

		return arg_69_0:isSpecialLayer(var_69_1)
	end

	return false
end

function var_0_0.isSpecialLayer(arg_70_0, arg_70_1)
	return arg_70_1 and arg_70_1 == 4
end

function var_0_0.getActivityBonus(arg_71_0)
	local var_71_0 = BossRushConfig.instance:getActivityId()

	return BossRushEnum.BonusTab[var_71_0] or BossRushEnum.BonusTab[BossRushEnum.DefaultAcitvityId]
end

function var_0_0.getActivityMainView(arg_72_0)
	local var_72_0 = BossRushConfig.instance:getActivityId()

	return BossRushEnum.MainView[var_72_0] or BossRushEnum.MainView[BossRushEnum.DefaultAcitvityId]
end

function var_0_0.getActivityMainViewPath(arg_73_0)
	local var_73_0 = arg_73_0:getActivityMainView()

	return var_73_0 and var_73_0.MainViewPath or BossRushEnum.ResPath.v1a4_bossrushmainview
end

function var_0_0.getActivityMainViewItemPath(arg_74_0)
	local var_74_0 = arg_74_0:getActivityMainView()

	return var_74_0 and var_74_0.MainViewItemPath or BossRushEnum.ResPath.v1a4_bossrushmainitem
end

function var_0_0.getActivityLevelDetailPath(arg_75_0)
	local var_75_0 = arg_75_0:getActivityMainView()

	return var_75_0 and var_75_0.LeveldetailViewPath or BossRushEnum.ResPath.v1a4_bossrushleveldetail
end

var_0_0.instance = var_0_0.New()

return var_0_0
