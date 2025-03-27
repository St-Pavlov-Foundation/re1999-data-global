module("modules.logic.rouge.view.RougeEndingThreeViewContainer", package.seeall)

slot0 = class("RougeEndingThreeViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeEndingThreeView.New())

	return slot1
end

return slot0
