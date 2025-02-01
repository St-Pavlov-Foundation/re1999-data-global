module("modules.logic.dungeon.view.rolestory.RoleStoryRewardViewContainer", package.seeall)

slot0 = class("RoleStoryRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "Left/progress/#scroll_view"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes.itemRes
	slot2.cellClass = RoleStoryRewardItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 268
	slot2.cellHeight = 600
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 2
	slot0.scrollView = LuaListScrollViewWithAnimator.New(RoleStoryRewardListModel.instance, slot2)

	table.insert(slot1, slot0.scrollView)
	table.insert(slot1, RoleStoryRewardView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	return slot1
end

function slot0.getScrollView(slot0)
	return slot0.scrollView
end

function slot0.buildTabViews(slot0, slot1)
	return {
		NavigateButtonsView.New({
			true,
			true,
			false
		})
	}
end

return slot0
