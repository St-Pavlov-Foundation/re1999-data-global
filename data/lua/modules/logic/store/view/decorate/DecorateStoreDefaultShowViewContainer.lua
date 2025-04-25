module("modules.logic.store.view.decorate.DecorateStoreDefaultShowViewContainer", package.seeall)

slot0 = class("DecorateStoreDefaultShowViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DecorateStoreDefaultShowView.New())

	return slot1
end

return slot0
