module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle4", package.seeall)

local var_0_0 = class("EntitySpecialIdle4", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)

	arg_1_0._entity = arg_1_1
end

function var_0_0._onSkillPlayFinish(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1.id ~= arg_2_0._entity.id then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_3.actEffect) do
		if iter_2_1.effectType == FightEnum.EffectType.EXPOINTCHANGE and iter_2_1.configEffect ~= 0 then
			FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, arg_2_1.id)

			break
		end
	end
end

function var_0_0.releaseSelf(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)

	arg_3_0._entity = nil

	arg_3_0:__onDispose()
end

return var_0_0
