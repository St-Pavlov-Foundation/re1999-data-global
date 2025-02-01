module("modules.logic.versionactivity1_4.act133.view.Activity133TaskViewContainer", package.seeall)

slot0 = class("Activity133TaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "main/#scroll_view"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = Activity133TaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1300
	slot2.cellHeight = 160
	slot2.cellSpaceV = 10
	slot2.startSpace = 0

	for slot7 = 1, 5 do
	end

	slot0._scrollview = LuaListScrollViewWithAnimator.New(Activity133TaskListModel.instance, slot2, {
		[slot7] = (slot7 - 1) * 0.06
	})

	table.insert(slot1, slot0._scrollview)
	table.insert(slot1, Activity133TaskView.New())

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
end

function slot0.onContainerInit(slot0)
	slot0.taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(slot0._scrollview)
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
