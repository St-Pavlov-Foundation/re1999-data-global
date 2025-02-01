module("modules.logic.scene.view.LoadingBlackViewContainer", package.seeall)

slot0 = class("LoadingBlackViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LoadingBlackView.New()
	}
end

return slot0
