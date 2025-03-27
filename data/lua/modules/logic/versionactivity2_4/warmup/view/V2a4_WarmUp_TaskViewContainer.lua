module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_TaskViewContainer", package.seeall)

slot0 = class("V2a4_WarmUp_TaskViewContainer", Activity125TaskViewBaseContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_TaskList"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = V2a4_WarmUp_TaskItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1136
	slot1.cellHeight = 152
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 12

	for slot6 = 1, 5 do
	end

	slot0.notPlayAnimation = true
	slot0._taskScrollView = LuaListScrollViewWithAnimator.New(V2a4_WarmUp_TaskListModel.instance, slot1, {
		[slot6] = (slot6 - 1) * 0.06
	})

	return {
		slot0._taskScrollView,
		V2a4_WarmUp_TaskView.New()
	}
end

function slot0.actId(slot0)
	return V2a4_WarmUpConfig.instance:actId()
end

return slot0
