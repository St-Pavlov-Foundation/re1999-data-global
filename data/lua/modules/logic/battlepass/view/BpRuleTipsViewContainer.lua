module("modules.logic.battlepass.view.BpRuleTipsViewContainer", package.seeall)

slot0 = class("BpRuleTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		BpRuleTipsView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
