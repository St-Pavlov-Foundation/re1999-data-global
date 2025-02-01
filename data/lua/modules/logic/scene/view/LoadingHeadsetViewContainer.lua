module("modules.logic.scene.view.LoadingHeadsetViewContainer", package.seeall)

slot0 = class("LoadingHeadsetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LoadingHeadsetView.New()
	}
end

return slot0
