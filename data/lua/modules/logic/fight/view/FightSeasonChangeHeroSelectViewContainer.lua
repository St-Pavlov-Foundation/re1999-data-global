module("modules.logic.fight.view.FightSeasonChangeHeroSelectViewContainer", package.seeall)

slot0 = class("FightSeasonChangeHeroSelectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightSeasonChangeHeroSelectView.New()
	}
end

return slot0
