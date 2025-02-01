module("modules.logic.activity.view.LinkageActivity_FullViewContainer", package.seeall)

slot0 = class("LinkageActivity_FullViewContainer", LinkageActivity_BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._view = LinkageActivity_FullView.New()

	table.insert(slot1, slot0._view)

	return slot1
end

function slot0.view(slot0)
	return slot0._view
end

return slot0
