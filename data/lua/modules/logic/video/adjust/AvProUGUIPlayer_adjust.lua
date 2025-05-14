module("modules.logic.video.adjust.AvProUGUIPlayer_adjust", package.seeall)

local var_0_0 = class("AvProUGUIPlayer_adjust")

function var_0_0.Play(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0._cb = arg_1_4
	arg_1_0._cbObj = arg_1_5

	TaskDispatcher.runDelay(arg_1_0._finishedPlaying, arg_1_0, 2)
end

function var_0_0._finishedPlaying(arg_2_0)
	if arg_2_0._cb then
		arg_2_0._cb(arg_2_0._cbObj, "", AvProEnum.PlayerStatus.FinishedPlaying, 0)
	end
end

function var_0_0.AddDisplayUGUI(arg_3_0)
	return
end

function var_0_0.SetEventListener(arg_4_0)
	return
end

function var_0_0.LoadMedia(arg_5_0)
	return
end

function var_0_0.Stop(arg_6_0)
	return
end

function var_0_0.Clear(arg_7_0)
	arg_7_0._cb = nil
	arg_7_0._cbObj = nil

	TaskDispatcher.cancelTask(arg_7_0._finishedPlaying)
end

function var_0_0.IsPlaying(arg_8_0)
	return false
end

function var_0_0.CanPlay(arg_9_0)
	return false
end

function var_0_0.Rewind(arg_10_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
