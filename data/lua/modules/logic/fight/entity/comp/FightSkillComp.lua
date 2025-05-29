module("modules.logic.fight.entity.comp.FightSkillComp", package.seeall)

local var_0_0 = class("FightSkillComp", LuaCompBase)

var_0_0.FrameEventHandlerCls = {
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
	FightTLEventSetFightViewPartVisible,
	FightTLEventALFCardEffect,
	[1001] = FightTLEventObjFly
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._timeScale = 1
	arg_1_0._tlEventContext = nil
	arg_1_0._fightStepMO = nil
	arg_1_0._curSkillId = nil
	arg_1_0._loader2SkillId = {}
	arg_1_0._skillId2Loader = {}
	arg_1_0._skillId2TimelineUrl = {}
	arg_1_0._frameEventHandlerPlaying = {}
	arg_1_0._tlAssetItem = nil
end

function var_0_0.getCurTimelineDuration(arg_2_0)
	if arg_2_0._timeline_list then
		return arg_2_0._last_timeline_item:GetDuration()
	end

	return 0
end

function var_0_0.playTimeline(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._fightStepMO = arg_3_2
	arg_3_0._curSkillId = arg_3_0._fightStepMO.actId
	arg_3_0._onceloader = MultiAbLoader.New()
	arg_3_0._timelineName = arg_3_1
	arg_3_0._skillId2TimelineUrl[arg_3_0._curSkillId] = ResUrl.getSkillTimeline(arg_3_1)

	local var_3_0 = FightHelper.getRolesTimelinePath(arg_3_1)

	arg_3_0._onceloader:addPath(var_3_0)
	arg_3_0._onceloader:startLoad(arg_3_0._onLoadOnceTimeline, arg_3_0)
end

function var_0_0._onLoadOnceTimeline(arg_4_0, arg_4_1)
	arg_4_0._tlAssetItem = arg_4_0._onceloader:getFirstAssetItem()

	if arg_4_0._tlAssetItem then
		arg_4_0._timelineName = SLFramework.FileHelper.GetFileName(arg_4_0._skillId2TimelineUrl[arg_4_0._curSkillId], false)

		FightHelper.logForPCSkillEditor("play Timeline " .. arg_4_0._timelineName)
		arg_4_0:_playTimeline()
	else
		arg_4_0._timelineName = nil

		logError("skillId timeline asset not loaded " .. arg_4_0._curSkillId)
	end

	arg_4_0._onceloader:dispose()

	arg_4_0._onceloader = nil
end

function var_0_0.playSkill(arg_5_0, arg_5_1, arg_5_2)
	FightHelper.logForPCSkillEditor("++++++++++++++++ entityId_ " .. arg_5_0.entity.id .. " play skill_" .. arg_5_1)

	if arg_5_2 == nil then
		logError("fightStepMO is nil, skillId = " .. arg_5_1)

		return
	end

	if not lua_skill.configDict[arg_5_1] then
		logError("skill config not exist，id = " .. arg_5_1)

		return
	end

	arg_5_0._tlEventContext = {}
	arg_5_0._curSkillId = arg_5_1
	arg_5_0._fightStepMO = arg_5_2

	local var_5_0 = arg_5_0._skillId2Loader[arg_5_1]

	if var_5_0 then
		var_5_0:dispose()

		arg_5_0._skillId2Loader[arg_5_1] = nil
	end

	arg_5_0:_loadSkillAsset(arg_5_1, arg_5_2)
end

function var_0_0.skipSkill(arg_6_0)
	local var_6_0 = arg_6_0._timeline_list and arg_6_0._timeline_list[1]

	if var_6_0 then
		var_6_0:skipSkill()
		var_6_0:onTimelineEnd()
	end
end

function var_0_0.stopSkill(arg_7_0)
	if arg_7_0._timeline_list then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._timeline_list) do
			iter_7_1:stopSkill()
		end

		arg_7_0._timeline_list = nil

		if arg_7_0._tlAssetItem then
			arg_7_0._tlAssetItem = nil
		end
	end

	arg_7_0._curSkillId = nil
end

function var_0_0.getCurTimelineItem(arg_8_0)
	return arg_8_0._last_timeline_item
end

function var_0_0.getBinder(arg_9_0)
	return arg_9_0._last_timeline_item and arg_9_0._last_timeline_item._binder
end

function var_0_0.getCurFrame(arg_10_0)
	return arg_10_0._last_timeline_item._binder.CurFrame
end

function var_0_0.getCurFrameFloat(arg_11_0)
	return arg_11_0._last_timeline_item._binder.CurFrameFloat
end

function var_0_0.getFrameFloatByTime(arg_12_0, arg_12_1)
	return arg_12_0._last_timeline_item._binder:GetFrameFloatByTime(arg_12_1)
end

function var_0_0.setTimeScale(arg_13_0, arg_13_1)
	arg_13_0._timeScale = arg_13_1

	if arg_13_0._timeline_list then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0._timeline_list) do
			iter_13_1:setTimeScale(arg_13_1)
		end
	end
