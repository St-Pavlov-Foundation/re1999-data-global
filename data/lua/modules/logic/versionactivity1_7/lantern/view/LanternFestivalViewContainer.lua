module("modules.logic.versionactivity1_7.lantern.view.LanternFestivalViewContainer", package.seeall)

slot0 = class("LanternFestivalViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		LanternFestivalView.New()
	}
end

return slot0
