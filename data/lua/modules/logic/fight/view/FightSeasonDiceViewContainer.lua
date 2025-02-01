module("modules.logic.fight.view.FightSeasonDiceViewContainer", package.seeall)

slot0 = class("FightSeasonDiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightSeasonDiceView.New()
	}
end

return slot0
