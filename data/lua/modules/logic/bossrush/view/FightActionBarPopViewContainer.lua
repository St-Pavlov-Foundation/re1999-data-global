module("modules.logic.bossrush.view.FightActionBarPopViewContainer", package.seeall)

slot0 = class("FightActionBarPopViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		FightActionBarPopView.New()
	}
end

return slot0
