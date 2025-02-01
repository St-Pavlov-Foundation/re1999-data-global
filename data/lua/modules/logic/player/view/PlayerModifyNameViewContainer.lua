module("modules.logic.player.view.PlayerModifyNameViewContainer", package.seeall)

slot0 = class("PlayerModifyNameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, PlayerModifyNameView.New())

	return slot1
end

return slot0
