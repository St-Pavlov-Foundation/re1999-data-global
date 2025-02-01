module("modules.logic.investigate.view.InvestigateTipsViewContainer", package.seeall)

slot0 = class("InvestigateTipsViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, InvestigateTipsView.New())

	return slot1
end

return slot0
