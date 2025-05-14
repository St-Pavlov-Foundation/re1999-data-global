module("modules.logic.fight.entity.comp.FightSkillTimelineItem", package.seeall)

local var_0_0 = class("FightSkillTimelineItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
end

function var_0_0.initLogic(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._binder = arg_2_1
	arg_2_0._entity = arg_2_2
	arg_2_0._fightStepMO = arg_2_3
end

function var_0_0.setParam(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	arg_3_0._time_start_time = arg_3_1
	arg_3_0._audio_start_time = arg_3_2
	arg_3_0._spine_start_time = arg_3_3
	arg_3_0._spine_delay_time = arg_3_4
	arg_3_0._curAnimState = arg_3_5
	arg_3_0._audio_id = arg_3_6

	if FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill and FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill <= 0 then
		arg_3_0._audio_id = nil
	end
end

function var_0_0.setTimeScale(arg_4_0, arg_4_1)
	arg_4_0._timeScale = arg_4_1
end

function var_0_0.play(arg_5_0, arg_5_1)
	arg_5_0:releaseFlow()

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._fightStepMO.actEffectMOs) do
		if iter_5_1.effectType == FightEnum.EffectType.DAMAGEFROMLOSTHP then
			arg_5_0._flow = arg_5_0._flow or FlowSequence.New()

			arg_5_0._flow:addWork(FightWork2Work.New(FightWorkDamageFromLostHp, arg_5_0._fightStepMO, iter_5_1))
		end
	end

	if arg_5_0._flow then
		arg_5_0._flow:start()
	end

	arg_5_0._startTime = Time.time
	arg_5_0._timeScale = arg_5_0._entity.skill._timeScale
	arg_5_0._frameEventHandlerPlaying = {}
	arg_5_0._tlEventContext = {}

	arg_5_0._binder:AddFrameEventCallback(arg_5_0._onFrameEventCallback, arg_5_0)
	arg_5_0._binder:AddEndCallback(arg_5_0._onTimelineEndCallback, arg_5_0)

	arg_5_0._binder.director.enabled = true

	if arg_5_0._time_start_time then
		arg_5_0._binder:SetTime(arg_5_0._time_start_time)
	end

	if arg_5_0._audio_start_time and arg_5_0._audio_id then
		arg_5_0._lock_skill_bgm = true
		arg_5_0._fightStepMO.atkAudioId = arg_5_0._audio_id

		AudioEffectMgr.instance:playAudio(arg_5_0._audio_id)
		AudioEffectMgr.instance:seekMilliSeconds(arg_5_0._audio_id, arg_5_0._audio_start_time * 1000)
	end

	arg_5_0._binder:Play(arg_5_1, arg_5_0._timelineUrl)
end

function var_0_0.onUpdate(arg_6_0)
	arg_6_0._binder:Evaluate(arg_6_0._timeScale * Time.deltaTime)
end

function var_0_0._onFrameEventCallback(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	if arg_7_3 then
		arg_7_0:_onFrameEventPlayCallback(arg_7_1, arg_7_2, arg_7_4, arg_7_5)
	else
		arg_7_0:_onFrameEventPauseCallback(arg_7_1, arg_7_2)
	end

	if FightReplayModel.instance:isReplay() then
		FightController.instance:dispatchEvent(FightEvent.ReplayTick)
	end
end

function var_0_0._onFrameEventPlayCallback(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	if arg_8_0._same_skill_after_hit then
		return
	end

	local var_8_0 = cjson.decode(arg_8_4)
	local var_8_1 = FightSkillComp.FrameEventHandlerCls[arg_8_1]

	if var_8_1 then
		if arg_8_1 == 30 and arg_8_0._entity.skill._sign_playing_same_skill then
			return
		end

		if arg_8_0._lock_skill_bgm and arg_8_1 == 10 then
			return
		end

		if arg_8_0._fightStepMO.cusParam_lockTimelineTypes and arg_8_0._fightStepMO.cusParam_lockTimelineTypes[arg_8_1] then
			return
		end

		local var_8_2 = FightTLEventPool.getHandlerInst(arg_8_1, var_8_1)

		if var_8_2 then
			var_8_2.id = arg_8_2
			var_8_2._binder = arg_8_0._binder
			var_8_2._timeline_item = arg_8_0
			arg_8_0._frameEventHandlerPlaying[arg_8_2] = var_8_2
			var_0_0.handler = var_0_0.handler or {}
			var_0_0.handler[arg_8_0._entity.id] = var_0_0.handler[arg_8_0._entity.id] or 0
			var_0_0.handler[arg_8_0._entity.id] = var_0_0.handler[arg_8_0._entity.id] + 1

			if var_8_2.setContext then
				var_8_2:setContext(arg_8_0._tlEventContext)
			end

			local var_8_3 = arg_8_0._fightStepMO

			if var_8_2.beforeSkillEvent then
				var_8_2:beforeSkillEvent(var_8_3, arg_8_3, var_8_0)
			end

			local var_8_4 = FightModel.instance:getSpeed()

			arg_8_3 = var_8_4 > 0 and arg_8_3 / var_8_4 or arg_8_3

			var_8_2:handleSkillEvent(var_8_3, arg_8_3, var_8_0)
		end
	else
		logError(string.format("%s 帧事件类型未实现: %s", arg_8_0._timelineName or "nil", arg_8_1))
	end
end

function var_0_0.skipSkill(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._frameEventHandlerPlaying) do
		if iter_9_1.skipSkill then
			iter_9_1:skipSkill()
		end
	end
end

function var_0_0._onTimelineEndCallback(arg_10_0)
	if Time.time - arg_10_0._startTime < arg_10_0._binder:GetDuration() * 0.5 then
		return
	end

	arg_10_0:onTimelineEnd()
end

function var_0_0.onTimelineEnd(arg_11_0)
	arg_11_0._entity.skill:clearSameSkillStartParam()

	arg_11_0._sign_playing_same_skill = false

	arg_11_0._binder:RemoveFrameEventCallback()
	arg_11_0._binder:RemoveEndCallback()

	local var_11_0 = tabletool.copy(arg_11_0._frameEventHandlerPlaying)

	arg_11_0._frameEventHandlerPlaying = {}

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		if iter_11_1.onSkillEnd then
			iter_11_1:onSkillEnd()
		end

		iter_11_1._binder = nil
		iter_11_1._timeline_item = nil

		FightTLEventPool.putHandlerInst(iter_11_1)

		var_0_0.handler[arg_11_0._entity.id] = var_0_0.handler[arg_11_0._entity.id] - 1
	end

	if gohelper.isNil(arg_11_0._entity.go) then
		return
	end

	arg_11_0._entity.skill:_afterPlayTimeline()
	FightHelper.logForPCSkillEditor("---------------- entityId_ " .. arg_11_0._entity.id .. " end skill_" .. (arg_11_0._curSkillId or "nil"))
	arg_11_0._entity.skill:_delayEndSkill()
end

function var_0_0._onFrameEventPauseCallback(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._same_skill_after_hit then
		return
	end

	if arg_12_0._sign_playing_same_skill then
		if arg_12_1 == 30 then
			return
		end

		if arg_12_1 ~= 9 or arg_12_0._fightStepMO.cus_Param_invokeSpineActTimelineEnd then
			-- block empty
		elseif arg_12_0 == arg_12_0._entity.skill:getCurTimelineItem() then
			-- block empty
		else
			return
		end
	end

	local var_12_0 = arg_12_0._frameEventHandlerPlaying[arg_12_2]

	if var_12_0 and var_12_0.handleSkillEventEnd then
		var_12_0:handleSkillEventEnd()
	end
end

function var_0_0.stopCurTimelineWaitPlaySameSkill(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._sign_playing_same_skill = true
	arg_13_0._same_skill_after_hit = arg_13_1 == 0
	arg_13_0._curAnimState = arg_13_2

	arg_13_0._binder:RemoveEndCallback()

	if arg_13_0._same_skill_after_hit then
		arg_13_0:_sameSkillFlowOneDone()
	else
		arg_13_0._binder:AddEndCallback(arg_13_0._sameSkillFlowOneDone, arg_13_0)
	end

	if gohelper.isNil(arg_13_0._entity.go) then
		return
	end

	FightSkillMgr.instance:afterTimeline(arg_13_0._entity, arg_13_0._fightStepMO)

	if arg_13_0._same_skill_after_hit then
		FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkillFinish, arg_13_0._entity, arg_13_0._fightStepMO.actId, arg_13_0._fightStepMO, arg_13_0._timelineName)
		FightController.instance:dispatchEvent(FightEvent.OnSkillPlayFinish, arg_13_0._entity, arg_13_0._fightStepMO.actId, arg_13_0._fightStepMO, arg_13_0._timelineName)
	end

	FightController.instance:dispatchEvent(FightEvent.ForceEndSkillStep, arg_13_0._fightStepMO)
end

function var_0_0._sameSkillFlowOneDone(arg_14_0)
	arg_14_0:onSkillEnd({
		30,
		9
	})

	if not arg_14_0._same_skill_after_hit then
		FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkillFinish, arg_14_0._entity, arg_14_0._fightStepMO.actId, arg_14_0._fightStepMO, arg_14_0._timelineName)
		FightController.instance:dispatchEvent(FightEvent.OnSkillPlayFinish, arg_14_0._entity, arg_14_0._fightStepMO.actId, arg_14_0._fightStepMO, arg_14_0._timelineName)
	end
end

function var_0_0.stopSkill(arg_15_0)
	arg_15_0:releaseSelf()
end

function var_0_0.onSkillEnd(arg_16_0, arg_16_1)
	local var_16_0 = tabletool.copy(arg_16_0._frameEventHandlerPlaying)

	for iter_16_0, iter_16_1 in pairs(var_16_0) do
		local var_16_1 = false

		if arg_16_1 then
			for iter_16_2, iter_16_3 in ipairs(arg_16_1) do
				if iter_16_1.type == iter_16_3 then
					var_16_1 = true

					break
				end
			end
		end

		if not var_16_1 then
			if iter_16_1.onSkillEnd then
				iter_16_1:onSkillEnd()
			end

			iter_16_1._binder = nil
			iter_16_1._timeline_item = nil

			FightTLEventPool.putHandlerInst(iter_16_1)

			arg_16_0._frameEventHandlerPlaying[iter_16_1.id] = nil
			var_0_0.handler[arg_16_0._entity.id] = var_0_0.handler[arg_16_0._entity.id] - 1
		end
	end
end

function var_0_0.GetDuration(arg_17_0)
	return arg_17_0._binder:GetDuration()
end

function var_0_0.releaseFlow(arg_18_0)
	if arg_18_0._flow then
		arg_18_0._flow:stop()

		arg_18_0._flow = nil
	end
end

function var_0_0.releaseSelf(arg_19_0)
	arg_19_0:onSkillEnd()
	arg_19_0._binder:RemoveFrameEventCallback()
	arg_19_0._binder:RemoveEndCallback()
	arg_19_0._binder:Stop(true)
	gohelper.destroy(arg_19_0._binder.gameObject)

	arg_19_0._entity = nil

	arg_19_0:__onDispose()
end

return var_0_0
