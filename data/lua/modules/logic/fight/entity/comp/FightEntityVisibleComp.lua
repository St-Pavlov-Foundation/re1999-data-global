module("modules.logic.fight.entity.comp.FightEntityVisibleComp", package.seeall)

local var_0_0 = class("FightEntityVisibleComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.entity = arg_1_1
	arg_1_0._hideByEntity = nil
	arg_1_0._hideBySkill = nil

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)
	FightController.instance:registerCallback(FightEvent.SetEntityVisibleByTimeline, arg_1_0._setEntityVisibleByTimeline, arg_1_0)
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.beforeDestroy(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_3_0._onSkillPlayStart, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.SetEntityVisibleByTimeline, arg_3_0._setEntityVisibleByTimeline, arg_3_0)
end

function var_0_0._onSkillPlayStart(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_2 == FightEnum.AppearTimelineSkillId then
		return
	end

	if FightHelper.getRelativeEntityIdDict(arg_4_3)[arg_4_0.entity.id] then
		arg_4_0.entity:setAlpha(1, 0)

		arg_4_0._hideByEntity = nil
		arg_4_0._hideBySkill = nil
	end
end

function var_0_0._onSkillPlayFinish(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1.skill and arg_5_1.skill:sameSkillPlaying() then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.SetEntityFootEffectVisible, arg_5_0.entity.id, true)

	if FightWorkStepChangeHero.playingChangeHero or FightWorkChangeHero.playingChangeHero then
		return
	end

	if not FightSkillMgr.instance:isPlayingAnyTimeline() then
		arg_5_0.entity:setAlpha(1, 0)

		arg_5_0._hideByEntity = nil
		arg_5_0._hideBySkill = nil
	elseif arg_5_0._hideByEntity and arg_5_0._hideByEntity == arg_5_1.id and arg_5_0._hideBySkill == arg_5_2 then
		arg_5_0.entity:setAlpha(1, 0)

		arg_5_0._hideByEntity = nil
		arg_5_0._hideBySkill = nil
	elseif arg_5_3.stepUid == FightTLEventEntityVisible.latestStepUid then
		arg_5_0.entity:setAlpha(1, 0)

		arg_5_0._hideByEntity = nil
		arg_5_0._hideBySkill = nil
	end
end

function var_0_0._setEntityVisibleByTimeline(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
	if arg_6_0.entity.id ~= arg_6_1.id then
		return
	end

	if arg_6_3 then
		arg_6_0.entity:setAlpha(1, arg_6_4)

		arg_6_0._hideByEntity = nil
		arg_6_0._hideBySkill = nil
	else
		arg_6_0.entity:setAlpha(0, arg_6_4)

		arg_6_0._hideByEntity = arg_6_1.id
		arg_6_0._hideBySkill = arg_6_2.actId
	end

	if not arg_6_3 then
		FightFloatMgr.instance:hideEntityEquipFloat(arg_6_1.id)
	end

	if not FightCardDataHelper.isBigSkill(arg_6_2.actId) then
		FightController.instance:dispatchEvent(FightEvent.SetEntityFootEffectVisible, arg_6_1.id, arg_6_3)
	end
end

return var_0_0
