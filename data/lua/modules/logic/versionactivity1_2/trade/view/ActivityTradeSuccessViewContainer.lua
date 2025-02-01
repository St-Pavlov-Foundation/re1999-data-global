module("modules.logic.versionactivity1_2.trade.view.ActivityTradeSuccessViewContainer", package.seeall)

slot0 = class("ActivityTradeSuccessViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, ActivityTradeSuccessView.New())

	return slot1
end

return slot0
