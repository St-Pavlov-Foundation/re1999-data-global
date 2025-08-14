module("modules.logic.bossrush.model.BossRushRedModel", package.seeall)

local var_0_0 = class("BossRushRedModel", BaseModel)
local var_0_1 = tostring
local var_0_2 = next
local var_0_3 = table.insert
local var_0_4 = RedDotEnum.DotNode
local var_0_5 = "BossRushRed|"
local var_0_6 = 0
local var_0_7 = -11235
local var_0_8 = 0

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_stopTick()
	FrameTimerController.onDestroyViewMember(arg_2_0, "_flushCacheFrameTimer")

	arg_2_0._unlockBossIdList = {}
	arg_2_0._delayNeedUpdateDictList = {}
	arg_2_0._delayUpdateRedValueList = {}
	arg_2_0._flushDataFrameTimer = nil
end

function var_0_0._getConfig(arg_3_0)
	return BossRushModel.instance:getConfig()
end

function var_0_0._getActivityId(arg_4_0)
	return BossRushConfig.instance:getActivityId()
end

function var_0_0._getRedDotGroup(arg_5_0, arg_5_1)
	return RedDotModel.instance:getRedDotInfo(arg_5_1)
end

function var_0_0._getRedDotGroupItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:_getRedDotGroup(arg_6_1)

	if not var_6_0 then
		logWarn("[BossRushRedModel] _getRedDotGroupItem: defineId=" .. var_0_1(arg_6_1) .. " uid=" .. var_0_1(arg_6_2))

		return
	end

	return var_6_0.infos[arg_6_2]
end

