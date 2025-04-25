module("modules.logic.fight.entity.comp.FightSkillComp", package.seeall)

slot0 = class("FightSkillComp", LuaCompBase)
slot0.FrameEventHandlerCls = {
	[0] = FightTLEventMove,
	FightTLEventTargetEffect,
	FightTLEventAtkSpineLookDir,
	FightTLEventDefHit,
	FightTLEventDefFreeze,
	FightTLEventAtkEffect,
	FightTLEventAtkFlyEffect,
	FightTLEventAtkFullEffect,
	FightTLEventDefEffect,
	FightTLEventAtkAction,
	FightTLEventPlayAudio,
	FightTLEventCreateSpine,
	FightTLEventCameraShake,
	FightTLEventEntityVisible,
	FightTLEventSceneMask,
	FightTLEventCameraTrace,
	FightTLEventPlayVideo,
	FightTLEventEntityScale,
	FightTLEventRefreshRenderOrder,
	FightTLEventCameraRotate,
	FightTLEventUIVisible,
	FightTLEventEntityRenderOrder,
	FightTLEventEntityRotate,
	FightTLEventSpineMaterial,
	FightTLEventBloomMaterial,
	FightTLEventDisableSpineRotate,
	FightTLEventHideScene,
	FightTLEventSpeed,
	FightTLEventDefEffect,
	FightTLEventDefHeal,
	FightTLEventUniqueCameraNew,
	FightTLEventEntityAnim,
	FightTLEventEntityTexture,
	FightTLEventJoinSameSkillStart,
	FightTLEventPlayNextSkill,
	FightTLEventSameSkillJump,
	FightTLEventCameraDistance,
	FightTLEventInvokeEntityDead,
	FightTLEventSetSceneObjVisible,
	FightTLEventSetSpinePos,
	FightTLEventSetTimelineTime,
	FightTLEventPlaySceneAnimator,
	FightTLEventPlayServerEffect,
	FightTLEventChangeScene,
	FightTLEventMarkSceneDefaultRoot,
	FightTLEventSceneMove,
	FightTLEventCatapult,
	FightTLEventStressTrigger,
	FightTLEventFloatBuffBySkillEffect,
	FightTLEventLYSpecialSpinePlayAniName,
	FightTLEventInvokeSummon,
	FightTLEventInvokeLookBack,
	[1000] = FightTLEventChangeHero,
	[1001] = FightTLEventObjFly,
	[1002] = FightTLEventEntityQuit,
	[1003] = FightTLEventEntityEnter,
	[1004] = FightTLEventSubEntityEnter
}

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._timeScale = 1
	slot0._tlEventContext = nil
	slot0._fightStepMO = nil
	slot0._curSkillId = nil
	slot0._loader2SkillId = {}
	slot0._skillId2Loader = {}
	slot0._skillId2TimelineUrl = {}
	slot0._frameEventHandlerPlaying = {}
	slot0._tlAssetItem = nil
end

function slot0.getCurTimelineDuration(slot0)
	if slot0._timeline_list then
		return slot0._last_timeline_item:GetDuration()
	end

	return 0
end

function slot0.playTimeline(slot0, slot1, slot2)
	slot0._fightStepMO = slot2
	slot0._curSkillId = slot0._fightStepMO.actId
	slot0._onceloader = MultiAbLoader.New()
	slot0._timelineName = slot1
	slot0._skillId2TimelineUrl[slot0._curSkillId] = ResUrl.getSkillTimeline(slot1)

	slot0._onceloader:addPath(FightHelper.getRolesTimelinePath(slot1))
	slot0._onceloader:startLoad(slot0._onLoadOnceTimeline, slot0)
end

function slot0._onLoadOnceTimeline(slot0, slot1)
	slot0._tlAssetItem = slot0._onceloader:getFirstAssetItem()

	if slot0._tlAssetItem then
		slot0._timelineName = SLFramework.FileHelper.GetFileName(slot0._skillId2TimelineUrl[slot0._curSkillId], false)

		FightHelper.logForPCSkillEditor("play Timeline " .. slot0._timelineName)
		slot0:_playTimeline()
	else
		slot0._timelineName = nil

		logError("skillId timeline asset not loaded " .. slot0._curSkillId)
	end

	slot0._onceloader:dispose()

	slot0._onceloader = nil
end

function slot0.playSkill(slot0, slot1, slot2)
	FightHelper.logForPCSkillEditor("++++++++++++++++ entityId_ " .. slot0.entity.id .. " play skill_" .. slot1)

	if slot2 == nil then
		logError("fightStepMO is nil, skillId = " .. slot1)

		return
	end

	if not lua_skill.configDict[slot1] then
		logError("skill config not exist，id = " .. slot1)

		return
	end

	slot0._tlEventContext = {}
	slot0._curSkillId = slot1
	slot0._fightStepMO = slot2

	if slot0._skillId2Loader[slot1] then
		slot4:dispose()

		slot0._skillId2Loader[slot1] = nil
	end

	slot0:_loadSkillAsset(slot1, slot2)
