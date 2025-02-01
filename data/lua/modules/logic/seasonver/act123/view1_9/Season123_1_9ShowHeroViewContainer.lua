module("modules.logic.seasonver.act123.view1_9.Season123_1_9ShowHeroViewContainer", package.seeall)

slot0 = class("Season123_1_9ShowHeroViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9ShowHeroView.New()
	}
end

return slot0
