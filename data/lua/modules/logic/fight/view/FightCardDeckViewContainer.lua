module("modules.logic.fight.view.FightCardDeckViewContainer", package.seeall)

slot0 = class("FightCardDeckViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightCardDeckView.New()
	}
end

return slot0
