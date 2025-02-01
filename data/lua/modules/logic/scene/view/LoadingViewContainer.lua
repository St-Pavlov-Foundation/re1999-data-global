module("modules.logic.scene.view.LoadingViewContainer", package.seeall)

slot0 = class("LoadingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LoadingView.New()
	}
end

return slot0
