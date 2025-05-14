module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle10", package.seeall)

local var_0_0 = class("EntitySpecialIdle10", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._entity = arg_1_1
end

function var_0_0.releaseSelf(arg_2_0)
	arg_2_0._entity = nil

	arg_2_0:__onDispose()
end

return var_0_0
