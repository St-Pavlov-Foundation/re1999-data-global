module("modules.logic.versionactivity.view.VersionActivityTaskViewContainer", package.seeall)

slot0 = class("VersionActivityTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_right"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = VersionActivityTaskItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1070
	slot1.cellHeight = 163
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = -6
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_left"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#scroll_left/Viewport/Content/#go_item"
	slot2.cellClass = VersionActivityTaskBonusItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 610
	slot2.cellHeight = 165
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot3 = {
		[slot7] = (slot7 - 1) * 0.04
	}

	for slot7 = 1, 8 do
	end

	slot4 = LuaListScrollViewWithAnimator.New(VersionActivityTaskListModel.instance, slot1, slot3)
	slot4.dontPlayCloseAnimation = true
	slot0._taskScrollView = slot4
	slot0._taskBonusScrollView = LuaListScrollViewWithAnimator.New(VersionActivityTaskBonusListModel.instance, slot2, slot3)

	return {
		slot4,
		slot0._taskBonusScrollView,
		VersionActivityTaskView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
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

function slot0.onContainerInit(slot0)
	slot0.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0._taskScrollView)

	slot0.taskAnimRemoveItem:setMoveInterval(0)
end

function slot0.setTaskBonusScrollViewIndexOffset(slot0, slot1)
	slot0._taskBonusScrollView.indexOffset = slot1
end

return slot0