end

function slot0.skipSkill(slot0)
	if slot0._timeline_list and slot0._timeline_list[1] then
		slot1:skipSkill()
		slot1:onTimelineEnd()
	end
end

function slot0.stopSkill(slot0)
	if slot0._timeline_list then
		for slot4, slot5 in ipairs(slot0._timeline_list) do
			slot5:stopSkill()
		end

		slot0._timeline_list = nil

		if slot0._tlAssetItem then
			slot0._tlAssetItem = nil
		end
	end

	slot0._curSkillId = nil
end

function slot0.getCurTimelineItem(slot0)
	return slot0._last_timeline_item
end

function slot0.getBinder(slot0)
	return slot0._last_timeline_item and slot0._last_timeline_item._binder
end

function slot0.getCurFrame(slot0)
	return slot0._last_timeline_item._binder.CurFrame
end

function slot0.getCurFrameFloat(slot0)
	return slot0._last_timeline_item._binder.CurFrameFloat
end

function slot0.getFrameFloatByTime(slot0, slot1)
	return slot0._last_timeline_item._binder:GetFrameFloatByTime(slot1)
end

function slot0.setTimeScale(slot0, slot1)
	slot0._timeScale = slot1

	if slot0._timeline_list then
		for slot5, slot6 in ipairs(slot0._timeline_list) do
			slot6:setTimeScale(slot1)
		end
	end
end

function slot0._reallyPlayCurSkill(slot0)
	if slot0._curSkillId then
		slot0._tlAssetItem = slot0._skillId2Loader[slot0._curSkillId]:getFirstAssetItem()

		if slot0._tlAssetItem then
			slot0._timelineName = SLFramework.FileHelper.GetFileName(slot0._skillId2TimelineUrl[slot0._curSkillId], false)

			FightHelper.logForPCSkillEditor("play Timeline " .. slot0._timelineName)
			slot0:_playTimeline()
		else
			slot0._timelineName = nil

			slot0._skillId2Loader[slot0._curSkillId]:dispose()

			slot0._skillId2Loader[slot0._curSkillId] = nil

			logError("skillId timeline asset not loaded " .. slot0._curSkillId)
		end
	else
		slot0._timelineName = nil

		FightHelper.logForPCSkillEditor("_reallyPlayCurSkill fail, self._curSkillId == nil")
	end
end

function slot0.clearSkillRes(slot0)
	for slot4, slot5 in pairs(slot0._skillId2Loader) do
		slot5:dispose()
	end

	if slot0._onceloader then
		slot0._onceloader:dispose()

		slot0._onceloader = nil
	end

	slot0._skillId2Loader = {}
	slot0._loader2SkillId = {}
end

function slot0.onUpdate(slot0)
	if slot0._tlAssetItem and slot0._timeline_list then
		for slot4, slot5 in ipairs(slot0._timeline_list) do
			slot5:onUpdate()
		end
	end
end

function slot0.beforeDestroy(slot0)
	slot0:stopSkill()
end

function slot0.onDestroy(slot0)
	slot0:clearSkillRes()

	slot0._skillId2Loader = nil
	slot0._loader2SkillId = nil
end

function slot0._playTimeline(slot0)
	FightHelper.setBossSkillSpeed(slot0.entity.id)
	FightHelper.setTimelineExclusiveSpeed(slot0._timelineName)
	FightModel.instance:updateRTPCSpeed()

	slot0._startTime = Time.time

	slot0:_beforePlayTimeline()

	if not slot0._timeline_list then
		slot0._timeline_list = {}
	end

	slot1 = FightSkillTimelineItem.New()
	slot1._timelineName = slot0._timelineName
	slot1._timelineUrl = slot0._skillId2TimelineUrl[slot0._curSkillId]
	slot0._last_timeline_item = slot1

	slot1:initLogic(ZProj.PlayableAssetBinder.Get(gohelper.create3d(slot0.entity.go, "_skill_playable")), slot0.entity, slot0._fightStepMO)
	table.insert(slot0._timeline_list, slot1)

	if slot0:sameSkillPlaying() then
		slot1:setParam(slot0._timeline_start_time, slot0._audio_start_time, slot0._spine_start_time, slot0._spine_delay_time, slot0._curAnimState, slot0._audio_id)
	end

	slot1:play(slot0._tlAssetItem)
	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkill, slot0.entity, slot0._curSkillId, slot0._fightStepMO, slot0._timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayStart, slot0.entity, slot0._curSkillId, slot0._fightStepMO, slot0._timelineName)
end

