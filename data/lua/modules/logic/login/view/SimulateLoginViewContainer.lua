module("modules.logic.login.view.SimulateLoginViewContainer", package.seeall)

slot0 = class("SimulateLoginViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SimulateLoginView.New()
	}
end

return slot0
