module("modules.logic.main.view.skininteraction.BaseSkinInteraction", package.seeall)

local var_0_0 = class("BaseSkinInteraction")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._view = arg_1_1
	arg_1_0._skinId = arg_1_2

	arg_1_0:_onInit()
end

function var_0_0.getSkinId(arg_2_0)
	return arg_2_0._skinId
end

function var_0_0.needRespond(arg_3_0)
	return false
end

function var_0_0.canPlay(arg_4_0, arg_4_1)
	return true
end

function var_0_0.isPlayingVoice(arg_5_0)
	return false
end

function var_0_0.beginDrag(arg_6_0)
	return
end

function var_0_0.endDrag(arg_7_0)
	return
end

function var_0_0.onCloseFullView(arg_8_0)
	return
end

function var_0_0._checkPosInBound(arg_9_0, arg_9_1)
	return arg_9_0._view:_checkPosInBound(arg_9_1)
end

function var_0_0._clickDefault(arg_10_0, arg_10_1)
	arg_10_0._view:_clickDefault(arg_10_1)
end

function var_0_0._onInit(arg_11_0)
	return
end

function var_0_0.onClick(arg_12_0, arg_12_1)
	arg_12_0:_onClick(arg_12_1)
end

function var_0_0.beforePlayVoice(arg_13_0, arg_13_1)
	arg_13_0:_beforePlayVoice(arg_13_1)
end

function var_0_0._beforePlayVoice(arg_14_0, arg_14_1)
	return
end

function var_0_0.afterPlayVoice(arg_15_0, arg_15_1)
	arg_15_0:_afterPlayVoice(arg_15_1)
end

function var_0_0._afterPlayVoice(arg_16_0, arg_16_1)
	return
end

function var_0_0.playVoiceFinish(arg_17_0, arg_17_1)
	arg_17_0:_onPlayVoiceFinish(arg_17_1)
end

function var_0_0._onPlayVoiceFinish(arg_18_0, arg_18_1)
	return
end

function var_0_0.playVoice(arg_19_0, arg_19_1)
	arg_19_0._view:playVoice(arg_19_1)
end

function var_0_0.onPlayVoice(arg_20_0, arg_20_1)
	arg_20_0._voiceConfig = arg_20_1

	arg_20_0:_onPlayVoice()
end

function var_0_0._onPlayVoice(arg_21_0)
	return
end

function var_0_0.onStopVoice(arg_22_0)
	arg_22_0:_onStopVoice()
end

function var_0_0._onStopVoice(arg_23_0)
	return
end

function var_0_0._onClick(arg_24_0, arg_24_1)
	return
end

function var_0_0.onDestroy(arg_25_0)
	arg_25_0:_onDestroy()
end

function var_0_0._onDestroy(arg_26_0)
	return
end

return var_0_0