end

function var_0_0._reallyPlayCurSkill(arg_14_0)
	if arg_14_0._curSkillId then
		arg_14_0._tlAssetItem = arg_14_0._skillId2Loader[arg_14_0._curSkillId]:getFirstAssetItem()

		if arg_14_0._tlAssetItem then
			arg_14_0._timelineName = SLFramework.FileHelper.GetFileName(arg_14_0._skillId2TimelineUrl[arg_14_0._curSkillId], false)

			FightHelper.logForPCSkillEditor("play Timeline " .. arg_14_0._timelineName)
			arg_14_0:_playTimeline()
		else
			arg_14_0._timelineName = nil

			arg_14_0._skillId2Loader[arg_14_0._curSkillId]:dispose()

			arg_14_0._skillId2Loader[arg_14_0._curSkillId] = nil

			logError("skillId timeline asset not loaded " .. arg_14_0._curSkillId)
		end
	else
		arg_14_0._timelineName = nil

		FightHelper.logForPCSkillEditor("_reallyPlayCurSkill fail, self._curSkillId == nil")
	end
end

function var_0_0.clearSkillRes(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._skillId2Loader) do
		iter_15_1:dispose()
	end

	if arg_15_0._onceloader then
		arg_15_0._onceloader:dispose()

		arg_15_0._onceloader = nil
	end

	arg_15_0._skillId2Loader = {}
	arg_15_0._loader2SkillId = {}
end

function var_0_0.onUpdate(arg_16_0)
	if arg_16_0._tlAssetItem and arg_16_0._timeline_list then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._timeline_list) do
			iter_16_1:onUpdate()
		end
	end
end

function var_0_0.beforeDestroy(arg_17_0)
	arg_17_0:stopSkill()
end

function var_0_0.onDestroy(arg_18_0)
	arg_18_0:clearSkillRes()

	arg_18_0._skillId2Loader = nil
	arg_18_0._loader2SkillId = nil
end

function var_0_0._playTimeline(arg_19_0)
	FightHelper.setBossSkillSpeed(arg_19_0.entity.id)
	FightHelper.setTimelineExclusiveSpeed(arg_19_0._timelineName)
	FightModel.instance:updateRTPCSpeed()

	arg_19_0._startTime = Time.time

	arg_19_0:_beforePlayTimeline()

	if not arg_19_0._timeline_list then
		arg_19_0._timeline_list = {}
	end

	local var_19_0 = FightSkillTimelineItem.New()

	var_19_0._timelineName = arg_19_0._timelineName
	var_19_0._timelineUrl = arg_19_0._skillId2TimelineUrl[arg_19_0._curSkillId]
	arg_19_0._last_timeline_item = var_19_0

	local var_19_1 = gohelper.create3d(arg_19_0.entity.go, "_skill_playable")
	local var_19_2 = ZProj.PlayableAssetBinder.Get(var_19_1)

	var_19_0:initLogic(var_19_2, arg_19_0.entity, arg_19_0._fightStepMO)
	table.insert(arg_19_0._timeline_list, var_19_0)

	if arg_19_0:sameSkillPlaying() then
		var_19_0:setParam(arg_19_0._timeline_start_time, arg_19_0._audio_start_time, arg_19_0._spine_start_time, arg_19_0._spine_delay_time, arg_19_0._curAnimState, arg_19_0._audio_id)
	end

	var_19_0:play(arg_19_0._tlAssetItem)
	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkill, arg_19_0.entity, arg_19_0._curSkillId, arg_19_0._fightStepMO, arg_19_0._timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayStart, arg_19_0.entity, arg_19_0._curSkillId, arg_19_0._fightStepMO, arg_19_0._timelineName)
