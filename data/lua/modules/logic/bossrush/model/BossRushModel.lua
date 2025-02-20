module("modules.logic.bossrush.model.BossRushModel", package.seeall)

slot0 = class("BossRushModel", Activity128Model)

function slot0.reInit(slot0)
	uv0.super.reInit(slot0)

	slot1 = BossRushConfig.instance

	slot0:_internal_set_config(slot1)
	slot0:_internal_set_activity(slot1:getActivityId())

	slot0._stage2LastTotalPoint = {}
	slot0._fightLastScore = 0
	slot0._fightCurScore = 0
	slot0._infiniteBossDeadSum = 0
	slot0._bossBloodCount = 0
	slot0._bossHP = 0
	slot0._bossIdList = nil
	slot0._fightScoreList = nil
end

function slot0.setFightScore(slot0, slot1)
	slot0._fightLastScore = slot0:getFightScore()
	slot0._fightCurScore = slot1
end

function slot0.noticeFightScore(slot0, slot1)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnScoreChange, slot0._fightLastScore, slot1 or slot0._fightCurScore)
end

function slot0.getFightScore(slot0)
	return slot0._fightCurScore or 0
end

function slot0.checkIsNewHighestPointRecord(slot0, slot1)
	return slot0:getHighestPoint(slot1) < slot0:getFightScore()
end

function slot0.getBossCurHP(slot0)
	return slot0._bossHP or 0
end

function slot0.setInfiniteBossDeadSum(slot0, slot1)
	slot0._infiniteBossDeadSum = slot1

	if slot0:getInfiniteBossDeadSum() ~= slot1 then
		BossRushController.instance:dispatchEvent(BossRushEvent.OnBossDeadSumChange, slot2, slot1)
	end
end

function slot0.getInfiniteBossDeadSum(slot0)
	return slot0._infiniteBossDeadSum or 0
end

function slot0.setBossBloodCount(slot0, slot1)
	slot0._bossBloodCount = slot1

	if slot0:getBossBloodCount() ~= slot1 then
		BossRushController.instance:dispatchEvent(BossRushEvent.OnBloodCountChange, slot2, slot1)
	end
end

function slot0.getBossBloodCount(slot0)
	return slot0._bossBloodCount or 0
end

function slot0.setBossIdList(slot0, slot1)
	slot0._bossIdList = slot1
end

function slot0.getBossIdList(slot0)
	return slot0._bossIdList
end

function slot0.getBossBloodMaxCount(slot0)
	if not slot0._bossIdList then
		return 0
	end

	return #slot0._bossIdList
end

function slot0.setBossCurHP(slot0, slot1)
	if slot1 == slot0._bossHP then
		return
	end

	slot0._bossHP = slot1

	BossRushController.instance:dispatchEvent(BossRushEvent.OnHpChange, slot2, slot1)
end

function slot0.getBossCurMaxHP(slot0)
	if not slot0:getBossEntityMO() then
		return 0
	end

	return slot1.attrMO.hp
end

function slot0.subBossBlood(slot0)
	slot0:setBossBloodCount(slot0:getBossBloodCount() - 1)
end

function slot0.getCurBossIndex(slot0)
	return slot0:getBossBloodMaxCount() - math.max(0, slot0:getBossBloodCount())
end

function slot0._isFightBossId(slot0, slot1)
	if not slot0:getBossIdList() then
		return false
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot1 == slot7 then
			return true
		end
	end

	return false
end

function slot0.getBossEntityMO(slot0)
	for slot5, slot6 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
		if slot0:_isFightBossId(slot6.modelId) then
			return slot6
		end
	end
end

