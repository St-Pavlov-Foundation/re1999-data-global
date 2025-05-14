module("modules.logic.room.view.critter.summon.RoomGetCritterEgg", package.seeall)

local var_0_0 = class("RoomGetCritterEgg", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_1_1)
end

function var_0_0.playIdleAnim(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._animatorPlayer:Play("idle", arg_2_1, arg_2_2)
end

function var_0_0.playOpenAnim(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._animatorPlayer:Play("open", arg_3_1, arg_3_2)
end

return var_0_0
