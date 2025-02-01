module("modules.logic.rouge.view.RougeSettlementViewContainer", package.seeall)

slot0 = class("RougeSettlementViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeSettlementView.New())

	return slot1
end

return slot0
