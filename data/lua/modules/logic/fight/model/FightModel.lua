module("modules.logic.fight.model.FightModel", package.seeall)

slot0 = class("FightModel", BaseModel)

function slot0.onInit(slot0)
	slot0._fightParam = nil
	slot0._curStage = nil
	slot0._curWaveId = 1
	slot0._curRoundId = 1
	slot0._roundInc = 1
	slot0._curRoundMO = nil
	slot0._historyRoundMOList = nil
	slot0._isFinish = false
	slot0._recordMO = nil
	slot0.maxRound = 1
	slot0.maxWave = 1
	slot0.power = 0
	slot0.clothId = 0
	slot0._clothSkillDict = nil
	slot0.needFightReconnect = false
	slot0._fightReason = nil
	slot0._isAuto = false
	slot0._userSpeed = 1
	slot0._gmOpenFightJoin = false
	slot0._isClickEnemy = false
	slot0.autoPlayCardList = {}
	slot0._guideParam = {
		OnGuideFightEndPause = false,
		OnGuideEntityDeadPause = false,
		OnGuideDistributePause = false,
		OnGuideCardEndPause = false,
		OnGuideFightEndPause_sp = false,
		OnGuideBeforeSkillPause = false
	}
	slot0._startFinish = false
	slot0.roundOffset = 0
end

function slot0.reInit(slot0)
	slot0._curStage = nil
	slot0.needFightReconnect = false
end

function slot0.clear(slot0)
	FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = false
	uv0.forceParallelSkill = false
	slot0._curStage = nil
	slot0._curWaveId = 1

	FightPlayCardModel.instance:clearUsedCards()
	slot0:resetRTPCSpeedTo1()

	slot0._userSpeed = 1
	slot0._historyRoundMOList = nil

	slot0:getMagicCircleInfo():clear()

	slot0.stressBehaviourDict = nil
	slot0.entitySpAttrMoDict = nil
	slot0.notifyEntityId = nil
	slot0.canContractList = nil
	slot0.contractEntityUid = nil
	slot0.beContractEntityUid = nil
	slot0.roundOffset = 0
end

function slot0.onRestart(slot0)
	slot0:clear()
end

function slot0.setFightParam(slot0, slot1)
	slot0._historyRoundMOList = nil
	slot0._fightParam = slot1
	slot0.maxWave = slot0._fightParam.monsterGroupIds and #slot0._fightParam.monsterGroupIds or 0
end

function slot0.getGuideParam(slot0)
	return slot0._guideParam
end

function slot0.getFightParam(slot0)
	return slot0._fightParam
end

function slot0.updateMySide(slot0, slot1)
	if slot0:getFightParam() then
		slot2:setMySide(slot1.clothId, slot1.heroList, slot1.subHeroList, slot1.equips, slot1.activity104Equips, slot1.trialHeroList, slot1.extraList, slot1.assistBossId)
	end
end

function slot0.recordFightGroup(slot0, slot1)
	slot0.last_fightGroup = slot1
end

function slot0.getCurWaveId(slot0)
	return slot0._curWaveId
end

function slot0.getCurRoundId(slot0)
	return slot0._curRoundId - slot0.roundOffset
end

function slot0.getMaxRound(slot0)
	return slot0.maxRound - slot0.roundOffset
end

function slot0.setRoundOffset(slot0, slot1)
	slot0.roundOffset = slot1 or 0
end

function slot0.getCurRoundMO(slot0)
	return slot0._curRoundMO
end

function slot0.getRecordMO(slot0)
	return slot0._recordMO
end

function slot0.clearRecordMO(slot0)
	slot0._recordMO = nil
end

function slot0.getFightReason(slot0)
	return slot0._fightReason
end

function slot0.getHistoryRoundMOList(slot0)
	return slot0._historyRoundMOList
end

