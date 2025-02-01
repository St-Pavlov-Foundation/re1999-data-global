module("modules.logic.rouge.view.RougeCollectionFilterViewContainer", package.seeall)

slot0 = class("RougeCollectionFilterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeCollectionFilterView.New())

	return slot1
end

return slot0
