module("modules.logic.fight.view.FightCardDescViewContainer", package.seeall)

slot0 = class("FightCardDescViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightCardDescView.New()
	}
end

return slot0
