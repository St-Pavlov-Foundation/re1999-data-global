module("modules.logic.scene.view.LoadingRoomView", package.seeall)

local var_0_0 = class("LoadingRoomView", LoadingBlackView)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_amb_home_mist)
end

return var_0_0
