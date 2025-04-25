module("modules.logic.versionactivity2_5.goldenmilletpresent.view.V2a5_GoldenMilletPresentViewContainer", package.seeall)

slot0 = class("V2a5_GoldenMilletPresentViewContainer", BaseViewContainer)
slot0.ExclusiveView = {
	DisplayView = 2,
	ReceiveView = 1
}

function slot0.buildViews(slot0)
	slot0.goldenMilletPresentView = V2a5_GoldenMilletPresentView.New()

	return {
		slot0.goldenMilletPresentView
	}
end

function slot0.openGoldMilletPresentDisplayView(slot0)
	slot0.goldenMilletPresentView:switchExclusiveView(true)
end

return slot0
