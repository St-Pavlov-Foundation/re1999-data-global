module("modules.logic.bossrush.model.BossRushRedModel", package.seeall)

slot0 = class("BossRushRedModel", BaseModel)
slot1 = tostring
slot2 = next
slot3 = table.insert
slot4 = RedDotEnum.DotNode
slot5 = "BossRushRed|"
slot6 = 0
slot7 = -11235
slot8 = 0

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0:_stopTick()
	FrameTimerController.onDestroyViewMember(slot0, "_flushCacheFrameTimer")

	slot0._unlockBossIdList = {}
	slot0._delayNeedUpdateDictList = {}
	slot0._delayUpdateRedValueList = {}
	slot0._flushDataFrameTimer = nil
end

function slot0._getConfig(slot0)
	return BossRushModel.instance:getConfig()
end

function slot0._getActivityId(slot0)
	return BossRushConfig.instance:getActivityId()
end

function slot0._getRedDotGroup(slot0, slot1)
	return RedDotModel.instance:getRedDotInfo(slot1)
end

function slot0._getRedDotGroupItem(slot0, slot1, slot2)
	if not slot0:_getRedDotGroup(slot1) then
		logWarn("[BossRushRedModel] _getRedDotGroupItem: defineId=" .. uv0(slot1) .. " uid=" .. uv0(slot2))

		return
	end

	return slot3.infos[slot2]
end

function slot0._getDisplayValue(slot0, slot1, slot2)
	if not slot2 or not slot1 then
		return uv0
	end

	if not slot0:_getRedDotGroup(slot1) then
		return uv0
	end

	if not slot0:_getRedDotGroupItem(slot1, slot2) then
		return uv0
	end

	return slot4.value, true
end

function slot0._getDisplayValueByDSL(slot0, slot1, slot2, slot3)
	return slot0:_getDisplayValue(slot1, slot0:getUId(slot1, slot2, slot3))
end

function slot0._createByDU(slot0, slot1, slot2)
	return {
		id = slot1,
		uid = slot2,
		value = slot0:_getSavedValue(slot1, slot2)
	}
end

function slot0._createByDSL(slot0, slot1, slot2, slot3)
	return slot0:_createByDU(slot1, slot0:getUId(slot1, slot2, slot3))
end

function slot0._getDUByDSL(slot0, slot1, slot2, slot3)
	return slot1, slot0:getUId(slot1, slot2, slot3)
end

function slot0._getSavedValue(slot0, slot1, slot2)
	slot4 = slot0:_get(slot1, slot2, slot0:getDefaultValue(slot1))

	return slot4, slot0:_isSValueValid(slot4)
end

function slot0._getSavedValueByDSL(slot0, slot1, slot2, slot3)
	return slot0:_getSavedValue(slot1, slot0:getUId(slot1, slot2, slot3))
end

