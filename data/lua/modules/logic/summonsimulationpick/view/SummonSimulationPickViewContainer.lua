module("modules.logic.summonsimulationpick.view.SummonSimulationPickViewContainer", package.seeall)

slot0 = class("SummonSimulationPickViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SummonSimulationPickView.New())

	return slot1
end

return slot0
