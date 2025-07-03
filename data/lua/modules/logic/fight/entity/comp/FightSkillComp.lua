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
	[1001] = FightTLEventObjFly
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
	local var_6_0 = arg_6_0.workComp:getAliveWorkList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		iter_6_1:skipSkill()
	end
end

function var_0_0.stopSkill(arg_7_0)
	local var_7_0 = arg_7_0.workComp:getAliveWorkList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		iter_7_1:disposeSelf()
	end
end

function var_0_0.isLastWork(arg_8_0, arg_8_1)
	return arg_8_1 == arg_8_0:getLastWork()
end

function var_0_0.getLastWork(arg_9_0)
	local var_9_0 = arg_9_0.workComp:getAliveWorkList()

	return var_9_0[#var_9_0]
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

	local var_14_0 = arg_14_0.workComp:getAliveWorkList()

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		iter_14_1:setTimeScale(arg_14_1)
	end
end

function var_0_0.onUpdate(arg_15_0)
	if not arg_15_0.workComp then
		return
	end

	local var_15_0 = arg_15_0.workComp:getAliveWorkList()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		iter_15_1:onUpdate()
	end
end

function var_0_0.beforeDestroy(arg_16_0)
	arg_16_0:stopSkill()
	arg_16_0.workComp:disposeSelf()

	arg_16_0.workComp = nil
end

function var_0_0.onDestroy(arg_17_0)
	arg_17_0.sameSkillParam = nil
end

function var_0_0.recordSameSkillStartParam(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.sameSkillStartParam[arg_18_1.stepUid] = arg_18_2
end

function var_0_0.recordFilterAtkEffect(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.sameSkillParam[arg_19_2.stepUid]

	if not var_19_0 then
		var_19_0 = {}
		arg_19_0.sameSkillParam[arg_19_2.stepUid] = var_19_0
	end

	var_19_0.filter_atk_effects = {}

	local var_19_1 = string.split(arg_19_1, "#")

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		var_19_0.filter_atk_effects[iter_19_1] = true
	end
end

function var_0_0.atkEffectNeedFilter(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.sameSkillParam[arg_20_2.stepUid]

	if not var_20_0 then
		return
	end

	if var_20_0.filter_atk_effects and var_20_0.filter_atk_effects[arg_20_1] then
		return true
	end

	return false
end

function var_0_0.recordFilterFlyEffect(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = arg_21_0.sameSkillParam[arg_21_2.stepUid]

	if not var_21_0 then
		var_21_0 = {}
		arg_21_0.sameSkillParam[arg_21_2.stepUid] = var_21_0
	end

	var_21_0.filter_fly_effects = {}

	local var_21_1 = string.split(arg_21_1, "#")

	for iter_21_0, iter_21_1 in ipairs(var_21_1) do
		var_21_0.filter_fly_effects[iter_21_1] = true
	end
end

function var_0_0.flyEffectNeedFilter(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_0.sameSkillParam[arg_22_2.stepUid]

	if not var_22_0 then
		return
	end

	if var_22_0.filter_fly_effects and var_22_0.filter_fly_effects[arg_22_1] then
		return true
	end

	return false
end

function var_0_0.clearSameSkillParam(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.sameSkillParam[arg_23_1.stepUid]

	if not var_23_0 then
		return
	end

	local var_23_1 = var_23_0.preStepData

	while var_23_1 do
		local var_23_2 = var_23_1

		var_23_1 = arg_23_0.sameSkillParam[var_23_2.stepUid] and arg_23_0.sameSkillParam[var_23_2.stepUid].preStepData
		arg_23_0.sameSkillStartParam[var_23_2.stepUid] = nil
		arg_23_0.sameSkillParam[var_23_2.stepUid] = nil

		local var_23_3 = arg_23_0.workComp:getAliveWorkList()

		for iter_23_0, iter_23_1 in ipairs(var_23_3) do
			if iter_23_1.fightStepData == var_23_2 then
				iter_23_1:onDone(true)
			end
		end
	end

	arg_23_0.sameSkillParam[arg_23_1.stepUid] = nil
end

function var_0_0.stopCurTimelineWaitPlaySameSkill(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	local var_24_0 = arg_24_0:getLastWork()

	if not var_24_0 then
		return
	end

	local var_24_1 = arg_24_0.sameSkillParam[arg_24_5.stepUid]

	if not var_24_1 then
		var_24_1 = {}
		arg_24_0.sameSkillParam[arg_24_5.stepUid] = var_24_1
	end

	var_24_1.curAnimState = arg_24_2
	var_24_1.audio_id = arg_24_3
	var_24_1.preStepData = arg_24_4
	var_24_1.startParam = arg_24_0.sameSkillStartParam[arg_24_4.stepUid]

	var_24_0.timelineItem:stopCurTimelineWaitPlaySameSkill(arg_24_1, arg_24_2)
end

function var_0_0.sameSkillPlaying(arg_25_0)
	return tabletool.len(arg_25_0.sameSkillParam) > 0
end

return var_0_0
