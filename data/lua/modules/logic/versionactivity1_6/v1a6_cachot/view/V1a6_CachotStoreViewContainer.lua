module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotStoreViewContainer", package.seeall)

slot0 = class("V1a6_CachotStoreViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_store"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#scroll_store/Viewport/#go_storeItem/#go_storegoodsitem"
	slot1.cellClass = V1a6_CachotStoreItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 4
	slot1.cellWidth = 356
	slot1.cellHeight = 376
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 10
	slot1.startSpace = 30
	slot1.frameUpdateMs = 100

	return {
		V1a6_CachotStoreView.New(),
		LuaListScrollView.New(V1a6_CachotStoreListModel.instance, slot1),
		V1a6_CachotCurrencyView.New("top")
	}
end

return slot0
