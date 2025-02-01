module("modules.logic.fight.view.FightLoadingViewContainer", package.seeall)

slot0 = class("FightLoadingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightLoadingView.New()
	}
end

return slot0