function slot0._getDUSValueByDSL(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUId(slot1, slot2, slot3)
	slot5, slot6 = slot0:_getSavedValue(slot1, slot4)

	return slot1, slot4, slot5, slot6
end

function slot0._getValue(slot0, slot1, slot2)
	slot3 = slot0:_getSavedValue(slot1, slot2)
	slot5, slot6 = slot0:_getDisplayValue(slot1, slot2)

	return slot0:_isSValueValid(slot3), slot3, slot5, slot6
end

function slot0._getValueByDSL(slot0, slot1, slot2, slot3)
	return slot0:_getValue(slot1, slot0:getUId(slot1, slot2, slot3))
end

function slot0._startFlushData(slot0)
	if math.max(tabletool.len(slot0._delayUpdateRedValueList), tabletool.len(slot0._delayNeedUpdateDictList)) == 0 then
		return
	end

	FrameTimerController.onDestroyViewMember(slot0, "_flushDataFrameTimer")

	slot0._flushDataFrameTimer = FrameTimerController.instance:register(slot0._tryFlushDatas, slot0, 3, slot1)

	slot0._flushDataFrameTimer:Start()
end

function slot0._onTick(slot0)
	if not uv0(slot0._unlockBossIdList) then
		slot0:_stopTick()

		return
	end

	for slot5, slot6 in pairs(slot1) do
		if BossRushModel.instance:isBossOnline(slot6) then
			slot1[slot5] = nil

			slot0:setIsNewUnlockStage(slot6, true)
			slot0:setIsNewUnlockStageLayer(slot6, 1, true)
		end
	end
end

function slot0._initRootRed(slot0, slot1)
	uv0(slot1, slot0:_createByDSL(uv1.BossRushEnter))
	uv0(slot1, slot0:_createByDSL(uv1.BossRushOpen))
end

function slot0._initBossRed(slot0, slot1)
	for slot7, slot8 in pairs(slot0:_getConfig():getStages()) do
		slot9 = slot8.stage

		uv0(slot1, slot0:_createByDSL(uv1.BossRushBoss, slot9))
		uv0(slot1, slot0:_createByDSL(uv1.BossRushNewBoss, slot9))

		slot14 = slot0
		slot15 = uv1.BossRushBossReward

		uv0(slot1, slot0._createByDSL(slot14, slot15, slot9))

		for slot14, slot15 in pairs(slot2:getEpisodeStages(slot9)) do
			uv0(slot1, slot0:_createByDSL(uv1.BossRushNewLayer, slot9, slot15.layer))
		end
	end
end

function slot0._isSValueValid(slot0, slot1)
	assert(type(slot1) == "number")

	return slot1 ~= uv0
end

function slot0._modifyOrMakeRedDotGroupItem(slot0, slot1, slot2, slot3, slot4)
	assert(type(slot3) == "number")

	slot5, slot6 = slot0:_getDisplayValue(slot1, slot2)

	if slot5 == slot3 then
		return
	end

	if not slot0:_getRedDotGroupItem(slot1, slot2) then
		slot6 = false
	end

	if slot6 then
		slot7:reset({
			ext = slot7.ext,
			time = slot7.time,
			value = slot3
		})
	else
		RedDotRpc.instance:clientAddRedDotGroupList({
			{
				id = slot1,
				uid = slot2,
				value = slot3
			}
		})
	end

	if slot4 then
		slot0:_trySave(slot1, slot2, uv0)
	else
		slot0:_trySave(slot1, slot2, slot3)
	end

	return true
end

function slot0._calcAssociateRedDots(slot0, slot1, slot2)
	for slot7, slot8 in pairs(RedDotModel.instance:_getAssociateRedDots(slot2) or {}) do
		slot1[slot8] = true
	end
end

function slot0._tryShowRedDotGroupItem(slot0, slot1, slot2, slot3, slot4)
	if slot0:_modifyOrMakeRedDotGroupItem(slot1, slot2, slot3 and 1 or 0, slot4) then
		slot6 = {
			[uv0] = true
		}

		slot0:_calcAssociateRedDots(slot6, slot1)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, slot6)
	end
end

function slot0._refreshReward(slot0, slot1, slot2)
	slot3, slot4 = slot0:_getDUByDSL(uv0.BossRushBossReward, slot2)
	slot5, slot6 = slot0:_getDisplayValueByDSL(uv0.BossRushBossSchedule, slot2)
	slot7, slot8 = slot0:_getDisplayValueByDSL(uv0.BossRushBossAchievement, slot2)

	if slot6 then
		slot9 = 0 + slot5
	end

	if slot8 then
		slot9 = slot9 + slot7
	end

	if slot0:_modifyOrMakeRedDotGroupItem(slot3, slot4, slot9) then
		slot1[slot3] = true
	end
end

