module("modules.logic.turnback.view.TurnbackTaskViewContainer", package.seeall)

slot0 = class("TurnbackTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "right/#scroll_task"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = TurnbackTaskItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 800
	slot1.cellHeight = 140
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 6
	slot1.frameUpdateMs = 100
	slot0._scrollView = LuaListScrollView.New(TurnbackTaskModel.instance, slot1)

	return {
		slot0._scrollView,
		TurnbackTaskView.New()
	}
end

return slot0
