module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionViewContainer", package.seeall)

slot0 = class("V1a6_CachotCollectionViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = MixScrollParam.New()
	slot1.scrollGOPath = "left/#scroll_view"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "left/#scroll_view/Viewport/Content/#go_collectionitem"
	slot1.cellClass = V1a6_CachotCollectionLineItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.startSpace = 0
	slot1.endSpace = 0

	return {
		V1a6_CachotCollectionView.New(),
		LuaMixScrollView.New(V1a6_CachotCollectionListModel.instance, slot1)
	}
end

return slot0