function slot0._refreshNewBoss(slot0, slot1, slot2)
	slot3, slot4, slot5, slot6 = slot0:_getDUSValueByDSL(uv0.BossRushNewBoss, slot2)

	if slot0:_modifyOrMakeRedDotGroupItem(slot3, slot4, slot6 and slot5 or 0) then
		slot1[slot3] = true
	end
end

function slot0._refreshNewLayer(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6, slot7 = slot0:_getDUSValueByDSL(uv0.BossRushNewLayer, slot2, slot3)

	if slot0:_modifyOrMakeRedDotGroupItem(slot4, slot5, slot7 and slot6 or 0) then
		slot1[slot4] = true
	end
end

function slot0.refreshAllStageLayerUnlockState(slot0)
	for slot6, slot7 in pairs(slot0:_getConfig():getStages()) do
		for slot12, slot13 in pairs(BossRushModel.instance:getStageLayersInfo(slot6)) do
			slot15, slot16, slot17, slot18 = slot0:_getDUSValueByDSL(uv0.BossRushNewLayer, slot6, slot12)

			if not slot18 then
				if slot13.isOpen then
					slot0:setIsNewUnlockStageLayer(slot6, slot12, true)
				end
			elseif not slot14 and slot17 >= 1 then
				slot0:setIsNewUnlockStageLayer(slot6, slot12, false, true)
			end
		end
	end
end

function slot0._refreshOpen(slot0, slot1)
	slot2, slot3, slot4, slot5 = slot0:_getDUSValueByDSL(uv0.BossRushOpen)

	if slot0:_modifyOrMakeRedDotGroupItem(slot2, slot3, slot5 and slot4 or 0) then
		slot1[slot2] = true
	end
end

function slot0._refreshBoss(slot0, slot1, slot2)
	slot3, slot4 = slot0:_getDUByDSL(uv0.BossRushBoss, slot2)
	slot7, slot8 = slot0:_getSavedValueByDSL(uv0.BossRushNewBoss, slot2)
	slot9, slot10 = slot0:_getDisplayValueByDSL(uv0.BossRushBossReward, slot2)

	for slot15, slot16 in pairs(slot0:_getConfig():getEpisodeStages(slot2)) do
		slot18, slot19 = slot0:_getSavedValueByDSL(uv0.BossRushNewLayer, slot2, slot16.layer)

		if slot19 then
			slot11 = 0 + slot18
		end
	end

	if slot8 then
		slot12 = slot11 + slot7
	end

	if slot10 then
		slot12 = slot12 + slot9
	end

	if slot0:_modifyOrMakeRedDotGroupItem(slot3, slot4, slot12) then
		slot1[slot3] = true
	end
end

function slot0._refreshRootInner(slot0, slot1)
	slot2, slot3 = slot0:_getDUByDSL(uv0.BossRushEnter)
	slot6, slot7 = slot0:_getSavedValueByDSL(uv0.BossRushOpen)

	for slot12, slot13 in pairs(slot0:_getConfig():getStages()) do
		slot15, slot16 = slot0:_getDisplayValueByDSL(uv0.BossRushBoss, slot13.stage)

		if slot16 then
			slot8 = 0 + slot15
		end
	end

	if slot7 then
		slot9 = slot8 + slot6
	end

	if slot0:_modifyOrMakeRedDotGroupItem(slot2, slot3, slot9) then
		slot1[slot2] = true
	end
end

function slot0._refreshRoot(slot0)
	slot3 = {}

	for slot7, slot8 in pairs(slot0:_getConfig():getStages()) do
		slot9 = slot8.stage

		slot0:_refreshNewBoss(slot3, slot9)

		for slot14, slot15 in pairs(slot1:getEpisodeStages(slot9)) do
			slot0:_refreshNewLayer(slot3, slot9, slot15.layer)
		end

		slot0:_refreshReward(slot3, slot9)
		slot0:_refreshBoss(slot3, slot9)
	end

	slot0:_refreshOpen(slot3)
	slot0:_refreshRootInner(slot3)

	return slot3
end

function slot0._getPrefsKey(slot0, slot1, slot2)
	slot3 = slot0:_getActivityId()

	if not slot2 then
		return uv0 .. uv1(slot3) .. uv1(slot1)
	end

	return uv0 .. uv1(slot3) .. uv1(slot1) .. "|" .. uv1(slot2)
end

function slot0._save(slot0, slot1, slot2, slot3)
	GameUtil.playerPrefsSetNumberByUserId(slot0:_getPrefsKey(slot1, slot2), slot3)
end

function slot0._get(slot0, slot1, slot2, slot3)
	return GameUtil.playerPrefsGetNumberByUserId(slot0:_getPrefsKey(slot1, slot2), slot3 or slot0:getDefaultValue(slot1))
end

function slot0._appendRefreshRedDict(slot0, slot1)
	if type(slot1) ~= "table" then
		return
	end

	table.insert(slot0._delayNeedUpdateDictList, slot1)
end

function slot0._waitWarmUpOrJustRun(slot0, slot1, ...)
	if slot0:_isWarmUp() then
		table.insert(slot0._delayUpdateRedValueList, {
			callback = slot1,
			args = {
				...
			}
		})

		return
	end

	slot1(...)
end

function slot0._tryRunRedDicts(slot0)
	if #slot0._delayNeedUpdateDictList == 0 then
		return true
	end

	slot0:updateRelateDotInfo(table.remove(slot1))

	return false
end

function slot0._tryRunValueSetterCallbacks(slot0)
	if #slot0._delayUpdateRedValueList == 0 then
		return true
	end

	slot2 = table.remove(slot1)

	slot2.callback(unpack(slot2.args))

	return false
end

function slot0._tryFlushDatas(slot0)
	return slot0:_tryRunRedDicts() or slot0:_tryRunValueSetterCallbacks()
end

function slot0._isWarmUp(slot0)
	return slot0:_getRedDotGroup(uv0.BossRushEnter) == nil
end

function slot0.isInitReady(slot0)
	return BossRushModel.instance:isActOnLine()
end

function slot0._stopTick(slot0)
	TaskDispatcher.cancelTask(slot0._onTick, slot0)
end

function slot0._startTick(slot0)
	slot0:_stopTick()

	slot3 = {}

	for slot7, slot8 in pairs(slot0:_getConfig():getStages()) do
		if not BossRushModel.instance:isBossOnline(slot8.stage) then
			slot3[#slot3 + 1] = slot9
		end
	end

	slot0._unlockBossIdList = slot3

	if #slot3 > 0 then
		TaskDispatcher.runRepeat(slot0._onTick, slot0, 1)
	end
end

function slot0._tryUpdateMissingRed(slot0)
	slot2 = slot0:_getConfig():getStages()
	slot5, slot6, slot7, slot8 = slot0:_getDUSValueByDSL(uv0.BossRushOpen)

	if not slot8 then
		if ActivityModel.instance:isActOnLine(BossRushModel.instance:getActivityId()) then
			slot0:setIsOpenActivity(true)
		end
	elseif not slot4 and slot7 == 1 then
		slot0:setIsOpenActivity(false, true)
	end

	for slot12, slot13 in pairs(slot2) do
		slot14 = slot13.stage
		slot16, slot17, slot18, slot19 = slot0:_getDUSValueByDSL(uv0.BossRushNewBoss, slot14)

		if not slot19 then
			if BossRushModel.instance:isBossOnline(slot14) then
				slot0:setIsNewUnlockStage(slot14, true)
			end
		elseif not slot15 and slot18 >= 1 then
			slot0:setIsNewUnlockStage(slot14, false, true)
		end

		for slot24, slot25 in pairs(slot1:getEpisodeStages(slot14)) do
			slot26 = slot25.layer
			slot28, slot29, slot30, slot31 = slot0:_getDUSValueByDSL(uv0.BossRushNewLayer, slot14, slot26)

			if not slot31 then
				if slot15 and BossRushModel.instance:isBossLayerOpen(slot14, slot26) or false then
					slot0:setIsNewUnlockStageLayer(slot14, slot26, true)
				end
			elseif not slot27 and slot30 >= 1 then
				slot0:setIsNewUnlockStageLayer(slot14, slot26, false, true)
			end
		end
	end
end

function slot0._flushCache(slot0)
	slot0:_startFlushData()
	slot0:_tryUpdateMissingRed()
	slot0:_startTick()
end

function slot0.refreshClientCharacterDot(slot0)
	if not slot0:isInitReady() then
		return
	end

	if not slot0:_isWarmUp() then
		return
	end

	slot1 = {}

	slot0:_initRootRed(slot1)
	slot0:_initBossRed(slot1)

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if slot0:_isSValueValid(slot7.value) then
			uv0(slot2, slot7)
		end
	end

	RedDotRpc.instance:clientAddRedDotGroupList(slot2)
end

function slot0.updateRelateDotInfo(slot0, slot1)
	if slot0:_isWarmUp() then
		slot0:_appendRefreshRedDict(slot1)

		return
	end

	if not slot1 then
		return
	end

	if not slot1[uv0.BossRushEnter] then
		return
	end

	slot2 = slot0:_refreshRoot()

	if not slot0._flushCacheFrameTimer then
		slot0._flushCacheFrameTimer = FrameTimerController.instance:register(slot0._flushCache, slot0)

		slot0._flushCacheFrameTimer:Start()
	end

	if not uv1(slot2) then
		return
	end

	if slot1[uv2] then
		return
	end

	RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, slot2)
end

function slot0.getUId(slot0, slot1, slot2, slot3)
	if uv0.BossRushNewLayer == slot1 then
		return slot2 * 1000 + slot3
	end

	return slot2 or uv1
end

function slot0.getDefaultValue(slot0, slot1)
	if slot1 == uv0.BossRushOpen or slot1 == uv0.BossRushNewBoss or slot1 == uv0.BossRushNewLayer then
		return uv1
	end

	return 0
end

function slot0._trySave(slot0, slot1, slot2, slot3)
	if slot1 == uv0.BossRushBossReward or slot1 == uv0.BossRushBossSchedule or slot1 == uv0.BossRushBossAchievement then
		return
	end

	slot4, slot6 = slot0:_getValue(slot1, slot2)

	if slot4 then
		slot6 = slot3
	elseif slot3 > 0 then
		slot6 = slot3
	end

	if slot5 ~= slot6 then
		slot0:_save(slot1, slot2, slot6)
	end
end

function slot0.setIsOpenActivity(slot0, slot1, slot2)
	slot3, slot4 = slot0:_getDUByDSL(uv0.BossRushOpen)

	slot0:_waitWarmUpOrJustRun(slot0._tryShowRedDotGroupItem, slot0, slot3, slot4, slot1, slot2)
end

function slot0.setIsNewUnlockStage(slot0, slot1, slot2, slot3)
	slot4, slot5 = slot0:_getDUByDSL(uv0.BossRushNewBoss, slot1)

	slot0:_waitWarmUpOrJustRun(slot0._tryShowRedDotGroupItem, slot0, slot4, slot5, slot2, slot3)
end

function slot0.setIsNewUnlockStageLayer(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = slot0:_getDUByDSL(uv0.BossRushNewLayer, slot1, slot2)

	slot0:_waitWarmUpOrJustRun(slot0._tryShowRedDotGroupItem, slot0, slot5, slot6, slot3, slot4)
end

function slot0.getIsNewUnlockStage(slot0, slot1)
	return slot0:checkIsShow(uv0.BossRushNewBoss, slot1)
end

function slot0.getIsNewUnlockStageLayer(slot0, slot1, slot2)
	return slot0:checkIsShow(uv0.BossRushNewLayer, slot1, slot2)
end

function slot0.checkIsShow(slot0, slot1, slot2, slot3)
	slot4, slot5, slot6 = slot0:_getValueByDSL(slot1, slot2, slot3)

	return slot4 and slot5 >= 1 or slot6 >= 1
end

slot9, slot10, slot11 = nil

function slot0._printerWarmUp(slot0)
	if not uv0 then
		uv0 = {}

		for slot4, slot5 in pairs(RedDotEnum.DotNode) do
			uv0[slot5] = slot4
		end
	end

	if not uv1 then
		uv1 = getGlobal("ddd") or SLFramework.SLLogger.Log
	end

	if not uv2 and PlayerModel.instance:getMyUserId() and slot1 ~= 0 then
		uv2 = slot1
	end
end

function slot0._print(slot0, slot1)
	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if not slot1 then
		return
	end

	slot0:_printerWarmUp()
	assert(uv0[slot1], "defineId = " .. slot1)

	function RedDotGroupMo.tostring(slot0)
		slot1 = slot0.id
		slot5 = true

		for slot9, slot10 in pairs(slot0.infos) do
			if slot9 ~= 0 then
				slot4 = string.format("%s\n\tuid: %s (%s)", string.format("%s(%s):", uv0[slot1], uv1(slot1)), uv1(slot9), uv1(slot10.value))
				slot5 = false
			end
		end

		if slot5 then
			slot4 = slot4 .. " empty"
		end

		return slot4
	end

	if not RedDotModel.instance:getRedDotInfo(slot1) then
		uv2(uv0[slot1] .. ": null")

		return
	end

	uv2(slot2:tostring())
end

function slot0.logDalayInfo(slot0)
	slot0:_printerWarmUp()
	uv0("#_delayNeedUpdateDictList=" .. uv1(#slot0._delayNeedUpdateDictList))
	uv0("#_delayUpdateRedValueList=" .. uv1(#slot0._delayUpdateRedValueList))
end

function slot0._delete(slot0, slot1, slot2)
	slot3 = slot0:_getPrefsKey(slot1, slot2)

	if not PlayerModel.instance:getMyUserId() or slot5 == 0 then
		slot5 = uv0
	end

	if not slot5 then
		return
	end

	slot0:_printerWarmUp()

	if PlayerPrefsHelper.hasKey(slot3 .. "#" .. uv1(slot5)) then
		PlayerPrefsHelper.deleteKey(slot6)

		return slot3
	end

	uv2("_delete no existed prefsKey!!", slot6)
end

function slot0._deleteByDSL(slot0, slot1, slot2, slot3)
	slot4, slot5 = slot0:_getDUByDSL(slot1, slot2, slot3)

	if not slot0:_delete(slot4, slot5) then
		return
	end

	if not SLFramework.FrameworkSettings.IsEditor then
		return
	end

	if not slot4 then
		return
	end

	slot0:_printerWarmUp()

	slot7 = "deleted " .. uv0(slot6)

	if slot2 and slot3 then
		slot8 = "" .. string.format("bossid: %s, layer: %s", slot2, slot3)
	elseif slot2 then
		slot8 = slot8 .. string.format("bossid: %s", slot2)
	end

	uv1(slot7 .. ": " .. slot8)
end

function slot0._reload(slot0)
	if not slot0:isInitReady() then
		return
	end

	slot0:_printerWarmUp()
	slot0:reInit()

	slot1 = {}

	slot0:_initRootRed(slot1)
	slot0:_initBossRed(slot1)

	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if slot0:_isSValueValid(slot7.value) then
			uv0(slot2, slot7)
		end
	end

	RedDotRpc.instance:clientAddRedDotGroupList(slot2, true)
	uv1("<color=#00FF00>reload BossRushRedModel finished!!</color>")
end

slot0.instance = slot0.New()

return slot0
