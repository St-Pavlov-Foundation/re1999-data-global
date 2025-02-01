module("modules.logic.dragonboat.view.DragonBoatFestivalViewContainer", package.seeall)

slot0 = class("DragonBoatFestivalViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		DragonBoatFestivalView.New()
	}
end

return slot0
