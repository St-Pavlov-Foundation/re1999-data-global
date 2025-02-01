module("modules.logic.rouge.map.view.tip.RougeMapTipViewContainer", package.seeall)

slot0 = class("RougeMapTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeMapTipView.New())

	return slot1
end

return slot0
