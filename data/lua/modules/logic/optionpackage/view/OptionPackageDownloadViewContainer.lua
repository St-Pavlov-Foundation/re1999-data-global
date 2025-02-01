module("modules.logic.optionpackage.view.OptionPackageDownloadViewContainer", package.seeall)

slot0 = class("OptionPackageDownloadViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		OptionPackageDownloadView.New()
	}
end

return slot0
