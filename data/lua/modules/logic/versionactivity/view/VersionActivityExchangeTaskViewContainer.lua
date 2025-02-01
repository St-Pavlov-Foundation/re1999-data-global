module("modules.logic.versionactivity.view.VersionActivityExchangeTaskViewContainer", package.seeall)

slot0 = class("VersionActivityExchangeTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		VersionActivityExchangeTaskView.New()
	}
end

return slot0
