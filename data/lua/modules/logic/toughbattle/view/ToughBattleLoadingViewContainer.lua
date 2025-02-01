module("modules.logic.toughbattle.view.ToughBattleLoadingViewContainer", package.seeall)

slot0 = class("ToughBattleLoadingViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ToughBattleLoadingView.New()
	}
end

return slot0
