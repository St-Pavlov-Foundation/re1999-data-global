module("modules.logic.messagebox.view.MessageBoxViewContainer", package.seeall)

slot0 = class("MessageBoxViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		MessageBoxView.New()
	}
end

return slot0