function slot0.recordSameSkillStartParam(slot0, slot1)
	slot0._timeline_start_time = tonumber(slot1[1])
	slot0._audio_start_time = tonumber(slot1[2])
	slot0._spine_start_time = tonumber(slot1[3])
	slot0._spine_delay_time = tonumber(slot1[4])
	slot0._timeline_start_time = slot0._timeline_start_time ~= 0 and slot0._timeline_start_time or nil
	slot0._audio_start_time = slot0._audio_start_time ~= 0 and slot0._audio_start_time or nil
	slot0._spine_start_time = slot0._spine_start_time ~= 0 and slot0._spine_start_time or nil
	slot0._spine_delay_time = slot0._spine_delay_time ~= 0 and slot0._spine_delay_time or nil
end

function slot0.recordFilterAtkEffect(slot0, slot1)
	if not slot0.filter_atk_effects then
		slot0.filter_atk_effects = {}
	end

	for slot6, slot7 in ipairs(string.split(slot1, "#")) do
		slot0.filter_atk_effects[slot7] = true
	end
end

function slot0.atkEffectNeedFilter(slot0, slot1)
	if slot0.filter_atk_effects and slot0.filter_atk_effects[slot1] then
		return true
	end

	return false
end

function slot0.recordFilterFlyEffect(slot0, slot1)
	if not slot0.filter_fly_effects then
		slot0.filter_fly_effects = {}
	end

	for slot6, slot7 in ipairs(string.split(slot1, "#")) do
		slot0.filter_fly_effects[slot7] = true
	end
end

function slot0.flyEffectNeedFilter(slot0, slot1)
	if slot0.filter_fly_effects and slot0.filter_fly_effects[slot1] then
		return true
	end

	return false
end

function slot0.clearSameSkillStartParam(slot0)
	slot0._timeline_start_time = nil
	slot0._audio_start_time = nil
	slot0._spine_start_time = nil
	slot0._spine_delay_time = nil
	slot0._curAnimState = nil
	slot0._audio_id = nil
	slot0.filter_atk_effects = nil
	slot0.filter_fly_effects = nil
end

function slot0.stopCurTimelineWaitPlaySameSkill(slot0, slot1, slot2, slot3)
	slot0._sign_playing_same_skill = true
	slot0._curAnimState = slot2
	slot0._audio_id = slot3

	slot0._last_timeline_item:stopCurTimelineWaitPlaySameSkill(slot1, slot2)
end

function slot0.sameSkillPlaying(slot0)
	return slot0._sign_playing_same_skill
end

function slot0._delayEndSkill(slot0)
	CameraMgr.instance:getCameraShake():StopShake()
	FightHelper.cancelBossSkillSpeed()
	FightHelper.cancelExclusiveSpeed()
	FightModel.instance:updateRTPCSpeed()

	slot0._sign_playing_same_skill = nil

	if slot0._timeline_list then
		for slot4, slot5 in ipairs(slot0._timeline_list) do
			slot5:releaseSelf()
		end

		slot0._timeline_list = nil
	end

	slot1 = slot0._curSkillId
	slot2 = slot0._fightStepMO
	slot0._curSkillId = nil
	slot0._fightStepMO = nil

	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkillFinish, slot0.entity, slot1, slot2, slot0._timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayFinish, slot0.entity, slot1, slot2, slot0._timelineName)
end

function slot0._loadSkillAsset(slot0, slot1, slot2)
	if lua_skill.configDict[slot1] then
		slot5 = slot0.entity:getMO() and slot4.skin

		if slot2 and slot4 and slot2.fromId == slot4.id then
			slot5 = FightHelper.processSkinByStepMO(slot2, slot4)
		end

		slot6 = FightHelper.detectReplaceTimeline(FightConfig.instance:getSkinSkillTimeline(slot5, slot1), slot0._fightStepMO)
		slot7 = MultiAbLoader.New()
		slot0._skillId2Loader[slot1] = slot7
		slot0._loader2SkillId[slot7] = slot1
		slot0._skillId2TimelineUrl[slot1] = ResUrl.getSkillTimeline(slot6)

		slot7:addPath(FightHelper.getRolesTimelinePath(slot6))
		slot7:setLoadFailCallback(slot0._delayEndSkill, slot0)
		slot7:startLoad(slot0._onLoadSkillTimelineFinish, slot0)
	else
		logError("skill not exist: " .. slot1)
	end
end

function slot0._onLoadSkillTimelineFinish(slot0, slot1)
	slot2 = slot0._loader2SkillId[slot1]

	if slot0._curSkillId and slot2 and slot0._curSkillId == slot2 then
		slot0:_reallyPlayCurSkill()
	else
		FightHelper.logForPCSkillEditor("skill loaded, but skill has stop")
	end
end

