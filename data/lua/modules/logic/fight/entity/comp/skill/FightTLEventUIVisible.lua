module("modules.logic.fight.entity.comp.skill.FightTLEventUIVisible", package.seeall)

local var_0_0 = class("FightTLEventUIVisible", FightTimelineTrackItem)
local var_0_1
local var_0_2 = {
	[FightEnum.EffectType.DAMAGEFROMABSORB] = true,
	[FightEnum.EffectType.STORAGEINJURY] = true,
	[FightEnum.EffectType.SHIELDVALUECHANGE] = true,
	[FightEnum.EffectType.SHAREHURT] = true
}

function var_0_0.resetLatestStepUid()
	var_0_1 = nil
end

function var_0_0.onTrackStart(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if var_0_1 and arg_2_1.stepUid < var_0_1 then
		return
	end

	var_0_1 = arg_2_1.stepUid
	arg_2_0.fightStepData = arg_2_1
	arg_2_0._isShowUI = arg_2_3[1] == "1" and true or false
	arg_2_0._isShowFloat = arg_2_3[2] == "1" and true or false
	arg_2_0._isShowNameUI = arg_2_3[3] == "1" and true or false
	arg_2_0._showNameUITarget = arg_2_3[4] and tonumber(arg_2_3[4]) or 0

	local var_2_0 = FightHelper.getEntity(arg_2_1.fromId)
	local var_2_1 = FightHelper.getEntity(arg_2_1.toId)

	arg_2_0._entitys = nil

	if arg_2_0._showNameUITarget == 0 then
		arg_2_0._entitys = FightHelper.getAllEntitys()
	elseif arg_2_0._showNameUITarget == 1 then
		arg_2_0._entitys = {}

		table.insert(arg_2_0._entitys, var_2_0)
	elseif arg_2_0._showNameUITarget == 2 then
		arg_2_0._entitys = FightHelper.getSkillTargetEntitys(arg_2_1, var_0_2)
	elseif arg_2_0._showNameUITarget == 3 then
		if var_2_0 then
			arg_2_0._entitys = FightHelper.getSideEntitys(var_2_0:getSide(), true)
		end
	elseif arg_2_0._showNameUITarget == 4 and var_2_1 then
		arg_2_0._entitys = FightHelper.getSideEntitys(var_2_1:getSide(), true)
	end

	arg_2_0:_setShowUI()
	TaskDispatcher.runRepeat(arg_2_0._setShowUI, arg_2_0, 0.5)
	FightController.instance:registerCallback(FightEvent.ParallelPlayNextSkillDoneThis, arg_2_0._onDoneThis, arg_2_0)
	FightController.instance:registerCallback(FightEvent.ForceEndSkillStep, arg_2_0._onDoneThis, arg_2_0)
end

function var_0_0.onTrackEnd(arg_3_0)
	arg_3_0:_removeEvent()
end

function var_0_0._setShowUI(arg_4_0)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, arg_4_0._isShowUI)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowFloat, arg_4_0._isShowFloat)

	if arg_4_0._entitys then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._entitys) do
			FightController.instance:dispatchEvent(FightEvent.SetNameUIVisibleByTimeline, iter_4_1, arg_4_0.fightStepData, arg_4_0._isShowNameUI)
		end
	end
end

function var_0_0._onDoneThis(arg_5_0, arg_5_1)
	if arg_5_1 == arg_5_0.fightStepData then
		arg_5_0:_removeEvent()
	end
end

function var_0_0._removeEvent(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._setShowUI, arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.ParallelPlayNextSkillDoneThis, arg_6_0._onDoneThis, arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.ForceEndSkillStep, arg_6_0._onDoneThis, arg_6_0)
end

function var_0_0.onDestructor(arg_7_0)
	arg_7_0._entitys = nil

	arg_7_0:_removeEvent()
end

return var_0_0
