module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle1", package.seeall)

local var_0_0 = class("EntitySpecialIdle1", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)

	arg_1_0._entity = arg_1_1
end

function var_0_0.detectState(arg_2_0)
	local var_2_0 = arg_2_0._entity:getMO()

	if var_2_0 then
		local var_2_1 = var_2_0:getBuffDic()

		if var_2_1 then
			for iter_2_0, iter_2_1 in pairs(var_2_1) do
				if iter_2_1.buffId == 30513 or iter_2_1.buffId == 30515 then
					FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, arg_2_0._entity.id)
				end
			end
		end
	end
end

function var_0_0._onBuffUpdate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 ~= arg_3_0._entity.id then
		return
	end

	if arg_3_2 == FightEnum.EffectType.BUFFADD and (arg_3_3 == 30513 or arg_3_3 == 30515) then
		FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, arg_3_0._entity.id)
	end
end

function var_0_0.releaseSelf(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_4_0._onBuffUpdate, arg_4_0)

	arg_4_0._entity = nil

	arg_4_0:__onDispose()
end

return var_0_0
