module("modules.logic.season.view1_2.Season1_2CelebrityCardTipViewContainer", package.seeall)

slot0 = class("Season1_2CelebrityCardTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_2CelebrityCardTipView.New()
	}
end

return slot0
