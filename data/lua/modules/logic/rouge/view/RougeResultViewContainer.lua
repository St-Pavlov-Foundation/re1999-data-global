module("modules.logic.rouge.view.RougeResultViewContainer", package.seeall)

slot0 = class("RougeResultViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeResultView.New())

	return slot1
end

return slot0
