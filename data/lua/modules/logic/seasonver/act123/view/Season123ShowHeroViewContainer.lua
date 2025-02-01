module("modules.logic.seasonver.act123.view.Season123ShowHeroViewContainer", package.seeall)

slot0 = class("Season123ShowHeroViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123CheckCloseView.New(),
		Season123ShowHeroView.New()
	}
end

return slot0
