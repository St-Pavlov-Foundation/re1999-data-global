module("modules.logic.store.view.optionalcharge.OptionalChargeViewContainer", package.seeall)

slot0 = class("OptionalChargeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, OptionalChargeView.New())

	return slot1
end

return slot0
