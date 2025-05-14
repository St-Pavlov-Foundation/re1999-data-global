module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle9", package.seeall)

local var_0_0 = class("EntitySpecialIdle9", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()
	FightController.instance:registerCallback(FightEvent.OnMySideRoundEnd, arg_1_0._onMySideRoundEnd, arg_1_0)

	arg_1_0._entity = arg_1_1
end

function var_0_0._onMySideRoundEnd(arg_2_0)
	FightController.instance:dispatchEvent(FightEvent.PlaySpecialIdle, arg_2_0._entity.id)
end

function var_0_0.releaseSelf(arg_3_0)
	FightController.instance:unregisterCallback(FightEvent.OnMySideRoundEnd, arg_3_0._onMySideRoundEnd, arg_3_0)

	arg_3_0._entity = nil

	arg_3_0:__onDispose()
end

return var_0_0
