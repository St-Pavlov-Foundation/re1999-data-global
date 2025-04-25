module("modules.logic.versionactivity2_5.challenge.view.Act183RepressViewContainer", package.seeall)

slot0 = class("Act183RepressViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act183RepressView.New())

	slot0.helpView = HelpShowView.New()

	slot0.helpView:setHelpId(HelpEnum.HelpId.Act183Repress)
	table.insert(slot1, slot0.helpView)

	return slot1
end

return slot0
