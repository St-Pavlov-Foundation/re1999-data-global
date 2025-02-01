module("modules.logic.battlepass.view.BpBonusSelectViewContainer", package.seeall)

slot0 = class("BpBonusSelectViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BpBonusSelectView.New()
	}
end

return slot0
