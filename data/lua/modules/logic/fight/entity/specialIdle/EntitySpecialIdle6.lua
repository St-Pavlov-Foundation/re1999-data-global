module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle6", package.seeall)

local var_0_0 = class("EntitySpecialIdle6", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)

	arg_1_0._entity = arg_1_1
end

function var_0_0._onSkillPlayFinish(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = FightHelper.getEntity(arg_2_3.toId)

	if var_2_0 and var_2_0:isMySide() then
		local var_2_1 = var_2_0:getMO()

		if var_2_1 and var_2_1.modelId == 3025 then
			for iter_2_0, iter_2_1 in ipairs(arg_2_3.actEffect) do
				if iter_2_1.effectType == FightEnum.EffectType.MISS and iter_2_1.targetId == var_2_0.id then
					local var_2_2 = var_2_1:getBuffDic()

					for iter_2_2, iter_2_3 in pairs(var_2_2) do
						if iter_2_3.buffId == 710601 or iter_2_3.buffId == 710602 then
							FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, var_2_0.id)

							return
						end
					end
				end
			end
		end
	end
end

function var_0_0.releaseSelf(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)

	arg_3_0._entity = nil

	arg_3_0:__onDispose()
end

return var_0_0
