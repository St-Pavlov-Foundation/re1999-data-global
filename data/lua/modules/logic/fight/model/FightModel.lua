module("modules.logic.fight.model.FightModel", package.seeall)

local var_0_0 = class("FightModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._fightParam = nil
	arg_1_0._curStage = nil
	arg_1_0._curWaveId = 1
	arg_1_0._curRoundId = 1
	arg_1_0._roundInc = 1
	arg_1_0._curRoundMO = nil
	arg_1_0._historyRoundMOList = nil
	arg_1_0._isFinish = false
	arg_1_0._recordMO = nil
	arg_1_0.maxRound = 1
	arg_1_0.maxWave = 1
	arg_1_0.power = 0
	arg_1_0.clothId = 0
	arg_1_0._clothSkillDict = nil
	arg_1_0.needFightReconnect = false
	arg_1_0._fightReason = nil
	arg_1_0._isAuto = false
	arg_1_0._userSpeed = 1
	arg_1_0._gmOpenFightJoin = false
	arg_1_0._isClickEnemy = false
	arg_1_0.autoPlayCardList = {}
	arg_1_0._guideParam = {
		OnGuideFightEndPause = false,
		OnGuideEntityDeadPause = false,
		OnGuideDistributePause = false,
		OnGuideCardEndPause = false,
		OnGuideFightEndPause_sp = false,
		OnGuideBeforeSkillPause = false
	}
	arg_1_0._startFinish = false
	arg_1_0.roundOffset = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._curStage = nil
	arg_2_0.needFightReconnect = false
end

function var_0_0.clear(arg_3_0)
	FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = false
	var_0_0.forceParallelSkill = false
	arg_3_0._curStage = nil
	arg_3_0._curWaveId = 1

	FightPlayCardModel.instance:clearUsedCards()
	arg_3_0:resetRTPCSpeedTo1()

	arg_3_0._userSpeed = 1
	arg_3_0._historyRoundMOList = nil

	arg_3_0:getMagicCircleInfo():clear()

	arg_3_0.stressBehaviourDict = nil
	arg_3_0.entitySpAttrMoDict = nil
	arg_3_0.notifyEntityId = nil
	arg_3_0.canContractList = nil
	arg_3_0.contractEntityUid = nil
	arg_3_0.beContractEntityUid = nil
	arg_3_0.roundOffset = 0
end

function var_0_0.onRestart(arg_4_0)
	arg_4_0:clear()
end

function var_0_0.setFightParam(arg_5_0, arg_5_1)
	arg_5_0._historyRoundMOList = nil
	arg_5_0._fightParam = arg_5_1
	arg_5_0.maxWave = arg_5_0._fightParam.monsterGroupIds and #arg_5_0._fightParam.monsterGroupIds or 0
end

function var_0_0.getGuideParam(arg_6_0)
	return arg_6_0._guideParam
end

function var_0_0.getFightParam(arg_7_0)
	return arg_7_0._fightParam
end

function var_0_0.updateMySide(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getFightParam()

	if var_8_0 then
		var_8_0:setMySide(arg_8_1.clothId, arg_8_1.heroList, arg_8_1.subHeroList, arg_8_1.equips, arg_8_1.activity104Equips, arg_8_1.trialHeroList, arg_8_1.extraList, arg_8_1.assistBossId)
	end
end

function var_0_0.recordFightGroup(arg_9_0, arg_9_1)
	arg_9_0.last_fightGroup = arg_9_1
end

function var_0_0.getCurWaveId(arg_10_0)
	return arg_10_0._curWaveId
end

function var_0_0.getCurRoundId(arg_11_0)
	return arg_11_0._curRoundId - arg_11_0.roundOffset
end

function var_0_0.getMaxRound(arg_12_0)
	return arg_12_0.maxRound - arg_12_0.roundOffset
end

function var_0_0.setRoundOffset(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 or 0
	arg_13_0.roundOffset = arg_13_1
end

function var_0_0.getCurRoundMO(arg_14_0)
	return arg_14_0._curRoundMO
end

function var_0_0.getRecordMO(arg_15_0)
	return arg_15_0._recordMO
end

function var_0_0.clearRecordMO(arg_16_0)
	arg_16_0._recordMO = nil
end

function var_0_0.getFightReason(arg_17_0)
	return arg_17_0._fightReason
end

function var_0_0.getHistoryRoundMOList(arg_18_0)
	return arg_18_0._historyRoundMOList
end

function var_0_0.getSelectMonsterGroupId(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._fightParam

	if not arg_19_2 then
		return var_19_0 and var_19_0.monsterGroupIds and var_19_0.monsterGroupIds[arg_19_1]
	end

	if not var_19_0 or var_19_0.battleId ~= arg_19_2 then
		var_19_0 = FightParam.New()

		var_19_0:setBattleId(arg_19_2)
	end

	return var_19_0 and var_19_0.monsterGroupIds and var_19_0.monsterGroupIds[arg_19_1]
end

function var_0_0.getCurMonsterGroupId(arg_20_0)
	return arg_20_0._fightParam and arg_20_0._fightParam.monsterGroupIds and arg_20_0._fightParam.monsterGroupIds[arg_20_0._curWaveId]
end

function var_0_0.isShowSettlement(arg_21_0)
	return arg_21_0._fightParam and arg_21_0._fightParam.isShowSettlement
end

function var_0_0.getAfterStory(arg_22_0)
	if arg_22_0._fightParam and arg_22_0._fightParam.episodeId then
		local var_22_0 = DungeonConfig.instance:getEpisodeCO(arg_22_0._fightParam.episodeId)

		if var_22_0 then
			return var_22_0.afterStory
		end
	end

	return 0
end

function var_0_0.getCurStage(arg_23_0)
	return arg_23_0._curStage
end

function var_0_0.inFight(arg_24_0)
	return arg_24_0._curStage ~= nil
end

local var_0_1 = {
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

function var_0_0.getCurStageDesc(arg_25_0)
	return var_0_1[arg_25_0._curStage] or "nil"
end

function var_0_0.setCurStage(arg_26_0, arg_26_1)
	arg_26_0._curStage = arg_26_1

	if arg_26_1 == FightEnum.Stage.StartRound then
		arg_26_0._startFinish = false
	elseif arg_26_1 == FightEnum.Stage.Card or arg_26_1 == FightEnum.Stage.AutoCard then
		arg_26_0._startFinish = true
	end
end

function var_0_0.isStartFinish(arg_27_0)
	return arg_27_0._startFinish
end

function var_0_0.isFinish(arg_28_0)
	return arg_28_0._isFinish
end

function var_0_0.getBattleId(arg_29_0)
	return arg_29_0._battleId
end

function var_0_0.clearBattleId(arg_30_0)
	arg_30_0._battleId = nil
end

function var_0_0.initSpeedConfig(arg_31_0)
	if not arg_31_0._normalSpeed then
		arg_31_0._normalSpeed = {
			1,
			CommonConfig.instance:getConstNum(ConstEnum.FightSpeed)
		}

		local var_31_0 = CommonConfig.instance:getConstStr(ConstEnum.FightReplaySpeed)
		local var_31_1 = FightStrUtil.instance:getSplitString2Cache(var_31_0, true, "|", "#")

		arg_31_0._replaySpeed = {
			var_31_1[1][1],
			var_31_1[2][1]
		}
		arg_31_0._replayUISpeed = {
			var_31_1[1][2],
			var_31_1[2][2]
		}

		local var_31_2 = FightStrUtil.instance:getSplitToNumberCache(CommonConfig.instance:getConstStr(ConstEnum.bossSkillFightSpeed), "#")

		arg_31_0._bossSkillNormalSpeed = {
			var_31_2[1],
			var_31_2[2]
		}

		local var_31_3 = FightStrUtil.instance:getSplitToNumberCache(CommonConfig.instance:getConstStr(ConstEnum.bossSkillFightReplaySpeed), "#")

		arg_31_0._bossSkillReplaySpeed = {
			var_31_3[1],
			var_31_3[2]
		}

		local var_31_4 = GameUtil.splitString2(lua_activity174_const.configDict[Activity174Enum.ConstKey.FightSpeed].value, true)

		arg_31_0._douQuQuSpeed = {
			var_31_4[1][1],
			var_31_4[2][1]
		}
		arg_31_0._douQuQuUISpeed = {
			var_31_4[1][2],
			var_31_4[2][2]
		}

		local var_31_5 = GameUtil.splitString2(lua_activity191_const.configDict[Activity191Enum.ConstKey.FightSpeed].value, true)

		arg_31_0._douQuQu191Speed = {
			var_31_5[1][1],
			var_31_5[2][1]
		}
		arg_31_0._douQuQu191UISpeed = {
			var_31_5[1][2],
			var_31_5[2][2]
		}
	end
end

function var_0_0.getSpeed(arg_32_0)
	if var_0_0.instance.useExclusiveSpeed then
		return var_0_0.instance.useExclusiveSpeed
	end

	arg_32_0:initSpeedConfig()

	if FightDataHelper.fieldMgr:isDouQuQu() then
		return arg_32_0._douQuQuSpeed[arg_32_0._userSpeed] or 1
	end

	if FightDataHelper.fieldMgr:is191DouQuQu() then
		return arg_32_0._douQuQu191Speed[arg_32_0._userSpeed] or 1
	end

	if FightReplayModel.instance:isReplay() then
		if var_0_0.instance.useBossSkillSpeed then
			return arg_32_0._bossSkillReplaySpeed[arg_32_0._userSpeed] or 1
		end

		return arg_32_0._replaySpeed[arg_32_0._userSpeed] or 1
	else
		if var_0_0.instance.useBossSkillSpeed then
			return arg_32_0._bossSkillNormalSpeed[arg_32_0._userSpeed] or 1
		end

		return arg_32_0._normalSpeed[arg_32_0._userSpeed] or 1
	end
end

function var_0_0.getNormalSpeed(arg_33_0)
	arg_33_0:initSpeedConfig()

	return arg_33_0._normalSpeed[1] or 1
end

function var_0_0.getReplaySpeed(arg_34_0)
	arg_34_0:initSpeedConfig()

	return arg_34_0._replaySpeed[1] or 1
end

function var_0_0.getUISpeed(arg_35_0)
	arg_35_0:initSpeedConfig()

	if FightDataHelper.fieldMgr:isDouQuQu() then
		return arg_35_0._douQuQuUISpeed[arg_35_0._userSpeed] or 1
	end

	if FightDataHelper.fieldMgr:is191DouQuQu() then
		return arg_35_0._douQuQu191UISpeed[arg_35_0._userSpeed] or 1
	end

	if FightReplayModel.instance:isReplay() then
		return arg_35_0._replayUISpeed[arg_35_0._userSpeed] or 1
	else
		return 1
	end
end

function var_0_0.setGMSpeed(arg_36_0, arg_36_1, arg_36_2)
	arg_36_0._normalSpeed = {
		arg_36_1,
		arg_36_1
	}
	arg_36_0._replaySpeed = {
		arg_36_2,
		arg_36_2
	}

	if arg_36_0:getCurStage() then
		arg_36_0:updateRTPCSpeed()
	end
end

function var_0_0.getUserSpeed(arg_37_0)
	return arg_37_0._userSpeed
end

function var_0_0.setUserSpeed(arg_38_0, arg_38_1)
	arg_38_0._userSpeed = arg_38_1 or 1

	arg_38_0:updateRTPCSpeed()
end

function var_0_0.updateRTPCSpeed(arg_39_0)
	AudioMgr.instance:setRTPCValue(FightEnum.GameSpeedRTPC, arg_39_0:getSpeed())
end

function var_0_0.resetRTPCSpeedTo1(arg_40_0)
	AudioMgr.instance:setRTPCValue(FightEnum.GameSpeedRTPC, 1)
end

function var_0_0.isAuto(arg_41_0)
	return arg_41_0._isAuto
end

function var_0_0.setAuto(arg_42_0, arg_42_1)
	if not arg_42_1 and arg_42_0._isAuto then
		arg_42_0._isAuto = arg_42_1

		FightDataHelper.operationDataMgr:setCurSelectEntityId(0)
		FightDataHelper.operationDataMgr:resetCurSelectEntityIdDefault()
	end

	arg_42_0._isAuto = arg_42_1

	if arg_42_1 then
		FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.Auto)
	else
		FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Auto)
	end
end

function var_0_0.switchGMFightJoin(arg_43_0)
	arg_43_0._gmOpenFightJoin = not arg_43_0._gmOpenFightJoin
end

function var_0_0.isGMFightJoin(arg_44_0)
	return arg_44_0._gmOpenFightJoin
end

function var_0_0.checkEnterUseFreeLimit(arg_45_0)
	arg_45_0._useFreeLimit = false
	arg_45_0._checkFreeLimitChapterType = nil

	local var_45_0 = DungeonModel.instance.curSendEpisodeId
	local var_45_1 = DungeonConfig.instance:getEpisodeCO(var_45_0)
	local var_45_2 = var_45_1 and DungeonConfig.instance:getChapterCO(var_45_1.chapterId)

	if var_45_2 and var_45_2.enterAfterFreeLimit > 0 then
		if DungeonModel.instance:getChapterRemainingNum(var_45_2.type) > 0 then
			arg_45_0._useFreeLimit = true
		else
			arg_45_0._checkFreeLimitChapterType = var_45_2.type
		end
	end
end

function var_0_0.isEnterUseFreeLimit(arg_46_0)
	if arg_46_0._useFreeLimit then
		return true
	end

	return arg_46_0._checkFreeLimitChapterType and DungeonModel.instance:getChapterRemainingNum(arg_46_0._checkFreeLimitChapterType) > 0
end

function var_0_0.canParallelSkill(arg_47_0, arg_47_1)
	if var_0_0.forceParallelSkill then
		return true
	end

	if arg_47_1 and arg_47_1.custom_ingoreParallelSkill then
		return false
	end

	return arg_47_0:isAuto() or FightReplayModel.instance:isReplay() or arg_47_0:isGMFightJoin()
end

function var_0_0.updateFight(arg_48_0, arg_48_1, arg_48_2)
	arg_48_0._version = var_0_0.GMForceVersion or arg_48_1.version or 0

	if not arg_48_2 then
		arg_48_0._isRecord = arg_48_1.isRecord
	end

	arg_48_0._fightActType = arg_48_1.fightActType or FightEnum.FightActType.Normal

	if arg_48_0._fightActType == 0 then
		arg_48_0._fightActType = FightEnum.FightActType.Normal
	end

	if not arg_48_2 then
		FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Fight, arg_48_1)
	end

	if arg_48_0._version >= 3 then
		if not arg_48_2 then
			arg_48_0._curRoundId = arg_48_1.curRound
		end
	else
		arg_48_0._curRoundId = arg_48_1.curRound
	end

	arg_48_0._curWaveId = arg_48_1.curWave
	arg_48_0.maxRound = arg_48_1.maxRound

	if not arg_48_2 then
		arg_48_0._isFinish = arg_48_1.isFinish
	end

	arg_48_0.power = arg_48_1.attacker.power
	arg_48_0.clothId = arg_48_1.attacker.clothId
	arg_48_0._battleId = arg_48_1.battleId
	arg_48_0.exTeamStr = arg_48_1.attacker.exTeamStr

	if arg_48_1.attacker and #arg_48_1.attacker.skillInfos > 0 then
		arg_48_0:_updatePlayerSkillInfo(arg_48_1.attacker.skillInfos)
	end

	if arg_48_1.magicCircle then
		arg_48_0:getMagicCircleInfo():refreshData(arg_48_1.magicCircle)
	end
end

function var_0_0.updateFightRound(arg_49_0, arg_49_1)
	FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Round, arg_49_1)
	FightDataHelper.setRoundDataByProto(arg_49_1)

	local var_49_0 = FightDataHelper.roundMgr:getRoundData()

	FightLocalDataMgr.instance:beforePlayRoundData(var_49_0)
	xpcall(FightDataMgr.dealRoundData, __G__TRACKBACK__, FightLocalDataMgr.instance, var_49_0)
	FightLocalDataMgr.instance:afterPlayRoundData(var_49_0)
	var_49_0:processRoundData()
	FightDataMgr.instance:beforePlayRoundData(var_49_0)
	arg_49_0:updateSpAttributeMo(var_49_0.heroSpAttributes)

	arg_49_0._isFinish = var_49_0.isFinish
	arg_49_0.power = var_49_0.power

	if #var_49_0.skillInfos > 0 then
		arg_49_0:_updatePlayerSkillInfo(var_49_0.skillInfos)
	end

	if arg_49_0:getVersion() < 1 then
		FightPlayCardModel.instance:updateFightRound(var_49_0)
	end

	arg_49_0.autoPlayCardList = {}
end

function var_0_0.updateSpAttributeMo(arg_50_0, arg_50_1)
	if #arg_50_1 == 0 then
		return
	end

	arg_50_0.entitySpAttrMoDict = arg_50_0.entitySpAttrMoDict or {}

	for iter_50_0, iter_50_1 in ipairs(arg_50_1) do
		local var_50_0 = iter_50_1.uid
		local var_50_1 = arg_50_0.entitySpAttrMoDict[var_50_0]

		if not var_50_1 then
			var_50_1 = HeroSpAttributeMO.New()
			arg_50_0.entitySpAttrMoDict[var_50_0] = var_50_1
		end

		var_50_1:init(var_50_0, iter_50_1.attribute)
	end
end

function var_0_0.getSpAttributeMo(arg_51_0, arg_51_1)
	return arg_51_0.entitySpAttrMoDict and arg_51_0.entitySpAttrMoDict[arg_51_1]
end

function var_0_0.updateClothSkillRound(arg_52_0, arg_52_1)
	if arg_52_0:getVersion() < 5 then
		arg_52_1.actPoint = FightDataHelper.operationDataMgr.actPoint
	end

	FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Round, arg_52_1)
	FightDataHelper.setRoundDataByProto(arg_52_1)

	local var_52_0 = FightDataHelper.roundMgr:getRoundData()

	FightLocalDataMgr.instance:beforePlayRoundData(var_52_0)
	xpcall(FightDataMgr.dealRoundData, __G__TRACKBACK__, FightLocalDataMgr.instance, var_52_0)
	FightLocalDataMgr.instance:afterPlayRoundData(var_52_0)
	var_52_0:processRoundData()
	FightDataMgr.instance:beforePlayRoundData(var_52_0)

	arg_52_0._isFinish = var_52_0.isFinish
	arg_52_0.power = var_52_0.power

	if #var_52_0.skillInfos > 0 then
		arg_52_0:_updatePlayerSkillInfo(var_52_0.skillInfos)
	end
