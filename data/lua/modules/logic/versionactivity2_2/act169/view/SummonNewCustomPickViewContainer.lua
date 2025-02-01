module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickViewContainer", package.seeall)

slot0 = class("SummonNewCustomPickViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SummonNewCustomPickView.New())

	return slot1
end

return slot0