function var_0_0._getDisplayValue(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_2 or not arg_7_1 then
		return var_0_8
	end

	if not arg_7_0:_getRedDotGroup(arg_7_1) then
		return var_0_8
	end

	local var_7_0 = arg_7_0:_getRedDotGroupItem(arg_7_1, arg_7_2)

	if not var_7_0 then
		return var_0_8
	end

	return var_7_0.value, true
end

function var_0_0._getDisplayValueByDSL(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_0:getUId(arg_8_1, arg_8_2, arg_8_3)

	return arg_8_0:_getDisplayValue(arg_8_1, var_8_0)
end

function var_0_0._createByDU(arg_9_0, arg_9_1, arg_9_2)
	return {
		id = arg_9_1,
		uid = arg_9_2,
		value = arg_9_0:_getSavedValue(arg_9_1, arg_9_2)
	}
end

function var_0_0._createByDSL(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0 = arg_10_0:getUId(arg_10_1, arg_10_2, arg_10_3)

	return arg_10_0:_createByDU(arg_10_1, var_10_0)
end

function var_0_0._getDUByDSL(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:getUId(arg_11_1, arg_11_2, arg_11_3)

	return arg_11_1, var_11_0
end

function var_0_0._getSavedValue(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getDefaultValue(arg_12_1)
	local var_12_1 = arg_12_0:_get(arg_12_1, arg_12_2, var_12_0)
	local var_12_2 = arg_12_0:_isSValueValid(var_12_1)

	return var_12_1, var_12_2
end

function var_0_0._getSavedValueByDSL(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0:getUId(arg_13_1, arg_13_2, arg_13_3)

	return arg_13_0:_getSavedValue(arg_13_1, var_13_0)
end

function var_0_0._getDUSValueByDSL(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0:getUId(arg_14_1, arg_14_2, arg_14_3)
	local var_14_1, var_14_2 = arg_14_0:_getSavedValue(arg_14_1, var_14_0)

	return arg_14_1, var_14_0, var_14_1, var_14_2
end

function var_0_0._getValue(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0:_getSavedValue(arg_15_1, arg_15_2)
	local var_15_1 = arg_15_0:_isSValueValid(var_15_0)
	local var_15_2, var_15_3 = arg_15_0:_getDisplayValue(arg_15_1, arg_15_2)

	return var_15_1, var_15_0, var_15_2, var_15_3
end

function var_0_0._getValueByDSL(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0:getUId(arg_16_1, arg_16_2, arg_16_3)

	return arg_16_0:_getValue(arg_16_1, var_16_0)
end

function var_0_0._startFlushData(arg_17_0)
	local var_17_0 = math.max(tabletool.len(arg_17_0._delayUpdateRedValueList), tabletool.len(arg_17_0._delayNeedUpdateDictList))

	if var_17_0 == 0 then
		return
	end

	FrameTimerController.onDestroyViewMember(arg_17_0, "_flushDataFrameTimer")

	arg_17_0._flushDataFrameTimer = FrameTimerController.instance:register(arg_17_0._tryFlushDatas, arg_17_0, 3, var_17_0)

	arg_17_0._flushDataFrameTimer:Start()
end

function var_0_0._onTick(arg_18_0)
	local var_18_0 = arg_18_0._unlockBossIdList

	if not var_0_2(var_18_0) then
		arg_18_0:_stopTick()

		return
	end

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		if BossRushModel.instance:isBossOnline(iter_18_1) and BossRushModel.instance:isBossOpen(iter_18_1) then
			var_18_0[iter_18_0] = nil

			arg_18_0:setIsNewUnlockStage(iter_18_1, true)
			arg_18_0:setIsNewUnlockStageLayer(iter_18_1, 1, true)
		end
	end
end

function var_0_0._initRootRed(arg_19_0, arg_19_1)
	var_0_3(arg_19_1, arg_19_0:_createByDSL(var_0_4.BossRushEnter))
	var_0_3(arg_19_1, arg_19_0:_createByDSL(var_0_4.BossRushOpen))
end

function var_0_0._initBossRed(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0:_getConfig()
	local var_20_1 = var_20_0:getStages()

	for iter_20_0, iter_20_1 in pairs(var_20_1) do
		local var_20_2 = iter_20_1.stage
		local var_20_3 = var_20_0:getEpisodeStages(var_20_2)

		var_0_3(arg_20_1, arg_20_0:_createByDSL(var_0_4.BossRushBoss, var_20_2))
		var_0_3(arg_20_1, arg_20_0:_createByDSL(var_0_4.BossRushNewBoss, var_20_2))
		var_0_3(arg_20_1, arg_20_0:_createByDSL(var_0_4.BossRushBossReward, var_20_2))

		for iter_20_2, iter_20_3 in pairs(var_20_3) do
			local var_20_4 = iter_20_3.layer

			var_0_3(arg_20_1, arg_20_0:_createByDSL(var_0_4.BossRushNewLayer, var_20_2, var_20_4))
		end
	end
end

function var_0_0._isSValueValid(arg_21_0, arg_21_1)
	assert(type(arg_21_1) == "number")

	return arg_21_1 ~= var_0_7
end

function var_0_0._modifyOrMakeRedDotGroupItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	assert(type(arg_22_3) == "number")

	local var_22_0, var_22_1 = arg_22_0:_getDisplayValue(arg_22_1, arg_22_2)

	if var_22_0 == arg_22_3 then
		return
	end

	local var_22_2 = arg_22_0:_getRedDotGroupItem(arg_22_1, arg_22_2)

	if not var_22_2 then
		var_22_1 = false
	end

	if var_22_1 then
		var_22_2:reset({
			ext = var_22_2.ext,
			time = var_22_2.time,
			value = arg_22_3
		})
	else
		RedDotRpc.instance:clientAddRedDotGroupList({
			{
				id = arg_22_1,
				uid = arg_22_2,
				value = arg_22_3
			}
		})
	end

	if arg_22_4 then
		arg_22_0:_trySave(arg_22_1, arg_22_2, var_0_7)
	else
		arg_22_0:_trySave(arg_22_1, arg_22_2, arg_22_3)
	end

	return true
end

function var_0_0._calcAssociateRedDots(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = RedDotModel.instance:_getAssociateRedDots(arg_23_2)

	for iter_23_0, iter_23_1 in pairs(var_23_0 or {}) do
		arg_23_1[iter_23_1] = true
	end
end

function var_0_0._tryShowRedDotGroupItem(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	local var_24_0 = arg_24_3 and 1 or 0

	if arg_24_0:_modifyOrMakeRedDotGroupItem(arg_24_1, arg_24_2, var_24_0, arg_24_4) then
		local var_24_1 = {
			[var_0_7] = true
		}

		arg_24_0:_calcAssociateRedDots(var_24_1, arg_24_1)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, var_24_1)
	end
end

function var_0_0._refreshReward(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = arg_25_0:_getDUByDSL(var_0_4.BossRushBossReward, arg_25_2)
	local var_25_2, var_25_3 = arg_25_0:_getDisplayValueByDSL(var_0_4.BossRushBossSchedule, arg_25_2)
	local var_25_4, var_25_5 = arg_25_0:_getDisplayValueByDSL(var_0_4.BossRushBossAchievement, arg_25_2)
	local var_25_6 = 0

	if var_25_3 then
		var_25_6 = var_25_6 + var_25_2
	end

	if var_25_5 then
		var_25_6 = var_25_6 + var_25_4
	end

	if arg_25_0:_modifyOrMakeRedDotGroupItem(var_25_0, var_25_1, var_25_6) then
		arg_25_1[var_25_0] = true
	end
end

function var_0_0._refreshNewBoss(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0, var_26_1, var_26_2, var_26_3 = arg_26_0:_getDUSValueByDSL(var_0_4.BossRushNewBoss, arg_26_2)

	var_26_2 = var_26_3 and var_26_2 or 0

	if arg_26_0:_modifyOrMakeRedDotGroupItem(var_26_0, var_26_1, var_26_2) then
		arg_26_1[var_26_0] = true
	end
end

function var_0_0._refreshNewLayer(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0, var_27_1, var_27_2, var_27_3 = arg_27_0:_getDUSValueByDSL(var_0_4.BossRushNewLayer, arg_27_2, arg_27_3)

	var_27_2 = var_27_3 and var_27_2 or 0

	if arg_27_0:_modifyOrMakeRedDotGroupItem(var_27_0, var_27_1, var_27_2) then
		arg_27_1[var_27_0] = true
	end
end

function var_0_0.refreshAllStageLayerUnlockState(arg_28_0)
	local var_28_0 = arg_28_0:_getConfig():getStages()

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		local var_28_1 = BossRushModel.instance:getStageLayersInfo(iter_28_0)

		for iter_28_2, iter_28_3 in pairs(var_28_1) do
			local var_28_2 = iter_28_3.isOpen
			local var_28_3 = iter_28_3.layer
			local var_28_4, var_28_5, var_28_6, var_28_7 = arg_28_0:_getDUSValueByDSL(var_0_4.BossRushNewLayer, iter_28_0, var_28_3)

			if not var_28_7 then
				if var_28_2 then
					arg_28_0:setIsNewUnlockStageLayer(iter_28_0, var_28_3, true)
				end
			elseif not var_28_2 and var_28_6 >= 1 then
				arg_28_0:setIsNewUnlockStageLayer(iter_28_0, var_28_3, false, true)
			end
		end
	end
end

function var_0_0._refreshOpen(arg_29_0, arg_29_1)
	local var_29_0, var_29_1, var_29_2, var_29_3 = arg_29_0:_getDUSValueByDSL(var_0_4.BossRushOpen)

	var_29_2 = var_29_3 and var_29_2 or 0

	if arg_29_0:_modifyOrMakeRedDotGroupItem(var_29_0, var_29_1, var_29_2) then
		arg_29_1[var_29_0] = true
	end
end

function var_0_0._refreshBoss(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0, var_30_1 = arg_30_0:_getDUByDSL(var_0_4.BossRushBoss, arg_30_2)
	local var_30_2 = arg_30_0:_getConfig():getEpisodeStages(arg_30_2)
	local var_30_3, var_30_4 = arg_30_0:_getSavedValueByDSL(var_0_4.BossRushNewBoss, arg_30_2)
	local var_30_5, var_30_6 = arg_30_0:_getDisplayValueByDSL(var_0_4.BossRushBossReward, arg_30_2)
	local var_30_7 = 0

	for iter_30_0, iter_30_1 in pairs(var_30_2) do
		local var_30_8 = iter_30_1.layer
		local var_30_9, var_30_10 = arg_30_0:_getSavedValueByDSL(var_0_4.BossRushNewLayer, arg_30_2, var_30_8)

		if var_30_10 then
			var_30_7 = var_30_7 + var_30_9
		end
	end

	local var_30_11 = var_30_7

	if var_30_4 then
		var_30_11 = var_30_11 + var_30_3
	end

	if var_30_6 then
		var_30_11 = var_30_11 + var_30_5
	end

	if arg_30_0:_modifyOrMakeRedDotGroupItem(var_30_0, var_30_1, var_30_11) then
		arg_30_1[var_30_0] = true
	end
end

function var_0_0._refreshRootInner(arg_31_0, arg_31_1)
	local var_31_0, var_31_1 = arg_31_0:_getDUByDSL(var_0_4.BossRushEnter)
	local var_31_2 = arg_31_0:_getConfig():getStages()
	local var_31_3, var_31_4 = arg_31_0:_getSavedValueByDSL(var_0_4.BossRushOpen)
	local var_31_5 = 0

	for iter_31_0, iter_31_1 in pairs(var_31_2) do
		local var_31_6 = iter_31_1.stage
		local var_31_7, var_31_8 = arg_31_0:_getDisplayValueByDSL(var_0_4.BossRushBoss, var_31_6)

		if var_31_8 then
			var_31_5 = var_31_5 + var_31_7
		end
	end

	local var_31_9 = var_31_5

	if var_31_4 then
		var_31_9 = var_31_9 + var_31_3
	end

	if arg_31_0:_modifyOrMakeRedDotGroupItem(var_31_0, var_31_1, var_31_9) then
		arg_31_1[var_31_0] = true
	end
end

function var_0_0._refreshRoot(arg_32_0)
	local var_32_0 = arg_32_0:_getConfig()
	local var_32_1 = var_32_0:getStages()
	local var_32_2 = {}

	for iter_32_0, iter_32_1 in pairs(var_32_1) do
		local var_32_3 = iter_32_1.stage

		arg_32_0:_refreshNewBoss(var_32_2, var_32_3)

		local var_32_4 = var_32_0:getEpisodeStages(var_32_3)

		for iter_32_2, iter_32_3 in pairs(var_32_4) do
			local var_32_5 = iter_32_3.layer

			arg_32_0:_refreshNewLayer(var_32_2, var_32_3, var_32_5)
		end

		arg_32_0:_refreshReward(var_32_2, var_32_3)
		arg_32_0:_refreshBoss(var_32_2, var_32_3)
	end

	arg_32_0:_refreshOpen(var_32_2)
	arg_32_0:_refreshRootInner(var_32_2)

	return var_32_2
end

function var_0_0._getPrefsKey(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0:_getActivityId()

	if not arg_33_2 then
		return var_0_5 .. var_0_1(var_33_0) .. var_0_1(arg_33_1)
	end

	return var_0_5 .. var_0_1(var_33_0) .. var_0_1(arg_33_1) .. "|" .. var_0_1(arg_33_2)
end

function var_0_0._save(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_0:_getPrefsKey(arg_34_1, arg_34_2)

	GameUtil.playerPrefsSetNumberByUserId(var_34_0, arg_34_3)
end

function var_0_0._get(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	arg_35_3 = arg_35_3 or arg_35_0:getDefaultValue(arg_35_1)

	local var_35_0 = arg_35_0:_getPrefsKey(arg_35_1, arg_35_2)

	return GameUtil.playerPrefsGetNumberByUserId(var_35_0, arg_35_3)
end

function var_0_0._appendRefreshRedDict(arg_36_0, arg_36_1)
	if type(arg_36_1) ~= "table" then
		return
	end

	table.insert(arg_36_0._delayNeedUpdateDictList, arg_36_1)
end

function var_0_0._waitWarmUpOrJustRun(arg_37_0, arg_37_1, ...)
	if arg_37_0:_isWarmUp() then
		local var_37_0 = {
			...
		}

		table.insert(arg_37_0._delayUpdateRedValueList, {
			callback = arg_37_1,
			args = var_37_0
		})

		return
	end

	arg_37_1(...)
end

function var_0_0._tryRunRedDicts(arg_38_0)
	local var_38_0 = arg_38_0._delayNeedUpdateDictList

	if #var_38_0 == 0 then
		return true
	end

	local var_38_1 = table.remove(var_38_0)

	arg_38_0:updateRelateDotInfo(var_38_1)

	return false
end

function var_0_0._tryRunValueSetterCallbacks(arg_39_0)
	local var_39_0 = arg_39_0._delayUpdateRedValueList

	if #var_39_0 == 0 then
		return true
	end

	local var_39_1 = table.remove(var_39_0)
	local var_39_2 = var_39_1.callback
	local var_39_3 = var_39_1.args

	var_39_2(unpack(var_39_3))

	return false
end

function var_0_0._tryFlushDatas(arg_40_0)
	local var_40_0 = arg_40_0:_tryRunRedDicts()
	local var_40_1 = arg_40_0:_tryRunValueSetterCallbacks()

	return var_40_0 or var_40_1
end

function var_0_0._isWarmUp(arg_41_0)
	return arg_41_0:_getRedDotGroup(var_0_4.BossRushEnter) == nil
end

function var_0_0.isInitReady(arg_42_0)
	return BossRushModel.instance:isActOnLine()
end

function var_0_0._stopTick(arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._onTick, arg_43_0)
end

function var_0_0._startTick(arg_44_0)
	arg_44_0:_stopTick()

	local var_44_0 = arg_44_0:_getConfig():getStages()
	local var_44_1 = {}

	for iter_44_0, iter_44_1 in pairs(var_44_0) do
		local var_44_2 = iter_44_1.stage

		if not BossRushModel.instance:isBossOnline(var_44_2) and BossRushModel.instance:isBossOpen(var_44_2) then
			var_44_1[#var_44_1 + 1] = var_44_2
		end
	end

	arg_44_0._unlockBossIdList = var_44_1

	if #var_44_1 > 0 then
		TaskDispatcher.runRepeat(arg_44_0._onTick, arg_44_0, 1)
	end
end

function var_0_0._tryUpdateMissingRed(arg_45_0)
	local var_45_0 = arg_45_0:_getConfig()
	local var_45_1 = var_45_0:getStages()
	local var_45_2 = BossRushModel.instance:getActivityId()
	local var_45_3 = ActivityModel.instance:isActOnLine(var_45_2)
	local var_45_4, var_45_5, var_45_6, var_45_7 = arg_45_0:_getDUSValueByDSL(var_0_4.BossRushOpen)

	if not var_45_7 then
		if var_45_3 then
			arg_45_0:setIsOpenActivity(true)
		end
	elseif not var_45_3 and var_45_6 == 1 then
		arg_45_0:setIsOpenActivity(false, true)
	end

	for iter_45_0, iter_45_1 in pairs(var_45_1) do
		local var_45_8 = iter_45_1.stage
		local var_45_9 = BossRushModel.instance:isBossOnline(var_45_8) and BossRushModel.instance:isBossOpen(var_45_8)
		local var_45_10, var_45_11, var_45_12, var_45_13 = arg_45_0:_getDUSValueByDSL(var_0_4.BossRushNewBoss, var_45_8)

		if not var_45_13 then
			if var_45_9 then
				arg_45_0:setIsNewUnlockStage(var_45_8, true)
			end
		elseif not var_45_9 and var_45_12 >= 1 then
			arg_45_0:setIsNewUnlockStage(var_45_8, false, true)
		end

		local var_45_14 = var_45_0:getEpisodeStages(var_45_8)

		for iter_45_2, iter_45_3 in pairs(var_45_14) do
			local var_45_15 = iter_45_3.layer
			local var_45_16 = var_45_9 and BossRushModel.instance:isBossLayerOpen(var_45_8, var_45_15) or false
			local var_45_17, var_45_18, var_45_19, var_45_20 = arg_45_0:_getDUSValueByDSL(var_0_4.BossRushNewLayer, var_45_8, var_45_15)

			if not var_45_20 then
				if var_45_16 then
					arg_45_0:setIsNewUnlockStageLayer(var_45_8, var_45_15, true)
				end
			elseif not var_45_16 and var_45_19 >= 1 then
				arg_45_0:setIsNewUnlockStageLayer(var_45_8, var_45_15, false, true)
			end
		end
	end
end

function var_0_0._flushCache(arg_46_0)
	arg_46_0:_startFlushData()
	arg_46_0:_tryUpdateMissingRed()
	arg_46_0:_startTick()
end

function var_0_0.refreshClientCharacterDot(arg_47_0)
	if not arg_47_0:isInitReady() then
		return
	end

	if not arg_47_0:_isWarmUp() then
		return
	end

	local var_47_0 = {}

	arg_47_0:_initRootRed(var_47_0)
	arg_47_0:_initBossRed(var_47_0)

	local var_47_1 = {}

	for iter_47_0, iter_47_1 in ipairs(var_47_0) do
		if arg_47_0:_isSValueValid(iter_47_1.value) then
			var_0_3(var_47_1, iter_47_1)
		end
	end

	RedDotRpc.instance:clientAddRedDotGroupList(var_47_1)
end

function var_0_0.updateRelateDotInfo(arg_48_0, arg_48_1)
	if arg_48_0:_isWarmUp() then
		arg_48_0:_appendRefreshRedDict(arg_48_1)

		return
	end

	if not arg_48_1 then
		return
	end

	if not arg_48_1[var_0_4.BossRushEnter] then
		return
	end

	local var_48_0 = arg_48_0:_refreshRoot()

	if not arg_48_0._flushCacheFrameTimer then
		arg_48_0._flushCacheFrameTimer = FrameTimerController.instance:register(arg_48_0._flushCache, arg_48_0)

		arg_48_0._flushCacheFrameTimer:Start()
	end

	if not var_0_2(var_48_0) then
		return
	end

	if arg_48_1[var_0_7] then
		return
	end

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, var_48_0)
end

function var_0_0.getUId(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	if var_0_4.BossRushNewLayer == arg_49_1 then
		return arg_49_2 * 1000 + arg_49_3
	end

	return arg_49_2 or var_0_6
end

function var_0_0.getDefaultValue(arg_50_0, arg_50_1)
	if arg_50_1 == var_0_4.BossRushOpen or arg_50_1 == var_0_4.BossRushNewBoss or arg_50_1 == var_0_4.BossRushNewLayer then
		return var_0_7
	end

	return 0
end

function var_0_0._trySave(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	if arg_51_1 == var_0_4.BossRushBossReward or arg_51_1 == var_0_4.BossRushBossSchedule or arg_51_1 == var_0_4.BossRushBossAchievement then
		return
	end

	local var_51_0, var_51_1 = arg_51_0:_getValue(arg_51_1, arg_51_2)
	local var_51_2 = var_51_1

	if var_51_0 then
		var_51_2 = arg_51_3
	elseif arg_51_3 > 0 then
		var_51_2 = arg_51_3
	end

	if var_51_1 ~= var_51_2 then
		arg_51_0:_save(arg_51_1, arg_51_2, var_51_2)
	end
end

function var_0_0.setIsOpenActivity(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0, var_52_1 = arg_52_0:_getDUByDSL(var_0_4.BossRushOpen)

	arg_52_0:_waitWarmUpOrJustRun(arg_52_0._tryShowRedDotGroupItem, arg_52_0, var_52_0, var_52_1, arg_52_1, arg_52_2)
end

function var_0_0.setIsNewUnlockStage(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	local var_53_0, var_53_1 = arg_53_0:_getDUByDSL(var_0_4.BossRushNewBoss, arg_53_1)

	arg_53_0:_waitWarmUpOrJustRun(arg_53_0._tryShowRedDotGroupItem, arg_53_0, var_53_0, var_53_1, arg_53_2, arg_53_3)
end

function var_0_0.setIsNewUnlockStageLayer(arg_54_0, arg_54_1, arg_54_2, arg_54_3, arg_54_4)
	local var_54_0, var_54_1 = arg_54_0:_getDUByDSL(var_0_4.BossRushNewLayer, arg_54_1, arg_54_2)

	arg_54_0:_waitWarmUpOrJustRun(arg_54_0._tryShowRedDotGroupItem, arg_54_0, var_54_0, var_54_1, arg_54_3, arg_54_4)
end

function var_0_0.getIsNewUnlockStage(arg_55_0, arg_55_1)
	return arg_55_0:checkIsShow(var_0_4.BossRushNewBoss, arg_55_1)
end

function var_0_0.getIsNewUnlockStageLayer(arg_56_0, arg_56_1, arg_56_2)
	return arg_56_0:checkIsShow(var_0_4.BossRushNewLayer, arg_56_1, arg_56_2)
end

function var_0_0.getIsPlayUnlockAnimStage(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0:_getActivityId()
	local var_57_1 = string.format(BossRushEnum.PlayUnlockAnimStage, var_57_0, arg_57_1)

	return GameUtil.playerPrefsGetNumberByUserId(var_57_1, 0) == 0
end

function var_0_0.setIsPlayUnlockAnimStage(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0:_getActivityId()
	local var_58_1 = string.format(BossRushEnum.PlayUnlockAnimStage, var_58_0, arg_58_1)

	GameUtil.playerPrefsSetNumberByUserId(var_58_1, arg_58_2 and 0 or 1)
end

function var_0_0.checkIsShow(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	local var_59_0, var_59_1, var_59_2 = arg_59_0:_getValueByDSL(arg_59_1, arg_59_2, arg_59_3)

	return var_59_0 and var_59_1 >= 1 or var_59_2 >= 1
end

local var_0_9
local var_0_10
local var_0_11

function var_0_0._printerWarmUp(arg_60_0)
	if not var_0_9 then
		var_0_9 = {}

		for iter_60_0, iter_60_1 in pairs(RedDotEnum.DotNode) do
			var_0_9[iter_60_1] = iter_60_0
		end
	end

	if not var_0_10 then
		var_0_10 = getGlobal("ddd") or SLFramework.SLLogger.Log
	end

	if not var_0_11 then
		local var_60_0 = PlayerModel.instance:getMyUserId()

		if var_60_0 and var_60_0 ~= 0 then
			var_0_11 = var_60_0
		end
	end
end

function var_0_0._print(arg_61_0, arg_61_1)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if not arg_61_1 then
		return
	end

	arg_61_0:_printerWarmUp()
	assert(var_0_9[arg_61_1], "defineId = " .. arg_61_1)

	function RedDotGroupMo.tostring(arg_62_0)
		local var_62_0 = arg_62_0.id
		local var_62_1 = arg_62_0.infos
		local var_62_2 = var_0_9[var_62_0]
		local var_62_3 = string.format("%s(%s):", var_62_2, var_0_1(var_62_0))
		local var_62_4 = true

		for iter_62_0, iter_62_1 in pairs(var_62_1) do
			if iter_62_0 ~= 0 then
				local var_62_5 = iter_62_1.value

				var_62_3 = string.format("%s\n\tuid: %s (%s)", var_62_3, var_0_1(iter_62_0), var_0_1(var_62_5))
				var_62_4 = false
			end
		end

		if var_62_4 then
			var_62_3 = var_62_3 .. " empty"
		end

		return var_62_3
	end

	local var_61_0 = RedDotModel.instance:getRedDotInfo(arg_61_1)

	if not var_61_0 then
		var_0_10(var_0_9[arg_61_1] .. ": null")

		return
	end

	var_0_10(var_61_0:tostring())
end

function var_0_0.logDalayInfo(arg_63_0)
	arg_63_0:_printerWarmUp()
	var_0_10("#_delayNeedUpdateDictList=" .. var_0_1(#arg_63_0._delayNeedUpdateDictList))
	var_0_10("#_delayUpdateRedValueList=" .. var_0_1(#arg_63_0._delayUpdateRedValueList))
end

function var_0_0._delete(arg_64_0, arg_64_1, arg_64_2)
	local var_64_0 = arg_64_0:_getPrefsKey(arg_64_1, arg_64_2)
	local var_64_1 = PlayerModel.instance:getMyUserId()

	if not var_64_1 or var_64_1 == 0 then
		var_64_1 = var_0_11
	end

	if not var_64_1 then
		return
	end

	arg_64_0:_printerWarmUp()

	local var_64_2 = var_64_0 .. "#" .. var_0_1(var_64_1)

	if PlayerPrefsHelper.hasKey(var_64_2) then
		PlayerPrefsHelper.deleteKey(var_64_2)

		return var_64_0
	end

	var_0_10("_delete no existed prefsKey!!", var_64_2)
end

function var_0_0._deleteByDSL(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	local var_65_0, var_65_1 = arg_65_0:_getDUByDSL(arg_65_1, arg_65_2, arg_65_3)
	local var_65_2 = arg_65_0:_delete(var_65_0, var_65_1)

	if not var_65_2 then
		return
	end

	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if not var_65_0 then
		return
	end

	arg_65_0:_printerWarmUp()

	local var_65_3 = "deleted " .. var_0_1(var_65_2)
	local var_65_4 = ""

	if arg_65_2 and arg_65_3 then
		var_65_4 = var_65_4 .. string.format("bossid: %s, layer: %s", arg_65_2, arg_65_3)
	elseif arg_65_2 then
		var_65_4 = var_65_4 .. string.format("bossid: %s", arg_65_2)
	end

	local var_65_5 = var_65_3 .. ": " .. var_65_4

	var_0_10(var_65_5)
end

function var_0_0._reload(arg_66_0)
	if not arg_66_0:isInitReady() then
		return
	end

	arg_66_0:_printerWarmUp()
	arg_66_0:reInit()

	local var_66_0 = {}

	arg_66_0:_initRootRed(var_66_0)
	arg_66_0:_initBossRed(var_66_0)

	local var_66_1 = {}

	for iter_66_0, iter_66_1 in ipairs(var_66_0) do
		if arg_66_0:_isSValueValid(iter_66_1.value) then
			var_0_3(var_66_1, iter_66_1)
		end
	end

	RedDotRpc.instance:clientAddRedDotGroupList(var_66_1, true)
	var_0_10("<color=#00FF00>reload BossRushRedModel finished!!</color>")
end

var_0_0.instance = var_0_0.New()

return var_0_0
