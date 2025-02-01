module("modules.logic.season.view.SeasonCelebrityCardGetlViewContainer", package.seeall)

slot0 = class("SeasonCelebrityCardGetlViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		SeasonCelebrityCardGetlView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
