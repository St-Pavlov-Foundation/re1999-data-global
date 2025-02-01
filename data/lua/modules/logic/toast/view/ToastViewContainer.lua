module("modules.logic.toast.view.ToastViewContainer", package.seeall)

slot0 = class("ToastViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ToastView.New()
	}
end

return slot0
