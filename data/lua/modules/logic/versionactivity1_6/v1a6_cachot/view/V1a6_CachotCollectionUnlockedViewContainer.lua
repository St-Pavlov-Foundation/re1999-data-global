module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionUnlockedViewContainer", package.seeall)

slot0 = class("V1a6_CachotCollectionUnlockedViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._scrollParam = ListScrollParam.New()
	slot0._scrollParam.scrollGOPath = "#go_info/#scroll_view"
	slot0._scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	slot0._scrollParam.prefabUrl = "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem"
	slot0._scrollParam.cellClass = V1a6_CachotCollectionUnLockItem
	slot0._scrollParam.scrollDir = ScrollEnum.ScrollDirV
	slot0._scrollParam.lineCount = 5
	slot0._scrollParam.cellWidth = 280
	slot0._scrollParam.cellHeight = 260
	slot0._scrollParam.cellSpaceH = 0
	slot0._scrollParam.cellSpaceV = 0
	slot0._scrollParam.startSpace = 50
	slot0._scrollParam.endSpace = 0

	return {
		V1a6_CachotCollectionUnlockedView.New(),
		LuaListScrollView.New(V1a6_CachotCollectionUnLockListModel.instance, slot0._scrollParam)
	}
end

function slot0.getListScrollParam(slot0)
	return slot0._scrollParam
end

return slot0
