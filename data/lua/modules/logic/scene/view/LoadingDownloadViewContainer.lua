module("modules.logic.scene.view.LoadingDownloadViewContainer", package.seeall)

local var_0_0 = class("LoadingDownloadViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		LoadingDownloadView.New()
	}
end

return var_0_0
