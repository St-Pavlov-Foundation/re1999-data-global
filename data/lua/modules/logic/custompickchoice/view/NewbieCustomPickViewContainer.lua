module("modules.logic.custompickchoice.view.NewbieCustomPickViewContainer", package.seeall)

slot0 = class("NewbieCustomPickViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, NewbieCustomPickView.New())

	return slot1
end

return slot0