function slot0.getBossEntityMOByCurBloodCount(slot0)
	if not slot0._bossIdList then
		return slot0:getBossEntityMO()
	end

	if not slot0._bossIdList[slot0:getBossBloodMaxCount() - math.max(0, slot0:getBossBloodCount())] then
		logError("[getBossEntityMOByCurBloodCount]: " .. string.format("max=%s, cur=%s, nowMax=%s", slot1, slot2, #slot0._bossIdList))

		return slot0:getBossEntityMO()
	end

	for slot9, slot10 in ipairs(FightDataHelper.entityMgr:getEnemyNormalList()) do
		if slot4 == slot10.modelId then
			return slot10
		end
	end
end

function slot0.getMultiHpInfo(slot0)
	return {
		multiHpIdx = slot0:getBossBloodMaxCount() - slot0:getBossBloodCount(),
		multiHpNum = slot0:getBossBloodMaxCount()
	}
end

function slot0.inUnlimit(slot0)
	slot1 = slot0:getMultiHpInfo()

	return slot1.multiHpNum - slot1.multiHpIdx <= 1
end

function slot0.setBattleStageAndLayer(slot0, slot1, slot2)
	slot0._battleStageTemp = slot1
	slot0._battleLayerTemp = slot2
end

function slot0.getBattleStageAndLayer(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight or not DungeonModel.instance.curSendEpisodeId then
		slot0:setBattleStageAndLayer(nil, )

		return
	end

	if not slot0._battleStageTemp then
		slot0:setBattleStageAndLayer(slot0:getConfig():tryGetStageAndLayerByEpisodeId(slot1))
	end

	return slot0._battleStageTemp, slot0._battleLayerTemp
end

function slot0._onReceiveGet128InfosReply(slot0, slot1)
	slot0:_initStageLastTotalPoint()
	BossRushRedModel.instance:refreshAllStageLayerUnlockState()
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveGet128InfosReply)
end

function slot0._onReceiveAct128GetTotalRewardsReply(slot0, slot1)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveAct128GetTotalRewardsReply)
end

function slot0._onReceiveAct128DoublePointReply(slot0, slot1)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveAct128DoublePointRequestReply, slot1.totalPoint, slot1.doublePoint)
end

function slot0._onReceiveAct128InfoUpdatePush(slot0, slot1)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveAct128InfoUpdatePush)
end

function slot0.onEndDungeonExtraStr(slot0, slot1)
	slot2 = cjson.decode(slot1)
	slot3 = slot2.evaluate
	slot4 = 0

	if not string.nilorempty(slot2.score) then
		slot4 = tonumber(slot2.score)
	end

	slot0:_setEvaluate(slot3)
	slot0:setFightScore(slot4)
end

function slot0._setEvaluate(slot0, slot1)
	slot0._evaluateList = {}

	if not string.nilorempty(slot1) then
		for slot6, slot7 in pairs(string.split(slot1, "#")) do
			table.insert(slot0._evaluateList, tonumber(slot7))
		end
	end

	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveGet128EvaluateReply)
end

function slot0._onReceiveAct128SingleRewardReply(slot0, slot1)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnReceiveGet128SingleRewardReply, slot1)
end

function slot0.getActivityDurationInfo(slot0)
	return {
		st = slot0:getRealStartTimeStamp(),
		ed = slot0:getRealEndTimeStamp()
	}
end

function slot0.getStagePointInfo(slot0, slot1)
	return {
		cur = slot0:getTotalPoint(slot1),
		max = slot0:getConfig():getStageCOMaxPoints(slot1)
	}
end

function slot0.getDoubleTimesInfo(slot0, slot1)
	slot4 = slot0:getConfig():InfiniteDoubleMaxTimes()

	return {
		cur = slot0:getStageInfo(slot1) and slot4 - slot2.doubleNum or 0,
		max = slot4
	}
end

function slot0.getStagesInfo(slot0)
	slot1 = {}

	for slot7, slot8 in pairs(slot0:getConfig():getStages()) do
		slot1[#slot1 + 1] = {
			stage = slot8.stage,
			stageCO = slot8
		}
	end

	table.sort(slot1, function (slot0, slot1)
		return slot0.stage < slot1.stage
	end)

	return slot1
end

function slot0.getStageLayerInfo(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0:getStagesInfo()) do
		if slot8.stage == slot1 then
			slot8.selectedIndex = slot0:layer2Index(slot1, slot2)

			return slot8
		end
	end
end

function slot0.getStageLayersInfo(slot0, slot1)
	slot2 = {}

	for slot8, slot9 in pairs(slot0:getConfig():getEpisodeStages(slot1)) do
		slot10 = slot9.layer
		slot2[#slot2 + 1] = {
			layer = slot10,
			layerCO = slot9,
			isInfinite = slot3:isInfinite(slot1, slot10),
			isOpen = slot0:isBossLayerOpen(slot1, slot10)
		}
	end

	table.sort(slot2, function (slot0, slot1)
		if slot0.layer ~= slot1.layer then
			return slot2 < slot3
		end
	end)

	return slot2
