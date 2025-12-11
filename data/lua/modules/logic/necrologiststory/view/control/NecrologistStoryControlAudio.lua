module("modules.logic.necrologiststory.view.control.NecrologistStoryControlAudio", package.seeall)

local var_0_0 = class("NecrologistStoryControlAudio", NecrologistStoryControlMgrItem)

function var_0_0.onPlayControl(arg_1_0)
	if not arg_1_0.isSkip then
		arg_1_0:playAudio()
	end

	arg_1_0:onPlayControlFinish()
end

function var_0_0.playAudio(arg_2_0)
	local var_2_0 = string.split(arg_2_0.controlParam, "#")
	local var_2_1 = tonumber(var_2_0[2]) or 1
	local var_2_2 = tonumber(var_2_0[3]) or 0
	local var_2_3 = tonumber(var_2_0[4]) or 0
	local var_2_4 = AudioParam.New()

	var_2_4.loopNum = 1
	var_2_4.fadeInTime = var_2_2
	var_2_4.fadeOutTime = var_2_3
	var_2_4.volume = var_2_1 * 100
	arg_2_0.audioId = tonumber(var_2_0[1])

	if arg_2_0.audioId then
		AudioEffectMgr.instance:playAudio(arg_2_0.audioId, var_2_4)
	end
end

function var_0_0.onDestory(arg_3_0)
	if arg_3_0.audioId then
		AudioEffectMgr.instance:stopAudio(arg_3_0.audioId)
	end

	var_0_0.super.onDestory(arg_3_0)
end

return var_0_0
