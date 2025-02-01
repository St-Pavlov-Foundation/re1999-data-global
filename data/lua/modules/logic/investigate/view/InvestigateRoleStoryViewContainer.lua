module("modules.logic.investigate.view.InvestigateRoleStoryViewContainer", package.seeall)

slot0 = class("InvestigateRoleStoryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, InvestigateRoleStoryView.New())

	return slot1
end

return slot0
