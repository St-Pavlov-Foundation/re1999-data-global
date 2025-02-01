module("modules.logic.versionactivity1_9.decalogpresent.view.V1a9DecalogPresentViewContainer", package.seeall)

slot0 = class("V1a9DecalogPresentViewContainer", DecalogPresentViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, V1a9DecalogPresentView.New())

	return slot1
end

return slot0