function slot0.getSelectMonsterGroupId(slot0, slot1, slot2)
	slot3 = slot0._fightParam

	if not slot2 then
		return slot3 and slot3.monsterGroupIds and slot3.monsterGroupIds[slot1]
	end

	if not slot3 or slot3.battleId ~= slot2 then
		FightParam.New():setBattleId(slot2)
	end

	return slot3 and slot3.monsterGroupIds and slot3.monsterGroupIds[slot1]
end

function slot0.getCurMonsterGroupId(slot0)
	return slot0._fightParam and slot0._fightParam.monsterGroupIds and slot0._fightParam.monsterGroupIds[slot0._curWaveId]
end

function slot0.isShowSettlement(slot0)
	return slot0._fightParam and slot0._fightParam.isShowSettlement
end

function slot0.getAfterStory(slot0)
	if slot0._fightParam and slot0._fightParam.episodeId and DungeonConfig.instance:getEpisodeCO(slot0._fightParam.episodeId) then
		return slot1.afterStory
	end

	return 0
end

function slot0.getCurStage(slot0)
	return slot0._curStage
end

function slot0.inFight(slot0)
	return slot0._curStage ~= nil
end

slot1 = {
	"起始回合",
	"发牌",
	"玩家自由打牌",
	"自动战斗打牌",
	"回合播技能",
	"回合补牌",
	"回合结束",
	"战斗结束",
	"主角技能"
}

function slot0.getCurStageDesc(slot0)
	return uv0[slot0._curStage] or "nil"
end

function slot0.setCurStage(slot0, slot1)
	slot0._curStage = slot1

	if slot1 == FightEnum.Stage.StartRound then
		slot0._startFinish = false
	elseif slot1 == FightEnum.Stage.Card or slot1 == FightEnum.Stage.AutoCard then
		slot0._startFinish = true
	end
end

function slot0.isStartFinish(slot0)
	return slot0._startFinish
end

function slot0.isFinish(slot0)
	return slot0._isFinish
end

function slot0.getBattleId(slot0)
	return slot0._battleId
end

function slot0.clearBattleId(slot0)
	slot0._battleId = nil
end

function slot0.initSpeedConfig(slot0)
	if not slot0._normalSpeed then
		slot0._normalSpeed = {
			1,
			CommonConfig.instance:getConstNum(ConstEnum.FightSpeed)
		}
		slot1 = FightStrUtil.instance:getSplitString2Cache(CommonConfig.instance:getConstStr(ConstEnum.FightReplaySpeed), true, "|", "#")
		slot0._replaySpeed = {
			slot1[1][1],
			slot1[2][1]
		}
		slot0._replayUISpeed = {
			slot1[1][2],
			slot1[2][2]
		}
		slot2 = FightStrUtil.instance:getSplitToNumberCache(CommonConfig.instance:getConstStr(ConstEnum.bossSkillFightSpeed), "#")
		slot0._bossSkillNormalSpeed = {
			slot2[1],
			slot2[2]
		}
		slot2 = FightStrUtil.instance:getSplitToNumberCache(CommonConfig.instance:getConstStr(ConstEnum.bossSkillFightReplaySpeed), "#")
		slot0._bossSkillReplaySpeed = {
			slot2[1],
			slot2[2]
		}
		slot2 = GameUtil.splitString2(lua_activity174_const.configDict[Activity174Enum.ConstKey.FightSpeed].value, true)
		slot0._douQuQuSpeed = {
			slot2[1][1],
			slot2[2][1]
		}
		slot0._douQuQuUISpeed = {
			slot2[1][2],
			slot2[2][2]
		}
	end
end

