module("modules.logic.fight.view.FightRoundViewContainer", package.seeall)

slot0 = class("FightRoundViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightRoundView.New()
	}
end

return slot0
