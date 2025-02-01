module("modules.logic.player.view.PlayerClothGuideViewContainer", package.seeall)

slot0 = class("PlayerClothGuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PlayerClothGuideView.New())

	return slot1
end

return slot0