function slot0.getSpeed(slot0)
	if uv0.instance.useExclusiveSpeed then
		return uv0.instance.useExclusiveSpeed
	end

	slot0:initSpeedConfig()

	if FightDataHelper.fieldMgr:isDouQuQu() then
		return slot0._douQuQuSpeed[slot0._userSpeed] or 1
	end

	if FightReplayModel.instance:isReplay() then
		if uv0.instance.useBossSkillSpeed then
			return slot0._bossSkillReplaySpeed[slot0._userSpeed] or 1
		end

		return slot0._replaySpeed[slot0._userSpeed] or 1
	else
		if uv0.instance.useBossSkillSpeed then
			return slot0._bossSkillNormalSpeed[slot0._userSpeed] or 1
		end

		return slot0._normalSpeed[slot0._userSpeed] or 1
	end
end

function slot0.getNormalSpeed(slot0)
	slot0:initSpeedConfig()

	return slot0._normalSpeed[1] or 1
end

function slot0.getReplaySpeed(slot0)
	slot0:initSpeedConfig()

	return slot0._replaySpeed[1] or 1
end

function slot0.getUISpeed(slot0)
	slot0:initSpeedConfig()

	if FightDataHelper.fieldMgr:isDouQuQu() then
		return slot0._douQuQuUISpeed[slot0._userSpeed] or 1
	end

	if FightReplayModel.instance:isReplay() then
		return slot0._replayUISpeed[slot0._userSpeed] or 1
	else
		return 1
	end
end

function slot0.setGMSpeed(slot0, slot1, slot2)
	slot0._normalSpeed = {
		slot1,
		slot1
	}
	slot0._replaySpeed = {
		slot2,
		slot2
	}

	if slot0:getCurStage() then
		slot0:updateRTPCSpeed()
	end
end

function slot0.getUserSpeed(slot0)
	return slot0._userSpeed
end

function slot0.setUserSpeed(slot0, slot1)
	slot0._userSpeed = slot1 or 1

	slot0:updateRTPCSpeed()
end

function slot0.updateRTPCSpeed(slot0)
	AudioMgr.instance:setRTPCValue(FightEnum.GameSpeedRTPC, slot0:getSpeed())
end

function slot0.resetRTPCSpeedTo1(slot0)
	AudioMgr.instance:setRTPCValue(FightEnum.GameSpeedRTPC, 1)
end

function slot0.isAuto(slot0)
	return slot0._isAuto
end

function slot0.setAuto(slot0, slot1)
	if not slot1 and slot0._isAuto then
		slot0._isAuto = slot1

		FightCardModel.instance:setCurSelectEntityId(0)
		FightCardModel.instance:resetCurSelectEntityIdDefault()
	end

	slot0._isAuto = slot1

	if slot1 then
		FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.Auto)
	else
		FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Auto)
	end
end

function slot0.switchGMFightJoin(slot0)
	slot0._gmOpenFightJoin = not slot0._gmOpenFightJoin
end

function slot0.isGMFightJoin(slot0)
	return slot0._gmOpenFightJoin
end

function slot0.checkEnterUseFreeLimit(slot0)
	slot0._useFreeLimit = false
	slot0._checkFreeLimitChapterType = nil

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and DungeonConfig.instance:getChapterCO(slot2.chapterId) and slot3.enterAfterFreeLimit > 0 then
		if DungeonModel.instance:getChapterRemainingNum(slot3.type) > 0 then
			slot0._useFreeLimit = true
		else
			slot0._checkFreeLimitChapterType = slot3.type
		end
	end
end

function slot0.isEnterUseFreeLimit(slot0)
	if slot0._useFreeLimit then
		return true
	end

	return slot0._checkFreeLimitChapterType and DungeonModel.instance:getChapterRemainingNum(slot0._checkFreeLimitChapterType) > 0
end

function slot0.canParallelSkill(slot0, slot1)
	if uv0.forceParallelSkill then
		return true
	end

	if slot1 and slot1.custom_ingoreParallelSkill then
		return false
	end

	return slot0:isAuto() or FightReplayModel.instance:isReplay() or slot0:isGMFightJoin()
end

