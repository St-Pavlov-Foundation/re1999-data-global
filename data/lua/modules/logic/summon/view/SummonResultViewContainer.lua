module("modules.logic.summon.view.SummonResultViewContainer", package.seeall)

slot0 = class("SummonResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SummonResultView.New())

	return slot1
end

return slot0
