module("modules.logic.meilanni.view.MeilanniBossInfoViewContainer", package.seeall)

slot0 = class("MeilanniBossInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, MeilanniBossInfoView.New())

	return slot1
end

return slot0
