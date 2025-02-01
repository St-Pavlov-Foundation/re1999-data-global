module("modules.logic.player.view.PlayerIdViewContainer", package.seeall)

slot0 = class("PlayerIdViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0.PlayerIdView = PlayerIdView.New()

	table.insert(slot1, slot0.PlayerIdView)

	return slot1
end

return slot0