function slot0.updateFight(slot0, slot1, slot2)
	slot0._version = uv0.GMForceVersion or slot1.version or 0
	slot0._isRecord = slot1.isRecord
	slot0._fightActType = slot1.fightActType or FightEnum.FightActType.Normal

	if slot0._fightActType == 0 then
		slot0._fightActType = FightEnum.FightActType.Normal
	end

	if not slot2 then
		FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Fight, slot1)
	end

	if slot0._version >= 3 then
		if not slot2 then
			slot0._curRoundId = slot1.curRound
		end
	else
		slot0._curRoundId = slot1.curRound
	end

	slot0._curWaveId = slot1.curWave
	slot0.maxRound = slot1.maxRound

	if not slot2 then
		slot0._isFinish = slot1.isFinish
	end

	slot0.power = slot1.attacker.power
	slot0.clothId = slot1.attacker.clothId
	slot0._battleId = slot1.battleId
	slot0.exTeamStr = slot1.attacker.exTeamStr

	if slot1:HasField("attacker") and #slot1.attacker.skillInfos > 0 then
		slot0:_updatePlayerSkillInfo(slot1.attacker.skillInfos)
	end

	if slot1:HasField("magicCircle") then
		slot0:getMagicCircleInfo():refreshData(slot1.magicCircle)
	end
end

function slot0.updateFightRound(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Round, slot1)
	FightLocalDataMgr.instance:beforePlayRoundProto(slot1)
	FightDataMgr.instance:beforePlayRoundProto(slot1)
	xpcall(FightDataMgr.dealRoundProto, __G__TRACKBACK__, FightLocalDataMgr.instance, slot1)
	FightLocalDataMgr.instance:afterPlayRoundProto(slot1)

	slot0._curRoundMO = slot0._curRoundMO or FightRoundMO.New()

	slot0._curRoundMO:init(slot1)
	slot0:updateSpAttributeMo(slot1.heroSpAttributes)

	slot0._isFinish = slot0._curRoundMO.isFinish
	slot0.power = slot0._curRoundMO.power

	if slot1:HasField("actPoint") then
		FightCardModel.instance.nextRoundActPoint = slot0._curRoundMO.actPoint
	end

	if slot1:HasField("moveNum") then
		FightCardModel.instance.nextRoundMoveNum = slot0._curRoundMO.moveNum
	end

	if #slot1.skillInfos > 0 then
		slot0:_updatePlayerSkillInfo(slot1.skillInfos)
	end

	if slot0:getVersion() < 1 then
		FightPlayCardModel.instance:updateFightRound(slot0._curRoundMO)
	end

	slot0.autoPlayCardList = {}
end

function slot0.updateSpAttributeMo(slot0, slot1)
	if #slot1 == 0 then
		return
	end

	slot0.entitySpAttrMoDict = slot0.entitySpAttrMoDict or {}

	for slot5, slot6 in ipairs(slot1) do
		if not slot0.entitySpAttrMoDict[slot6.uid] then
			slot0.entitySpAttrMoDict[slot7] = HeroSpAttributeMO.New()
		end

		slot8:init(slot7, slot6.attribute)
	end
end

function slot0.getSpAttributeMo(slot0, slot1)
	return slot0.entitySpAttrMoDict and slot0.entitySpAttrMoDict[slot1]
end

function slot0.updateClothSkillRound(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Round, slot1)
	FightLocalDataMgr.instance:beforePlayRoundProto(slot1)
	FightDataMgr.instance:beforePlayRoundProto(slot1)
	xpcall(FightDataMgr.dealRoundProto, __G__TRACKBACK__, FightLocalDataMgr.instance, slot1)
	FightLocalDataMgr.instance:afterPlayRoundProto(slot1)

	slot0._curRoundMO = slot0._curRoundMO or FightRoundMO.New()

	slot0._curRoundMO:updateClothSkillRound(slot1)

	slot0._isFinish = slot0._curRoundMO.isFinish
	slot0.power = slot0._curRoundMO.power

	if slot1:HasField("actPoint") then
		FightCardModel.instance.nextRoundActPoint = slot0._curRoundMO.actPoint
	end

	if slot1:HasField("moveNum") then
		FightCardModel.instance.nextRoundMoveNum = slot0._curRoundMO.moveNum
	end

	if #slot1.skillInfos > 0 then
		slot0:_updatePlayerSkillInfo(slot1.skillInfos)
	end
