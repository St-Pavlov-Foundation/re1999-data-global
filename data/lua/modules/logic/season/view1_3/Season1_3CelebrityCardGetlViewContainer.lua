module("modules.logic.season.view1_3.Season1_3CelebrityCardGetlViewContainer", package.seeall)

slot0 = class("Season1_3CelebrityCardGetlViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season1_3CelebrityCardGetlView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
