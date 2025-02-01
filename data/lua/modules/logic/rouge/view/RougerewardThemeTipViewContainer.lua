module("modules.logic.rouge.view.RougerewardThemeTipViewContainer", package.seeall)

slot0 = class("RougerewardThemeTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RougerewardThemeTipView.New())

	return slot1
end

return slot0
