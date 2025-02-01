module("modules.logic.fight.view.FightCardDeckGMViewContainer", package.seeall)

slot0 = class("FightCardDeckGMViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightCardDeckGMView.New()
	}
end

return slot0
