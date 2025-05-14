module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle5", package.seeall)

local var_0_0 = class("EntitySpecialIdle5", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)

	arg_1_0._entity = arg_1_1
end

function var_0_0._onSkillPlayFinish(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1.id ~= arg_2_0._entity.id then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._entity:getMO().skillGroup2) do
		if arg_2_2 == iter_2_1 then
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
