module("modules.logic.necrologiststory.view.control.NecrologistStoryControlStopAudio", package.seeall)

local var_0_0 = class("NecrologistStoryControlStopAudio", NecrologistStoryControlMgrItem)

function var_0_0.onPlayControl(arg_1_0)
	arg_1_0:stopAudio()
	arg_1_0:onPlayControlFinish()
end

function var_0_0.stopAudio(arg_2_0)
	local var_2_0 = string.split(arg_2_0.controlParam, "#")
	local var_2_1 = tonumber(var_2_0[2]) or 0
	local var_2_2 = tonumber(var_2_0[1])

	if var_2_2 then
		AudioEffectMgr.instance:stopAudio(var_2_2, var_2_1)
	end
end

return var_0_0
