module("modules.logic.player.view.WaterMarkViewContainer", package.seeall)

slot0 = class("WaterMarkViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.waterMarkView = WaterMarkView.New()

	table.insert(slot1, slot0.waterMarkView)

	return slot1
end

return slot0
