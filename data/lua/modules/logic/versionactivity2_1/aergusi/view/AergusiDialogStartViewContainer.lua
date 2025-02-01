module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogStartViewContainer", package.seeall)

slot0 = class("AergusiDialogStartViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AergusiDialogStartView.New())

	return slot1
end

return slot0
