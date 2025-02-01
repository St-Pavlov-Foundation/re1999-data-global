module("modules.logic.activitywelfare.view.NewWelfarePanelContainer", package.seeall)

slot0 = class("NewWelfarePanelContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, NewWelfarePanel.New())

	return slot1
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
