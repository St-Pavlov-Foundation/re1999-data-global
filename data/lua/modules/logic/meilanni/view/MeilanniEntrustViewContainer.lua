module("modules.logic.meilanni.view.MeilanniEntrustViewContainer", package.seeall)

slot0 = class("MeilanniEntrustViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, MeilanniEntrustView.New())

	return slot1
end

return slot0
