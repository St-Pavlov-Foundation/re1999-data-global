module("modules.logic.fight.view.FightFocusCameraAdjustViewContainer", package.seeall)

slot0 = class("FightFocusCameraAdjustViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightFocusCameraAdjustView.New()
	}
end

return slot0
