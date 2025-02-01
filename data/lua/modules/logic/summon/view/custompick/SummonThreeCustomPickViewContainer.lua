module("modules.logic.summon.view.custompick.SummonThreeCustomPickViewContainer", package.seeall)

slot0 = class("SummonThreeCustomPickViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SummonThreeCustomPickView.New())

	return slot1
end

return slot0
