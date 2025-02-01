module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftViewContainer", package.seeall)

slot0 = class("SemmelWeisGiftViewContainer", DecalogPresentViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SemmelWeisGiftView.New())

	return slot1
end

return slot0
