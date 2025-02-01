module("modules.logic.stresstip.view.StressTipViewContainer", package.seeall)

slot0 = class("StressTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, StressTipView.New())

	return slot1
end

return slot0
