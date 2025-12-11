module("modules.logic.survival.controller.work.AnimatorWork", package.seeall)

local var_0_0 = class("AnimatorWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.player = SLFramework.AnimatorPlayer.Get(arg_1_1.go)
	arg_1_0.animName = arg_1_1.animName
end

function var_0_0.onStart(arg_2_0)
	arg_2_0.player:Play(arg_2_0.animName, arg_2_0.onPlayFinish, arg_2_0)
end

function var_0_0.onPlayFinish(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.onDestroy(arg_4_0)
	arg_4_0.player = nil
end

return var_0_0
