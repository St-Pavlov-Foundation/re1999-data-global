module("modules.logic.season.view1_3.Season1_3CelebrityCardTipViewContainer", package.seeall)

slot0 = class("Season1_3CelebrityCardTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_3CelebrityCardTipView.New()
	}
end

return slot0
