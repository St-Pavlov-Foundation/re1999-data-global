module("modules.logic.explore.view.ExploreRewardViewContainer", package.seeall)

slot0 = class("ExploreRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "mask/#scroll_view1"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#go_rewarditem"
	slot1.cellClass = ExploreBonusItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 700
	slot1.cellHeight = 154
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 25
	slot1.frameUpdateMs = 100
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "mask/#scroll_view2"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromView
	slot2.prefabUrl = "#go_rewarditem"
	slot2.cellClass = ExploreBonusItem
	slot2.scrollDir = ScrollEnum.ScrollDirV
	slot2.lineCount = 1
	slot2.cellWidth = 700
	slot2.cellHeight = 154
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 25
	slot2.frameUpdateMs = 100
	slot3 = {
		[slot7] = (slot7 - 1) * 0.06
	}

	for slot7 = 1, 10 do
	end

	return {
		ExploreRewardView.New(),
		LuaListScrollViewWithAnimator.New(ExploreTaskModel.instance:getTaskList(1), slot1, slot3),
		LuaListScrollViewWithAnimator.New(ExploreTaskModel.instance:getTaskList(2), slot2, slot3),
		TabViewGroup.New(1, "#go_btns")
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

return slot0
