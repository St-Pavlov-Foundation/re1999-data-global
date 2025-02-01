module("modules.logic.dragonboat.view.DragonBoatFestivalActivityViewContainer", package.seeall)

slot0 = class("DragonBoatFestivalActivityViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		DragonBoatFestivalActivityView.New()
	}
end

return slot0
