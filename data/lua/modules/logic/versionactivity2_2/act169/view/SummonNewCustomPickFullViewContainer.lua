module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickFullViewContainer", package.seeall)

slot0 = class("SummonNewCustomPickFullViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SummonNewCustomPickFullView.New())

	return slot1
end

return slot0
