module("modules.logic.explore.view.ExploreBonusRewardViewContainer", package.seeall)

slot0 = class("ExploreBonusRewardViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "mask/#scroll_view"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "mask/#scroll_view/Viewport/Content/rewarditem"
	slot1.cellClass = ExploreBonusRewardItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1470
	slot1.cellHeight = 140
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 0
	slot1.startSpace = 0
	slot1.frameUpdateMs = 100

	return {
		ExploreBonusRewardView.New(),
		LuaListScrollView.New(ExploreTaskModel.instance:getTaskList(0), slot1)
	}
end

return slot0
