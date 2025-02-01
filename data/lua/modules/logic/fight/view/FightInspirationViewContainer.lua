module("modules.logic.fight.view.FightInspirationViewContainer", package.seeall)

slot0 = class("FightInspirationViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightInspirationView.New()
	}
end

return slot0
