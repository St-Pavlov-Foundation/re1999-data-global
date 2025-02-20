module("modules.logic.seasonver.act123.view2_3.Season123_2_3TaskViewContainer", package.seeall)

slot0 = class("Season123_2_3TaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	slot0:buildScrollViews()
	table.insert(slot1, slot0.scrollView)
	table.insert(slot1, Season123_2_3TaskView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
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

function slot0.buildScrollViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll_tasklist"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = Season123_2_3TaskItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1112
	slot1.cellHeight = 140
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 18.9
	slot1.startSpace = 0
	slot1.frameUpdateMs = 100
	slot0.scrollView = LuaListScrollView.New(Season123TaskModel.instance, slot1)
end

return slot0
