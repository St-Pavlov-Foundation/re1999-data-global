module("modules.logic.battlepass.view.BPSPFaceViewContainer", package.seeall)

local var_0_0 = class("BPSPFaceViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		BPSPFaceView.New()
	}
end

return var_0_0
