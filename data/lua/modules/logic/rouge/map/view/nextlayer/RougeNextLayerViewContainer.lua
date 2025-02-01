module("modules.logic.rouge.map.view.nextlayer.RougeNextLayerViewContainer", package.seeall)

slot0 = class("RougeNextLayerViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeNextLayerView.New())

	return slot1
end

return slot0
