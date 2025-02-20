module("modules.logic.seasonver.act123.view2_3.Season123_2_3ShowHeroViewContainer", package.seeall)

slot0 = class("Season123_2_3ShowHeroViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3ShowHeroView.New()
	}
end

return slot0
