module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotProgressViewContainer", package.seeall)

slot0 = class("V1a6_CachotProgressViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._scrollParam = slot0:getMixContentParam()
	slot0._scrollView = LuaMixScrollView.New(V1a6_CachotProgressListModel.instance, slot0._scrollParam)

	return {
		V1a6_CachotProgressView.New(),
		slot0._scrollView
	}
end

function slot0.buildTabViews(slot0, slot1)
end

function slot0.getMixContentParam(slot0)
	slot1 = MixScrollParam.New()
	slot1.scrollGOPath = "Left/#go_progress/#scroll_view"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = V1a6_CachotProgressItem
	slot1.scrollDir = ScrollEnum.ScrollDirH
	slot1.startSpace = 2.5
	slot1.endSpace = 50

	return slot1
end

return slot0
