module("modules.live2d.Live2dVoiceMouth", package.seeall)

local var_0_0 = class("Live2dVoiceMouth", SpineVoiceMouth)

function var_0_0.removeTaskActions(arg_1_0)
	var_0_0.super.removeTaskActions(arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._delayPlayMouthActionList, arg_1_0)
end

function var_0_0._checkPlayMouthActionList(arg_2_0, arg_2_1)
	TaskDispatcher.cancelTask(arg_2_0._delayPlayMouthActionList, arg_2_0)

	arg_2_0._mouthConfig = arg_2_1

	if arg_2_0._stopTime and Time.time - arg_2_0._stopTime < 0.1 then
		TaskDispatcher.runDelay(arg_2_0._delayPlayMouthActionList, arg_2_0, 0.1 - (Time.time - arg_2_0._stopTime))

		return
	end

	arg_2_0:_playMouthActionList(arg_2_1)
end

function var_0_0._delayPlayMouthActionList(arg_3_0)
	arg_3_0:_playMouthActionList(arg_3_0._mouthConfig)
end

function var_0_0.stopMouthCallback(arg_4_0, arg_4_1)
	arg_4_0:stopMouth()
end

function var_0_0._setBiZui(arg_5_0)
	if arg_5_0._isVoiceStop and arg_5_0._pauseMouth and arg_5_0._pauseMouth ~= arg_5_0._spine:getCurMouth() then
		arg_5_0._curMouth = "t_" .. arg_5_0._pauseMouth
		arg_5_0._pauseMouth = nil

		arg_5_0._spine:setMouthAnimation(arg_5_0._curMouth, false, 0)

		return
	end

	if arg_5_0._spine:hasAnimation(StoryAnimName.T_BiZui) then
		arg_5_0._curMouth = StoryAnimName.T_BiZui

		arg_5_0._spine:setMouthAnimation(arg_5_0._curMouth, true, 0)
	else
		logError("no animation:t_bizui")
	end
end

function var_0_0.onVoiceStop(arg_6_0)
	arg_6_0._isVoiceStop = true
	arg_6_0._stopTime = Time.time

	arg_6_0:stopMouth()
	arg_6_0:removeTaskActions()

	arg_6_0._isVoiceStop = false
end

function var_0_0.suspend(arg_7_0)
	arg_7_0:removeTaskActions()
end

return var_0_0