end

function slot0.onAutoRound(slot0, slot1)
	slot0.autoPlayCardList = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = FightBeginRoundOp.New()

		slot7:init(slot6)
		table.insert(slot0.autoPlayCardList, slot7)
	end
end

function slot0._updatePlayerSkillInfo(slot0, slot1)
	slot0._clothSkillList = {}
	slot0._clothSkillDict = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = {
			skillId = slot6.skillId,
			cd = slot6.cd,
			needPower = slot6.needPower,
			type = slot6.type
		}

		table.insert(slot0._clothSkillList, slot7)

		slot0._clothSkillDict[slot6.skillId] = slot7
	end
end

function slot0.onEndRound(slot0)
	if slot0._curRoundMO then
		slot0._historyRoundMOList = slot0._historyRoundMOList or {}

		table.insert(slot0._historyRoundMOList, slot0._curRoundMO:clone())
	end

	if uv0.instance:getVersion() < 3 then
		slot0._curRoundId = slot0._curRoundId + slot0._roundInc
	end

	slot0._roundInc = 1
	slot0.hasNextWave = false
	slot0._nextWaveMsg = nil
	slot0.cacheWaveMsg = nil

	slot0:clearStressBehaviour()
end

function slot0.updateRecord(slot0, slot1)
	slot0._recordMO = slot0._recordMO or FightRecordMO.New()

	slot0._recordMO:init(slot1)

	slot0._lastFightResult = slot0._recordMO.fightResult
end

function slot0.getLastFightResult(slot0)
	return slot0._lastFightResult
end

function slot0.onEndFight(slot0)
	slot0._isFinish = true
	slot0._curRoundMO = nil
	slot0._clothSkillList = nil
	slot0._clothSkillDict = nil
	slot0._nextWaveMsg = nil
	slot0.hasNextWave = false
	slot0.cacheWaveMsg = nil
end

function slot0.updateFightReason(slot0, slot1)
	slot0._fightReason = slot0._fightReason or FightReasonMO.New()

	slot0._fightReason:init(slot1)
end

function slot0.setNextWaveMsg(slot0, slot1)
	slot0._nextWaveMsg = slot0._nextWaveMsg or {}

	table.insert(slot0._nextWaveMsg, slot1)

	slot0.cacheWaveMsg = slot0.cacheWaveMsg or {}

	table.insert(slot0.cacheWaveMsg, slot1)

	slot0._roundInc = 0
	slot0.hasNextWave = true
end

function slot0.getNextWaveMsg(slot0)
	return slot0._nextWaveMsg and slot0._nextWaveMsg[1]
end

function slot0.getAndRemoveNextWaveMsg(slot0)
	return slot0._nextWaveMsg and table.remove(slot0._nextWaveMsg, 1)
end

function slot0.getAndRemoveCacheWaveMsg(slot0)
	return slot0.cacheWaveMsg and table.remove(slot0.cacheWaveMsg, 1)
end

function slot0.getClothSkillList(slot0)
	return slot0._clothSkillList
end

function slot0.setClickEnemyState(slot0, slot1)
	slot0._isClickEnemy = slot1
end

function slot0.getClickEnemyState(slot0)
	return slot0._isClickEnemy
end

function slot0.recordPassModel(slot0, slot1)
	slot0.curFightModel = slot1.isRecord
	slot2 = (not string.nilorempty(PlayerPrefsHelper.getString(uv0.getPrefsKeyFightPassModel(), "")) or {}) and cjson.decode(slot2)

	if slot0._fightParam then
		slot2[tostring(slot0._fightParam.episodeId)] = slot1.isRecord
	end

	PlayerPrefsHelper.setString(uv0.getPrefsKeyFightPassModel(), cjson.encode(slot2))
