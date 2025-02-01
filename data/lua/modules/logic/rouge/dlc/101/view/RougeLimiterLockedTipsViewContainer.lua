module("modules.logic.rouge.dlc.101.view.RougeLimiterLockedTipsViewContainer", package.seeall)

slot0 = class("RougeLimiterLockedTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeLimiterLockedTipsView.New())

	return slot1
end

return slot0
