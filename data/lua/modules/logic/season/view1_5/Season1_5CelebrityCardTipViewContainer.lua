module("modules.logic.season.view1_5.Season1_5CelebrityCardTipViewContainer", package.seeall)

slot0 = class("Season1_5CelebrityCardTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_5CelebrityCardTipView.New()
	}
end

return slot0
