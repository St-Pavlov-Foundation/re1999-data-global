module("modules.logic.versionactivity2_0.dungeon.view.task.VersionActivity2_0TaskViewContainer", package.seeall)

slot0 = class("VersionActivity2_0TaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_TaskList"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = VersionActivity2_0TaskItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1160
	slot1.cellHeight = 165
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0

	for slot6 = 1, 6 do
	end

	slot0._taskScrollView = LuaListScrollViewWithAnimator.New(VersionActivity2_0TaskListModel.instance, slot1, {
		[slot6] = (slot6 - 1) * 0.06
	})

	return {
		VersionActivity2_0TaskView.New(),
		slot0._taskScrollView,
		TabViewGroup.New(1, "#go_lefttop")
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

return slot0
