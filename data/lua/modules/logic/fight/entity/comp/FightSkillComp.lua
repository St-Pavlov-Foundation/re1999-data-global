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
	FightTLEventPlayEffectByOperation,
	FightTLEventEffectVisible,
	[1001] = FightTLEventObjFly,
	[1002] = FightTLEventSetSign
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0.timeScale = 1
	arg_1_0.workComp = FightWorkComponent.New()
	arg_1_0.sameSkillParam = {}
	arg_1_0.sameSkillStartParam = {}
end

function var_0_0.playTimeline(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:registTimelineWork(arg_2_1, arg_2_2)

	if not var_2_0 then
		return
	end

	var_2_0:start()
end

function var_0_0.registTimelineWork(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0.workComp:registWork(FightWorkTimelineItem, arg_3_0.entity, arg_3_1, arg_3_2)
end

function var_0_0.registPlaySkillWork(arg_4_0, arg_4_1, arg_4_2)
	FightHelper.logForPCSkillEditor("++++++++++++++++ entityId_ " .. arg_4_0.entity.id .. " play skill_" .. arg_4_1)

	if arg_4_2 == nil then
		logError("找不到fightStepData, 请检查代码")

		return
	end

	if not lua_skill.configDict[arg_4_1] then
		logError("技能表找不到id:" .. arg_4_1)

		return
	end

	local var_4_0 = arg_4_0.entity:getMO()
	local var_4_1 = var_4_0 and var_4_0.skin

	if arg_4_2 and var_4_0 and arg_4_2.fromId == var_4_0.id then
		var_4_1 = FightHelper.processSkinByStepData(arg_4_2, var_4_0)
	end

	local var_4_2 = FightHelper.detectReplaceTimeline(FightConfig.instance:getSkinSkillTimeline(var_4_1, arg_4_1), arg_4_2)

	return (arg_4_0:registTimelineWork(var_4_2, arg_4_2))
end

function var_0_0.playSkill(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:registPlaySkillWork(arg_5_1, arg_5_2)

	if not var_5_0 then
		return
	end

	var_5_0:start()
end

function var_0_0.skipSkill(arg_6_0)
	local var_6_0 = arg_6_0.workComp.workList

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		if iter_6_1:isAlive() then
			iter_6_1:skipSkill()
		end
	end
end

function var_0_0.stopSkill(arg_7_0)
	local var_7_0 = arg_7_0.workComp.workList

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		iter_7_1:disposeSelf()
	end
end

function var_0_0.isLastWork(arg_8_0, arg_8_1)
	return arg_8_1 == arg_8_0:getLastWork()
end

function var_0_0.getLastWork(arg_9_0)
	local var_9_0 = arg_9_0.workComp.workList

	for iter_9_0 = #var_9_0, 1, -1 do
		local var_9_1 = var_9_0[iter_9_0]

		if var_9_1:isAlive() then
			return var_9_1
		end
	end
end

function var_0_0.getBinder(arg_10_0)
	local var_10_0 = arg_10_0:getLastWork()

	if not var_10_0 then
		return
	end

	return (var_10_0:getBinder())
end

function var_0_0.getCurTimelineDuration(arg_11_0)
	local var_11_0 = arg_11_0:getBinder()

	return var_11_0 and var_11_0:GetDuration() or 0
end

function var_0_0.getCurFrameFloat(arg_12_0)
	local var_12_0 = arg_12_0:getBinder()

	if not var_12_0 then
		return
	end

	return var_12_0.CurFrameFloat
end

function var_0_0.getFrameFloatByTime(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getBinder()

	if not var_13_0 then
		return
	end

	return var_13_0:GetFrameFloatByTime(arg_13_1)
end

function var_0_0.setTimeScale(arg_14_0, arg_14_1)
	arg_14_0.timeScale = arg_14_1

	local var_14_0 = arg_14_0.workComp.workList

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		if iter_14_1:isAlive() then
			iter_14_1:setTimeScale(arg_14_1)
		end
	end
end

function var_0_0.beforeDestroy(arg_15_0)
	arg_15_0:stopSkill()
	arg_15_0.workComp:disposeSelf()

	arg_15_0.workComp = nil
end

function var_0_0.onDestroy(arg_16_0)
	arg_16_0.sameSkillParam = nil
end

function var_0_0.recordSameSkillStartParam(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0.sameSkillStartParam[arg_17_1.stepUid] = arg_17_2
end

function var_0_0.recordFilterAtkEffect(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.sameSkillParam[arg_18_2.stepUid]

	if not var_18_0 then
		var_18_0 = {}
		arg_18_0.sameSkillParam[arg_18_2.stepUid] = var_18_0
	end

	var_18_0.filter_atk_effects = {}

	local var_18_1 = string.split(arg_18_1, "#")

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		var_18_0.filter_atk_effects[iter_18_1] = true
	end
end

function var_0_0.atkEffectNeedFilter(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.sameSkillParam[arg_19_2.stepUid]

	if not var_19_0 then
		return
	end

	if var_19_0.filter_atk_effects and var_19_0.filter_atk_effects[arg_19_1] then
		return true
	end

	return false
end

function var_0_0.recordFilterFlyEffect(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.sameSkillParam[arg_20_2.stepUid]

	if not var_20_0 then
		var_20_0 = {}
		arg_20_0.sameSkillParam[arg_20_2.stepUid] = var_20_0
	end

	var_20_0.filter_fly_effects = {}

	local var_20_1 = string.split(arg_20_1, "#")

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		var_20_0.filter_fly_effects[iter_20_1] = true
	end
end

function var_0_0.flyEffectNeedFilter(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.sameSkillParam[arg_21_2.stepUid]

	if not var_21_0 then
		return
	end

	if var_21_0.filter_fly_effects and var_21_0.filter_fly_effects[arg_21_1] then
		return true
	end

	return false
end

function var_0_0.clearSameSkillParam(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.sameSkillParam[arg_22_1.stepUid]

	if not var_22_0 then
		return
	end

	local var_22_1 = var_22_0.preStepData

	while var_22_1 do
		local var_22_2 = var_22_1

		var_22_1 = arg_22_0.sameSkillParam[var_22_2.stepUid] and arg_22_0.sameSkillParam[var_22_2.stepUid].preStepData
		arg_22_0.sameSkillStartParam[var_22_2.stepUid] = nil
		arg_22_0.sameSkillParam[var_22_2.stepUid] = nil

		local var_22_3 = arg_22_0.workComp.workList

		for iter_22_0, iter_22_1 in ipairs(var_22_3) do
			if iter_22_1:isAlive() and iter_22_1.fightStepData == var_22_2 then
				iter_22_1:onDone(true)
			end
		end
	end

	arg_22_0.sameSkillParam[arg_22_1.stepUid] = nil
end

function var_0_0.stopCurTimelineWaitPlaySameSkill(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4, arg_23_5)
	local var_23_0 = arg_23_0:getLastWork()

	if not var_23_0 then
		return
	end

	local var_23_1 = arg_23_0.sameSkillParam[arg_23_5.stepUid]

	if not var_23_1 then
		var_23_1 = {}
		arg_23_0.sameSkillParam[arg_23_5.stepUid] = var_23_1
	end

	var_23_1.curAnimState = arg_23_2
	var_23_1.audio_id = arg_23_3
	var_23_1.preStepData = arg_23_4
	var_23_1.startParam = arg_23_0.sameSkillStartParam[arg_23_4.stepUid]

	var_23_0.timelineItem:stopCurTimelineWaitPlaySameSkill(arg_23_1, arg_23_2)
end

function var_0_0.sameSkillPlaying(arg_24_0)
	return tabletool.len(arg_24_0.sameSkillParam) > 0
end

return var_0_0
