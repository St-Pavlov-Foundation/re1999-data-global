module("modules.logic.fight.entity.comp.skill.FightTLEventInvokeEntityDead", package.seeall)

local var_0_0 = class("FightTLEventInvokeEntityDead", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	for iter_1_0, iter_1_1 in ipairs(arg_1_1.actEffect) do
		if iter_1_1.effectType == FightEnum.EffectType.DEAD then
			FightController.instance:dispatchEvent(FightEvent.InvokeEntityDeadImmediately, iter_1_1.targetId, arg_1_1)
		end
	end
end

function var_0_0.onTrackEnd(arg_2_0)
	return
end

function var_0_0.onDestructor(arg_3_0)
	return
end

return var_0_0
