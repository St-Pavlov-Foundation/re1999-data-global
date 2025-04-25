module("modules.logic.versionactivity2_5.act186.view.Activity186TaskViewContainer", package.seeall)

slot0 = class("Activity186TaskViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Activity186TaskView.New())
	table.insert(slot1, Activity186MileStoneView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_topleft"))

	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "root/taskList/ScrollView"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = slot0._viewSetting.otherRes.itemRes
	slot2.cellClass = Activity186TaskItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 364
	slot2.cellHeight = 450
	slot2.cellSpaceH = 20
	slot2.cellSpaceV = 0
	slot2.startSpace = 0
	slot2.endSpace = 0

	table.insert(slot1, LuaListScrollView.New(Activity186TaskListModel.instance, slot2))

	slot3 = ListScrollParam.New()
	slot3.scrollGOPath = "root/bonusNode/#scroll_reward"
	slot3.prefabType = ScrollEnum.ScrollPrefabFromView
	slot3.prefabUrl = "root/bonusNode/#scroll_reward/Viewport/#go_content/rewarditem"
	slot3.cellClass = Activity186MileStoneItem
	slot3.scrollDir = ScrollEnum.ScrollDirH
	slot3.lineCount = 1
	slot3.cellWidth = 210
	slot3.cellHeight = 285
	slot3.cellSpaceH = 30
	slot3.startSpace = -10
	slot0.mileStoneScrollView = LuaListScrollViewWithAnimator.New(Activity186MileStoneListModel.instance, slot3)

	table.insert(slot1, slot0.mileStoneScrollView)

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

return slot0
