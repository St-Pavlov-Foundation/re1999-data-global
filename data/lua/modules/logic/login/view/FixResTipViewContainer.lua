module("modules.logic.login.view.FixResTipViewContainer", package.seeall)

slot0 = class("FixResTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FixResTipView.New()
	}
end

return slot0
