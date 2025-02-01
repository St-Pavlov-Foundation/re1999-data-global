module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalActivityViewContainer", package.seeall)

slot0 = class("LanternFestivalActivityViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LanternFestivalActivityView.New()
	}
end

return slot0
