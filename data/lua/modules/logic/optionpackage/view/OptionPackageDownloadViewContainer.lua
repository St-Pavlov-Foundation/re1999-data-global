module("modules.logic.optionpackage.view.OptionPackageDownloadViewContainer", package.seeall)

local var_0_0 = class("OptionPackageDownloadViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		OptionPackageDownloadView.New()
	}
end

return var_0_0
