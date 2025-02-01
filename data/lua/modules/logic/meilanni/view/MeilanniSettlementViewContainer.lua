module("modules.logic.meilanni.view.MeilanniSettlementViewContainer", package.seeall)

slot0 = class("MeilanniSettlementViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, MeilanniSettlementView.New())

	return slot1
end

return slot0
