module("modules.logic.achievement.view.AchievementMainViewContainer", package.seeall)

slot0 = class("AchievementMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot0._scrollListView = LuaMixScrollView.New(AchievementMainListModel.instance, slot0:getListContentParam())
	slot0._scrollTileView = LuaMixScrollView.New(AchievementMainTileModel.instance, slot0:getMixContentParam())
	slot0._poolView = AchievementMainViewPool.New(AchievementEnum.MainIconPath)

	return {
		AchievementMainView.New(),
		TabViewGroup.New(1, "#go_btns"),
		slot0._scrollTileView,
		slot0._scrollListView,
		slot0._poolView,
		AchievementMainViewFocus.New(),
		AchievementMainTopView.New()
	}
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

function slot0.getMixContentParam(slot0)
	slot1 = MixScrollParam.New()
	slot1.scrollGOPath = "#go_container/#scroll_content"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = AchievementMainItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.startSpace = -20
	slot1.endSpace = 50

	return slot1
end

function slot0.getListContentParam(slot0)
	slot1 = MixScrollParam.New()
	slot1.scrollGOPath = "#go_container/#scroll_list"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#go_container/#scroll_list/Viewport/content/#go_listitem"
	slot1.cellClass = AchievementMainListItem
	slot1.scrollDir = ScrollEnum.ScrollDirV

	return slot1
end

function slot0.getScrollView(slot0, slot1)
	if slot1 == AchievementEnum.ViewType.Tile then
		return slot0._scrollTileView
	else
		return slot0._scrollListView
	end
end

function slot0.getPoolView(slot0)
	return slot0._poolView
end

return slot0
