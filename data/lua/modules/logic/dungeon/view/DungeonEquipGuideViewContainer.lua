module("modules.logic.dungeon.view.DungeonEquipGuideViewContainer", package.seeall)

slot0 = class("DungeonEquipGuideViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonEquipGuideView.New())

	return slot1
end

return slot0
