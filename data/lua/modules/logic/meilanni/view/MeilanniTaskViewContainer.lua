module("modules.logic.meilanni.view.MeilanniTaskViewContainer", package.seeall)

slot0 = class("MeilanniTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "right/#scroll_reward"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = MeilanniTaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1300
	slot2.cellHeight = 160
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 6.19
	slot2.startSpace = 0

	for slot7 = 1, 6 do
	end

	slot4 = LuaListScrollViewWithAnimator.New(MeilanniTaskListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.07
	})
	slot4.dontPlayCloseAnimation = true
	slot0._taskScrollView = slot4

	table.insert(slot1, slot0._taskScrollView)
	table.insert(slot1, MeilanniTaskView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	slot0._navigateButtonView = NavigateButtonsView.New({
		true,
		true,
		false
	}, nil, , , , slot0)

	return {
		slot0._navigateButtonView
	}
end

function slot0.onContainerInit(slot0)
	slot0.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0._taskScrollView)

	slot0.taskAnimRemoveItem:setMoveInterval(0)
end

return slot0