end

function var_0_0.onAutoRound(arg_53_0, arg_53_1)
	arg_53_0.autoPlayCardList = {}

	for iter_53_0, iter_53_1 in ipairs(arg_53_1) do
		local var_53_0 = FightOperationItemData.New()

		var_53_0:setByProto(iter_53_1)
		table.insert(arg_53_0.autoPlayCardList, var_53_0)
	end
end

function var_0_0._updatePlayerSkillInfo(arg_54_0, arg_54_1)
	arg_54_0._clothSkillList = {}
	arg_54_0._clothSkillDict = {}

	for iter_54_0, iter_54_1 in ipairs(arg_54_1) do
		local var_54_0 = {
			skillId = iter_54_1.skillId,
			cd = iter_54_1.cd,
			needPower = iter_54_1.needPower,
			type = iter_54_1.type
		}

		table.insert(arg_54_0._clothSkillList, var_54_0)

		arg_54_0._clothSkillDict[iter_54_1.skillId] = var_54_0
	end
end

function var_0_0.onEndRound(arg_55_0)
	if arg_55_0._curRoundMO then
		arg_55_0._historyRoundMOList = arg_55_0._historyRoundMOList or {}

		table.insert(arg_55_0._historyRoundMOList, arg_55_0._curRoundMO:clone())
	end

	if var_0_0.instance:getVersion() >= 3 then
		-- block empty
	else
		arg_55_0._curRoundId = arg_55_0._curRoundId + arg_55_0._roundInc
	end

	arg_55_0._roundInc = 1
	arg_55_0.hasNextWave = false

	arg_55_0:clearStressBehaviour()
