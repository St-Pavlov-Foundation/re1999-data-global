module("modules.logic.fight.view.FightFailViewContainer", package.seeall)

slot0 = class("FightFailViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightFailView.New()
	}
end

return slot0
