module("modules.logic.seasonver.act123.view.Season123CelebrityCardGetViewContainer", package.seeall)

slot0 = class("Season123CelebrityCardGetViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123CelebrityCardGetView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		-- Nothing
	end
end

return slot0
