module("modules.logic.fight.view.FightDiceViewContainer", package.seeall)

slot0 = class("FightDiceViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightDiceView.New()
	}
end

return slot0
