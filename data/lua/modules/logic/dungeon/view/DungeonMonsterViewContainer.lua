module("modules.logic.dungeon.view.DungeonMonsterViewContainer", package.seeall)

slot0 = class("DungeonMonsterViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, DungeonMonsterView.New())

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_monster"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "content_prefab"
	slot2.cellClass = DungeonMonsterItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 4
	slot2.cellWidth = 130
	slot2.cellHeight = 130
	slot2.cellSpaceH = 40
	slot2.cellSpaceV = 40
	slot2.startSpace = 24
	slot2.endSpace = 0
	slot0._scrollView = LuaListScrollView.New(DungeonMonsterListModel.instance, slot2)

	table.insert(slot1, slot0._scrollView)
	table.insert(slot1, TabViewGroup.New(1, "top_left"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			false,
			false
		}, 100)
	}
end

function slot0.getScrollView(slot0)
	return slot0._scrollView
end

return slot0
