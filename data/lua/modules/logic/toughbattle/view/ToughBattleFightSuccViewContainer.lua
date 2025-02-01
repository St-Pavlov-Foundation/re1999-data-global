module("modules.logic.toughbattle.view.ToughBattleFightSuccViewContainer", package.seeall)

slot0 = class("ToughBattleFightSuccViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		ToughBattleFightSuccView.New()
	}
end

return slot0
