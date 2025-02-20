module("modules.logic.tower.view.TowerTaskViewContainer", package.seeall)

slot0 = class("TowerTaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	slot0:buildScrollViews()
	table.insert(slot1, slot0.scrollView)
	table.insert(slot1, TowerTaskView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_lefttop"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			slot0.navigateView
		}
	end
end

function slot0.buildScrollViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "Right/#scroll_taskList"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot1.prefabUrl = slot0._viewSetting.otherRes[1]
	slot1.cellClass = TowerTaskItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1160
	slot1.cellHeight = 165
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.frameUpdateMs = 100

	for slot6 = 1, 6 do
	end

	slot0.scrollView = LuaListScrollViewWithAnimator.New(TowerTaskModel.instance, slot1, {
		[slot6] = (slot6 - 1) * 0.06
	})
end

return slot0
