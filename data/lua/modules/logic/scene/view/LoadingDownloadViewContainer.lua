module("modules.logic.scene.view.LoadingDownloadViewContainer", package.seeall)

slot0 = class("LoadingDownloadViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LoadingDownloadView.New()
	}
end

return slot0
