module("modules.logic.voyage.view.ActivityGiftForTheVoyageContainer", package.seeall)

slot0 = class("ActivityGiftForTheVoyageContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ActivityGiftForTheVoyage.New()
	}
end

return slot0
