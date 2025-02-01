module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionBagViewContainer", package.seeall)

slot0 = class("V1a6_CachotCollectionBagViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._scrollView = LuaListScrollView.New(V1a6_CachotCollectionBagListModel.instance, slot0:getScrollParam())

	return {
		V1a6_CachotCollectionBagView.New(),
		slot0._scrollView
	}
end

function slot0.getScrollView(slot0)
	return slot0._scrollView
end

function slot0.getScrollParam(slot0)
	if not slot0._scrollParam then
		slot0._scrollParam = ListScrollParam.New()
		slot0._scrollParam.scrollGOPath = "left/#scroll_view"
		slot0._scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
		slot0._scrollParam.prefabUrl = slot0._viewSetting.otherRes[1]
		slot0._scrollParam.cellClass = V1a6_CachotCollectionBagItem
		slot0._scrollParam.scrollDir = ScrollEnum.ScrollDirV
		slot0._scrollParam.lineCount = 4
		slot0._scrollParam.cellWidth = 248
		slot0._scrollParam.cellHeight = 256
		slot0._scrollParam.cellSpaceH = 0
		slot0._scrollParam.cellSpaceV = 0
		slot0._scrollParam.startSpace = 0
		slot0._scrollParam.endSpace = 0
	end

	return slot0._scrollParam
end

return slot0
