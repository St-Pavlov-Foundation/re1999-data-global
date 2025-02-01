module("modules.logic.activity.view.LinkageActivity_PanelViewContainer", package.seeall)

slot0 = class("LinkageActivity_PanelViewContainer", LinkageActivity_BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._view = LinkageActivity_PanelView.New()

	table.insert(slot1, slot0._view)

	return slot1
end

function slot0.view(slot0)
	return slot0._view
end

return slot0
