module("modules.logic.limited.view.LimitedRoleViewContainer", package.seeall)

slot0 = class("LimitedRoleViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LimitedRoleView.New()
	}
end

return slot0