end

function var_0_0.updateRecord(arg_56_0, arg_56_1)
	arg_56_0._recordMO = arg_56_0._recordMO or FightRecordMO.New()

	arg_56_0._recordMO:init(arg_56_1)

	arg_56_0._lastFightResult = arg_56_0._recordMO.fightResult
end

function var_0_0.getLastFightResult(arg_57_0)
	return arg_57_0._lastFightResult
end

function var_0_0.onEndFight(arg_58_0)
	arg_58_0._isFinish = true
	arg_58_0._curRoundMO = nil
	arg_58_0._clothSkillList = nil
	arg_58_0._clothSkillDict = nil
	arg_58_0.hasNextWave = false
end

function var_0_0.updateFightReason(arg_59_0, arg_59_1)
	arg_59_0._fightReason = arg_59_0._fightReason or FightReasonMO.New()

	arg_59_0._fightReason:init(arg_59_1)
end

function var_0_0.setNextWaveMsg(arg_60_0, arg_60_1)
	arg_60_0._roundInc = 0
	arg_60_0.hasNextWave = true
end

function var_0_0.getClothSkillList(arg_61_0)
	return arg_61_0._clothSkillList
end

function var_0_0.setClickEnemyState(arg_62_0, arg_62_1)
	arg_62_0._isClickEnemy = arg_62_1
