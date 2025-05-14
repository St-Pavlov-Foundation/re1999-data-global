module("modules.logic.battlepass.view.BPFaceViewContainer", package.seeall)

local var_0_0 = class("BPFaceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		BPFaceView.New()
	}
end

return var_0_0
