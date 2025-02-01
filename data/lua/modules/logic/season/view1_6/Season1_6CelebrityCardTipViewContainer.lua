module("modules.logic.season.view1_6.Season1_6CelebrityCardTipViewContainer", package.seeall)

slot0 = class("Season1_6CelebrityCardTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_6CelebrityCardTipView.New()
	}
end

return slot0