end

function var_0_0.getClickEnemyState(arg_63_0)
	return arg_63_0._isClickEnemy
end

function var_0_0.recordPassModel(arg_64_0, arg_64_1)
	arg_64_0.curFightModel = arg_64_1.isRecord

	local var_64_0 = PlayerPrefsHelper.getString(var_0_0.getPrefsKeyFightPassModel(), "")

	if string.nilorempty(var_64_0) then
		var_64_0 = {}
	else
		var_64_0 = cjson.decode(var_64_0)
	end

	if arg_64_0._fightParam then
		var_64_0[tostring(arg_64_0._fightParam.episodeId)] = arg_64_1.isRecord
	end

	PlayerPrefsHelper.setString(var_0_0.getPrefsKeyFightPassModel(), cjson.encode(var_64_0))
end

function var_0_0.getPrefsKeyFightPassModel()
	return PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.FightPassModel
end

function var_0_0.setWaitIndicatorAnimation(arg_66_0, arg_66_1)
	arg_66_0.waitIndicatorAnimation = arg_66_1
end

function var_0_0.isWaitIndicatorAnimation(arg_67_0)
	return arg_67_0.waitIndicatorAnimation
end

function var_0_0.refreshBattleId(arg_68_0, arg_68_1)
	arg_68_0._battleId = arg_68_1.battleId

	if arg_68_0._fightParam then
		arg_68_0._fightParam:setBattleId(arg_68_0._battleId)
	end
