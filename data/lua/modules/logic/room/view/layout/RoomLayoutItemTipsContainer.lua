module("modules.logic.room.view.layout.RoomLayoutItemTipsContainer", package.seeall)

slot0 = class("RoomLayoutItemTipsContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, RoomLayoutItemTips.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#go_content/#scroll_ItemList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#go_content/#go_normalitem"
	slot2.cellClass = RoomLayoutItemTipsItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 550
	slot2.cellHeight = 52
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(RoomLayoutItemListModel.instance, slot2))

	return slot1
end

function slot0.getTipsHeight(slot0)
	slot2 = 0
	slot3 = 12.5
	slot4 = 52
	slot5 = 88
	slot6 = 20

	if RoomLayoutItemListModel.instance:getCount() > 0 then
		slot1 = slot1 + 0.5
	end

	return math.min(slot3, math.max(slot2, slot1)) * slot4 + slot5 + slot6
end

return slot0