end

function var_0_0.recordSameSkillStartParam(arg_20_0, arg_20_1)
	arg_20_0._timeline_start_time = tonumber(arg_20_1[1])
	arg_20_0._audio_start_time = tonumber(arg_20_1[2])
	arg_20_0._spine_start_time = tonumber(arg_20_1[3])
	arg_20_0._spine_delay_time = tonumber(arg_20_1[4])
	arg_20_0._timeline_start_time = arg_20_0._timeline_start_time ~= 0 and arg_20_0._timeline_start_time or nil
	arg_20_0._audio_start_time = arg_20_0._audio_start_time ~= 0 and arg_20_0._audio_start_time or nil
	arg_20_0._spine_start_time = arg_20_0._spine_start_time ~= 0 and arg_20_0._spine_start_time or nil
	arg_20_0._spine_delay_time = arg_20_0._spine_delay_time ~= 0 and arg_20_0._spine_delay_time or nil
end

function var_0_0.recordFilterAtkEffect(arg_21_0, arg_21_1)
	if not arg_21_0.filter_atk_effects then
		arg_21_0.filter_atk_effects = {}
	end

	local var_21_0 = string.split(arg_21_1, "#")

	for iter_21_0, iter_21_1 in ipairs(var_21_0) do
		arg_21_0.filter_atk_effects[iter_21_1] = true
	end
end

function var_0_0.atkEffectNeedFilter(arg_22_0, arg_22_1)
	if arg_22_0.filter_atk_effects and arg_22_0.filter_atk_effects[arg_22_1] then
		return true
	end

	return false
end

function var_0_0.recordFilterFlyEffect(arg_23_0, arg_23_1)
	if not arg_23_0.filter_fly_effects then
		arg_23_0.filter_fly_effects = {}
	end

	local var_23_0 = string.split(arg_23_1, "#")

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		arg_23_0.filter_fly_effects[iter_23_1] = true
	end
end

function var_0_0.flyEffectNeedFilter(arg_24_0, arg_24_1)
	if arg_24_0.filter_fly_effects and arg_24_0.filter_fly_effects[arg_24_1] then
		return true
	end

	return false
end

function var_0_0.clearSameSkillStartParam(arg_25_0)
	arg_25_0._timeline_start_time = nil
	arg_25_0._audio_start_time = nil
	arg_25_0._spine_start_time = nil
	arg_25_0._spine_delay_time = nil
	arg_25_0._curAnimState = nil
	arg_25_0._audio_id = nil
	arg_25_0.filter_atk_effects = nil
	arg_25_0.filter_fly_effects = nil
end

function var_0_0.stopCurTimelineWaitPlaySameSkill(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0._sign_playing_same_skill = true
	arg_26_0._curAnimState = arg_26_2
	arg_26_0._audio_id = arg_26_3

	arg_26_0._last_timeline_item:stopCurTimelineWaitPlaySameSkill(arg_26_1, arg_26_2)
end

function var_0_0.sameSkillPlaying(arg_27_0)
	return arg_27_0._sign_playing_same_skill
end

function var_0_0._delayEndSkill(arg_28_0)
	CameraMgr.instance:getCameraShake():StopShake()
	FightHelper.cancelBossSkillSpeed()
	FightHelper.cancelExclusiveSpeed()
	FightModel.instance:updateRTPCSpeed()

	arg_28_0._sign_playing_same_skill = nil

	if arg_28_0._timeline_list then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0._timeline_list) do
			iter_28_1:releaseSelf()
		end

		arg_28_0._timeline_list = nil
	end

	local var_28_0 = arg_28_0._curSkillId
	local var_28_1 = arg_28_0._fightStepMO

	arg_28_0._curSkillId = nil
	arg_28_0._fightStepMO = nil

	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkillFinish, arg_28_0.entity, var_28_0, var_28_1, arg_28_0._timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayFinish, arg_28_0.entity, var_28_0, var_28_1, arg_28_0._timelineName)