end

function slot0.getPrefsKeyFightPassModel()
	return PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.FightPassModel
end

function slot0.setWaitIndicatorAnimation(slot0, slot1)
	slot0.waitIndicatorAnimation = slot1
end

function slot0.isWaitIndicatorAnimation(slot0)
	return slot0.waitIndicatorAnimation
end

function slot0.refreshBattleId(slot0, slot1)
	slot0._battleId = slot1.battleId

	if slot0._fightParam then
		slot0._fightParam:setBattleId(slot0._battleId)
	end
end

function slot0.getMagicCircleInfo(slot0)
	slot0._magicCircleInfo = slot0._magicCircleInfo or FightMagicCircleInfo.New()

	return slot0._magicCircleInfo
end

function slot0.getVersion(slot0)
	return slot0._version or 0
end

function slot0.getFightActType(slot0)
	return slot0._fightActType
end

function slot0.isRecord(slot0)
	return slot0._isRecord
end

function slot0.setRougeExData(slot0, slot1, slot2)
	slot4[1] = string.split(uv0.instance.exTeamStr, "#")[1] or 0
	slot4[2] = slot4[2] or 0
	slot4[3] = slot4[3] or 0
	slot4[4] = slot4[4] or cjson.encode({})
	slot4[slot1] = slot2
	uv0.instance.exTeamStr = string.format("%s#%s#%s#%s", slot4[1], slot4[2], slot4[3], slot4[4])
end

function slot0.getRougeExData(slot0, slot1)
	slot2 = string.split(uv0.instance.exTeamStr, "#")

	if slot1 == FightEnum.ExIndexForRouge.SupportHeroSkill then
		return slot2[slot1] or cjson.encode({})
	end

	return tonumber(slot2[slot1]) or 0
end

function slot0.isAbort(slot0)
	return slot0._recordMO and slot0._recordMO.fightResult == FightEnum.FightResult.Abort
end

function slot0.isFail(slot0)
	return slot0._recordMO and slot0._recordMO.fightResult == FightEnum.FightResult.Fail
end

function slot0.setCurSceneOriginPos(slot0, slot1, slot2, slot3)
	slot0.originZ = slot3
	slot0.originY = slot2
	slot0.originX = slot1
end

function slot0.getCurSceneOriginPos(slot0)
	return slot0.originX, slot0.originY, slot0.originZ
end

function slot0.isSeason2(slot0)
	return slot0:getFightActType() == FightEnum.FightActType.Season2
end

function slot0.recordDelayHandleStressBehaviour(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.stressBehaviourDict = slot0.stressBehaviourDict or {}

	if not slot0.stressBehaviourDict[slot1.targetId] then
		slot0.stressBehaviourDict[slot1.targetId] = {}
	end

	table.insert(slot2, slot1)
end

function slot0.popNoHandledStressBehaviour(slot0, slot1)
	slot2 = slot1 and slot0.stressBehaviourDict and slot0.stressBehaviourDict[slot1]

	return slot2 and table.remove(slot2, 1)
end

function slot0.clearStressBehaviour(slot0)
	if slot0.stressBehaviourDict then
		for slot4, slot5 in pairs(slot0.stressBehaviourDict) do
			tabletool.clear(slot5)
		end
	end
end

function slot0.setNotifyContractInfo(slot0, slot1, slot2)
	slot0.notifyEntityId = slot1
	slot0.canContractList = slot2
end

function slot0.setContractEntityUid(slot0, slot1)
	slot0.contractEntityUid = slot1
end

function slot0.setBeContractEntityUid(slot0, slot1)
	slot0.beContractEntityUid = slot1
end

function slot0.isBeContractEntity(slot0, slot1)
	return slot1 == slot0.beContractEntityUid
end

slot0.instance = slot0.New()

return slot0
