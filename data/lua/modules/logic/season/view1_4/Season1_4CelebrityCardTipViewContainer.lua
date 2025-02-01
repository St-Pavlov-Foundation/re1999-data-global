module("modules.logic.season.view1_4.Season1_4CelebrityCardTipViewContainer", package.seeall)

slot0 = class("Season1_4CelebrityCardTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_4CelebrityCardTipView.New()
	}
end

return slot0