end

function var_0_0._loadSkillAsset(arg_29_0, arg_29_1, arg_29_2)
	if lua_skill.configDict[arg_29_1] then
		local var_29_0 = arg_29_0.entity:getMO()
		local var_29_1 = var_29_0 and var_29_0.skin

		if arg_29_2 and var_29_0 and arg_29_2.fromId == var_29_0.id then
			var_29_1 = FightHelper.processSkinByStepMO(arg_29_2, var_29_0)
		end

		local var_29_2 = FightHelper.detectReplaceTimeline(FightConfig.instance:getSkinSkillTimeline(var_29_1, arg_29_1), arg_29_0._fightStepMO)
		local var_29_3 = MultiAbLoader.New()

		arg_29_0._skillId2Loader[arg_29_1] = var_29_3
		arg_29_0._loader2SkillId[var_29_3] = arg_29_1
		arg_29_0._skillId2TimelineUrl[arg_29_1] = ResUrl.getSkillTimeline(var_29_2)

		local var_29_4 = FightHelper.getRolesTimelinePath(var_29_2)

		var_29_3:addPath(var_29_4)
		var_29_3:setLoadFailCallback(arg_29_0._delayEndSkill, arg_29_0)
		var_29_3:startLoad(arg_29_0._onLoadSkillTimelineFinish, arg_29_0)
	else
		logError("skill not exist: " .. arg_29_1)
	end
end

function var_0_0._onLoadSkillTimelineFinish(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0._loader2SkillId[arg_30_1]

	if arg_30_0._curSkillId and var_30_0 and arg_30_0._curSkillId == var_30_0 then
		arg_30_0:_reallyPlayCurSkill()
	else
		FightHelper.logForPCSkillEditor("skill loaded, but skill has stop")
	end
end

function var_0_0._beforePlayTimeline(arg_31_0)
	arg_31_0:_setSideRenderOrder()

	if arg_31_0.entity.buff then
		arg_31_0.entity.buff:hideLoopEffects("before_skill_timeline")
	end

	for iter_31_0, iter_31_1 in pairs(FightHelper.hideDefenderBuffEffect(arg_31_0._fightStepMO, "before_skill_timeline")) do
		arg_31_0._hide_defenders_buff_effect = arg_31_0._hide_defenders_buff_effect or {}

		table.insert(arg_31_0._hide_defenders_buff_effect, iter_31_1)
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		if not arg_31_0._sign_playing_same_skill then
			FightFloatMgr.instance:removeInterval()
		end

		local var_31_0 = arg_31_0.entity:getMO()

		if var_31_0 and var_31_0:isPassiveSkill(arg_31_0._curSkillId) then
			-- block empty
		else
			GameSceneMgr.instance:getCurScene().level:setFrontVisible(false)
		end
	end

	FightSkillMgr.instance:beforeTimeline(arg_31_0.entity, arg_31_0._fightStepMO)
end

function var_0_0._afterPlayTimeline(arg_32_0)
	arg_32_0._sign_playing_same_skill = nil

	FightSkillMgr.instance:afterTimeline(arg_32_0.entity, arg_32_0._fightStepMO)
	arg_32_0:_resetTargetHp()

	if arg_32_0._timeline_list then
		for iter_32_0, iter_32_1 in ipairs(arg_32_0._timeline_list) do
			arg_32_0:_checkFloatTable(iter_32_1._tlEventContext.floatNum, "伤害")
			arg_32_0:_checkFloatTable(iter_32_1._tlEventContext.healFloatNum, "回血")
		end
	end

	if arg_32_0.entity.buff then
		arg_32_0.entity.buff:showBuffEffects("before_skill_timeline")
	end

	if arg_32_0._hide_defenders_buff_effect then
		FightHelper.revertDefenderBuffEffect(arg_32_0._hide_defenders_buff_effect, "before_skill_timeline")

		arg_32_0._hide_defenders_buff_effect = nil
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		FightFloatMgr.instance:resetInterval()
		arg_32_0:_cancelSideRenderOrder()
		GameSceneMgr.instance:getCurScene().camera:enablePostProcessSmooth(false)

		if arg_32_0._fightStepMO.hasPlayTimelineCamera then
			GameSceneMgr.instance:getCurScene().camera:resetParam()
		end

		GameSceneMgr.instance:getCurScene().entityMgr.enableSpineRotate = true

		local var_32_0 = arg_32_0.entity:getMO()

		if var_32_0 and var_32_0:isPassiveSkill(arg_32_0._curSkillId) then
			-- block empty
		else
			GameSceneMgr.instance:getCurScene().level:setFrontVisible(true)
		end

		FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, true)
		FightController.instance:dispatchEvent(FightEvent.SetIsShowFloat, true)
		FightController.instance:dispatchEvent(FightEvent.SetIsShowNameUI, true)
	end
