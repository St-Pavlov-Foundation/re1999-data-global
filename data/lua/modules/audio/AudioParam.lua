module("modules.audio.AudioParam", package.seeall)

local var_0_0 = class("AudioParam")

function var_0_0.ctor(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.clear(arg_2_0)
	arg_2_0.loopNum = nil
	arg_2_0.fadeInTime = nil
	arg_2_0.fadeOutTime = nil
	arg_2_0.volume = nil
	arg_2_0.callback = nil
	arg_2_0.callbackTarget = nil
end

return var_0_0
