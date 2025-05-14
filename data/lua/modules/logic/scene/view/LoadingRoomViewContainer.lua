module("modules.logic.scene.view.LoadingRoomViewContainer", package.seeall)

local var_0_0 = class("LoadingRoomViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LoadingRoomView.New()
	}
end

function var_0_0.playCloseTransition(arg_2_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	var_0_0.super.playCloseTransition(arg_2_0)
end

function var_0_0.onPlayCloseTransitionFinish(arg_3_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	var_0_0.super.onPlayCloseTransitionFinish(arg_3_0)
end

return var_0_0
