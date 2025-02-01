module("modules.logic.rouge.dlc.101.view.RougeLimiterResultViewContainer", package.seeall)

slot0 = class("RougeLimiterResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeLimiterResultView.New())

	return slot1
end

return slot0
