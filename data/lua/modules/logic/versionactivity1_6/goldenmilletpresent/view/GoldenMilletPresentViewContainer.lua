module("modules.logic.versionactivity1_6.goldenmilletpresent.view.GoldenMilletPresentViewContainer", package.seeall)

slot0 = class("GoldenMilletPresentViewContainer", BaseViewContainer)
slot0.ExclusiveView = {
	DisplayView = 2,
	ReceiveView = 1
}

function slot0.buildViews(slot0)
	slot0.goldenMilletPresentView = GoldenMilletPresentView.New()

	return {
		slot0.goldenMilletPresentView
	}
end

function slot0.openGoldMilletPresentDisplayView(slot0)
	slot0.goldenMilletPresentView:switchExclusiveView(true)
end

return slot0
