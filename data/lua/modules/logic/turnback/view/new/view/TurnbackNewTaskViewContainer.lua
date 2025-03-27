module("modules.logic.turnback.view.new.view.TurnbackNewTaskViewContainer", package.seeall)

slot0 = class("TurnbackNewTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "left/#scroll_task"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes[1]
	slot2.cellClass = TurnbackNewTaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 1136
	slot2.cellHeight = 152
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 6
	slot2.startSpace = 6
	slot2.frameUpdateMs = 100
	slot0._scrollView = LuaListScrollView.New(TurnbackTaskModel.instance, slot2)

	table.insert(slot1, slot0._scrollView)
	table.insert(slot1, TurnbackNewTaskView.New())

	return slot1
end

return slot0
