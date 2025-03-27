module("modules.logic.reactivity.view.ReactivityTaskViewContainer", package.seeall)

slot0 = class("ReactivityTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_TaskList"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = ReactivityTaskItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1136
	slot1.cellHeight = 152
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 16

	for slot6 = 1, 8 do
	end

	slot3 = LuaListScrollViewWithAnimator.New(ReactivityTaskModel.instance, slot1, {
		[slot6] = (slot6 - 1) * 0.04
	})
	slot3.dontPlayCloseAnimation = true
	slot0._taskScrollView = slot3

	return {
		slot3,
		ReactivityTaskView.New(),
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
