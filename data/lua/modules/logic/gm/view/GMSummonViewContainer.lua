module("modules.logic.gm.view.GMSummonViewContainer", package.seeall)

slot0 = class("GMSummonViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, GMSummonView.New())

	return slot1
end

return slot0
