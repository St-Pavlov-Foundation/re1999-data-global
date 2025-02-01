module("modules.logic.activitywelfare.subview.NewWelfareViewContainer", package.seeall)

slot0 = class("NewWelfareViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, NewWelfareView.New())

	return slot1
end

return slot0
