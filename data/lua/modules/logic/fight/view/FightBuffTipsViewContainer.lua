module("modules.logic.fight.view.FightBuffTipsViewContainer", package.seeall)

slot0 = class("FightBuffTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightBuffTipsView.New()
	}
end

return slot0
