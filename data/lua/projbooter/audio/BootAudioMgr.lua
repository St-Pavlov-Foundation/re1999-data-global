module("projbooter.audio.BootAudioMgr", package.seeall)

local var_0_0 = class("BootAudioMgr")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.csharpInst = ZProj.AudioManager.Instance

	arg_2_0.csharpInst:BootInit(arg_2_1, arg_2_2)
end

function var_0_0._onInited(arg_3_0)
	logNormal("BootAudioMgr._onInited -----------")
end

function var_0_0.dispose(arg_4_0)
	arg_4_0.csharpInst:BootDispose()
end

function var_0_0.trigger(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.csharpInst:TriggerEvent(arg_5_1, arg_5_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
