module("modules.logic.video.view.FullScreenVideoViewContainer", package.seeall)

local var_0_0 = class("FullScreenVideoViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		FullScreenVideoView.New()
	}
end

return var_0_0
