module("modules.logic.versionactivity1_2.jiexika.view.Activity114PhotoViewContainer", package.seeall)

slot0 = class("Activity114PhotoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Activity114PhotoView.New("#go_photos", true),
		TabViewGroup.New(1, "#go_btns")
	}
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		})
	}
end

return slot0
