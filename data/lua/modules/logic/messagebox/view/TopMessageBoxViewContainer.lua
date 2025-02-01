module("modules.logic.messagebox.view.TopMessageBoxViewContainer", package.seeall)

slot0 = class("TopMessageBoxViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		MessageBoxView.New()
	}
end

return slot0
