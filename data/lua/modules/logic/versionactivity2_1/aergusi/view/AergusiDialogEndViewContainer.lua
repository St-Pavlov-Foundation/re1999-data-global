module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogEndViewContainer", package.seeall)

slot0 = class("AergusiDialogEndViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, AergusiDialogEndView.New())

	return slot1
end

return slot0
