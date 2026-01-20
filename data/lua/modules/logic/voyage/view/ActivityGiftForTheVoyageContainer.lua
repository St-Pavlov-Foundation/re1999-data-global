-- chunkname: @modules/logic/voyage/view/ActivityGiftForTheVoyageContainer.lua

module("modules.logic.voyage.view.ActivityGiftForTheVoyageContainer", package.seeall)

local ActivityGiftForTheVoyageContainer = class("ActivityGiftForTheVoyageContainer", BaseViewContainer)

function ActivityGiftForTheVoyageContainer:buildViews()
	return {
		ActivityGiftForTheVoyage.New()
	}
end

return ActivityGiftForTheVoyageContainer
