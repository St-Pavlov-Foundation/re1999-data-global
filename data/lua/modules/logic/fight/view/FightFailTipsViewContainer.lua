module("modules.logic.fight.view.FightFailTipsViewContainer", package.seeall)

slot0 = class("FightFailTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightFailTipsView.New()
	}
end

return slot0