end

function var_0_0._setSideRenderOrder(arg_33_0)
	local var_33_0 = FightHelper.getSideEntitys(arg_33_0.entity:getSide(), true)
	local var_33_1 = FightModel.instance:getFightParam().battleId

	for iter_33_0, iter_33_1 in ipairs(var_33_0) do
		local var_33_2
		local var_33_3 = FightEnum.AtkRenderOrderIgnore[var_33_1]

		if var_33_3 then
			local var_33_4 = var_33_3[iter_33_1:getSide()]

			if var_33_4 and tabletool.indexOf(var_33_4, iter_33_1:getMO().position) then
				var_33_2 = true
			end
		end

		if not var_33_2 then
			var_33_0[iter_33_0] = iter_33_1.id
		end
	end

	local var_33_5 = FightRenderOrderMgr.sortOrder(FightEnum.RenderOrderType.StandPos, var_33_0)

	for iter_33_2, iter_33_3 in pairs(var_33_5) do
		FightRenderOrderMgr.instance:setOrder(iter_33_2, FightEnum.TopOrderFactor + iter_33_3 - 1)
	end
end

function var_0_0._cancelSideRenderOrder(arg_34_0)
	local var_34_0 = FightHelper.getAllEntitys(arg_34_0.entity:getSide())

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		FightRenderOrderMgr.instance:cancelOrder(iter_34_1.id)
	end

	FightRenderOrderMgr.instance:setSortType(FightEnum.RenderOrderType.StandPos)
end

function var_0_0._resetTargetHp(arg_35_0)
	for iter_35_0, iter_35_1 in ipairs(arg_35_0._fightStepMO.actEffectMOs) do
		local var_35_0 = FightHelper.getEntity(iter_35_1.targetId)

		if var_35_0 and var_35_0.nameUI then
			var_35_0.nameUI:resetHp()
		end
	end
end

function var_0_0._checkFloatRatio1(arg_36_0)
	if not arg_36_0._tlEventContext then
		return
	end

	arg_36_0:_checkFloatTable(arg_36_0._tlEventContext.floatNum, "伤害")
	arg_36_0:_checkFloatTable(arg_36_0._tlEventContext.healFloatNum, "回血")
end

function var_0_0._checkFloatTable(arg_37_0, arg_37_1, arg_37_2)
	if not arg_37_1 then
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

	for iter_37_0, iter_37_1 in pairs(arg_37_1) do
		for iter_37_2, iter_37_3 in pairs(iter_37_1) do
			if math.abs(iter_37_3.ratio - 1) > 0.0001 then
				local var_37_0 = arg_37_0._skillId2Loader[arg_37_0._curSkillId]
				local var_37_1 = var_37_0 and var_37_0:getFirstAssetItem()
				local var_37_2 = var_37_1 and var_37_1.ResPath or " url = nil"

				logError("技能" .. arg_37_2 .. "系数之和为" .. iter_37_3.ratio .. " " .. var_37_2)
			end

			return
		end
	end
end

return var_0_0
