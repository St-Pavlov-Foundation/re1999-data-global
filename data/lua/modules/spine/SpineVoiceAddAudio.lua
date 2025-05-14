module("modules.spine.SpineVoiceAddAudio", package.seeall)

local var_0_0 = class("SpineVoiceAddAudio")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._audioId = arg_2_1

	if arg_2_2 < 0.1 then
		arg_2_0:_playAddAudio()

		return
	end

	TaskDispatcher.runDelay(arg_2_0._playAddAudio, arg_2_0, arg_2_2)
end

function var_0_0._playAddAudio(arg_3_0)
	if arg_3_0._audioId and arg_3_0._audioId > 0 then
		AudioMgr.instance:trigger(arg_3_0._audioId)
	end
end

function var_0_0.onDestroy(arg_4_0)
	if arg_4_0._audioId and arg_4_0._audioId > 0 then
		AudioMgr.instance:stopPlayingID(arg_4_0._audioId)
	end

	arg_4_0._audioId = nil

	TaskDispatcher.cancelTask(arg_4_0._playAddAudio, arg_4_0)
end

return var_0_0
