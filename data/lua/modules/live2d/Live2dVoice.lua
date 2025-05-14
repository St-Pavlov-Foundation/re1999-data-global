module("modules.live2d.Live2dVoice", package.seeall)

local var_0_0 = class("Live2dVoice", SpineVoice)

function var_0_0._init(arg_1_0)
	arg_1_0._normalVoiceMouth = arg_1_0:_addComponent(Live2dVoiceMouth, true)
	arg_1_0._spineVoiceMouth = arg_1_0._normalVoiceMouth
	arg_1_0._voiceFace = arg_1_0:_addComponent(Live2dVoiceFace, true)
end

function var_0_0.getMouth(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getVoiceLang()

	if var_2_0 == "zh" then
		return arg_2_1.mouth
	else
		return arg_2_1[var_2_0 .. "mouth"] or arg_2_1.mouth
	end
end

function var_0_0._initSpineVoiceMouth(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:getMouth(arg_3_1)

	arg_3_0._useAutoMouth = string.find(var_3_0, Live2dVoiceMouthAuto.AutoActionName)

	local var_3_1 = arg_3_0._spineVoiceMouth

	if arg_3_0._useAutoMouth then
		arg_3_0._autoVoiceMouth = arg_3_0._autoVoiceMouth or Live2dVoiceMouthAuto.New()
		arg_3_0._spineVoiceMouth = arg_3_0._autoVoiceMouth
	else
		arg_3_0._spineVoiceMouth = arg_3_0._normalVoiceMouth
	end

	if var_3_1 and var_3_1 ~= arg_3_0._spineVoiceMouth then
		var_3_1:suspend()
	end

	arg_3_0._spineVoiceMouth:init(arg_3_0, arg_3_1, arg_3_2)
end

function var_0_0.onSpineVoiceAudioStop(arg_4_0)
	arg_4_0._spineVoiceText:onVoiceStop()

	if arg_4_0._useAutoMouth then
		arg_4_0._spineVoiceMouth:onVoiceStop()
	end

	arg_4_0:_doCallback()
end

function var_0_0.playVoice(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	arg_5_0._spine = arg_5_1

	arg_5_1:setParameterStoreEnabled(true)

	if arg_5_0:getInStory() then
		arg_5_0._spine:setAlwaysFade(true)
	end

	var_0_0.super.playVoice(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
end

function var_0_0._onComponentStop(arg_6_0, arg_6_1)
	if arg_6_1 == arg_6_0._spineVoiceBody and arg_6_0._spine and arg_6_0:getInStory() then
		arg_6_0._spine:setAlwaysFade(false)
	end

	var_0_0.super._onComponentStop(arg_6_0, arg_6_1)
end

function var_0_0.playing(arg_7_0)
	if arg_7_0._spineVoiceMouth._setComponentStop then
		return var_0_0.super.playing(arg_7_0)
	end

	if arg_7_0._useAutoMouth then
		return not (arg_7_0._stopVoiceCount >= arg_7_0._componentStopVoiceCount - 1)
	end

	return not (arg_7_0._stopVoiceCount >= arg_7_0._componentStopVoiceCount - 1) or not arg_7_0._spineVoiceMouth._playLastOne
end

function var_0_0.onDestroy(arg_8_0)
	if arg_8_0._normalVoiceMouth then
		arg_8_0._normalVoiceMouth:onDestroy()

		arg_8_0._normalVoiceMouth = nil
	end

	if arg_8_0._autoVoiceMouth then
		arg_8_0._autoVoiceMouth:onDestroy()

		arg_8_0._autoVoiceMouth = nil
	end

	arg_8_0._spineVoiceMouth = nil

	var_0_0.super.onDestroy(arg_8_0)
end

return var_0_0
