module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftFullViewContainer", package.seeall)

slot0 = class("SemmelWeisGiftFullViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SemmelWeisGiftFullView.New())

	return slot1
end

return slot0
