module("modules.logic.rouge.view.RougeOpenGuideViewContainer", package.seeall)

slot0 = class("RougeOpenGuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougeOpenGuideView.New())

	return slot1
end

return slot0