end

function var_0_0.getMagicCircleInfo(arg_69_0)
	arg_69_0._magicCircleInfo = arg_69_0._magicCircleInfo or FightMagicCircleInfo.New()

	return arg_69_0._magicCircleInfo
end

function var_0_0.getVersion(arg_70_0)
	return arg_70_0._version or 0
end

function var_0_0.getFightActType(arg_71_0)
	return arg_71_0._fightActType
end

function var_0_0.isRecord(arg_72_0)
	return arg_72_0._isRecord
end

function var_0_0.setRougeExData(arg_73_0, arg_73_1, arg_73_2)
	local var_73_0 = var_0_0.instance.exTeamStr
	local var_73_1 = string.split(var_73_0, "#")

	var_73_1[1] = var_73_1[1] or 0
	var_73_1[2] = var_73_1[2] or 0
	var_73_1[3] = var_73_1[3] or 0
	var_73_1[4] = var_73_1[4] or cjson.encode({})
	var_73_1[arg_73_1] = arg_73_2
	var_0_0.instance.exTeamStr = string.format("%s#%s#%s#%s", var_73_1[1], var_73_1[2], var_73_1[3], var_73_1[4])
end

function var_0_0.getRougeExData(arg_74_0, arg_74_1)
	local var_74_0 = string.split(var_0_0.instance.exTeamStr, "#")

	if arg_74_1 == FightEnum.ExIndexForRouge.SupportHeroSkill then
		return var_74_0[arg_74_1] or cjson.encode({})
	end

	return tonumber(var_74_0[arg_74_1]) or 0
