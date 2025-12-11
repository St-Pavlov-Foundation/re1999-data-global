module("modules.logic.fight.model.FightModel", package.seeall)

local var_0_0 = class("FightModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._fightParam = nil
	arg_1_0._curWaveId = 1
	arg_1_0._curRoundId = 1
	arg_1_0._roundInc = 1
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
	arg_2_0.needFightReconnect = false
end

function var_0_0.clear(arg_3_0)
	FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill = false
	var_0_0.forceParallelSkill = false
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
	arg_3_0.removeActEffectObj = nil
	arg_3_0.smallSkillIcon = nil
	arg_3_0.bigSkillIcon = nil
	arg_3_0.needPlay500MRemoveActEffect = nil
	arg_3_0.multiHpType = nil
	arg_3_0.isHideCard = nil
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

function var_0_0.getRecordMO(arg_14_0)
	return arg_14_0._recordMO
end

function var_0_0.clearRecordMO(arg_15_0)
	arg_15_0._recordMO = nil
end

function var_0_0.getFightReason(arg_16_0)
	return arg_16_0._fightReason
end

function var_0_0.getHistoryRoundMOList(arg_17_0)
	return arg_17_0._historyRoundMOList
end

function var_0_0.getSelectMonsterGroupId(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0._fightParam

	if not arg_18_2 then
		return var_18_0 and var_18_0.monsterGroupIds and var_18_0.monsterGroupIds[arg_18_1]
	end

	if not var_18_0 or var_18_0.battleId ~= arg_18_2 then
		var_18_0 = FightParam.New()

		var_18_0:setBattleId(arg_18_2)
	end

	return var_18_0 and var_18_0.monsterGroupIds and var_18_0.monsterGroupIds[arg_18_1]
end

function var_0_0.getCurMonsterGroupId(arg_19_0)
	return arg_19_0._fightParam and arg_19_0._fightParam.monsterGroupIds and arg_19_0._fightParam.monsterGroupIds[arg_19_0._curWaveId]
end

function var_0_0.isShowSettlement(arg_20_0)
	return arg_20_0._fightParam and arg_20_0._fightParam.isShowSettlement
end

function var_0_0.getAfterStory(arg_21_0)
	if arg_21_0._fightParam and arg_21_0._fightParam.episodeId then
		local var_21_0 = DungeonConfig.instance:getEpisodeCO(arg_21_0._fightParam.episodeId)

		if var_21_0 then
			return var_21_0.afterStory
		end
	end

	return 0
end

function var_0_0.isStartFinish(arg_22_0)
	return not FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.Enter)
end

function var_0_0.isFinish(arg_23_0)
	return arg_23_0._isFinish
end

function var_0_0.getBattleId(arg_24_0)
	return arg_24_0._battleId
end

function var_0_0.clearBattleId(arg_25_0)
	arg_25_0._battleId = nil
end

function var_0_0.initSpeedConfig(arg_26_0)
	if not arg_26_0._normalSpeed then
		arg_26_0._normalSpeed = {
			1,
			CommonConfig.instance:getConstNum(ConstEnum.FightSpeed)
		}

		local var_26_0 = CommonConfig.instance:getConstStr(ConstEnum.FightReplaySpeed)
		local var_26_1 = FightStrUtil.instance:getSplitString2Cache(var_26_0, true, "|", "#")

		arg_26_0._replaySpeed = {
			var_26_1[1][1],
			var_26_1[2][1]
		}
		arg_26_0._replayUISpeed = {
			var_26_1[1][2],
			var_26_1[2][2]
		}

		local var_26_2 = FightStrUtil.instance:getSplitToNumberCache(CommonConfig.instance:getConstStr(ConstEnum.bossSkillFightSpeed), "#")

		arg_26_0._bossSkillNormalSpeed = {
			var_26_2[1],
			var_26_2[2]
		}

		local var_26_3 = FightStrUtil.instance:getSplitToNumberCache(CommonConfig.instance:getConstStr(ConstEnum.bossSkillFightReplaySpeed), "#")

		arg_26_0._bossSkillReplaySpeed = {
			var_26_3[1],
			var_26_3[2]
		}

		local var_26_4 = GameUtil.splitString2(lua_activity174_const.configDict[Activity174Enum.ConstKey.FightSpeed].value, true)

		arg_26_0._douQuQuSpeed = {
			var_26_4[1][1],
			var_26_4[2][1]
		}
		arg_26_0._douQuQuUISpeed = {
			var_26_4[1][2],
			var_26_4[2][2]
		}

		local var_26_5 = GameUtil.splitString2(lua_activity191_const.configDict[Activity191Enum.ConstKey.FightSpeed].value, true)

		arg_26_0._douQuQu191Speed = {
			var_26_5[1][1],
			var_26_5[2][1]
		}
		arg_26_0._douQuQu191UISpeed = {
			var_26_5[1][2],
			var_26_5[2][2]
		}
	end
end

function var_0_0.getSpeed(arg_27_0)
	if var_0_0.instance.useExclusiveSpeed then
		return var_0_0.instance.useExclusiveSpeed
	end

	arg_27_0:initSpeedConfig()

	if FightDataHelper.fieldMgr:isDouQuQu() then
		return arg_27_0._douQuQuSpeed[arg_27_0._userSpeed] or 1
	end

	if FightDataHelper.fieldMgr:is191DouQuQu() then
		return arg_27_0._douQuQu191Speed[arg_27_0._userSpeed] or 1
	end

	if FightDataHelper.stateMgr.isReplay then
		if var_0_0.instance.useBossSkillSpeed then
			return arg_27_0._bossSkillReplaySpeed[arg_27_0._userSpeed] or 1
		end

		return arg_27_0._replaySpeed[arg_27_0._userSpeed] or 1
	else
		if var_0_0.instance.useBossSkillSpeed then
			return arg_27_0._bossSkillNormalSpeed[arg_27_0._userSpeed] or 1
		end

		return arg_27_0._normalSpeed[arg_27_0._userSpeed] or 1
	end
end

function var_0_0.getNormalSpeed(arg_28_0)
	arg_28_0:initSpeedConfig()

	return arg_28_0._normalSpeed[1] or 1
end

function var_0_0.getReplaySpeed(arg_29_0)
	arg_29_0:initSpeedConfig()

	return arg_29_0._replaySpeed[1] or 1
end

function var_0_0.getUISpeed(arg_30_0)
	arg_30_0:initSpeedConfig()

	if FightDataHelper.fieldMgr:isDouQuQu() then
		return arg_30_0._douQuQuUISpeed[arg_30_0._userSpeed] or 1
	end

	if FightDataHelper.fieldMgr:is191DouQuQu() then
		return arg_30_0._douQuQu191UISpeed[arg_30_0._userSpeed] or 1
	end

	if FightDataHelper.stateMgr.isReplay then
		return arg_30_0._replayUISpeed[arg_30_0._userSpeed] or 1
	else
		return 1
	end
end

function var_0_0.setGMSpeed(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0._normalSpeed = {
		arg_31_1,
		arg_31_1
	}
	arg_31_0._replaySpeed = {
		arg_31_2,
		arg_31_2
	}

	arg_31_0:updateRTPCSpeed()
end

function var_0_0.getUserSpeed(arg_32_0)
	return arg_32_0._userSpeed
end

function var_0_0.setUserSpeed(arg_33_0, arg_33_1)
	arg_33_0._userSpeed = arg_33_1 or 1

	arg_33_0:updateRTPCSpeed()
end

function var_0_0.updateRTPCSpeed(arg_34_0)
	AudioMgr.instance:setRTPCValue(FightEnum.GameSpeedRTPC, arg_34_0:getSpeed())
end

function var_0_0.resetRTPCSpeedTo1(arg_35_0)
	AudioMgr.instance:setRTPCValue(FightEnum.GameSpeedRTPC, 1)
end

function var_0_0.switchGMFightJoin(arg_36_0)
	arg_36_0._gmOpenFightJoin = not arg_36_0._gmOpenFightJoin
end

function var_0_0.isGMFightJoin(arg_37_0)
	return arg_37_0._gmOpenFightJoin
end

function var_0_0.checkEnterUseFreeLimit(arg_38_0)
	arg_38_0._useFreeLimit = false
	arg_38_0._checkFreeLimitChapterType = nil

	local var_38_0 = DungeonModel.instance.curSendEpisodeId
	local var_38_1 = DungeonConfig.instance:getEpisodeCO(var_38_0)
	local var_38_2 = var_38_1 and DungeonConfig.instance:getChapterCO(var_38_1.chapterId)

	if var_38_2 and var_38_2.enterAfterFreeLimit > 0 then
		if DungeonModel.instance:getChapterRemainingNum(var_38_2.type) > 0 then
			arg_38_0._useFreeLimit = true
		else
			arg_38_0._checkFreeLimitChapterType = var_38_2.type
		end
	end
end

function var_0_0.isEnterUseFreeLimit(arg_39_0)
	if arg_39_0._useFreeLimit then
		return true
	end

	return arg_39_0._checkFreeLimitChapterType and DungeonModel.instance:getChapterRemainingNum(arg_39_0._checkFreeLimitChapterType) > 0
end

function var_0_0.canParallelSkill(arg_40_0, arg_40_1)
	if var_0_0.forceParallelSkill then
		return true
	end

	if arg_40_1 and arg_40_1.custom_ingoreParallelSkill then
		return false
	end

	return FightDataHelper.stateMgr:getIsAuto() or FightDataHelper.stateMgr.isReplay or arg_40_0:isGMFightJoin()
end

function var_0_0.updateFight(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0._version = var_0_0.GMForceVersion or arg_41_1.version or 0

	if not arg_41_2 then
		arg_41_0._isRecord = arg_41_1.isRecord
	end

	arg_41_0._fightActType = arg_41_1.fightActType or FightEnum.FightActType.Normal

	if arg_41_0._fightActType == 0 then
		arg_41_0._fightActType = FightEnum.FightActType.Normal
	end

	if not arg_41_2 then
		FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Fight, arg_41_1)
	end

	if arg_41_0._version >= 3 then
		if not arg_41_2 then
			arg_41_0._curRoundId = arg_41_1.curRound
		end
	else
		arg_41_0._curRoundId = arg_41_1.curRound
	end

	arg_41_0._curWaveId = arg_41_1.curWave
	arg_41_0.maxRound = arg_41_1.maxRound

	if not arg_41_2 then
		arg_41_0._isFinish = arg_41_1.isFinish
	end

	arg_41_0.power = arg_41_1.attacker.power
	arg_41_0.clothId = arg_41_1.attacker.clothId
	arg_41_0._battleId = arg_41_1.battleId
	arg_41_0.exTeamStr = arg_41_1.attacker.exTeamStr

	if arg_41_1.attacker and #arg_41_1.attacker.skillInfos > 0 then
		arg_41_0:_updatePlayerSkillInfo(arg_41_1.attacker.skillInfos)
	end

	if arg_41_1.magicCircle then
		arg_41_0:getMagicCircleInfo():refreshData(arg_41_1.magicCircle)
	end
end

function var_0_0.updateFightRound(arg_42_0, arg_42_1)
	FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Round, arg_42_1)
	FightDataHelper.setRoundDataByProto(arg_42_1)

	local var_42_0 = FightDataHelper.roundMgr:getRoundData()

	FightLocalDataMgr.instance:beforePlayRoundData(var_42_0)
	xpcall(FightDataMgr.dealRoundData, __G__TRACKBACK__, FightLocalDataMgr.instance, var_42_0)
	FightLocalDataMgr.instance:afterPlayRoundData(var_42_0)
	var_42_0:processRoundData()
	FightDataMgr.instance:beforePlayRoundData(var_42_0)
	arg_42_0:updateSpAttributeMo(var_42_0.heroSpAttributes)

	arg_42_0._isFinish = var_42_0.isFinish
	arg_42_0.power = var_42_0.power

	if #var_42_0.skillInfos > 0 then
		arg_42_0:_updatePlayerSkillInfo(var_42_0.skillInfos)
	end

	if arg_42_0:getVersion() < 1 then
		FightPlayCardModel.instance:updateFightRound(var_42_0)
	end

	arg_42_0.autoPlayCardList = {}
end

function var_0_0.updateSpAttributeMo(arg_43_0, arg_43_1)
	if #arg_43_1 == 0 then
		return
	end

	arg_43_0.entitySpAttrMoDict = arg_43_0.entitySpAttrMoDict or {}

	for iter_43_0, iter_43_1 in ipairs(arg_43_1) do
		local var_43_0 = iter_43_1.uid
		local var_43_1 = arg_43_0.entitySpAttrMoDict[var_43_0]

		if not var_43_1 then
			var_43_1 = HeroSpAttributeMO.New()
			arg_43_0.entitySpAttrMoDict[var_43_0] = var_43_1
		end

		var_43_1:init(var_43_0, iter_43_1.attribute)
	end
end

function var_0_0.getSpAttributeMo(arg_44_0, arg_44_1)
	return arg_44_0.entitySpAttrMoDict and arg_44_0.entitySpAttrMoDict[arg_44_1]
end

function var_0_0.updateClothSkillRound(arg_45_0, arg_45_1)
	if arg_45_0:getVersion() < 5 then
		arg_45_1.actPoint = FightDataHelper.operationDataMgr.actPoint
	end

	FightController.instance:dispatchEvent(FightEvent.CacheFightProto, FightEnum.CacheProtoType.Round, arg_45_1)
	FightDataHelper.setRoundDataByProto(arg_45_1)

	local var_45_0 = FightDataHelper.roundMgr:getRoundData()

	FightLocalDataMgr.instance:beforePlayRoundData(var_45_0)
	xpcall(FightDataMgr.dealRoundData, __G__TRACKBACK__, FightLocalDataMgr.instance, var_45_0)
	FightLocalDataMgr.instance:afterPlayRoundData(var_45_0)
	var_45_0:processRoundData()
	FightDataMgr.instance:beforePlayRoundData(var_45_0)

	arg_45_0._isFinish = var_45_0.isFinish
	arg_45_0.power = var_45_0.power

	if #var_45_0.skillInfos > 0 then
		arg_45_0:_updatePlayerSkillInfo(var_45_0.skillInfos)
	end
end

function var_0_0.onAutoRound(arg_46_0, arg_46_1)
	arg_46_0.autoPlayCardList = {}

	for iter_46_0, iter_46_1 in ipairs(arg_46_1) do
		local var_46_0 = FightOperationItemData.New()

		var_46_0:setByProto(iter_46_1)
		table.insert(arg_46_0.autoPlayCardList, var_46_0)
	end
end

function var_0_0._updatePlayerSkillInfo(arg_47_0, arg_47_1)
	arg_47_0._clothSkillList = {}
	arg_47_0._clothSkillDict = {}

	for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
		local var_47_0 = {
			skillId = iter_47_1.skillId,
			cd = iter_47_1.cd,
			needPower = iter_47_1.needPower,
			type = iter_47_1.type
		}

		table.insert(arg_47_0._clothSkillList, var_47_0)

		arg_47_0._clothSkillDict[iter_47_1.skillId] = var_47_0
	end
end

function var_0_0.onEndRound(arg_48_0)
	if var_0_0.instance:getVersion() >= 3 then
		-- block empty
	else
		arg_48_0._curRoundId = arg_48_0._curRoundId + arg_48_0._roundInc
	end

	arg_48_0._roundInc = 1
	arg_48_0.hasNextWave = false

	arg_48_0:clearStressBehaviour()
end

function var_0_0.updateRecord(arg_49_0, arg_49_1)
	arg_49_0._recordMO = arg_49_0._recordMO or FightRecordMO.New()

	arg_49_0._recordMO:init(arg_49_1)

	arg_49_0._lastFightResult = arg_49_0._recordMO.fightResult
end

function var_0_0.getLastFightResult(arg_50_0)
	return arg_50_0._lastFightResult
end

function var_0_0.onEndFight(arg_51_0)
	arg_51_0._isFinish = true
	arg_51_0._clothSkillList = nil
	arg_51_0._clothSkillDict = nil
	arg_51_0.hasNextWave = false
end

function var_0_0.updateFightReason(arg_52_0, arg_52_1)
	arg_52_0._fightReason = arg_52_0._fightReason or FightReasonMO.New()

	arg_52_0._fightReason:init(arg_52_1)
end

function var_0_0.setNextWaveMsg(arg_53_0, arg_53_1)
	arg_53_0._roundInc = 0
	arg_53_0.hasNextWave = true
end

function var_0_0.getClothSkillList(arg_54_0)
	return arg_54_0._clothSkillList
end

function var_0_0.setClickEnemyState(arg_55_0, arg_55_1)
	arg_55_0._isClickEnemy = arg_55_1
end

function var_0_0.getClickEnemyState(arg_56_0)
	return arg_56_0._isClickEnemy
end

function var_0_0.recordPassModel(arg_57_0, arg_57_1)
	arg_57_0.curFightModel = arg_57_1.isRecord

	local var_57_0 = PlayerPrefsHelper.getString(var_0_0.getPrefsKeyFightPassModel(), "")

	if string.nilorempty(var_57_0) then
		var_57_0 = {}
	else
		var_57_0 = cjson.decode(var_57_0)
	end

	if arg_57_0._fightParam then
		var_57_0[tostring(arg_57_0._fightParam.episodeId)] = arg_57_1.isRecord
	end

	PlayerPrefsHelper.setString(var_0_0.getPrefsKeyFightPassModel(), cjson.encode(var_57_0))
end

function var_0_0.getPrefsKeyFightPassModel()
	return PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.FightPassModel
end

function var_0_0.setWaitIndicatorAnimation(arg_59_0, arg_59_1)
	arg_59_0.waitIndicatorAnimation = arg_59_1
end

function var_0_0.isWaitIndicatorAnimation(arg_60_0)
	return arg_60_0.waitIndicatorAnimation
end

function var_0_0.refreshBattleId(arg_61_0, arg_61_1)
	arg_61_0._battleId = arg_61_1.battleId

	if arg_61_0._fightParam then
		arg_61_0._fightParam:setBattleId(arg_61_0._battleId)
	end
end

function var_0_0.getMagicCircleInfo(arg_62_0)
	arg_62_0._magicCircleInfo = arg_62_0._magicCircleInfo or FightMagicCircleInfo.New()

	return arg_62_0._magicCircleInfo
end

function var_0_0.getVersion(arg_63_0)
	return arg_63_0._version or 0
end

function var_0_0.getFightActType(arg_64_0)
	return arg_64_0._fightActType
end

function var_0_0.isRecord(arg_65_0)
	return arg_65_0._isRecord
end

function var_0_0.setRougeExData(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = var_0_0.instance.exTeamStr
	local var_66_1 = string.split(var_66_0, "#")

	var_66_1[1] = var_66_1[1] or 0
	var_66_1[2] = var_66_1[2] or 0
	var_66_1[3] = var_66_1[3] or 0
	var_66_1[4] = var_66_1[4] or cjson.encode({})
	var_66_1[arg_66_1] = arg_66_2
	var_0_0.instance.exTeamStr = string.format("%s#%s#%s#%s", var_66_1[1], var_66_1[2], var_66_1[3], var_66_1[4])
end

function var_0_0.getRougeExData(arg_67_0, arg_67_1)
	local var_67_0 = string.split(var_0_0.instance.exTeamStr, "#")

	if arg_67_1 == FightEnum.ExIndexForRouge.SupportHeroSkill then
		return var_67_0[arg_67_1] or cjson.encode({})
	end

	return tonumber(var_67_0[arg_67_1]) or 0
end

function var_0_0.isAbort(arg_68_0)
	return arg_68_0._recordMO and arg_68_0._recordMO.fightResult == FightEnum.FightResult.Abort
end

function var_0_0.isFail(arg_69_0)
	return arg_69_0._recordMO and arg_69_0._recordMO.fightResult == FightEnum.FightResult.Fail
end

function var_0_0.setCurSceneOriginPos(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	arg_70_0.originX, arg_70_0.originY, arg_70_0.originZ = arg_70_1, arg_70_2, arg_70_3
end

function var_0_0.getCurSceneOriginPos(arg_71_0)
	return arg_71_0.originX, arg_71_0.originY, arg_71_0.originZ
end

function var_0_0.isSeason2(arg_72_0)
	return arg_72_0:getFightActType() == FightEnum.FightActType.Season2
end

function var_0_0.recordDelayHandleStressBehaviour(arg_73_0, arg_73_1)
	if not arg_73_1 then
		return
	end

	arg_73_0.stressBehaviourDict = arg_73_0.stressBehaviourDict or {}

	local var_73_0 = arg_73_0.stressBehaviourDict[arg_73_1.targetId]

	if not var_73_0 then
		var_73_0 = {}
		arg_73_0.stressBehaviourDict[arg_73_1.targetId] = var_73_0
	end

	table.insert(var_73_0, arg_73_1)
end

function var_0_0.popNoHandledStressBehaviour(arg_74_0, arg_74_1)
	local var_74_0 = arg_74_1 and arg_74_0.stressBehaviourDict and arg_74_0.stressBehaviourDict[arg_74_1]

	return var_74_0 and table.remove(var_74_0, 1)
end

function var_0_0.clearStressBehaviour(arg_75_0)
	if arg_75_0.stressBehaviourDict then
		for iter_75_0, iter_75_1 in pairs(arg_75_0.stressBehaviourDict) do
			tabletool.clear(iter_75_1)
		end
	end
end

function var_0_0.setNotifyContractInfo(arg_76_0, arg_76_1, arg_76_2)
	arg_76_0.notifyEntityId = arg_76_1
	arg_76_0.canContractList = arg_76_2
end

function var_0_0.setContractEntityUid(arg_77_0, arg_77_1)
	arg_77_0.contractEntityUid = arg_77_1
end

function var_0_0.setBeContractEntityUid(arg_78_0, arg_78_1)
	arg_78_0.beContractEntityUid = arg_78_1
end

function var_0_0.isBeContractEntity(arg_79_0, arg_79_1)
	return arg_79_1 == arg_79_0.beContractEntityUid
end

function var_0_0.setSkillIcon(arg_80_0, arg_80_1, arg_80_2)
	arg_80_0.smallSkillIcon = arg_80_1
	arg_80_0.bigSkillIcon = arg_80_2
end

function var_0_0.setIsHideCard(arg_81_0, arg_81_1)
	arg_81_0.isHideCard = arg_81_1
end

function var_0_0.getHandCardSkillIcon(arg_82_0, arg_82_1, arg_82_2)
	if not arg_82_2 then
		return
	end

	if FightCardDataHelper.getSkillLv(arg_82_0.entityId, arg_82_2.id) == FightEnum.UniqueSkillCardLv then
		return string.nilorempty(arg_82_0.bigSkillIcon) and ResUrl.getSkillIcon(arg_82_2.icon) or ResUrl.getSkillIcon(arg_82_0.bigSkillIcon)
	end

	return string.nilorempty(arg_82_0.smallSkillIcon) and ResUrl.getSkillIcon(arg_82_2.icon) or ResUrl.getSkillIcon(arg_82_0.smallSkillIcon)
end

function var_0_0.setRemoveActEffectObj(arg_83_0, arg_83_1)
	arg_83_0.removeActEffectObj = arg_83_1
end

function var_0_0.getRemoveActEffectObj(arg_84_0)
	return arg_84_0.removeActEffectObj
end

function var_0_0.setNeedPlay500MRemoveActEffect(arg_85_0, arg_85_1)
	arg_85_0.needPlay500MRemoveActEffect = arg_85_1
end

function var_0_0.getNeedPlay500MRemoveActEffect(arg_86_0)
	return arg_86_0.needPlay500MRemoveActEffect
end

function var_0_0.setMultiHpType(arg_87_0, arg_87_1)
	arg_87_0.multiHpType = arg_87_1
end

function var_0_0.getMultiHpType(arg_88_0)
	return arg_88_0.multiHpType or FightEnum.MultiHpType.Default
end

var_0_0.instance = var_0_0.New()

return var_0_0