end

function slot0.getTaskMoListByStage(slot0, slot1)
	slot4 = {}

	for slot8, slot9 in ipairs(slot0:getTaskMoList()) do
		slot11 = slot0:getConfig():getTaskCO(slot9.id)

		if slot11.listenerType == BossRushEnum.TaskListenerType.highestPoint and slot1 == tonumber(string.split(slot11.listenerParam, "#")[1]) then
			slot4[#slot4 + 1] = slot9
		end
	end

	return slot4
end

function slot0.getLayer4RewardMoListByStage(slot0, slot1)
	slot4 = {}

	for slot8, slot9 in ipairs(slot0:getTaskMoList()) do
		slot11 = slot0:getConfig():getTaskCO(slot9.id)

		if slot11.listenerType == BossRushEnum.TaskListenerType.layer4Reward and slot1 == tonumber(string.split(slot11.listenerParam, "#")[1]) then
			slot4[#slot4 + 1] = slot9
		end
	end

	return slot4
end

function slot0.getScheduleViewRewardList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(BossRushConfig.instance:getStageRewardList(slot1)) do
		slot2[#slot2 + 1] = {
			isGot = slot0:hasGetBonusIds(slot1, slot8.id),
			stageRewardCO = slot8
		}
	end

	return slot2
end

function slot0.getSpecialScheduleViewRewardList(slot0, slot1)
	slot2 = {}

	for slot8, slot9 in ipairs(BossRushConfig.instance:getActLayer4rewards(slot1)) do
		slot2[#slot2 + 1] = {
			isGot = slot9.maxProgress <= slot0:getLayer4CurScore(slot1),
			config = slot9
		}
	end

	return slot2
end

function slot0.checkAnyRewardClaim(slot0, slot1)
	return slot0:calcRewardClaim(slot1, slot0:getStageInfo(slot1) and slot2.totalPoint or 0, true)
end

function slot0.calcRewardClaim(slot0, slot1, slot2, slot3)
	slot5 = false
	slot6 = 0

	for slot10, slot11 in ipairs(BossRushConfig.instance:getStageRewardList(slot1)) do
		slot13 = slot11.rewardPointNum

		if slot0:hasGetBonusIds(slot1, slot11.id) then
			slot6 = slot10
		elseif slot13 <= slot2 then
			slot5 = true
			slot6 = slot10

			if slot3 then
				break
			end
		end
	end

	return slot5, slot6
end

function slot0.getScheduleViewRewardNoGotIndex(slot0, slot1)
	slot2 = BossRushConfig.instance:getStageRewardList(slot1)
	slot3 = #slot2

	for slot7, slot8 in ipairs(slot2) do
		if not slot0:hasGetBonusIds(slot1, slot8.id) then
			return true, slot7
		end
	end

	return false, slot3
end

function slot0.getResultPanelProgressBarPointList(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in ipairs(BossRushConfig.instance:getStageRewardList(slot1)) do
		slot4[#slot4 + 1] = {
			isGray = (slot2 or 0) < slot9.rewardPointNum,
			stageRewardCO = slot9
		}
	end

	return slot4
end

function slot0.clearStageScore(slot0)
	slot0._fightScoreList = nil
end

function slot0.snapShotFightScore(slot0, slot1)
	if not slot0._fightScoreList then
		slot0._fightScoreList = {}
	end

	slot2 = slot0._fightScoreList

	if slot0:getBossBloodCount() <= 1 then
		return
	end

	table.insert(slot2, slot1)
end

function slot0.getStageScore(slot0)
	if not slot0._fightScoreList then
		return {
			slot0:getFightScore()
		}
	end

	slot1 = {}

	for slot9 = 1, math.min(#slot0._fightScoreList + 1, slot0:getBossBloodMaxCount()) - 1 do
		slot10 = slot2[slot9] - (slot2[slot9 - 1] or 0)
		slot1[#slot1 + 1] = slot10
		slot4 = 0 + slot10
	end

	if slot5 > 1 then
		slot1[#slot1 + 1] = slot0:getFightScore() - slot4
	end

	if slot5 < slot3 then
		for slot9 = slot5 + 1, slot3 do
			slot1[#slot1 + 1] = 0
		end
	end

	return slot1
end

function slot0.getUnlimitedHpColor(slot0)
	return {
		[BossRushEnum.HpColor.Red] = "#B33E2D",
		[BossRushEnum.HpColor.Orange] = "#D9852B",
		[BossRushEnum.HpColor.Yellow] = "#B3A574",
		[BossRushEnum.HpColor.Green] = "#69995E",
		[BossRushEnum.HpColor.Blue] = "#4C8699",
		[BossRushEnum.HpColor.Purple] = "#86568F"
	}
end

function slot0.getUnlimitedTopAndBotHpColor(slot0, slot1)
	slot2 = slot0:getUnlimitedHpColor()
	slot5 = slot2[BossRushEnum.HpColor.Red]

	return string.nilorempty(slot2[slot3]) and slot5 or slot6, string.nilorempty(slot2[slot1 % #slot2 + 1 + 1 > #slot2 and 1 or slot3 + 1]) and slot5 or slot8, string.nilorempty(slot6) and BossRushEnum.HpColor.Red or slot3
end

function slot0.syncUnlimitedHp(slot0, slot1, slot2)
	if not slot0._unlimitHp then
		slot0._unlimitHp = {}
	end

	slot0._unlimitHp.fillAmount = slot2

	if slot1 then
		slot0._unlimitHp.index = slot1
	end
end

function slot0.resetUnlimitedHp(slot0)
	slot0._unlimitHp = nil
end

function slot0.setStageLastTotalPoint(slot0, slot1, slot2)
	slot0._stage2LastTotalPoint[slot1] = tonumber(slot2)
end

function slot0._getStageLastTotalPoint(slot0, slot1)
	return slot0._stage2LastTotalPoint[slot1] or 0
end

function slot0._initStageLastTotalPoint(slot0)
	if next(slot0._stage2LastTotalPoint) then
		return
	end

	for slot5, slot6 in pairs(BossRushConfig.instance:getStages()) do
		slot7 = slot6.stage

		slot0:setStageLastTotalPoint(slot7, slot0:getStageInfo(slot7) and slot8.totalPoint or 0)
	end
end

function slot0.getLastPointInfo(slot0, slot1)
	slot2 = slot0:getStagePointInfo(slot1)
	slot2.last = slot0:_getStageLastTotalPoint(slot1)

	return slot2
end

slot1 = "Version1_4_BossRushSelectedLayer_"

function slot0.setLastMarkSelectedLayer(slot0, slot1, slot2)
	slot3 = uv0 .. tostring(slot1)

	if not tonumber(slot2) then
		return
	end

	PlayerPrefsHelper.setNumber(slot3, slot2)
end

function slot0.getLastMarkSelectedLayer(slot0, slot1)
	return PlayerPrefsHelper.getNumber(uv0 .. tostring(slot1), 1)
end

function slot0.layer2Index(slot0, slot1, slot2)
	for slot8, slot9 in pairs(slot0:getConfig():getEpisodeStages(slot1)) do
		if slot2 == slot9.layer then
			return slot8
		end
	end

	return 1
end

function slot0.getEvaluateList(slot0)
	return slot0._evaluateList
end

function slot0.getActivityMo(slot0)
	if BossRushConfig.instance:getActivityId() then
		return ActivityModel.instance:getActivityInfo() and slot2[slot1]
	end
end

function slot0.isSpecialActivity(slot0)
	for slot5, slot6 in pairs(BossRushConfig.instance:getStages()) do
		if #BossRushConfig.instance:getEpisodeStages(slot6.stage) > 3 then
			return true
		end
	end
end

function slot0.isEnhanceRole(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return false
	end

	if not BossRushConfig.instance:getEpisodeCO(slot1, slot2) then
		return false
	end

	return slot3.enhanceRole == 1
end

function slot0.getLayer4MaxRewardScore(slot0, slot1)
	slot3 = 0

	for slot7, slot8 in pairs(BossRushConfig.instance:getActLayer4rewards(slot1)) do
		slot3 = slot8.maxProgress
	end

	return slot3
end

function slot0.isSpecialLayerCurBattle(slot0)
	if BossRushController.instance:isInBossRushFight() then
		slot2, slot3 = slot0:getBattleStageAndLayer()

		return slot0:isSpecialLayer(slot3)
	end

	return false
end

function slot0.isSpecialLayer(slot0, slot1)
	return slot1 and slot1 > 3
end

slot0.instance = slot0.New()

return slot0