end

function var_0_0.isAbort(arg_75_0)
	return arg_75_0._recordMO and arg_75_0._recordMO.fightResult == FightEnum.FightResult.Abort
end

function var_0_0.isFail(arg_76_0)
	return arg_76_0._recordMO and arg_76_0._recordMO.fightResult == FightEnum.FightResult.Fail
end

function var_0_0.setCurSceneOriginPos(arg_77_0, arg_77_1, arg_77_2, arg_77_3)
	arg_77_0.originX, arg_77_0.originY, arg_77_0.originZ = arg_77_1, arg_77_2, arg_77_3
end

function var_0_0.getCurSceneOriginPos(arg_78_0)
	return arg_78_0.originX, arg_78_0.originY, arg_78_0.originZ
end

function var_0_0.isSeason2(arg_79_0)
	return arg_79_0:getFightActType() == FightEnum.FightActType.Season2
end

function var_0_0.recordDelayHandleStressBehaviour(arg_80_0, arg_80_1)
	if not arg_80_1 then
		return
	end

	arg_80_0.stressBehaviourDict = arg_80_0.stressBehaviourDict or {}

	local var_80_0 = arg_80_0.stressBehaviourDict[arg_80_1.targetId]

	if not var_80_0 then
		var_80_0 = {}
		arg_80_0.stressBehaviourDict[arg_80_1.targetId] = var_80_0
	end

	table.insert(var_80_0, arg_80_1)
end

function var_0_0.popNoHandledStressBehaviour(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_1 and arg_81_0.stressBehaviourDict and arg_81_0.stressBehaviourDict[arg_81_1]

	return var_81_0 and table.remove(var_81_0, 1)
end

function var_0_0.clearStressBehaviour(arg_82_0)
	if arg_82_0.stressBehaviourDict then
		for iter_82_0, iter_82_1 in pairs(arg_82_0.stressBehaviourDict) do
			tabletool.clear(iter_82_1)
		end
	end
end

function var_0_0.setNotifyContractInfo(arg_83_0, arg_83_1, arg_83_2)
	arg_83_0.notifyEntityId = arg_83_1
	arg_83_0.canContractList = arg_83_2
end

function var_0_0.setContractEntityUid(arg_84_0, arg_84_1)
	arg_84_0.contractEntityUid = arg_84_1
end

function var_0_0.setBeContractEntityUid(arg_85_0, arg_85_1)
	arg_85_0.beContractEntityUid = arg_85_1
end

function var_0_0.isBeContractEntity(arg_86_0, arg_86_1)
	return arg_86_1 == arg_86_0.beContractEntityUid
end

var_0_0.instance = var_0_0.New()

return var_0_0
