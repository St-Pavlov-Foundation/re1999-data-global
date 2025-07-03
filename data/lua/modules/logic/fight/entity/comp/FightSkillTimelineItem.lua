module("modules.logic.fight.entity.comp.FightSkillTimelineItem", package.seeall)

local var_0_0 = class("FightSkillTimelineItem", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.workTimelineItem = arg_1_1
	arg_1_0.entity = arg_1_1.entity
	arg_1_0.fightStepData = arg_1_1.fightStepData
	arg_1_0.timelineName = arg_1_1.timelineName
	arg_1_0.timelineUrl = arg_1_1.timelineUrl
	arg_1_0.assetLoader = arg_1_1.assetLoader
	arg_1_0.timelineObj = gohelper.create3d(arg_1_0.entity.go, "_skill_playable")
	arg_1_0.binder = ZProj.PlayableAssetBinder.Get(arg_1_0.timelineObj)
	arg_1_0.trackDic = {}
	arg_1_0.timelineContext = {}
end

function var_0_0.setSameSkillParam(arg_2_0)
	if arg_2_0.entity.skill:sameSkillPlaying() then
		local var_2_0 = arg_2_0.entity.skill.sameSkillParam[arg_2_0.fightStepData.stepUid]

		if not var_2_0 then
			return
		end

		if not var_2_0.startParam then
			return
		end

		local var_2_1 = var_2_0.startParam

		arg_2_0.timelineStartTime = tonumber(var_2_1[1])
		arg_2_0.audioStartTime = tonumber(var_2_1[2])
		arg_2_0.spineStartTime = tonumber(var_2_1[3])
		arg_2_0.spineDelayTime = tonumber(var_2_1[4])
		arg_2_0.timelineStartTime = arg_2_0.timelineStartTime ~= 0 and arg_2_0.timelineStartTime or nil
		arg_2_0.audioStartTime = arg_2_0.audioStartTime ~= 0 and arg_2_0.audioStartTime or nil
		arg_2_0.spineStartTime = arg_2_0.spineStartTime ~= 0 and arg_2_0.spineStartTime or nil
		arg_2_0.spineDelayTime = arg_2_0.spineDelayTime ~= 0 and arg_2_0.spineDelayTime or nil
		arg_2_0.curAnimState = var_2_0.curAnimState
		arg_2_0.audioId = var_2_0.audioId

		if FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill and FightWorkBFSGSkillStart.BeiFangShaoGeUniqueSkill <= 0 then
			arg_2_0.audioId = nil
		end
	end
end

function var_0_0.setTimeScale(arg_3_0, arg_3_1)
	arg_3_0.timeScale = arg_3_1
end

function var_0_0.play(arg_4_0)
	arg_4_0:setSameSkillParam()
	arg_4_0:dealDamageFromLostHp()

	arg_4_0._startTime = Time.time
	arg_4_0.timeScale = arg_4_0.entity.skill.timeScale

	arg_4_0.binder:AddFrameEventCallback(arg_4_0._onFrameEventCallback, arg_4_0)
	arg_4_0.binder:AddEndCallback(arg_4_0._onTimelineEndCallback, arg_4_0)

	arg_4_0.endCallbackFunc = arg_4_0.timelineEndNormalFunc
	arg_4_0.binder.director.enabled = true

	if arg_4_0.timelineStartTime then
		arg_4_0.binder:SetTime(arg_4_0.timelineStartTime)
	end

	if arg_4_0.audioStartTime and arg_4_0.audioId then
		arg_4_0._lock_skill_bgm = true
		arg_4_0.fightStepData.atkAudioId = arg_4_0.audioId

		AudioEffectMgr.instance:playAudio(arg_4_0.audioId)
		AudioEffectMgr.instance:seekMilliSeconds(arg_4_0.audioId, arg_4_0.audioStartTime * 1000)
	end

	arg_4_0.binder:Play(arg_4_0.assetLoader, arg_4_0.timelineUrl)
end

function var_0_0.onUpdate(arg_5_0)
	arg_5_0.binder:Evaluate(arg_5_0.timeScale * Time.deltaTime)
end

function var_0_0._onFrameEventCallback(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	if arg_6_3 then
		arg_6_0:_onFrameEventPlayCallback(arg_6_1, arg_6_2, arg_6_4, arg_6_5)
	else
		arg_6_0:_onFrameEventPauseCallback(arg_6_1, arg_6_2)
	end

	if FightReplayModel.instance:isReplay() then
		FightController.instance:dispatchEvent(FightEvent.ReplayTick)
	end
end

function var_0_0._onFrameEventPlayCallback(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	if arg_7_0._same_skill_after_hit then
		return
	end

	local var_7_0 = cjson.decode(arg_7_4)
	local var_7_1 = FightSkillComp.FrameEventHandlerCls[arg_7_1]

	if var_7_1 then
		if arg_7_1 == 30 and arg_7_0.entity.skill:sameSkillPlaying() then
			return
		end

		if arg_7_0._lock_skill_bgm and arg_7_1 == 10 then
			return
		end

		if arg_7_0.fightStepData.cusParam_lockTimelineTypes and arg_7_0.fightStepData.cusParam_lockTimelineTypes[arg_7_1] then
			return
		end

		local var_7_2 = arg_7_0:newClass(var_7_1, arg_7_2, arg_7_1, arg_7_0.binder, arg_7_0)

		arg_7_0.trackDic[arg_7_2] = var_7_2

		if var_7_2.setContext then
			var_7_2:setContext(arg_7_0.timelineContext)
		end

		local var_7_3 = FightModel.instance:getSpeed()

		arg_7_3 = var_7_3 > 0 and arg_7_3 / var_7_3 or arg_7_3

		var_7_2:onTrackStart(arg_7_0.fightStepData, arg_7_3, var_7_0)
	else
		logError(string.format("%s 帧事件类型未实现: %s", arg_7_0._timelineName or "nil", arg_7_1))
	end
end

function var_0_0.skipSkill(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.trackDic) do
		if iter_8_1.skipSkill then
			iter_8_1:skipSkill()
		end
	end
end

function var_0_0._onTimelineEndCallback(arg_9_0)
	if Time.time - arg_9_0._startTime < arg_9_0.binder:GetDuration() * 0.5 then
		return
	end

	if arg_9_0.finishWork then
		arg_9_0.finishWork:registFinishCallback(arg_9_0.onTimelineEnd, arg_9_0)
		arg_9_0.finishWork:start()
	else
		arg_9_0:onTimelineEnd()
	end
end

function var_0_0.addWork2FinishWork(arg_10_0, arg_10_1)
	if not arg_10_0.finishWork then
		arg_10_0.finishWork = arg_10_0:com_registFlowSequence()
	end

	arg_10_0.finishWork:addWork(arg_10_1)
end

function var_0_0.onTimelineEnd(arg_11_0)
	arg_11_0.endCallbackFunc(arg_11_0)
end

function var_0_0.timelineEndNormalFunc(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.trackDic) do
		if not iter_12_1.signOfInvokedTrackEnd then
			iter_12_1.signOfInvokedTrackEnd = true

			xpcall(iter_12_1.onTrackEnd, __G__TRACKBACK__, iter_12_1)
		end
	end

	arg_12_0.entity.skill:clearSameSkillParam(arg_12_0.fightStepData)
	arg_12_0.workTimelineItem:onTimelineFinish()
end

function var_0_0._sameSkillFlowOneDone(arg_13_0)
	return
end

function var_0_0._onFrameEventPauseCallback(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = true

	if arg_14_0._same_skill_after_hit then
		var_14_0 = false
	end

	if arg_14_0.entity.skill:sameSkillPlaying() then
		if arg_14_1 == 30 then
			var_14_0 = false
		end

		if arg_14_1 ~= 9 or arg_14_0.fightStepData.cus_Param_invokeSpineActTimelineEnd then
			-- block empty
		elseif arg_14_0.entity.skill:isLastWork(arg_14_0.workTimelineItem) then
			-- block empty
		else
			var_14_0 = false
		end
	end

	local var_14_1 = arg_14_0.trackDic[arg_14_2]

	if var_14_1 and var_14_0 and not var_14_1.signOfInvokedTrackEnd then
		var_14_1.signOfInvokedTrackEnd = true

		var_14_1:onTrackEnd()
	end
end

function var_0_0.stopCurTimelineWaitPlaySameSkill(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._same_skill_after_hit = arg_15_1 == 0
	arg_15_0.curAnimState = arg_15_2
	arg_15_0.endCallbackFunc = arg_15_0._sameSkillFlowOneDone

	if gohelper.isNil(arg_15_0.entity.go) then
		return
	end

	FightSkillMgr.instance:afterTimeline(arg_15_0.entity, arg_15_0.fightStepData)
	FightMsgMgr.sendMsg(FightMsgId.PlayTimelineSkillFinish, arg_15_0.entity, arg_15_0.fightStepData.actId, arg_15_0.fightStepData, arg_15_0._timelineName)
	FightController.instance:dispatchEvent(FightEvent.OnSkillPlayFinish, arg_15_0.entity, arg_15_0.fightStepData.actId, arg_15_0.fightStepData, arg_15_0._timelineName)
	FightController.instance:dispatchEvent(FightEvent.ForceEndSkillStep, arg_15_0.fightStepData)
end

function var_0_0.stopSkill(arg_16_0)
	arg_16_0:releaseSelf()
end

function var_0_0.GetDuration(arg_17_0)
	return arg_17_0.binder:GetDuration()
end

function var_0_0.releaseSelf(arg_18_0)
	arg_18_0.binder:RemoveFrameEventCallback()
	arg_18_0.binder:RemoveEndCallback()
	arg_18_0.binder:Stop(true)
	gohelper.destroy(arg_18_0.timelineObj)
end

function var_0_0.dealDamageFromLostHp(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.fightStepData.actEffect) do
		if iter_19_1.effectType == FightEnum.EffectType.DAMAGEFROMLOSTHP then
			arg_19_0.flowForDamageFromLostHp = arg_19_0.flowForDamageFromLostHp or arg_19_0:com_registFlowSequence()

			arg_19_0.flowForDamageFromLostHp:registWork(FightWorkDamageFromLostHp, arg_19_0.fightStepData, iter_19_1)
		end
	end

	if arg_19_0.flowForDamageFromLostHp then
		arg_19_0.flowForDamageFromLostHp:start()
	end
end

return var_0_0
