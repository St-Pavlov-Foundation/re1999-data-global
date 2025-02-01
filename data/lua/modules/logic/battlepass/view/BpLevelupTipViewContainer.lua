module("modules.logic.battlepass.view.BpLevelupTipViewContainer", package.seeall)

slot0 = class("BpLevelupTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BpLevelupTipView.New()
	}
end

return slot0