function slot0._beforePlayTimeline(slot0)
	slot0:_setSideRenderOrder()

	if slot0.entity.buff then
		slot0.entity.buff:hideLoopEffects("before_skill_timeline")
	end

	slot4 = "before_skill_timeline"

	for slot4, slot5 in pairs(FightHelper.hideDefenderBuffEffect(slot0._fightStepMO, slot4)) do
		slot0._hide_defenders_buff_effect = slot0._hide_defenders_buff_effect or {}

		table.insert(slot0._hide_defenders_buff_effect, slot5)
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		if not slot0._sign_playing_same_skill then
			FightFloatMgr.instance:removeInterval()
		end

		if not slot0.entity:getMO() or not slot1:isPassiveSkill(slot0._curSkillId) then
			GameSceneMgr.instance:getCurScene().level:setFrontVisible(false)
		end
	end

	FightSkillMgr.instance:beforeTimeline(slot0.entity, slot0._fightStepMO)
end

function slot0._afterPlayTimeline(slot0)
	slot0._sign_playing_same_skill = nil

	FightSkillMgr.instance:afterTimeline(slot0.entity, slot0._fightStepMO)
	slot0:_resetTargetHp()

	if slot0._timeline_list then
		for slot4, slot5 in ipairs(slot0._timeline_list) do
			slot0:_checkFloatTable(slot5._tlEventContext.floatNum, "伤害")
			slot0:_checkFloatTable(slot5._tlEventContext.healFloatNum, "回血")
		end
	end

	if slot0.entity.buff then
		slot0.entity.buff:showBuffEffects("before_skill_timeline")
	end

	if slot0._hide_defenders_buff_effect then
		FightHelper.revertDefenderBuffEffect(slot0._hide_defenders_buff_effect, "before_skill_timeline")

		slot0._hide_defenders_buff_effect = nil
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		FightFloatMgr.instance:resetInterval()
		slot0:_cancelSideRenderOrder()
		GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)

		if slot0._fightStepMO.hasPlayTimelineCamera then
			GameSceneMgr.instance:getCurScene().camera:resetParam()
		end

		GameSceneMgr.instance:getCurScene().entityMgr.enableSpineRotate = true

		if not slot0.entity:getMO() or not slot1:isPassiveSkill(slot0._curSkillId) then
			GameSceneMgr.instance:getCurScene().level:setFrontVisible(true)
		end

		FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
		FightController.instance:dispatchEvent(FightEvent.SetIsShowFloat, true)
		FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, true)
	end
end

function slot0._setSideRenderOrder(slot0)
	for slot6, slot7 in ipairs(FightHelper.getSideEntitys(slot0.entity:getSide(), true)) do
		slot8 = nil

		if FightEnum.AtkRenderOrderIgnore[FightModel.instance:getFightParam().battleId] and slot9[slot7:getSide()] and tabletool.indexOf(slot10, slot7:getMO().position) then
			slot8 = true
		end

		if not slot8 then
			slot1[slot6] = slot7.id
		end
	end

	for slot7, slot8 in pairs(FightRenderOrderMgr.sortOrder(FightEnum.RenderOrderType.StandPos, slot1)) do
		FightRenderOrderMgr.instance:setOrder(slot7, FightEnum.TopOrderFactor + slot8 - 1)
	end
end

function slot0._cancelSideRenderOrder(slot0)
	for slot5, slot6 in ipairs(FightHelper.getAllEntitys(slot0.entity:getSide())) do
		FightRenderOrderMgr.instance:cancelOrder(slot6.id)
	end

	FightRenderOrderMgr.instance:setSortType(FightEnum.RenderOrderType.StandPos)
end

function slot0._resetTargetHp(slot0)
	for slot4, slot5 in ipairs(slot0._fightStepMO.actEffectMOs) do
		if FightHelper.getEntity(slot5.targetId) and slot6.nameUI then
			slot6.nameUI:resetHp()
		end
	end
end

function slot0._checkFloatRatio1(slot0)
	if not slot0._tlEventContext then
		return
	end

	slot0:_checkFloatTable(slot0._tlEventContext.floatNum, "伤害")
	slot0:_checkFloatTable(slot0._tlEventContext.healFloatNum, "回血")
end

function slot0._checkFloatTable(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if not isDebugBuild then
		return
	end

	if Time.timeScale > 1 then
		return
	end

	if FightModel.instance:getSpeed() > 1.5 then
		return
	end

	for slot6, slot7 in pairs(slot1) do
		for slot11, slot12 in pairs(slot7) do
			if math.abs(slot12.ratio - 1) > 0.0001 then
				slot14 = slot0._skillId2Loader[slot0._curSkillId] and slot13:getFirstAssetItem()

				logError("技能" .. slot2 .. "系数之和为" .. slot12.ratio .. " " .. (slot14 and slot14.ResPath or " url = nil"))
			end

			return
		end
	end
end

return slot0
