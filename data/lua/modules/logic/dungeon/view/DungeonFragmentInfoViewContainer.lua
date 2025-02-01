module("modules.logic.dungeon.view.DungeonFragmentInfoViewContainer", package.seeall)

slot0 = class("DungeonFragmentInfoViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonFragmentInfoView.New())

	return slot1
end

return slot0
