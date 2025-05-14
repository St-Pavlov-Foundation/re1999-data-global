module("modules.audio.bgm.AudioBgmData", package.seeall)

local var_0_0 = class("AudioBgmData")

function var_0_0.ctor(arg_1_0)
	arg_1_0.layer = nil

	arg_1_0:clear()
end

function var_0_0.clear(arg_2_0)
	arg_2_0.playId = 0
	arg_2_0.stopId = 0
	arg_2_0.pauseId = nil
	arg_2_0.resumeId = nil
	arg_2_0.switchGroup = nil
	arg_2_0.switchState = nil
end

function var_0_0.setSwitch(arg_3_0)
	if arg_3_0.switchGroup and arg_3_0.switchState then
		AudioMgr.instance:setSwitch(AudioMgr.instance:getIdFromString(arg_3_0.switchGroup), AudioMgr.instance:getIdFromString(arg_3_0.switchState))
	end
end

return var_0_0
