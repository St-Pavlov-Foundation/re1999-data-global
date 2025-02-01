module("modules.logic.season.view.SeasonCelebrityCardTipViewContainer", package.seeall)

slot0 = class("SeasonCelebrityCardTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SeasonCelebrityCardTipView.New()
	}
end

return slot0
