module("modules.logic.fight.view.FightWaveChangeViewContainer", package.seeall)

slot0 = class("FightWaveChangeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightWaveChangeView.New()
	}
end

return slot0
