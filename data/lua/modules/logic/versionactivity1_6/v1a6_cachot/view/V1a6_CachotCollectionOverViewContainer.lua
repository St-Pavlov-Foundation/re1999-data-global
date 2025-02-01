module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionOverViewContainer", package.seeall)

slot0 = class("V1a6_CachotCollectionOverViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_view"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#scroll_view/Viewport/Content/#go_unlockeditem"
	slot1.cellClass = V1a6_CachotCollectionOverItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 3
	slot1.cellWidth = 600
	slot1.cellHeight = 248
	slot1.cellSpaceH = 9
	slot1.cellSpaceV = 7
	slot1.startSpace = 0
	slot1.endSpace = 0
	slot0._scrollView = LuaListScrollView.New(V1a6_CachotCollectionOverListModel.instance, slot1)

	return {
		V1a6_CachotCollectionOverView.New(),
		slot0._scrollView
	}
end

function slot0.getScrollView(slot0)
	return slot0._scrollView
end

return slot0
